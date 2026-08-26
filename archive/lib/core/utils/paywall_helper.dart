// lib/core/utils/paywall_helper.dart
//
// Call showPaywall(context) from anywhere to present the paywall.
// Optionally pass a triggerReason to show a contextual banner.
// Returns the new PremiumTier if the user upgraded, null if they dismissed.

import 'package:flutter/material.dart';
import '../../features/premium/presentation/pages/paywall_page.dart';
import '../services/premium_service.dart';

Future<PremiumTier?> showPaywall(
  BuildContext context, {
  String? triggerReason,
  int initialTier = 1,
}) {
  return Navigator.of(context, rootNavigator: true).push<PremiumTier>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => PaywallPage(
        triggerReason: triggerReason,
        initialTier: initialTier,
      ),
    ),
  );
}