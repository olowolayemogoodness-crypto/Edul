// lib/core/services/feed_video_watch_service.dart
//
// Counts genuine video-watch starts in the social feed (a real tap to
// begin playback -- feed videos are deliberately tap-to-play, not
// autoplay, so this is a real "wanted to watch this" signal, not a
// scroll-past). Every 5th watch shows an interstitial, reusing the
// same InterstitialAdService already wired up for the Aspirants gate.

import 'package:shared_preferences/shared_preferences.dart';
import 'interstitial_ad_service.dart';

class FeedVideoWatchService {
  FeedVideoWatchService._();

  static const int _adEveryNVideos = 5;
  static const _kWatchCount = 'feed_video_watch_count';

  /// Call this the moment a feed video genuinely starts playing (first
  /// tap, not every replay/pause-resume). Shows an interstitial on
  /// every 5th watch.
  static Future<void> recordWatch() async {
    final prefs = await SharedPreferences.getInstance();
    final count = (prefs.getInt(_kWatchCount) ?? 0) + 1;
    await prefs.setInt(_kWatchCount, count);

    if (count % _adEveryNVideos == 0) {
      InterstitialAdService.showIfReady();
    }
  }
}