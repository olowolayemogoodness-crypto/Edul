// lib/core/services/aspirants_engagement_service.dart
//
// Tracks how many times someone has tapped "Enter Aspirants" -- once
// that crosses 15 (a real "this is a habit, not a one-off" signal),
// shows an interstitial every 3rd entry from then on, not every single
// time. Hitting your heaviest users with an ad on every visit punishes
// exactly the engagement you want to keep; every-3rd is real
// monetization without hammering the people using it the most.
//
// Interstitials are fine to show automatically at a natural screen
// transition like this (no explicit opt-in needed, unlike rewarded ads)
// -- same reasoning already established for the post-lesson interstitial.

import 'package:shared_preferences/shared_preferences.dart';
import 'interstitial_ad_service.dart';

class AspirantsEngagementService {
  AspirantsEngagementService._();

  static const int _heavyUserThreshold = 15;
  static const int _adEveryNVisitsAfter = 3;
  static const _kEntryCount = 'aspirants_entry_count';

  /// Call this every time "Enter Aspirants" is tapped. Increments the
  /// persisted count and shows an interstitial if this entry lands on
  /// the right cadence.
  static Future<void> recordEntry() async {
    final prefs = await SharedPreferences.getInstance();
    final count = (prefs.getInt(_kEntryCount) ?? 0) + 1;
    await prefs.setInt(_kEntryCount, count);

    if (count > _heavyUserThreshold && (count - _heavyUserThreshold) % _adEveryNVisitsAfter == 0) {
      InterstitialAdService.showIfReady();
    }
  }
}