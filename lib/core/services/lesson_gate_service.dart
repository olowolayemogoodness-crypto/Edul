// lib/core/services/lesson_gate_service.dart
//
// Free users get a small number of lessons per day; Plus/Pro get
// unlimited. Watching a rewarded ad grants one extra lesson for today
// only -- it doesn't carry over or stack up.
//
// Deliberately uses PremiumService.isRealFree (not isFree), same
// reasoning as HintService: this should respect a user's ACTUAL
// subscription, not the app-wide premiumDisabledForLaunch switch, since
// letting everyone bypass the cap during launch would give away real
// ad-revenue opportunities for no reason.

import 'package:shared_preferences/shared_preferences.dart';
import 'premium_service.dart';

class LessonGateService {
  LessonGateService._();

  static const int dailyFreeLimit = 2;

  static String get _todayKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  static Future<int> _completedToday() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lessons_completed_${_todayKey}') ?? 0;
  }

  static Future<int> _extraUnlockedToday() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lessons_extra_unlocked_${_todayKey}') ?? 0;
  }

  /// Call this once, right when a lesson is actually completed.
  static Future<void> recordLessonCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final current = await _completedToday();
    await prefs.setInt('lessons_completed_${_todayKey}', current + 1);
  }

  /// Whether the next lesson can be started right now.
  static Future<bool> canStartNextLesson() async {
    if (!PremiumService.isRealFree) return true; // real Plus/Pro: unlimited
    final completed = await _completedToday();
    final extra = await _extraUnlockedToday();
    return completed < (dailyFreeLimit + extra);
  }

  /// Call after a rewarded ad completes successfully.
  static Future<void> grantExtraUnlock() async {
    final prefs = await SharedPreferences.getInstance();
    final current = await _extraUnlockedToday();
    await prefs.setInt('lessons_extra_unlocked_${_todayKey}', current + 1);
  }
}