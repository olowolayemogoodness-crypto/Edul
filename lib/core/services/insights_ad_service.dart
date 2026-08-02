// lib/core/services/insights_ad_service.dart
//
// Interstitial ad shown between Insights videos -- every 5 videos
// watched, matching the "1 ad per 5 videos" plan. Same
// auto-show-at-a-break-point reasoning as InterstitialAdService (this
// is a separate ad unit so its performance is trackable independently
// in the AdMob dashboard).

import 'package:google_mobile_ads/google_mobile_ads.dart';

class InsightsAdService {
  InsightsAdService._();

  static const String _adUnitId = 'ca-app-pub-8635571505694976/5380203191';

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

  static void showIfReady() {
    final ad = _ad;
    if (ad == null) {
      preload();
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