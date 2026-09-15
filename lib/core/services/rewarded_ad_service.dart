// lib/core/services/rewarded_ad_service.dart
//
// First real rewarded-ad integration in the app. Everywhere else that
// mentioned "watch an ad" before this (e.g. LivesService's placeholder
// refillOneLifeViaAd) was never actually wired to an ad SDK — this is
// the real thing, and those placeholders could now be connected to it
// too if wanted.
//
// Uses the real AdMob rewarded ad unit (app: Edulink, ca-app-pub-8635571505694976).
// Real ads generally take a few days after account/app creation before
// they reliably fill and pay out — a low or empty fill rate right after
// setup is expected AdMob behavior, not a bug.

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdService {
  RewardedAdService._();

  static const String _rewardedAdUnitId = 'ca-app-pub-8635571505694976/6783502945';

  // While the real AdMob account/ad unit is still "warming up" (new
  // accounts commonly see NO_FILL errors for the first few hours to
  // days — this is expected, not a bug), registering specific physical
  // devices as test devices guarantees THEM real-looking test ads,
  // letting you confirm the whole load/show/reward flow works while
  // waiting on genuine fill. Remove this list once real ads are
  // reliably filling, or leave your own dev device in it long-term so
  // you're never stuck without ads to test with.
  static const List<String> _testDeviceIds = [
    '7F1A5F392C8FBD09EBFEFE6AB7B07EC5', // Z Fold, from logcat
  ];

  static RewardedAd? _ad;
  static bool _loading = false;

  /// Call this early (e.g. when the quiz screen opens) so an ad is
  /// likely already loaded by the time the user actually wants one —
  /// avoids a loading spinner right at the moment they tap "watch ad".
  static void preload() {
    if (kIsWeb || _ad != null || _loading) return;
    _loading = true;
    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
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

  static bool get isReady => _ad != null;

  /// Call once, right after MobileAds.instance.initialize() in main.dart.
  static Future<void> configureTestDevices() async {
    if (kIsWeb) return;
    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: _testDeviceIds),
    );
  }

  /// Shows the preloaded ad if one's ready. [onRewarded] fires only if
  /// the user actually watches through to completion — closing early
  /// does not grant the reward. Always preloads the next ad afterward,
  /// regardless of outcome.
  static Future<void> show({
    required void Function() onRewarded,
    void Function()? onNotReady,
    void Function()? onFailed,
  }) async {
    if (kIsWeb) {
      onNotReady?.call();
      return;
    }
    final ad = _ad;
    if (ad == null) {
      onNotReady?.call();
      preload(); // try to have one ready for next time
      return;
    }
    _ad = null; // consumed — can't be shown twice

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        preload();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        preload();
        onFailed?.call();
      },
    );

    await ad.show(onUserEarnedReward: (ad, reward) {
      onRewarded();
    });
  }
}