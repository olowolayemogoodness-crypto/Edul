// lib/core/services/notification_service.dart
//
// Reads and writes the `notifications` collection.
//
// IMPORTANT — current scope:
// Creation is currently self-only (a user can only create a notification
// addressed to themselves, e.g. a welcome message). This is intentional:
// letting any client create a notification doc addressed to ANY uid would
// let user A spam/spoof notifications to user B. Real cross-user
// notifications (e.g. "so-and-so liked your post") need to be created by a
// trusted backend (a Cloud Function using the Admin SDK, which bypasses
// security rules) — that requires Firebase's Blaze plan, which isn't set
// up yet. Until then, only self-notifications are safe to create from the
// client, which is what `createSelfNotification` below does.
//
// Firestore rule required (Firebase Console → Firestore Database → Rules),
// replacing whatever you currently have for notifications:
//
//   match /notifications/{docId} {
//     allow read, update, delete: if request.auth != null
//                                  && request.auth.uid == resource.data.uid;
//     allow create: if request.auth != null
//                   && request.auth.uid == request.resource.data.uid;
//   }
//
// (Your existing rule checked `resource.data.uid` for write too, which
// can never be true on create — there's no existing document yet at that
// point, so all creates were being silently rejected.)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class NotificationService {
  NotificationService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference get _col => _db.collection('notifications');

  /// Live stream of the current user's notifications, newest first.
  static Stream<List<Map<String, dynamic>>> stream() {
    final uid = UserService.uid;
    if (uid == null) return const Stream.empty();
    return _col
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) {
              final data = d.data() as Map<String, dynamic>;
              data['id'] = d.id;
              return data;
            }).toList());
  }

  /// Creates a notification addressed to the CURRENT user only. See the
  /// class doc comment for why cross-user notifications aren't done here.
  static Future<void> createSelfNotification({
    required String type,
    required String title,
    required String body,
    String? postId,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return;
    try {
      await _col.add({
        'uid': uid,
        'type': type,
        'title': title,
        'body': body,
        'read': false,
        'postId': postId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (_) {}
  }

  static Future<void> markAsRead(String notificationId) async {
    try {
      await _col.doc(notificationId).update({'read': true});
    } catch (_) {}
  }

  static Future<void> markAllAsRead(List<String> notificationIds) async {
    if (notificationIds.isEmpty) return;
    try {
      final batch = _db.batch();
      for (final id in notificationIds) {
        batch.update(_col.doc(id), {'read': true});
      }
      await batch.commit();
    } catch (_) {}
  }
}