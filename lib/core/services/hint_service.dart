// lib/core/services/hint_service.dart
//
// Two independent hint types, tracked separately, spendable across ANY
// question in ANY quiz OR duel -- one shared bank, not a per-session
// balance:
//   - "reveal": shows the correct answer outright (quiz), or the first
//     two letters of the word (spelling duels). One ad unlocks 3.
//   - "eliminate": rules out 2 wrong options. One ad unlocks 5.
//
// Persisted via SharedPreferences -- this is a real bank now, not
// in-memory-only state. It survives finishing a quiz, closing the app,
// switching into a duel, all of it. The only thing that clears it is
// genuinely running out, or the bank expiring.
//
// Expiry: 24 hours after the LAST top-up (not the first) -- watching
// an ad refreshes the clock. This is deliberately generous and easy to
// explain ("use them within a day of getting them"), not a hard
// per-quiz cliff like the old design was.
//
// Duels specifically must pre-stock BEFORE entering a live match --
// watching an ad mid-turn would either burn the opponent's wait time
// or require pausing the shared clock, which opens the door to
// stalling. Boosters apply instantly from the bank once you're in a
// duel; there's no ad-watching inside one.
//
// Plus/Pro users get the same batch sizes but never need to watch an
// ad -- tapping "unlock" for them just grants the batch directly.

import 'package:shared_preferences/shared_preferences.dart';
import 'premium_service.dart';

class HintService {
  HintService._();

  static int revealBalance = 0;
  static int eliminateBalance = 0;
  static DateTime? _bankedAt;

  static const int revealBatchSize = 3;
  static const int eliminateBatchSize = 5;
  static const Duration bankExpiry = Duration(hours: 24);

  static const _kReveal = 'hint_reveal_balance';
  static const _kEliminate = 'hint_eliminate_balance';
  static const _kBankedAt = 'hint_banked_at_ms';

  static bool _loaded = false;

  /// Loads the persisted bank and expires it if stale. Safe to call
  /// repeatedly -- only actually touches disk once per app run. Any
  /// screen that reads balances before first paint (quiz question page,
  /// duel play page) should call and await this in initState, then
  /// setState once it resolves so the real numbers show instead of the
  /// optimistic 0 default.
  static Future<void> ensureLoaded() async {
    if (_loaded) {
      _expireIfStale();
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    revealBalance = prefs.getInt(_kReveal) ?? 0;
    eliminateBalance = prefs.getInt(_kEliminate) ?? 0;
    final bankedAtMs = prefs.getInt(_kBankedAt);
    _bankedAt = bankedAtMs != null ? DateTime.fromMillisecondsSinceEpoch(bankedAtMs) : null;
    _loaded = true;
    _expireIfStale();
  }

  static void _expireIfStale() {
    if (_bankedAt == null) return;
    if (DateTime.now().difference(_bankedAt!) > bankExpiry) {
      revealBalance = 0;
      eliminateBalance = 0;
      _bankedAt = null;
      _persist();
    }
  }

  static Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kReveal, revealBalance);
    await prefs.setInt(_kEliminate, eliminateBalance);
    if (_bankedAt != null) {
      await prefs.setInt(_kBankedAt, _bankedAt!.millisecondsSinceEpoch);
    } else {
      await prefs.remove(_kBankedAt);
    }
  }

  /// How long until the current bank expires -- null if there's no
  /// active bank (empty, or never topped up). Useful for a "boosters
  /// expire in Xh" label so the expiry isn't a silent surprise.
  static Duration? get timeUntilExpiry {
    if (_bankedAt == null) return null;
    final remaining = bankExpiry - DateTime.now().difference(_bankedAt!);
    return remaining.isNegative ? Duration.zero : remaining;
  }

  // Deliberately checks the REAL tier (isRealFree), not isFree/isPlus/
  // isPro -- those get overridden by PremiumService.premiumDisabledForLaunch
  // during the free-launch period, which would make every hint unlock
  // "free" for everyone and skip the ad entirely. Same reasoning as AI
  // Tutor: hints trade away real ad revenue, so they should respect the
  // person's actual subscription regardless of the launch-wide switch.
  static bool get isPremium => !PremiumService.isRealFree;

  static void grantRevealBatch() {
    _expireIfStale();
    revealBalance += revealBatchSize;
    _bankedAt = DateTime.now(); // refresh the 24h clock on every top-up
    _persist();
  }

  static void grantEliminateBatch() {
    _expireIfStale();
    eliminateBalance += eliminateBatchSize;
    _bankedAt = DateTime.now();
    _persist();
  }

  static bool useReveal() {
    _expireIfStale();
    if (revealBalance <= 0) return false;
    revealBalance -= 1;
    _persist();
    return true;
  }

  static bool useEliminate() {
    _expireIfStale();
    if (eliminateBalance <= 0) return false;
    eliminateBalance -= 1;
    _persist();
    return true;
  }
}