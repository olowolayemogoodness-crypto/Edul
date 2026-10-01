// lib/core/services/post_visibility_service.dart
//
// Local, on-device only (SharedPreferences, same pattern as search
// history) -- not synced to Firestore, since this fires constantly
// during normal scrolling and would be wasteful and slow as a network
// write. Capped to the most recent 500 seen post ids so this never
// grows unbounded over months of use.
//
// Two very different bars, both driven by the same visibility signal
// (see the VisibilityDetector wrapping PostCard):
//   - "seen" fires almost immediately (a fraction of a second) --
//     just "did this pass through view at all", used to heavily
//     deprioritize repeats in ranking.
//   - "lingered" (tracked separately, in the widget itself, not here)
//     needs ~2 real seconds of dwell time before it counts, and feeds
//     RelationshipService instead -- a much higher, deliberate bar,
//     since brief visibility says nothing about genuine interest.

import 'package:shared_preferences/shared_preferences.dart';
import 'user_service.dart';

class PostVisibilityService {
  PostVisibilityService._();

  static const _maxSeen = 500;
  static String get _prefsKey => 'seen_post_ids_${UserService.uid ?? "anon"}';

  static Set<String>? _cache;

  /// Synchronous, in-memory only -- for use inside a stream's .map()
  /// transform, which can't await. Empty until getSeenPostIds() has
  /// been called at least once (harmless: the very first render just
  /// treats everything as unseen, which is correct anyway since
  /// nothing could have been marked seen yet at that point).
  static Set<String> get seenPostIdsSync => _cache ?? {};

  static Future<Set<String>> getSeenPostIds() async {
    if (_cache != null) return _cache!;
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList(_prefsKey) ?? [];
      _cache = raw.toSet();
      return _cache!;
    } catch (e) {
      // ignore: avoid_print
      print('[PostVisibilityService] getSeenPostIds failed: $e');
      return {};
    }
  }

  static Future<void> markSeen(String postId) async {
    try {
      final seen = await getSeenPostIds();
      if (seen.contains(postId)) return; // already tracked, avoid a redundant write
      seen.add(postId);
      // Oldest-first trim once over the cap -- Set iteration order in
      // Dart follows insertion order, so this drops the earliest seen
      // rather than a random one.
      final trimmed = seen.length > _maxSeen
          ? seen.skip(seen.length - _maxSeen).toSet()
          : seen;
      _cache = trimmed;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_prefsKey, trimmed.toList());
    } catch (e) {
      // ignore: avoid_print
      print('[PostVisibilityService] markSeen failed: $e');
    }
  }
}