// lib/core/services/home_study_feature_service.dart
//
// Controls whether the Home and Study tabs appear in the bottom nav
// at all. Same pattern as Campaign's backend activation flag -- a
// single Firestore doc, flippable from the console, no app update
// needed to turn these back on later. The widgets and all their code
// stay fully intact either way; this only controls whether they're
// reachable from navigation.

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeStudyFeatureService {
  HomeStudyFeatureService._();

  static Future<bool> isEnabled() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('app_config').doc('home_study_feature').get();
      return doc.data()?['enabled'] == true;
    } catch (_) {
      // Fail closed -- if the read fails for any reason (offline,
      // permissions, doc doesn't exist yet), default to hidden rather
      // than accidentally exposing an unfinished feature.
      return false;
    }
  }
}