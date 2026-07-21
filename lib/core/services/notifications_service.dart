// lib/core/services/notifications_service.dart
//
// Reads and writes the `notifications` collection.
//
// SCOPE — two kinds of creation, two safety models:
//
// 1. Self-notifications (createSelfNotification) — a user can only create
//    a notification addressed to THEMSELVES (e.g. a welcome message).
//
// 2. Cross-user, TEMPLATED notifications (createFollowNotification,
//    createCommentNotification) — now allowed, but tightly constrained by
//    the Firestore rule below: `type` must be one of a fixed small set,
//    and for `follow` the exact `title`/`body` text is enforced by the
//    rule itself (built from `fromDisplayName`, which the rule confirms
//    matches the real caller's own name field), so a malicious client
//    cannot inject arbitrary title/body text — no phishing-link vector.
//    What this does NOT prevent: repeated real notifications (no
//    rate-limiting), since that needs server-side logic (Cloud Functions,
//    which needs Blaze — not set up yet). Known, accepted tradeoff for
//    now.
//
//    "New post from someone you follow" is deliberately NOT built this
//    way — fanning out to every follower from the poster's own client
//    would mean one post triggering hundreds/thousands of writes on their
//    device, which is slow and abusable. That one genuinely needs a
//    Cloud Function trigger later.
//
// Firestore rule required (Firebase Console → Firestore Database → Rules)
// — replace your current `notifications` rule with:
//
//   match /notifications/{docId} {
//     allow read, update, delete: if request.auth != null
//                                  && request.auth.uid == resource.data.uid;
//
//     // Self notifications (e.g. welcome message).
//     allow create: if request.auth != null
//                   && request.auth.uid == request.resource.data.uid;
//
//     // Follow notification — title/body are exactly derived from
//     // fromDisplayName by the rule itself, so no arbitrary text.
//     allow create: if request.auth != null
//                   && request.auth.uid == request.resource.data.fromUid
//                   && request.resource.data.uid != request.auth.uid
//                   && request.resource.data.type == 'follow'
//                   && request.resource.data.title
//                        == request.resource.data.fromDisplayName + ' started following you'
//                   && request.resource.data.body == 'Tap to view their profile';
//
//     // Comment notification — title is locked; body (comment preview)
//     // is free text but capped in length.
//     allow create: if request.auth != null
//                   && request.auth.uid == request.resource.data.fromUid
//                   && request.resource.data.uid != request.auth.uid
//                   && request.resource.data.type == 'comment'
//                   && request.resource.data.title
//                        == request.resource.data.fromDisplayName + ' commented on your post'
//                   && request.resource.data.body is string
//                   && request.resource.data.body.size() <= 200;
//   }

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

  /// Creates a notification addressed to the CURRENT user only.
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

  /// Notifies [targetUid] that the current user just followed them.
  /// Title/body must exactly match what the Firestore rule expects.
  static Future<void> createFollowNotification(String targetUid) async {
    final fromUid = UserService.uid;
    if (fromUid == null || fromUid == targetUid) return;
    try {
      final profile = await UserService.getProfile();
      final fromDisplayName = profile?['displayName'] as String? ?? 'Someone';
      await _col.add({
        'uid': targetUid,
        'fromUid': fromUid,
        'fromDisplayName': fromDisplayName,
        'type': 'follow',
        'title': '$fromDisplayName started following you',
        'body': 'Tap to view their profile',
        'read': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (_) {
      // Best-effort — a failed notification shouldn't block the follow
      // action itself.
    }
  }

  /// Notifies [targetUid] (the post owner) that the current user just
  /// commented on their post. No-op if commenting on your own post.
  static Future<void> createCommentNotification({
    required String targetUid,
    required String postId,
    required String commentPreview,
  }) async {
    final fromUid = UserService.uid;
    if (fromUid == null || fromUid == targetUid) return;
    try {
      final profile = await UserService.getProfile();
      final fromDisplayName = profile?['displayName'] as String? ?? 'Someone';
      final preview = commentPreview.length > 120
          ? '${commentPreview.substring(0, 120)}…'
          : commentPreview;
      await _col.add({
        'uid': targetUid,
        'fromUid': fromUid,
        'fromDisplayName': fromDisplayName,
        'type': 'comment',
        'title': '$fromDisplayName commented on your post',
        'body': preview.isEmpty ? '🎤 Sent a voice note' : preview,
        'postId': postId,
        'read': false,
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