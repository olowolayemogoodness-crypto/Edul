// lib/core/services/theme_override_service.dart
//
// Lets a user manually force Light or Dark from Settings, overriding the
// automatic 7am–3pm schedule in AppColors. Defaults to "Auto" (the
// schedule) until someone picks something else. This exists mainly so
// testers can actually see the light theme without waiting for a real
// clock change — pick "Light" in Settings and it applies immediately.
//
// `changeSignal` is what makes the switch show up instantly everywhere:
// main.dart listens to it and remounts the whole app tree when it fires,
// since none of the individual screens are otherwise reactive to a
// color change happening mid-session.

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeOverrideService {
  ThemeOverrideService._();

  static const _prefsKey = 'theme_override'; // 'light' | 'dark' | absent (auto)

  static String? _override; // null = auto (follow the 7am-3pm schedule)
  static String? get override => _override;

  /// Bumps every time the override changes, so the app root can listen
  /// and force a full rebuild.
  static final ValueNotifier<int> changeSignal = ValueNotifier(0);

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _override = prefs.getString(_prefsKey);
  }

  /// Pass 'light', 'dark', or null (auto / follow schedule).
  static Future<void> setOverride(String? value) async {
    _override = value;
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await prefs.remove(_prefsKey);
    } else {
      await prefs.setString(_prefsKey, value);
    }
    changeSignal.value++;
  }

  static String get label {
    switch (_override) {
      case 'light': return 'Light';
      case 'dark': return 'Dark';
      default: return 'Auto (7am–3pm)';
    }
  }
}
