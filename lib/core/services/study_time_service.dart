// lib/core/services/study_time_service.dart
//
// Tracks daily study activity and writes to Firestore under:
//   users/{uid}/studyStats/{YYYY-MM-DD}
//
// Fields written:
//   studyMinutes    - total minutes studied today
//   tasksCompleted  - lessons completed + quizzes finished today
//   quizzesCompleted - quizzes finished today
//   quizCorrect     - total correct answers today
//   quizTotal       - total questions answered today
//   peakHour        - hour of day (0-23) with most study activity
//   hourBuckets     - map of hour → minutes studied (for peak calculation)
//   lastUpdated     - server timestamp
//
// Usage:
//   // Start tracking when entering a lesson or PDF
//   StudyTimeService.startSession();
//
//   // Stop and save when leaving
//   await StudyTimeService.endSession();
//
//   // Record quiz completion
//   await StudyTimeService.recordQuiz(correct: 8, total: 10);
//
//   // Record lesson/task completion
//   await StudyTimeService.recordTaskCompleted();
//
//   // Read today's stats for profile display
//   final stats = await StudyTimeService.getTodayStats();

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class StudyTimeService {
  StudyTimeService._();

  static DateTime? _sessionStart;
  static int? _sessionHour;
  static final _db = FirebaseFirestore.instance;

  // ── Date key ─────────────────────────────────────────────────────────────
  static String get _todayKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  static DocumentReference? get _todayRef {
    final uid = UserService.uid;
    if (uid == null) return null;
    return _db.collection('users').doc(uid)
        .collection('studyStats').doc(_todayKey);
  }

  // ── Session tracking ──────────────────────────────────────────────────────

  /// Call when user enters a lesson, quiz, or PDF viewer.
  static void startSession() {
    _sessionStart = DateTime.now();
    _sessionHour = DateTime.now().hour;
  }

  /// Call when user leaves a lesson, quiz, or PDF viewer.
  /// Saves elapsed minutes to Firestore.
  static Future<void> endSession() async {
    if (_sessionStart == null) return;
    final elapsed = DateTime.now().difference(_sessionStart!).inMinutes;
    _sessionStart = null;

    if (elapsed <= 0) return;

    final ref = _todayRef;
    if (ref == null) return;

    final hour = _sessionHour ?? DateTime.now().hour;
    final hourKey = 'hourBuckets.$hour';

    try {
      await ref.set({
        'studyMinutes': FieldValue.increment(elapsed),
        hourKey: FieldValue.increment(elapsed),
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Update peak hour after writing
      await _updatePeakHour(ref);
    } catch (_) {}
  }

  /// Updates the peakHour field based on current hourBuckets.
  static Future<void> _updatePeakHour(DocumentReference ref) async {
    try {
      final snap = await ref.get();
      final data = snap.data() as Map<String, dynamic>?;
      if (data == null) return;
      final buckets = data['hourBuckets'] as Map<String, dynamic>? ?? {};
      if (buckets.isEmpty) return;

      int peakHour = 0;
      int peakMinutes = 0;
      buckets.forEach((hour, minutes) {
        final m = (minutes as num).toInt();
        if (m > peakMinutes) {
          peakMinutes = m;
          peakHour = int.tryParse(hour) ?? 0;
        }
      });

      await ref.update({'peakHour': peakHour});
    } catch (_) {}
  }

  // ── Quiz recording ────────────────────────────────────────────────────────

  /// Call after a quiz completes with the number of correct and total answers.
  static Future<void> recordQuiz({
    required int correct,
    required int total,
  }) async {
    final ref = _todayRef;
    if (ref == null) return;
    try {
      await ref.set({
        'quizzesCompleted': FieldValue.increment(1),
        'tasksCompleted': FieldValue.increment(1),
        'quizCorrect': FieldValue.increment(correct),
        'quizTotal': FieldValue.increment(total),
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {}
  }

  // ── Task recording ────────────────────────────────────────────────────────

  /// Call when a lesson is completed (passed).
  static Future<void> recordTaskCompleted() async {
    final ref = _todayRef;
    if (ref == null) return;
    try {
      await ref.set({
        'tasksCompleted': FieldValue.increment(1),
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {}
  }

  // ── Reading stats ─────────────────────────────────────────────────────────

  /// Returns today's stats map. Keys: studyMinutes, tasksCompleted,
  /// quizzesCompleted, quizCorrect, quizTotal, peakHour.
  static Future<Map<String, dynamic>> getTodayStats() async {
    final ref = _todayRef;
    if (ref == null) return {};
    try {
      final snap = await ref.get();
      return snap.data() as Map<String, dynamic>? ?? {};
    } catch (_) {
      return {};
    }
  }
static Stream<Map<String, dynamic>> todayStatsStream() {
  final uid = UserService.uid;
  if (uid == null) return const Stream.empty();
  return _db
      .collection('users')
      .doc(uid)
      .collection('studyStats')
      .doc(_todayKey)
      .snapshots()
      .map((snap) => snap.data() ?? {});
}
  /// Returns stats for the past [days] days as a list of daily maps.
  static Future<List<Map<String, dynamic>>> getWeekStats() async {
    final uid = UserService.uid;
    if (uid == null) return [];
    try {
      final now = DateTime.now();
      final keys = List.generate(7, (i) {
        final d = now.subtract(Duration(days: i));
        return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
      });

      final results = await Future.wait(keys.map((key) =>
        _db.collection('users').doc(uid)
            .collection('studyStats').doc(key).get()));

      return results.map((snap) {
        final data = snap.data() ?? {};
data['date'] = snap.id;
return data;
      }).toList();
    } catch (_) {
      return [];
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  /// Formats a peak hour int (0-23) to a display string e.g. "10am", "2pm"
  static String formatPeakHour(int hour) {
    if (hour == 0) return '12am';
    if (hour < 12) return '${hour}am';
    if (hour == 12) return '12pm';
    return '${hour - 12}pm';
  }

  /// Returns accuracy percentage (0-100) from correct/total counts.
  static int accuracyPercent(int correct, int total) {
    if (total == 0) return 0;
    return (correct / total * 100).round();
  }
}