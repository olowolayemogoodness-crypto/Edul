// lib/core/services/interstitial_ad_service.dart
//
// Interstitials are allowed to show automatically at natural break
// points (unlike rewarded ads, which need explicit user opt-in) -- this
// is used right after a lesson completes.
//
// Uses the real "Lesson Complete" interstitial ad unit (app: Edulink,
// ca-app-pub-8635571505694976). Same account verification status as
// the rewarded ad unit applies here -- fill may be low/absent until
// AdMob finishes approving the account.

import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdService {
  InterstitialAdService._();

  static const String _adUnitId = 'ca-app-pub-8635571505694976/1959832934';

  static InterstitialAd? _ad;
  static bool _loading = false;

  static void preload() {
    if (_ad != null || _loading) return;
    _loading = true;
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _loading = false;
        },
        onAdFailedToLoad: (error) {
          _ad = null;
          _loading = false;
        },
      ),
    );
  }

  /// Shows the preloaded interstitial if one's ready. Silently does
  /// nothing if not ready -- never blocks the user's flow waiting on an
  /// ad, since (unlike the rewarded hints) there's no reward tied to
  /// this one actually showing.
  static void showIfReady() {
    final ad = _ad;
    if (ad == null) {
      preload(); // try to have one ready for next time
      return;
    }
    _ad = null;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        preload();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        preload();
      },
    );
    ad.show();
  }
}