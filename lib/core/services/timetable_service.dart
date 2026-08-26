// lib/core/services/timetable_service.dart
//
// The timetable is class-wide, not personal -- one schedule per
// official SET30 group, created only by that group's admin (the
// class rep). Everyone in the group sees the same thing. Regular
// members can't create entries at all right now; the "create your
// own timetable" future premium feature has its UI built (a locked
// button), but is gated behind a single backend flag under
// app_config/timetable_feature, toggleable for testing without an
// app update.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class TimetableEntryResult { static const success = 'success', notAdmin = 'notAdmin', notSignedIn = 'notSignedIn'; }

class TimetableService {
  TimetableService._();

  static final _db = FirebaseFirestore.instance;

  // Matches the confirmed reference palette exactly -- Physics blue,
  // Math purple, English pink, History amber, Music teal, Art red.
  // Any subject outside this fixed list falls back to a deterministic
  // hash-based pick from the same six, so it's still consistent
  // every time without needing the list extended manually.
  static const Map<String, Map<String, String>> _subjectColors = {
    'physics': {'bg': '#182A42', 'text': '#85B7EB', 'border': '#378ADD', 'badgeBg': '#0C447C', 'badgeText': '#B5D4F4'},
    'math':    {'bg': '#241D40', 'text': '#AFA9EC', 'border': '#7F77DD', 'badgeBg': '#3C3489', 'badgeText': '#CECBF6'},
    'english': {'bg': '#3A2138', 'text': '#ED93B1', 'border': '#D4537E', 'badgeBg': '#72243E', 'badgeText': '#F4C0D1'},
    'history': {'bg': '#3A2C14', 'text': '#FAC775', 'border': '#EF9F27', 'badgeBg': '#854F0B', 'badgeText': '#FAC775'},
    'music':   {'bg': '#153228', 'text': '#9FE1CB', 'border': '#1D9E75', 'badgeBg': '#085041', 'badgeText': '#9FE1CB'},
    'art':     {'bg': '#3A1E1E', 'text': '#F09595', 'border': '#E24B4A', 'badgeBg': '#791F1F', 'badgeText': '#F7C1C1'},
  };

  static Map<String, String> colorFor(String subject) {
    final key = subject.trim().toLowerCase();
    if (_subjectColors.containsKey(key)) return _subjectColors[key]!;
    final keys = _subjectColors.keys.toList();
    final fallback = keys[subject.hashCode.abs() % keys.length];
    return _subjectColors[fallback]!;
  }

  // ── Finding the user's own official group ───────────────────────
  static Future<String?> myOfficialGroupId() async {
    final uid = UserService.uid;
    if (uid == null) return null;
    final snap = await _db.collection('users').doc(uid).collection('myGroups')
        .where('isOfficial', isEqualTo: true).limit(1).get();
    if (snap.docs.isEmpty) return null;
    return snap.docs.first.id;
  }

  static Future<bool> _isClassRep(String groupId) async {
    final uid = UserService.uid;
    if (uid == null) return false;
    final memberDoc = await _db.collection('groups').doc(groupId).collection('members').doc(uid).get();
    return memberDoc.data()?['role'] == 'admin';
  }

  /// Public, read-only version of the same check -- safe for the UI
  /// to call directly to decide whether to show admin-only controls,
  /// without going through a write-based method just to test permission.
  static Future<bool> isClassRep(String groupId) => _isClassRep(groupId);

  // ── Class entries (one weekly schedule per group) ────────────────
  static Stream<List<Map<String, dynamic>>> entriesForDay(String groupId, String day) {
    return _db.collection('groups').doc(groupId).collection('timetable_entries')
        .where('day', isEqualTo: day)
        .orderBy('startMinutes')
        .snapshots()
        .map((s) => s.docs.map((d) => {'id': d.id, ...d.data()}).toList());
  }

  static Stream<List<Map<String, dynamic>>> allEntries(String groupId) {
    return _db.collection('groups').doc(groupId).collection('timetable_entries')
        .orderBy('startMinutes')
        .snapshots()
        .map((s) => s.docs.map((d) => {'id': d.id, ...d.data()}).toList());
  }

  static Future<String> addEntry({
    required String groupId,
    required String subject,
    required String day,
    required String startTime, // "8:00"
    required String endTime,
    required String room,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return TimetableEntryResult.notSignedIn;
    if (!await _isClassRep(groupId)) return TimetableEntryResult.notAdmin;

    await _db.collection('groups').doc(groupId).collection('timetable_entries').add({
      'subject': subject.trim(),
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'startMinutes': _toMinutes(startTime),
      'room': room.trim(),
      'createdBy': uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return TimetableEntryResult.success;
  }

  static int _toMinutes(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  // ── Assignments (countdown cards, tied to a subject + due date) ──
  static Stream<List<Map<String, dynamic>>> assignments(String groupId) {
    return _db.collection('groups').doc(groupId).collection('timetable_assignments')
        .orderBy('dueAt')
        .snapshots()
        .map((s) => s.docs.map((d) => {'id': d.id, ...d.data()}).toList());
  }

  static Future<String> addAssignment({
    required String groupId,
    required String subject,
    required String title,
    required DateTime dueAt,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return TimetableEntryResult.notSignedIn;
    if (!await _isClassRep(groupId)) return TimetableEntryResult.notAdmin;

    await _db.collection('groups').doc(groupId).collection('timetable_assignments').add({
      'subject': subject.trim(),
      'title': title.trim(),
      'dueAt': Timestamp.fromDate(dueAt),
      'createdBy': uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return TimetableEntryResult.success;
  }

  // ── Future premium "create your own timetable" feature ──────────
  // UI-only right now -- button exists but is gated by this single
  // backend flag, flippable in Firestore Console for testing without
  // an app release. Not tied to actual premium purchase status yet.
  static Future<bool> isPersonalTimetableCreationEnabled() async {
    final doc = await _db.collection('app_config').doc('timetable_feature').get();
    return doc.data()?['personalCreationEnabled'] == true;
  }
}