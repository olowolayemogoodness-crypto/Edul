// lib/core/services/ai_explain_service.dart
//
// Gates the floating AI explanation widget (quiz screenshot-explain +
// study room ask-AI) -- first 2 uses free per session, then a rewarded
// ad grants a batch of 3 more, same proven shape as HintService's
// booster bank: persisted, expires 24h after the last top-up, watching
// an ad is opt-in and grants a batch rather than a single extra tap.
//
// Deliberately its own small service rather than folded into
// HintService -- different resource entirely (AI calls, not quiz
// hints), no reason to conflate the two balances just because the
// mechanics rhyme.

import 'package:shared_preferences/shared_preferences.dart';

class AiExplainService {
  AiExplainService._();

  static const int freeUsesPerSession = 2;
  static const int adBatchSize = 3;
  static const Duration bankExpiry = Duration(hours: 24);

  static int _sessionUsed = 0; // resets on app restart, not persisted --
  // this is the "first 2 free" counter, deliberately session-scoped so
  // reopening the app doesn't feel like a punishment for a device restart.
  static int _bankedUses = 0;
  static DateTime? _bankedAt;

  static const _kBanked = 'ai_explain_banked_uses';
  static const _kBankedAt = 'ai_explain_banked_at_ms';
  static bool _loaded = false;

  static Future<void> ensureLoaded() async {
    if (_loaded) {
      _expireIfStale();
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    _bankedUses = prefs.getInt(_kBanked) ?? 0;
    final ms = prefs.getInt(_kBankedAt);
    _bankedAt = ms != null ? DateTime.fromMillisecondsSinceEpoch(ms) : null;
    _loaded = true;
    _expireIfStale();
  }

  static void _expireIfStale() {
    if (_bankedAt == null) return;
    if (DateTime.now().difference(_bankedAt!) > bankExpiry) {
      _bankedUses = 0;
      _bankedAt = null;
      _persist();
    }
  }

  static Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kBanked, _bankedUses);
    if (_bankedAt != null) {
      await prefs.setInt(_kBankedAt, _bankedAt!.millisecondsSinceEpoch);
    } else {
      await prefs.remove(_kBankedAt);
    }
  }

  /// True if the next tap can proceed without needing an ad first --
  /// either still within the free session allowance, or there's a
  /// banked (ad-earned) use available.
  static bool get canUseNow {
    _expireIfStale();
    return _sessionUsed < freeUsesPerSession || _bankedUses > 0;
  }

  /// Call right before actually making the AI request. Consumes a free
  /// session use first, then falls back to the banked balance. Returns
  /// false if neither is available -- caller should show the rewarded
  /// ad prompt instead of proceeding.
  static bool consumeUse() {
    _expireIfStale();
    if (_sessionUsed < freeUsesPerSession) {
      _sessionUsed++;
      return true;
    }
    if (_bankedUses > 0) {
      _bankedUses--;
      _persist();
      return true;
    }
    return false;
  }

  /// Called from the rewarded ad's onRewarded callback.
  static void grantAdBatch() {
    _expireIfStale();
    _bankedUses += adBatchSize;
    _bankedAt = DateTime.now();
    _persist();
  }
}