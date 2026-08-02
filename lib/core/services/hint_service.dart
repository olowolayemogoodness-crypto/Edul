// lib/core/services/hint_service.dart
//
// Two independent hint types, tracked separately, both spendable
// across any question in the current quiz session (not per-question):
//   - "reveal": shows the correct answer outright. One ad unlocks 3.
//   - "eliminate": rules out 2 wrong options. One ad unlocks 5.
//
// Plus/Pro users get the same batch sizes but never need to watch an
// ad — tapping "unlock" for them just grants the batch directly.
//
// Balances are session-only (reset each time a new quiz starts) via
// plain in-memory state here — deliberately NOT persisted, since these
// are meant to be earned per quiz attempt, not stockpiled indefinitely
// the way lives are.

import 'premium_service.dart';

class HintService {
  HintService._();

  static int revealBalance = 0;
  static int eliminateBalance = 0;

  static const int revealBatchSize = 3;
  static const int eliminateBatchSize = 5;

  /// Call when a new quiz starts.
  static void resetForNewQuiz() {
    revealBalance = 0;
    eliminateBalance = 0;
  }

  // Deliberately checks the REAL tier (isRealFree), not isFree/isPlus/
  // isPro -- those get overridden by PremiumService.premiumDisabledForLaunch
  // during the free-launch period, which would make every hint unlock
  // "free" for everyone and skip the ad entirely. Same reasoning as AI
  // Tutor: hints trade away real ad revenue, so they should respect the
  // person's actual subscription regardless of the launch-wide switch.
  static bool get isPremium => !PremiumService.isRealFree;

  static void grantRevealBatch() => revealBalance += revealBatchSize;
  static void grantEliminateBatch() => eliminateBalance += eliminateBatchSize;

  static bool useReveal() {
    if (revealBalance <= 0) return false;
    revealBalance -= 1;
    return true;
  }

  static bool useEliminate() {
    if (eliminateBalance <= 0) return false;
    eliminateBalance -= 1;
    return true;
  }
}