// lib/core/services/presence_service.dart
//
// Writes `lastActiveAt` on the current user's own doc while the app is
// in the foreground, and provides the shared "is this user online right
// now" check used by every presence dot in the app.
//
// Deliberately simple: no separate `presence` collection, no Realtime
// Database (which is what Firestore's own presence-detection guide
// recommends for TRUE disconnect-detection, since Firestore alone can't
// tell you when a client vanishes without a clean sign-off). This is a
// best-effort heartbeat, not guaranteed-accurate presence — "online"
// here means "wrote a heartbeat in roughly the last 2 minutes", which
// is the right accuracy/cost tradeoff for a green dot, not something
// that needs to be perfectly correct the instant someone closes the app.
//
// Firestore rule: NONE needed. users/{userId} already allows
// `allow write: if request.auth.uid == userId`, which covers a user
// writing their own lastActiveAt field.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'user_service.dart';

class PresenceService with WidgetsBindingObserver {
  PresenceService._();
  static final PresenceService instance = PresenceService._();

  // How "online" is defined everywhere a presence dot is shown — a
  // single constant so every dot in the app agrees on the same window.
  static const Duration onlineWindow = Duration(minutes: 2);

  // How often to refresh the heartbeat while the app is in the
  // foreground. Shorter than onlineWindow so a dot never flickers off
  // between beats during normal use.
  static const Duration _heartbeatInterval = Duration(seconds: 75);

  Timer? _timer;
  bool _started = false;

  /// Call once per app session, after sign-in (e.g. alongside
  /// PushNotificationService.initialize() in HomePage). Safe to call
  /// more than once — no-ops after the first run.
  void initialize() {
    if (_started) return;
    _started = true;
    WidgetsBinding.instance.addObserver(this);
    _beat(); // write one immediately rather than waiting for the first tick
    _timer = Timer.periodic(_heartbeatInterval, (_) => _beat());
  }

  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _started = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Stop heartbeating while backgrounded — no point paying writes for
    // a user who isn't actually here, and it means the dot correctly
    // goes stale/offline for them within one onlineWindow of leaving.
    if (state == AppLifecycleState.resumed) {
      _beat();
      _timer ??= Timer.periodic(_heartbeatInterval, (_) => _beat());
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _timer?.cancel();
      _timer = null;
    }
  }

  Future<void> _beat() async {
    final uid = UserService.uid;
    if (uid == null) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid)
          .set({'lastActiveAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));
    } catch (_) {
      // Best-effort — a missed heartbeat just means the dot goes stale
      // a little early, never worth surfacing as an error.
    }
  }

  /// Shared helper — every presence dot in the app should call THIS
  /// rather than rolling its own "is it recent enough" check, so the
  /// definition of "online" never drifts between call sites.
  static bool isOnline(Timestamp? lastActiveAt) {
    if (lastActiveAt == null) return false;
    return DateTime.now().difference(lastActiveAt.toDate()) < onlineWindow;
  }
}