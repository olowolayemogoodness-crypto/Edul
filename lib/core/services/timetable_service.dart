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

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
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
  /// Filters client-side off allEntries() rather than a server-side
  /// .where('day', isEqualTo: day).orderBy('startMinutes') query --
  /// that combination needs a composite index, and without one a live
  /// .snapshots() listener can show an optimistic cached result then
  /// clear it once the real (failing) server query resolves --
  /// exactly the "appears then disappears" symptom this replaces.
  /// Also tolerant of case/whitespace differences in the stored day
  /// string, same reasoning as CourseScheduleService's subject match.
  static Stream<List<Map<String, dynamic>>> entriesForDay(String groupId, String day) {
    final wanted = day.trim().toLowerCase();
    return allEntries(groupId).map((entries) =>
        entries.where((e) => (e['day'] as String? ?? '').trim().toLowerCase() == wanted).toList());
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

  // ── Per-date lecture status ("is it holding?") ───────────────────
  // Scoped to a specific calendar date, not the recurring weekly
  // entry itself -- marking one Monday cancelled must not cancel
  // every future Monday. No override document = 'holding' (normal).
  static String dateKeyFor(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static Stream<String> entryStatusStream(String groupId, String entryId, DateTime date) {
    return _db.collection('groups').doc(groupId).collection('timetable_entries').doc(entryId)
        .collection('status_overrides').doc(dateKeyFor(date))
        .snapshots()
        .map((doc) => doc.data()?['status'] as String? ?? 'holding');
  }

  static Future<String> setEntryStatus({
    required String groupId,
    required String entryId,
    required DateTime date,
    required String status, // 'holding' | 'delayed' | 'cancelled'
  }) async {
    final uid = UserService.uid;
    if (uid == null) return TimetableEntryResult.notSignedIn;
    if (!await _isClassRep(groupId)) return TimetableEntryResult.notAdmin;

    await _db.collection('groups').doc(groupId).collection('timetable_entries').doc(entryId)
        .collection('status_overrides').doc(dateKeyFor(date)).set({
      'status': status, 'updatedBy': uid, 'updatedAt': FieldValue.serverTimestamp(),
    });
    return TimetableEntryResult.success;
  }

  /// Notifies every other group member when a class rep marks a class
  /// cancelled or delayed. Calls the existing edulink-push-send
  /// Cloudflare Worker directly from the app -- that worker
  /// authenticates the CALLER as a signed-in Firebase user (via their
  /// own ID token, verified against Firebase's public JWKS), not via
  /// a separate service-to-service secret. The class rep's own app
  /// session already satisfies that, so no new backend piece (Cloud
  /// Function, etc.) is needed here -- just calling the worker once
  /// per member's saved fcmToken (see push_notification_service.dart
  /// for where that gets saved).
  ///
  /// Best-effort: one member's missing/invalid token, or one failed
  /// HTTP call, doesn't stop the rest of the group from being
  /// /// coming back on after being cancelled/delayed).
/// notified. Fires for every status, including 'holding' (a class  /// to normal isn't worth a push).
  static const _pushWorkerUrl = 'https://edulink-push-send.edulinkore.workers.dev/';

    static Future<String> deleteEntry({
    required String groupId,
    required String entryId,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return TimetableEntryResult.notSignedIn;
    if (!await _isClassRep(groupId)) return TimetableEntryResult.notAdmin;

    await _db.collection('groups').doc(groupId).collection('timetable_entries').doc(entryId).delete();
    return TimetableEntryResult.success;
  }

  static Future<void> notifyClassStatusChange({
    required String groupId,
    required String subject,
    required String status, // 'cancelled' | 'delayed' | 'holding'
    String? room,
    String? startTime,
  }) async {
    // No early-return here now -- 'holding' is worth a push too.

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    late final String idToken;
    try {
      idToken = (await currentUser.getIdToken())!;
    } catch (_) {
      return; // can't authenticate to the worker -- best-effort, fail quietly
    }

        final title = status == 'cancelled' ? '$subject cancelled' : status == 'delayed' ? '$subject delayed' : '$subject is back on';
    final where = room != null && room.isNotEmpty ? ' ($room)' : '';
    final when = startTime != null && startTime.isNotEmpty ? ' at $startTime' : '';
    final body = status == 'cancelled'
        ? '$subject$when$where has been cancelled.'
        : status == 'delayed'
            ? '$subject$when$where has been delayed -- check the timetable for the new time.'
            : '$subject$when$where is holding as scheduled.';

    final membersSnap = await _db.collection('groups').doc(groupId).collection('members').get();

    for (final memberDoc in membersSnap.docs) {
      final uid = memberDoc.id;
      if (uid == currentUser.uid) continue; // don't notify the rep who made the change

      final userDoc = await _db.collection('users').doc(uid).get();
      final token = userDoc.data()?['fcmToken'] as String?;
      if (token == null || token.isEmpty) continue;

      try {
        await http.post(
          Uri.parse(_pushWorkerUrl),
          headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $idToken'},
          body: jsonEncode({
            'fcmToken': token,
            'title': title,
            'body': body,
            'data': {'type': 'class_status', 'groupId': groupId, 'subject': subject, 'status': status},
          }),
        );
      } catch (_) {
        // one failed device shouldn't block notifying the rest
      }
    }
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