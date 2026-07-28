// lib/core/services/push_notification_service.dart
//
// Registers this device for OS-level push (the thing that shows on the
// LOCKSCREEN, unlike the in-app notification bell) and keeps
// users/{uid}.fcmToken current. Actually SENDING a push is a separate
// step — see NotificationService's _sendPush helper, which reads this
// token and calls the Cloudflare Worker (pushWorker/push-send-worker.js)
// that holds the Firebase service-account credential needed to talk to
// FCM. This file only handles the device side: permission, token,
// keeping it fresh, and clearing it on sign-out.
//
// Firestore rule: none needed. users/{userId} already allows
// `allow write: if request.auth.uid == userId`, which covers a user
// writing their own device's fcmToken field.
//
// Platform setup still required (can't be done from code):
//   - Android: works automatically, no developer-portal steps.
//   - iOS: needs an APNs key generated in your Apple Developer account,
//     uploaded to Firebase Console > Project Settings > Cloud Messaging,
//     plus the "Push Notifications" capability enabled in Xcode
//     (Signing & Capabilities tab) — that step also finalizes
//     ios/Runner/Runner.entitlements, which this repo now has a starting
//     version of.

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_service.dart';

class PushNotificationService {
  PushNotificationService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static bool _initialized = false;

  /// Call once per app session (e.g. from HomePage.initState). Safe to
  /// call more than once — no-ops after the first run per app launch.
  ///
  /// IMPORTANT: this must NOT assume the user is already signed in when
  /// it runs. HomePage can build before Firebase Auth has finished
  /// restoring the session, in which case UserService.uid is still null
  /// and there's no token to attach to anyone yet. That's why the token
  /// save is driven by authStateChanges() below rather than a single
  /// one-shot call — same reasoning as the auth-restore fix in AuthBloc.
  static Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      // ignore: avoid_print
      print('[push] permission status: ${settings.authorizationStatus}');
      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        // User said no at the OS permission prompt — nothing more to do,
        // this device just won't get lockscreen pushes.
        return;
      }

      // Save now if a session is already restored...
      await _saveToken();

      // ...and again whenever auth state resolves to a signed-in user.
      // This covers the launch race (initialize ran before restore
      // finished) AND fresh logins/account switches on the same device.
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) _saveToken();
      });

      // The token can rotate (reinstall, app data cleared, restored on a
      // new device, etc.) — keep Firestore in sync whenever that happens.
      _messaging.onTokenRefresh.listen((_) => _saveToken());

      // Foreground messages don't show a system banner by default on
      // either platform — deliberately a no-op here for now, since the
      // in-app notification bell already reflects the same event live
      // while the app is open. A local heads-up banner for foreground
      // pushes can be added later if you want that too.
      FirebaseMessaging.onMessage.listen((_) {});
    } catch (e) {
      // ignore: avoid_print
      print('[push] initialize() failed: $e');
    }
  }

  static String? _lastSavedToken;

  static Future<void> _saveToken() async {
    final uid = UserService.uid;
    if (uid == null) {
      // ignore: avoid_print
      print('[push] no signed-in uid yet — will retry on auth state change');
      return;
    }
    try {
      final token = await _messaging.getToken();
      if (token == null) {
        // ignore: avoid_print
        print('[push] getToken() returned null');
        return;
      }
      // authStateChanges() can fire more than once per session; don't
      // burn a Firestore write re-saving a token that's already stored.
      if (_lastSavedToken == token) return;

      // set(merge:true) rather than update() — update() throws if the
      // user doc somehow doesn't exist yet, and this write only ever
      // touches the single fcmToken field either way.
      await FirebaseFirestore.instance
          .collection('users').doc(uid)
          .set({'fcmToken': token}, SetOptions(merge: true));
      _lastSavedToken = token;
      // ignore: avoid_print
      print('[push] saved fcmToken for $uid: ${token.substring(0, 12)}...');
    } catch (e) {
      // ignore: avoid_print
      print('[push] _saveToken failed: $e');
    }
  }

  /// Call on sign-out, BEFORE the Firebase Auth session actually clears
  /// (so UserService.uid is still available) — otherwise a shared or
  /// reused device would keep receiving pushes meant for the account
  /// that just logged out.
  static Future<void> clearToken() async {
    final uid = UserService.uid;
    _lastSavedToken = null;
    if (uid == null) return;
    try {
      await FirebaseFirestore.instance
          .collection('users').doc(uid)
          .update({'fcmToken': FieldValue.delete()});
    } catch (_) {}
  }
}