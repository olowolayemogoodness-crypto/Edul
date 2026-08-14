// lib/core/services/group_service.dart
//
// Data model:
//   groups/{groupId}                      -- name, creatorUid, memberCount, createdAt
//   groups/{groupId}/members/{uid}         -- status: pending|approved, role: admin|member
//   users/{uid}/myGroups/{groupId}         -- mirror, written ONLY on approval
//
// Two separate caps, confirmed as 5 + 5 (10 total, not one shared limit):
//   - Joining (non-admin, approved membership): checked via users/{uid}/myGroups count
//   - Creating/admin-ing: checked via groups where creatorUid == uid
//
// Both counts deliberately avoid collection-group queries -- same lesson
// learned from tonight's followingCount bug. myGroups is a subcollection
// on the user's OWN doc (cheap, always-permitted read), and the creator
// count is a single equality where() with no orderBy, so it never needs
// a composite index the way a combined where+orderBy would.
//
// Admin approval is deliberately pull-based, not notification-driven:
// pendingRequests() is a live stream an admin sees when they open their
// own group, not a push notification fired on every request.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

enum JoinRequestResult { success, capReached, alreadyMember, alreadyRequested, notSignedIn }
enum CreateGroupResult { success, capReached, notSignedIn }

class GroupService {
  GroupService._();

  static const int freeJoinCap = 5;
  static const int freeAdminCap = 5;

  static final _db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> _groups() => _db.collection('groups');

  /// Groups the current user is an approved member of -- the actual
  /// "your groups" list on the Groups screen.
  static Stream<List<Map<String, dynamic>>> myGroups() {
    final uid = UserService.uid;
    if (uid == null) return Stream.value([]);
    return _db.collection('users').doc(uid).collection('myGroups')
        .snapshots()
        .map((s) => s.docs.map((d) => {'id': d.id, ...d.data()}).toList());
  }

  /// How many groups this user currently admins/created -- capped
  /// separately from joined-group count.
  static Future<int> myAdminGroupCount() async {
    final uid = UserService.uid;
    if (uid == null) return 0;
    final snap = await _groups().where('creatorUid', isEqualTo: uid).get();
    return snap.docs.length;
  }

  static Future<int> myJoinedGroupCount() async {
    final uid = UserService.uid;
    if (uid == null) return 0;
    final snap = await _db.collection('users').doc(uid).collection('myGroups').get();
    return snap.docs.length;
  }

  static Future<CreateGroupResult> createGroup(String name, {String? iconUrl}) async {
    final uid = UserService.uid;
    if (uid == null) return CreateGroupResult.notSignedIn;
    if (await myAdminGroupCount() >= freeAdminCap) {
      // TODO: bypass this check once premium status is wired up.
      return CreateGroupResult.capReached;
    }

    final groupRef = _groups().doc();
    await groupRef.set({
      'name': name.trim(),
      'iconUrl': iconUrl,
      'creatorUid': uid,
      'memberCount': 1,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await groupRef.collection('members').doc(uid).set({
      'status': 'approved',
      'role': 'admin',
      'requestedAt': FieldValue.serverTimestamp(),
      'approvedAt': FieldValue.serverTimestamp(),
    });
    await _db.collection('users').doc(uid).collection('myGroups').doc(groupRef.id).set({
      'name': name.trim(),
      'iconUrl': iconUrl,
      'role': 'admin',
      'joinedAt': FieldValue.serverTimestamp(),
    });
    return CreateGroupResult.success;
  }

  static Future<JoinRequestResult> requestToJoin(String groupId) async {
    final uid = UserService.uid;
    if (uid == null) return JoinRequestResult.notSignedIn;

    final memberRef = _groups().doc(groupId).collection('members').doc(uid);
    final existing = await memberRef.get();
    if (existing.exists) {
      final status = existing.data()?['status'];
      return status == 'approved' ? JoinRequestResult.alreadyMember : JoinRequestResult.alreadyRequested;
    }

    if (await myJoinedGroupCount() >= freeJoinCap) {
      // TODO: bypass this check once premium status is wired up.
      return JoinRequestResult.capReached;
    }

    final profile = await UserService.getProfile();
    final displayName = profile?['displayName'] as String? ?? 'User';
    final usernameDisplay = profile?['usernameDisplay'] as String?;

    await memberRef.set({
      'status': 'pending',
      'role': 'member',
      'displayName': displayName,
      'usernameDisplay': usernameDisplay,
      'requestedAt': FieldValue.serverTimestamp(),
      'approvedAt': null,
    });
    return JoinRequestResult.success;
  }

  /// Live pending-request list for a group -- surfaced as a popup when
  /// an admin opens the group, not via a push notification.
  static Stream<List<Map<String, dynamic>>> pendingRequests(String groupId) {
    return _groups().doc(groupId).collection('members')
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((s) => s.docs.map((d) => {'uid': d.id, ...d.data()}).toList());
  }

  static Future<void> approveMember(String groupId, String memberUid, String groupName) async {
    final memberRef = _groups().doc(groupId).collection('members').doc(memberUid);
    await memberRef.update({'status': 'approved', 'approvedAt': FieldValue.serverTimestamp()});
    await _groups().doc(groupId).update({'memberCount': FieldValue.increment(1)});
    await _db.collection('users').doc(memberUid).collection('myGroups').doc(groupId).set({
      'name': groupName,
      'role': 'member',
      'joinedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> rejectMember(String groupId, String memberUid) async {
    await _groups().doc(groupId).collection('members').doc(memberUid).delete();
  }

  // Posting into a group happens through the real PostComposerPage now
  // (writing directly to this group's posts subcollection), not through
  // a dedicated method here -- this keeps one single posting code path
  // for both the main feed and groups, rather than two divergent ones.

  static Stream<List<Map<String, dynamic>>> groupPosts(String groupId) {
    return _groups().doc(groupId).collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => {'id': d.id, ...d.data()}).toList());
  }
}