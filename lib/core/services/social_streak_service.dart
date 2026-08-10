// lib/core/services/social_streak_service.dart
//
// A separate streak from the study/lesson streak shown on Home -- this
// one tracks daily TIME SPENT actually browsing the social feed, not a
// single qualifying action. Reaching 15 cumulative minutes on the
// Social tab in a day counts that day; consecutive qualifying days
// build the streak, same continuation logic as the lesson streak
// (miss a day, it resets).
//
// Time only accumulates while the Social tab is the actively visible
// one -- callers are responsible for calling startTracking()/
// pauseTracking() around tab visibility changes, since Social lives in
// an IndexedStack alongside other tabs (all mounted at once), not a
// route that cleanly pushes/pops.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SocialStreakService {
  SocialStreakService._();

  static const int qualifyingSeconds = 15 * 60;

  static DateTime? _sessionStart;
  static int _accumulatedTodaySeconds = 0;
  static String? _cachedDateKey;
  static bool _qualifiedToday = false;

  static String get _todayKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  static DocumentReference<Map<String, dynamic>>? get _userDoc {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    return FirebaseFirestore.instance.collection('users').doc(uid);
  }

  /// Call when the Social tab becomes the active tab.
  static Future<void> startTracking() async {
    _sessionStart = DateTime.now();
    if (_cachedDateKey != _todayKey) {
      await _loadToday();
    }
  }

  /// Call when the user navigates away from the Social tab (switches
  /// tabs, backgrounds the app, etc). Safe to call even if tracking
  /// was never started.
  static Future<void> pauseTracking() async {
    final start = _sessionStart;
    if (start == null) return;
    _sessionStart = null;
    final elapsed = DateTime.now().difference(start).inSeconds;
    if (elapsed <= 0) return;

    _accumulatedTodaySeconds += elapsed;

    final doc = _userDoc;
    if (doc == null) return;
    try {
      await doc.set({
        'socialStreakProgress': {
          'date': _todayKey,
          'seconds': _accumulatedTodaySeconds,
        },
      }, SetOptions(merge: true));

      if (!_qualifiedToday && _accumulatedTodaySeconds >= qualifyingSeconds) {
        _qualifiedToday = true;
        await _awardStreakDay(doc);
      }
    } catch (_) {
      // Best-effort -- a failed write just means today's progress isn't
      // saved yet; it'll catch up on the next pause.
    }
  }

  static Future<void> _loadToday() async {
    _cachedDateKey = _todayKey;
    final doc = _userDoc;
    if (doc == null) { _accumulatedTodaySeconds = 0; _qualifiedToday = false; return; }
    try {
      final snap = await doc.get();
      final progress = snap.data()?['socialStreakProgress'] as Map<String, dynamic>?;
      if (progress != null && progress['date'] == _todayKey) {
        _accumulatedTodaySeconds = progress['seconds'] as int? ?? 0;
      } else {
        _accumulatedTodaySeconds = 0;
      }
      _qualifiedToday = _accumulatedTodaySeconds >= qualifyingSeconds;
    } catch (_) {
      _accumulatedTodaySeconds = 0;
      _qualifiedToday = false;
    }
  }

  static Future<void> _awardStreakDay(DocumentReference<Map<String, dynamic>> doc) async {
    await FirebaseFirestore.instance.runTransaction((tx) async {
      final snap = await tx.get(doc);
      final data = snap.data() ?? {};
      final currentStreak = data['socialStreak'] as int? ?? 0;
      final lastDateStr = data['socialStreakLastDate'] as String?;

      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final yesterdayKey =
          '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}';

      final newStreak = (lastDateStr == yesterdayKey) ? currentStreak + 1 : 1;

      tx.set(doc, {
        'socialStreak': newStreak,
        'socialStreakLastDate': _todayKey,
      }, SetOptions(merge: true));
    });
  }

  /// Live stream of the current social streak count, for the capsule badge.
  static Stream<int> streamCurrentStreak() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return Stream.value(0);
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots()
        .map((snap) {
      final data = snap.data();
      final streak = data?['socialStreak'] as int? ?? 0;
      final lastDateStr = data?['socialStreakLastDate'] as String?;
      if (lastDateStr == null) return 0;

      // If the last qualifying day was before yesterday, the streak has
      // lapsed -- show 0 rather than a stale number until it's re-earned.
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      final todayKey = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
      final yesterdayKey = '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}';
      if (lastDateStr != todayKey && lastDateStr != yesterdayKey) return 0;
      return streak;
    });
  }
}