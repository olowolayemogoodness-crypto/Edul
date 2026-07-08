// lib/core/services/lives_service.dart
//
// Persistent, GLOBAL lives (hearts) system -- replaces the old
// per-quiz-session lives that reset to 3 every time a quiz started.
// Lives now survive across quiz sessions and app restarts (stored
// locally via SharedPreferences, per-device -- not synced across a
// student's other devices).
//
// Mechanics:
//   - Max 3 lives.
//   - Every 5 wrong answers/timeouts (cumulative, tracked globally --
//     not reset when a quiz ends, only when a life is actually lost)
//     costs exactly 1 life.
//   - Lost lives regenerate ONE AT A TIME, strictly in the order they
//     were lost (Candy Crush/Duolingo-style) -- while more than one
//     life is missing, only the NEXT one counts down; losing another
//     life while one is already regenerating does NOT restart or
//     otherwise affect that running timer.
//   - Each position in the regen queue has its OWN duration: the 1st
//     life lost takes 2 minutes to come back, the 2nd takes 5
//     minutes, the 3rd takes 5 minutes (_regenDurations below).
//   - Regeneration is computed LAZILY on read, against real elapsed
//     time, rather than via a background timer -- this keeps the
//     count correct even if the app was closed for hours, and
//     correctly catches up through MULTIPLE completed regen cycles
//     (each honoring its own assigned duration) in one read.
//
// NOT YET WIRED: refillOneLifeViaAd() is a placeholder for the
// "watch an ad to refill a life" flow. markQuizContinuedViaAd() is a
// SEPARATE placeholder for "watch an ad to finish THIS quiz" --
// deliberately does NOT touch the persistent life count at all, it
// only exists to let a student finish the specific quiz they're
// already in. Neither is wired to a real ad SDK yet; both should stay
// behind disabled UI buttons until ad integration lands.

import 'package:shared_preferences/shared_preferences.dart';

class LivesService {
  LivesService._();

  static const int maxLives = 3;
  // Duration for each position in the regen queue: 1st life lost
  // takes 2 min, 2nd takes 5 min, 3rd takes 5 min.
  static const List<Duration> _regenDurations = [
    Duration(minutes: 2),
    Duration(minutes: 5),
    Duration(minutes: 5),
  ];
  static const int wrongAnswersPerLifeLost = 5;

  static const _kLives = 'lives_current';
  static const _kRegenStart = 'lives_regen_start_millis';
  static const _kRegenCycleIndex = 'lives_regen_cycle_index';
  static const _kWrongCount = 'lives_wrong_count';

  /// Returns the current life count, catching up through any regen
  /// cycles that should have completed based on real elapsed time --
  /// each honoring its own duration from _regenDurations. Persists
  /// the caught-up value so subsequent reads are cheap and consistent.
  static Future<int> getCurrentLives() async {
    final prefs = await SharedPreferences.getInstance();
    var lives = prefs.getInt(_kLives) ?? maxLives;
    var regenStart = prefs.getInt(_kRegenStart);
    var cycleIndex = prefs.getInt(_kRegenCycleIndex) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    var changed = false;

    while (lives < maxLives && regenStart != null) {
      final durationMs = _regenDurations[cycleIndex].inMilliseconds;
      final elapsed = now - regenStart;
      if (elapsed < durationMs) break; // this cycle isn't done yet

      lives += 1;
      changed = true;
      if (lives >= maxLives) {
        regenStart = null;
        cycleIndex = 0;
      } else {
        cycleIndex += 1;
        // Advance the start time by exactly this cycle's duration
        // (not to "now") so any overshoot carries into the next
        // cycle's countdown instead of being silently discarded.
        regenStart = regenStart + durationMs;
      }
    }

    if (changed) {
      await prefs.setInt(_kLives, lives);
      if (regenStart == null) {
        await prefs.remove(_kRegenStart);
        await prefs.remove(_kRegenCycleIndex);
      } else {
        await prefs.setInt(_kRegenStart, regenStart);
        await prefs.setInt(_kRegenCycleIndex, cycleIndex);
      }
    }

    return lives;
  }

  /// Time remaining until the next life regenerates, or null if
  /// lives are already at max (nothing regenerating).
  static Future<Duration?> getTimeUntilNextLife() async {
    final prefs = await SharedPreferences.getInstance();
    final lives = await getCurrentLives(); // ensures a caught-up read first
    if (lives >= maxLives) return null;

    final regenStart = prefs.getInt(_kRegenStart);
    if (regenStart == null) return null;
    final cycleIndex = prefs.getInt(_kRegenCycleIndex) ?? 0;

    final durationMs = _regenDurations[cycleIndex].inMilliseconds;
    final elapsed = DateTime.now().millisecondsSinceEpoch - regenStart;
    final remaining = durationMs - elapsed;
    return Duration(milliseconds: remaining < 0 ? 0 : remaining);
  }

  /// Deducts one life (floors at 0). If nothing is currently
  /// regenerating, starts a fresh regen queue at position 0 (2 min).
  /// If a life is already regenerating, that timer keeps running
  /// completely untouched -- this loss just queues up behind it.
  static Future<int> _loseLife() async {
    final prefs = await SharedPreferences.getInstance();
    final current = await getCurrentLives();
    if (current <= 0) return 0;

    final newLives = current - 1;
    await prefs.setInt(_kLives, newLives);

    if (prefs.getInt(_kRegenStart) == null) {
      await prefs.setInt(_kRegenStart, DateTime.now().millisecondsSinceEpoch);
      await prefs.setInt(_kRegenCycleIndex, 0);
    }
    return newLives;
  }

  /// Records one wrong answer/timeout toward the GLOBAL miss count
  /// (persists across quiz sessions, not just within one quiz).
  /// Returns true if this was the 5th miss and a life was lost.
  static Future<bool> recordWrongAnswer() async {
    final prefs = await SharedPreferences.getInstance();
    final wrongCount = (prefs.getInt(_kWrongCount) ?? 0) + 1;

    if (wrongCount >= wrongAnswersPerLifeLost) {
      await prefs.setInt(_kWrongCount, 0);
      await _loseLife();
      return true;
    }
    await prefs.setInt(_kWrongCount, wrongCount);
    return false;
  }

  /// ⚠️ PLACEHOLDER -- not wired to a real ad SDK. Refills one life
  /// unconditionally. Do not call this from a live "watch ad" button
  /// until real rewarded-ad integration exists; the button should
  /// stay disabled until then.
  static Future<int> refillOneLifeViaAd() async {
    final prefs = await SharedPreferences.getInstance();
    final current = await getCurrentLives();
    if (current >= maxLives) return current;

    final newLives = current + 1;
    await prefs.setInt(_kLives, newLives);
    if (newLives >= maxLives) {
      await prefs.remove(_kRegenStart);
      await prefs.remove(_kRegenCycleIndex);
    }
    return newLives;
  }

  /// ⚠️ PLACEHOLDER -- not wired to a real ad SDK. Deliberately does
  /// NOT touch lives/regen state at all -- this is only meant to let
  /// a student finish the SPECIFIC quiz they're currently in when
  /// they hit 0 lives mid-session, not grant a permanent life back.
  /// The quiz screen should track the "unlocked" result locally
  /// (session-only, not persisted) after this resolves; don't call
  /// this from a live button until real ad integration exists.
  static Future<void> markQuizContinuedViaAd() async {
    // Intentionally a no-op on the lives/regen system. Exists as a
    // named hook so it's obvious where to wire a real ad-watched
    // callback once ad integration lands.
  }
}