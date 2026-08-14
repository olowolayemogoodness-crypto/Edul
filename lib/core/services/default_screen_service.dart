// lib/core/services/default_screen_service.dart
//
// Lets a user pick which bottom-nav tab opens by default whenever they
// launch the app, instead of it always being Home. Mirrors
// ThemeOverrideService's exact pattern -- same init-at-startup,
// same persisted-preference shape -- since that's the established
// convention for this kind of simple, single-value setting in this app.
//
// Tab indices match home_page.dart's IndexedStack order exactly:
//   0 = Home, 1 = Study, 2 = Social, 3 = Discover, 4 = Profile

import 'package:shared_preferences/shared_preferences.dart';

class DefaultScreenService {
  DefaultScreenService._();

  static const _prefsKey = 'default_screen_index';

  static int _index = 0; // defaults to Home until someone picks something else
  static int get index => _index;

  static const List<String> _labels = ['Home', 'Study', 'Social', 'Discover', 'Profile'];

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _index = prefs.getInt(_prefsKey) ?? 0;
  }

  static Future<void> setIndex(int value) async {
    _index = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsKey, value);
  }

  static String get label => _labels[_index.clamp(0, _labels.length - 1)];
  static List<String> get allLabels => _labels;
}