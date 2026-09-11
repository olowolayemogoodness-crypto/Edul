// lib/core/services/group_service.dart
//
// Groups are class-wide, not personal -- one official group per
// department per admission cohort ("set"). The 47 SET30 groups were
// bulk-created directly in Firestore and were untouched by the app's
// code revert, so this file mainly reconnects code to data that's
// still there. Each group has an admin (the class rep), matching
// the "notification tags / alerts" system planned as the next phase.
//
// Confirmed mapping: 100L=Set30, 200L=Set29, 300L=Set28, 400L=Set27,
// 500L=Set26. Only Set30 groups exist right now -- other levels will
// find no matching groups until those sets are also bulk-imported.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class GroupService {
  GroupService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> _groups() => _db.collection('groups');

  static int? setForLevel(String level) {
    switch (level) {
      case '100': return 30;
      case '200': return 29;
      case '300': return 28;
      case '400': return 27;
      case '500': return 26;
      default: return null;
    }
  }

  /// Every official department group for the given [set], live from
  /// Firestore -- so the registration course picker always reflects
  /// real, existing groups rather than a hardcoded list that could
  /// drift out of sync with what's actually in the database.
  static Future<List<Map<String, dynamic>>> officialGroups({required int set}) async {
    final snap = await _groups()
        .where('isOfficial', isEqualTo: true)
        .where('set', isEqualTo: set)
        .get();
    final groups = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
    groups.sort((a, b) => (a['department'] as String? ?? '').compareTo(b['department'] as String? ?? ''));
    return groups;
  }

  /// Places the current user directly into the official group matching
  /// [department] AND [set] -- skips the normal pending-request step,
  /// since this is automatic assignment at signup, not a manual join.
  static Future<void> autoJoinOfficialDepartment(String department, {required int set}) async {
    final uid = UserService.uid;
    if (uid == null) return;

    final snap = await _groups()
        .where('isOfficial', isEqualTo: true)
        .where('department', isEqualTo: department)
        .where('set', isEqualTo: set)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return; // no matching official group -- fail quietly, don't block registration over it
    final groupDoc = snap.docs.first;
    final groupId = groupDoc.id;
    final groupName = groupDoc.data()['name'] as String? ?? department;

    await _groups().doc(groupId).collection('members').doc(uid).set({
      'status': 'approved',
      'role': 'member',
      'requestedAt': FieldValue.serverTimestamp(),
      'approvedAt': FieldValue.serverTimestamp(),
    });
    await _groups().doc(groupId).update({'memberCount': FieldValue.increment(1)});
    await _db.collection('users').doc(uid).collection('myGroups').doc(groupId).set({
      'name': groupName,
      'role': 'member',
      'isOfficial': true,
      'joinedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Finds the current user's own official group -- the one place a
  /// user is scoped to, used to drive the Social feed's department tab.
  static Future<String?> myOfficialGroupId() async {
    final uid = UserService.uid;
    if (uid == null) return null;
    final snap = await _db.collection('users').doc(uid).collection('myGroups')
        .where('isOfficial', isEqualTo: true).limit(1).get();
    if (snap.docs.isEmpty) return null;
    return snap.docs.first.id;
  }

  static Future<Map<String, dynamic>?> myOfficialGroup() async {
    final groupId = await myOfficialGroupId();
    if (groupId == null) return null;
    final doc = await _groups().doc(groupId).get();
    if (!doc.exists) return null;
    return {'id': doc.id, ...?doc.data()};
  }

  /// Whether the current user is the admin (class rep) of [groupId] --
  /// the permission check for admin-only actions like posting alerts.
  static Future<bool> isClassRep(String groupId) async {
    final uid = UserService.uid;
    if (uid == null) return false;
    final memberDoc = await _groups().doc(groupId).collection('members').doc(uid).get();
    return memberDoc.data()?['role'] == 'admin';
  }
}