// lib/core/services/default_screen_service.dart
//
// Lets a user pick which bottom-nav tab opens by default whenever they
// launch the app, instead of it always being Home. Mirrors
// ThemeOverrideService's exact pattern -- same init-at-startup,
// same persisted-preference shape -- since that's the established
// convention for this kind of simple, single-value setting in this app.
//
// Tab indices match home_page.dart's IndexedStack order exactly:
//   0 = Social, 1 = Albums, 2 = Timetable, 3 = Profile

import 'package:shared_preferences/shared_preferences.dart';

class DefaultScreenService {
  DefaultScreenService._();

  static const _prefsKey = 'default_screen_index';

  static int _index = 0; // defaults to Social -- the app's core identity now
  static int get index => _index;

  static const List<String> _labels = ['Social', 'Albums', 'Timetable', 'Profile'];

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt(_prefsKey) ?? 0;
    // Clamp defensively -- a value saved under the old 5-tab structure
    // (indices 0-4) could otherwise be out of bounds for the current
    // 4-tab IndexedStack and crash on launch.
    _index = saved.clamp(0, _labels.length - 1);
  }

  static Future<void> setIndex(int value) async {
    _index = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsKey, value);
  }

  static String get label => _labels[_index.clamp(0, _labels.length - 1)];
  static List<String> get allLabels => _labels;
}