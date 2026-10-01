// lib/core/services/community_service.dart
//
// Rebuilt data model, matching the clarified flow:
//   - Follow: lightweight, works on ANY community, drives feed
//     inclusion + push notifications. Nothing to do with the Room.
//   - Room membership: only exists for communities with hasRoom ==
//     true. Getting in is a REQUEST an admin approves, not instant --
//     same as a real group chat.
//
// communities/{communityId}:
//   { name, handle, description, color, category, creatorUid,
//     verified, status: 'active'|'candidate', memberCount,
//     followerCount, hasRoom: bool,
//     lastMessage: {text, senderName, createdAt}?, createdAt }
//
// communities/{communityId}/members/{uid}:      approved room members
//   { role: 'admin'|'member', joinedAt }
//
// communities/{communityId}/joinRequests/{uid}: pending room requests
//   { displayName, requestedAt }
//
// communities/{communityId}/followers/{uid}:    lightweight follow
//   { followedAt }
//
// users/{uid}/joinedRooms/{communityId} and
// users/{uid}/pendingRoomRequests/{communityId}: fan-out on write, so
// "my rooms" and "my pending requests" are each one direct query
// instead of a collection-group scan keyed by document id (which
// Firestore can't do cheaply for this shape).
//   joinedRooms: { name, color, joinedAt, lastReadAt }
//   pendingRoomRequests: { name, color, requestedAt }

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class CommunityService {
  CommunityService._();

  static final _db = FirebaseFirestore.instance;

  // Avoids visually ambiguous characters (0/O, 1/I/l) since this gets
  // typed by hand, shared over WhatsApp, read off a screen, etc.
  static const _codeChars = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
  static String _generateInviteCode() {
    final rand = Random.secure();
    return List.generate(6, (_) => _codeChars[rand.nextInt(_codeChars.length)]).join();
  }

  // ── Creation ──────────────────────────────────────────────────────
  static Future<String> createCommunity({
    required String name,
    required String handle,
    required String description,
    required String color,
    required String category,
    required bool hasRoom,
    bool requiresApproval = true,
  }) async {
    final uid = UserService.uid;
    if (uid == null) throw Exception('Not logged in');

    final userRef = _db.collection('users').doc(uid);
    final communityRef = _db.collection('communities').doc();

    await _db.runTransaction((tx) async {
      // TEMPORARY: cap disabled while testing. Restore this read +
      // check once creation is confirmed working end to end.
      // final userSnap = await tx.get(userRef);
      // final currentCount = (userSnap.data()?['communityCount'] as num?)?.toInt() ?? 0;
      // if (currentCount >= 1) {
      //   throw Exception('You can only create one community for now.');
      // }
      tx.set(communityRef, {
        'name': name,
        'handle': handle,
        'description': description,
        'color': color,
        'category': category,
        'creatorUid': uid,
        'verified': false,
        'status': 'active',
        'memberCount': hasRoom ? 1 : 0,
        'followerCount': 1,
        'hasRoom': hasRoom,
        if (hasRoom) 'requiresApproval': requiresApproval,
        if (hasRoom) 'inviteCode': _generateInviteCode(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      tx.update(userRef, {'communityCount': FieldValue.increment(1)});
    });

    // Creator auto-follows their own community.
    await communityRef.collection('followers').doc(uid).set({'followedAt': FieldValue.serverTimestamp()});

    if (hasRoom) {
      // Creator is auto-approved as the Room's first admin -- they
      // don't request to join their own community.
      await communityRef.collection('members').doc(uid).set({
        'role': 'admin', 'joinedAt': FieldValue.serverTimestamp(),
      });
      await _db.collection('users').doc(uid).collection('joinedRooms').doc(communityRef.id).set({
        'name': name, 'color': color, 'joinedAt': FieldValue.serverTimestamp(), 'lastReadAt': FieldValue.serverTimestamp(),
      });
    }
    return communityRef.id;
  }

  // ── Follow (lightweight, any community, no Room needed) ──────────
  static Future<void> follow(String communityId) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final ref = _db.collection('communities').doc(communityId).collection('followers').doc(uid);
    if ((await ref.get()).exists) return;
    await ref.set({'followedAt': FieldValue.serverTimestamp()});
    await _db.collection('communities').doc(communityId).update({'followerCount': FieldValue.increment(1)});
  }

  static Future<void> unfollow(String communityId) async {
    final uid = UserService.uid;
    if (uid == null) return;
    await _db.collection('communities').doc(communityId).collection('followers').doc(uid).delete();
    await _db.collection('communities').doc(communityId).update({'followerCount': FieldValue.increment(-1)});
  }

  static Stream<bool> isFollowing(String communityId) {
    final uid = UserService.uid;
    if (uid == null) return Stream.value(false);
    return _db.collection('communities').doc(communityId).collection('followers').doc(uid)
        .snapshots().map((d) => d.exists);
  }

  // ── Room membership (only meaningful when hasRoom == true) ───────
  static Stream<bool> isRoomMember(String communityId) {
    final uid = UserService.uid;
    if (uid == null) return Stream.value(false);
    return _db.collection('communities').doc(communityId).collection('members').doc(uid)
        .snapshots().map((d) => d.exists);
  }

  static Stream<bool> hasPendingJoinRequest(String communityId) {
    final uid = UserService.uid;
    if (uid == null) return Stream.value(false);
    return _db.collection('communities').doc(communityId).collection('joinRequests').doc(uid)
        .snapshots().map((d) => d.exists);
  }

  static Future<void> requestToJoinRoom(String communityId) async {
    final uid = UserService.uid;
    if (uid == null) throw Exception('Not logged in');
    final memberRef = _db.collection('communities').doc(communityId).collection('members').doc(uid);
    if ((await memberRef.get()).exists) return; // already in

    final profile = await UserService.getProfile();
    final displayName = profile?['displayName'] as String? ?? 'User';
    final communitySnap = await _db.collection('communities').doc(communityId).get();
    final name = communitySnap.data()?['name'] as String? ?? '';
    final color = communitySnap.data()?['color'] as String?;

    final batch = _db.batch();
    batch.set(_db.collection('communities').doc(communityId).collection('joinRequests').doc(uid), {
      'displayName': displayName, 'requestedAt': FieldValue.serverTimestamp(),
    });
    batch.set(_db.collection('users').doc(uid).collection('pendingRoomRequests').doc(communityId), {
      'name': name, 'color': color, 'requestedAt': FieldValue.serverTimestamp(),
    });
    await batch.commit();
  }

  static Future<void> cancelJoinRequest(String communityId) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final batch = _db.batch();
    batch.delete(_db.collection('communities').doc(communityId).collection('joinRequests').doc(uid));
    batch.delete(_db.collection('users').doc(uid).collection('pendingRoomRequests').doc(communityId));
    await batch.commit();
  }

  /// The single entry point the Handle's Join button calls. Branches
  /// on the community's own requiresApproval setting -- an admin
  /// decision, not something the joiner chooses. Existing communities
  /// with no setting stored default to requiring approval (the
  /// original, safer behavior), so nothing that already exists
  /// silently becomes open.
  static Future<void> joinRoom(String communityId) async {
    final uid = UserService.uid;
    if (uid == null) throw Exception('Not logged in');
    final memberRef = _db.collection('communities').doc(communityId).collection('members').doc(uid);
    if ((await memberRef.get()).exists) return;

    final communitySnap = await _db.collection('communities').doc(communityId).get();
    final data = communitySnap.data();
    if (data == null || data['hasRoom'] != true) throw Exception('This community has no room to join');
    final requiresApproval = data['requiresApproval'] != false;

    if (requiresApproval) {
      await requestToJoinRoom(communityId);
      return;
    }

    final profile = await UserService.getProfile();
    final displayName = profile?['displayName'] as String? ?? 'User';
    final followerRef = _db.collection('communities').doc(communityId).collection('followers').doc(uid);
    final alreadyFollowing = (await followerRef.get()).exists;
    final name = data['name'] as String? ?? '';
    final color = data['color'] as String?;

    final batch = _db.batch();
    batch.set(memberRef, {'role': 'member', 'joinedAt': FieldValue.serverTimestamp()});
    batch.update(_db.collection('communities').doc(communityId), {
      'memberCount': FieldValue.increment(1),
      if (!alreadyFollowing) 'followerCount': FieldValue.increment(1),
    });
    if (!alreadyFollowing) batch.set(followerRef, {'followedAt': FieldValue.serverTimestamp()});
    batch.set(_db.collection('users').doc(uid).collection('joinedRooms').doc(communityId), {
      'name': name, 'color': color, 'joinedAt': FieldValue.serverTimestamp(), 'lastReadAt': FieldValue.serverTimestamp(),
    });
    final logRef = _db.collection('communities').doc(communityId).collection('activityLog').doc();
    batch.set(logRef, {'type': 'joined', 'uid': uid, 'displayName': displayName, 'timestamp': FieldValue.serverTimestamp()});
    await batch.commit();
    await _checkMemberMilestones(communityId);
  }

  // Same automatic-milestone idea as cloutMilestones in
  // UserTierService, for member count specifically. Kept here rather
  // than there since it's checked from join flows, not Clout flows.
  static const Map<String, int> memberMilestones = {
    'members_10': 10, 'members_50': 50, 'members_100': 100, 'members_500': 500,
  };

  /// Called after every join path (never on leave -- milestones only
  /// unlock going up). memberCount itself is updated via fire-and-
  /// forget FieldValue.increment() calls in each join method, which
  /// don't return the resulting value -- so this does its own fresh
  /// read afterward rather than trying to thread the new count
  /// through every call site.
  static Future<void> _checkMemberMilestones(String communityId) async {
    try {
      final ref = _db.collection('communities').doc(communityId);
      final snap = await ref.get();
      final count = (snap.data()?['memberCount'] as num?)?.toInt() ?? 0;
      final achievements = ((snap.data()?['achievements'] as List<dynamic>?) ?? []).cast<String>().toSet();
      final before = achievements.length;
      for (final entry in memberMilestones.entries) {
        if (count >= entry.value) achievements.add(entry.key);
      }
      if (achievements.length != before) {
        await ref.update({'achievements': achievements.toList()});
      }
    } catch (e) {
      // ignore: avoid_print
      print('[CommunityService] _checkMemberMilestones failed: $e');
    }
  }

  static Future<void> leaveRoom(String communityId) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final profile = await UserService.getProfile();
    final displayName = profile?['displayName'] as String? ?? 'User';

    final batch = _db.batch();
    batch.delete(_db.collection('communities').doc(communityId).collection('members').doc(uid));
    batch.update(_db.collection('communities').doc(communityId), {'memberCount': FieldValue.increment(-1)});
    batch.delete(_db.collection('users').doc(uid).collection('joinedRooms').doc(communityId));
    final logRef = _db.collection('communities').doc(communityId).collection('activityLog').doc();
    batch.set(logRef, {'type': 'left', 'uid': uid, 'displayName': displayName, 'timestamp': FieldValue.serverTimestamp()});
    await batch.commit();
  }

  static Stream<List<Map<String, dynamic>>> members(String communityId) {
    return _db.collection('communities').doc(communityId).collection('members')
        .orderBy('joinedAt').snapshots()
        .map((s) => s.docs.map((d) => {'uid': d.id, ...d.data()}).toList());
  }

  static Stream<List<Map<String, dynamic>>> activityLog(String communityId) {
    return _db.collection('communities').doc(communityId).collection('activityLog')
        .orderBy('timestamp', descending: true).limit(50)
        .snapshots()
        .map((s) => s.docs.map((d) => {'id': d.id, ...d.data()}).toList());
  }

  static Future<void> updateRequiresApproval(String communityId, bool requiresApproval) async {
    await _db.collection('communities').doc(communityId).update({'requiresApproval': requiresApproval});
  }

  static Future<void> updateBanner(String communityId, String bannerUrl) async {
    await _db.collection('communities').doc(communityId).update({'bannerUrl': bannerUrl});
  }

  /// One pinned post per community, shown first regardless of the
  /// Top/Latest sort -- matches the mockup's single "Pinned by admins"
  /// slot rather than a whole pinned-posts list.
  static Future<void> setPinnedPost(String communityId, String? postId) async {
    await _db.collection('communities').doc(communityId).update({'pinnedPostId': postId});
  }

  /// Instant join via a 6-character invite code -- no admin approval,
  /// by explicit choice: a code is something an admin deliberately
  /// handed out, so possessing it IS the vouching step. Also
  /// auto-follows the community (being in its Room without following
  /// its Handle would be a strange half-state).
  static Future<void> joinViaInviteCode(String code) async {
    final uid = UserService.uid;
    if (uid == null) throw Exception('Not logged in');
    final normalized = code.trim().toUpperCase();
    if (normalized.isEmpty) throw Exception('Enter an invite code');

    final query = await _db.collection('communities').where('inviteCode', isEqualTo: normalized).limit(1).get();
    if (query.docs.isEmpty) throw Exception('Invite code not found');
    final communityDoc = query.docs.first;
    final communityId = communityDoc.id;
    final data = communityDoc.data();
    if (data['hasRoom'] != true) throw Exception('This community has no room to join');

    final memberRef = _db.collection('communities').doc(communityId).collection('members').doc(uid);
    if ((await memberRef.get()).exists) return; // already a member, nothing to do

    final followerRef = _db.collection('communities').doc(communityId).collection('followers').doc(uid);
    final alreadyFollowing = (await followerRef.get()).exists;

    final name = data['name'] as String? ?? '';
    final color = data['color'] as String?;

    final batch = _db.batch();
    batch.set(memberRef, {'role': 'member', 'joinedAt': FieldValue.serverTimestamp()});
    batch.update(_db.collection('communities').doc(communityId), {
      'memberCount': FieldValue.increment(1),
      if (!alreadyFollowing) 'followerCount': FieldValue.increment(1),
    });
    if (!alreadyFollowing) {
      batch.set(followerRef, {'followedAt': FieldValue.serverTimestamp()});
    }
    batch.set(_db.collection('users').doc(uid).collection('joinedRooms').doc(communityId), {
      'name': name, 'color': color, 'joinedAt': FieldValue.serverTimestamp(), 'lastReadAt': FieldValue.serverTimestamp(),
    });
    await batch.commit();
    await _checkMemberMilestones(communityId);
  }

  static Stream<List<Map<String, dynamic>>> pendingJoinRequests(String communityId) {
    return _db.collection('communities').doc(communityId).collection('joinRequests')
        .orderBy('requestedAt').snapshots()
        .map((s) => s.docs.map((d) => {'uid': d.id, ...d.data()}).toList());
  }

  static Future<void> approveJoinRequest(String communityId, String uid) async {
    final communitySnap = await _db.collection('communities').doc(communityId).get();
    final name = communitySnap.data()?['name'] as String? ?? '';
    final color = communitySnap.data()?['color'] as String?;

    final batch = _db.batch();
    batch.set(_db.collection('communities').doc(communityId).collection('members').doc(uid), {
      'role': 'member', 'joinedAt': FieldValue.serverTimestamp(),
    });
    batch.delete(_db.collection('communities').doc(communityId).collection('joinRequests').doc(uid));
    batch.update(_db.collection('communities').doc(communityId), {'memberCount': FieldValue.increment(1)});
    batch.set(_db.collection('users').doc(uid).collection('joinedRooms').doc(communityId), {
      'name': name, 'color': color, 'joinedAt': FieldValue.serverTimestamp(), 'lastReadAt': FieldValue.serverTimestamp(),
    });
    batch.delete(_db.collection('users').doc(uid).collection('pendingRoomRequests').doc(communityId));
    await batch.commit();
    await _checkMemberMilestones(communityId);
  }

  static Future<void> denyJoinRequest(String communityId, String uid) async {
    final batch = _db.batch();
    batch.delete(_db.collection('communities').doc(communityId).collection('joinRequests').doc(uid));
    batch.delete(_db.collection('users').doc(uid).collection('pendingRoomRequests').doc(communityId));
    await batch.commit();
  }

  static Future<bool> isAdmin(String communityId) async {
    final uid = UserService.uid;
    if (uid == null) return false;
    final doc = await _db.collection('communities').doc(communityId).collection('members').doc(uid).get();
    return doc.data()?['role'] == 'admin';
  }

  // ── "My Communities" tab -- rooms + pending requests, each one
  // direct query against the fan-out above ─────────────────────────
  static Stream<List<Map<String, dynamic>>> myJoinedRooms() {
    final uid = UserService.uid;
    if (uid == null) return Stream.value([]);
    return _db.collection('users').doc(uid).collection('joinedRooms')
        .orderBy('joinedAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => {'communityId': d.id, ...d.data()}).toList());
  }

  /// One-time fetch, not a live stream -- for ranking, which needs a
  /// plain Set to check posts against, the same pattern as
  /// myInterests/relationshipStrength in the feed.
  static Future<Set<String>> myJoinedRoomIds() async {
    final uid = UserService.uid;
    if (uid == null) return {};
    final snap = await _db.collection('users').doc(uid).collection('joinedRooms').get();
    return snap.docs.map((d) => d.id).toSet();
  }

  static Stream<List<Map<String, dynamic>>> myPendingRoomRequests() {
    final uid = UserService.uid;
    if (uid == null) return Stream.value([]);
    return _db.collection('users').doc(uid).collection('pendingRoomRequests')
        .orderBy('requestedAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => {'communityId': d.id, ...d.data()}).toList());
  }

  static Future<void> markRoomRead(String communityId) async {
    final uid = UserService.uid;
    if (uid == null) return;
    await _db.collection('users').doc(uid).collection('joinedRooms').doc(communityId)
        .update({'lastReadAt': FieldValue.serverTimestamp()});
  }

  static Future<Map<String, dynamic>?> getCommunity(String communityId) async {
    final doc = await _db.collection('communities').doc(communityId).get();
    if (!doc.exists) return null;
    return {'id': doc.id, ...doc.data()!};
  }

  static Stream<Map<String, dynamic>?> communityStream(String communityId) {
    return _db.collection('communities').doc(communityId).snapshots()
        .map((d) => d.exists ? {'id': d.id, ...d.data()!} : null);
  }
}