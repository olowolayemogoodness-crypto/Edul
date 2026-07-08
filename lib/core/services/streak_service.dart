// lib/core/services/streak_service.dart
//
// Streak gate: a streak is only awarded for a day when the user
// completes at least ONE of:
//   1. A quiz with >= 80% accuracy
//   2. A lesson passed (already handled by learning bloc elsewhere --
//      call StreakService.recordLessonPassed() from there)
//   3. Watched >= 10 reels AND answered >= 5 of 10 popup questions
//      correctly (NOT YET WIRED -- reels feature not built).
//
// The streak counter increments in Firestore the moment any of these
// conditions is met for the first time today. A second qualifying
// event on the same day is a no-op (streak already counted).
//
// After a qualifying event, the caller should check
// wasStreakIncrementedToday() and, if true, show StreakCelebrationPage
// before updating the displayed counter in the top bar.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class StreakService {
  StreakService._();

  static final _db = FirebaseFirestore.instance;

  // ── Check if today's activity qualifies for a streak ──────────────

  /// Returns true if [accuracyPercent] qualifies for a streak-worthy
  /// quiz (>= 80%). Callers should then call tryAwardStreak().
  static bool quizQualifiesForStreak(int accuracyPercent) =>
      accuracyPercent >= 80;

  // ── Award streak (if not already awarded today) ───────────────────

  /// Checks if a streak increment is already recorded for today and,
  /// if not, increments the streak and returns the new value.
  /// Returns null if the streak was already counted today (no-op).
  static Future<int?> tryAwardStreak() async {
    final uid = UserService.uid;
    if (uid == null) return null;

    final ref = _db.collection('users').doc(uid);
    final doc = await ref.get();
    final data = doc.data();
    if (data == null) return null;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Was streak already awarded today?
    final lastStudy = (data['lastStudyDate'] as Timestamp?)?.toDate();
    final lastDay = lastStudy != null
        ? DateTime(lastStudy.year, lastStudy.month, lastStudy.day)
        : null;
    if (lastDay == today) return null; // already counted today

    // Compute new streak value
    final yesterday = today.subtract(const Duration(days: 1));
    final current = data['streak'] as int? ?? 0;
    final newStreak = lastDay == yesterday ? current + 1 : 1;
    final longest = newStreak > (data['longestStreak'] as int? ?? 0)
        ? newStreak
        : (data['longestStreak'] as int? ?? 0);

    await ref.update({
      'streak': newStreak,
      'longestStreak': longest,
      'lastStudyDate': FieldValue.serverTimestamp(),
    });

    return newStreak;
  }

  /// Lesson passed: also qualifies for a streak.
  /// Call from the learning/lesson bloc after a lesson is completed.
  static Future<int?> recordLessonPassed() => tryAwardStreak();

  // ── Read current streak for display ──────────────────────────────

  static Future<int> getCurrentStreak() async {
    final uid = UserService.uid;
    if (uid == null) return 0;
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data()?['streak'] as int? ?? 0;
  }
}