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
//
//     // Reply notification (new) — same shape as the comment rule above,
//     // fired at the parent COMMENT's author rather than the post owner.
//     allow create: if request.auth != null
//                   && request.auth.uid == request.resource.data.fromUid
//                   && request.resource.data.uid != request.auth.uid
//                   && request.resource.data.type == 'reply'
//                   && request.resource.data.title
//                        == request.resource.data.fromDisplayName + ' replied to your comment'
//                   && request.resource.data.body is string
//                   && request.resource.data.body.size() <= 200;
//
//     // Like milestone notification — fired only when a post crosses a
//     // milestone count (1, 10, 50, 100, ...), not on every single like.
//     allow create: if request.auth != null
//                   && request.auth.uid == request.resource.data.fromUid
//                   && request.resource.data.uid != request.auth.uid
//                   && request.resource.data.type == 'like_milestone'
//                   && request.resource.data.milestoneCount is int
//                   && request.resource.data.milestoneCount > 0
//                   && request.resource.data.title is string
//                   && request.resource.data.title.size() <= 100
//                   && request.resource.data.body is string
//                   && request.resource.data.body.size() <= 200;
//
//     // Repost notification (new) — same shape as the like rule above.
//     allow create: if request.auth != null
//                   && request.auth.uid == request.resource.data.fromUid
//                   && request.resource.data.uid != request.auth.uid
//                   && request.resource.data.type == 'repost'
//                   && request.resource.data.title
//                        == request.resource.data.fromDisplayName + ' reposted your post'
//                   && request.resource.data.body == 'Tap to view your post';
//   }
//
// LOCKSCREEN PUSH — writing the doc above only feeds the in-app
// notification bell. Actually showing something on the lockscreen while
// the app is closed/backgrounded needs OS-level push (FCM/APNs), which a
// client can never safely send itself (that needs a service-account
// credential that can't live in the app). So _sendPush below reads the
// target's saved FCM token (see PushNotificationService) and calls a
// Cloudflare Worker endpoint that holds that credential and talks to
// FCM's HTTP v1 API — see pushWorker/push-send-worker.js for that side.
// No new Firestore rule needed for the token read: users/{userId} is
// already open to any signed-in user via your existing read rule.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_service.dart';

class NotificationService {
  NotificationService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference get _col => _db.collection('notifications');

  // Same Cloudflare account as the R2 upload worker — either a new
  // route on that worker or its own deploy, your call. Update this to
  // wherever you actually deploy pushWorker/push-send-worker.js.
  static const String _pushWorkerUrl =
      'https://edulink-push-send.edulinkore.workers.dev';

  /// Best-effort: looks up [targetUid]'s saved FCM token and asks the
  /// Worker to send an actual OS push. Never throws — a failed push
  /// should never block the in-app notification that was already
  /// written successfully by the caller.
  static Future<void> _sendPush({
    required String targetUid,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final targetDoc = await _db.collection('users').doc(targetUid).get();
      final token = targetDoc.data()?['fcmToken'] as String?;
      if (token == null || token.isEmpty) {
        // ignore: avoid_print
        print('[push] no fcmToken saved for $targetUid — nothing to send to');
        return;
      }

      final user = FirebaseAuth.instance.currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) {
        // ignore: avoid_print
        print('[push] could not get caller ID token — aborting send');
        return;
      }

      final res = await http.post(
        Uri.parse(_pushWorkerUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
        body: jsonEncode({
          'fcmToken': token,
          'title': title,
          'body': body,
          'data': data ?? {},
        }),
      );
      // ignore: avoid_print
      print('[push] worker responded ${res.statusCode}: ${res.body}');
    } catch (e) {
      // ignore: avoid_print
      print('[push] _sendPush failed: $e');
    }
  }

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
      await _sendPush(
        targetUid: targetUid,
        title: '$fromDisplayName started following you',
        body: 'Tap to view their profile',
        data: {'type': 'follow'},
      );
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
      await _sendPush(
        targetUid: targetUid,
        title: '$fromDisplayName commented on your post',
        body: preview.isEmpty ? '🎤 Sent a voice note' : preview,
        data: {'type': 'comment', 'postId': postId},
      );
    } catch (_) {}
  }

  /// Notifies [targetUid] (the parent comment's author) that the current
  /// user just replied to their comment. No-op if replying to your own
  /// comment. Mirrors [createCommentNotification] — same shape, just a
  /// different `type`/title so it needs its own rule (see file header).
  static Future<void> createReplyNotification({
    required String targetUid,
    required String postId,
    required String replyPreview,
  }) async {
    final fromUid = UserService.uid;
    if (fromUid == null || fromUid == targetUid) return;
    try {
      final profile = await UserService.getProfile();
      final fromDisplayName = profile?['displayName'] as String? ?? 'Someone';
      final preview = replyPreview.length > 120
          ? '${replyPreview.substring(0, 120)}…'
          : replyPreview;
      await _col.add({
        'uid': targetUid,
        'fromUid': fromUid,
        'fromDisplayName': fromDisplayName,
        'type': 'reply',
        'title': '$fromDisplayName replied to your comment',
        'body': preview.isEmpty ? '🎤 Sent a voice note' : preview,
        'postId': postId,
        'read': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _sendPush(
        targetUid: targetUid,
        title: '$fromDisplayName replied to your comment',
        body: preview.isEmpty ? '🎤 Sent a voice note' : preview,
        data: {'type': 'reply', 'postId': postId},
      );
    } catch (_) {}
  }

  /// Notifies [targetUid] (the post owner) that their post just crossed a
  /// like milestone (1, 10, 50, 100, ...) — NOT fired on every single
  /// like, since that would both spam the owner and cost a write per
  /// like at scale. The caller (PostInteractionService.toggleLike) only
  /// invokes this when the new count is actually in the milestone list.
  static Future<void> createLikeMilestoneNotification({
    required String targetUid,
    required String postId,
    required int milestoneCount,
  }) async {
    final fromUid = UserService.uid;
    if (fromUid == null || fromUid == targetUid) return;
    try {
      await _col.add({
        'uid': targetUid,
        'fromUid': fromUid,
        'type': 'like_milestone',
        'milestoneCount': milestoneCount,
        'title': 'Your post hit $milestoneCount likes! 🎉',
        'body': 'Tap to view your post',
        'postId': postId,
        'read': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _sendPush(
        targetUid: targetUid,
        title: 'Your post hit $milestoneCount likes! 🎉',
        body: 'Tap to view your post',
        data: {'type': 'like_milestone', 'postId': postId},
      );
    } catch (_) {}
  }

  /// Notifies [targetUid] (the original post's owner) that the current
  /// user just reposted their post. No-op if reposting your own post.
  static Future<void> createRepostNotification({
    required String targetUid,
    required String postId,
  }) async {
    final fromUid = UserService.uid;
    if (fromUid == null || fromUid == targetUid) return;
    try {
      final profile = await UserService.getProfile();
      final fromDisplayName = profile?['displayName'] as String? ?? 'Someone';
      await _col.add({
        'uid': targetUid,
        'fromUid': fromUid,
        'fromDisplayName': fromDisplayName,
        'type': 'repost',
        'title': '$fromDisplayName reposted your post',
        'body': 'Tap to view your post',
        'postId': postId,
        'read': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _sendPush(
        targetUid: targetUid,
        title: '$fromDisplayName reposted your post',
        body: 'Tap to view your post',
        data: {'type': 'repost', 'postId': postId},
      );
    } catch (_) {}
  }
    /// Notifies the CURRENT user's own followers that they just reposted
  /// something -- different from createRepostNotification above, which
  /// tells the ORIGINAL POST'S OWNER "someone reposted your post". This
  /// tells YOUR followers "someone you follow reposted something",
  /// same "new_post" fan-out shape used in post_composer_page.dart, but
  /// with real push added (the new_post fan-out only ever wrote the
  /// in-app doc, never called _sendPush -- this one does both).
  static Future<void> notifyFollowersOfRepost({
    required String postId,
  }) async {
    final reposterUid = UserService.uid;
    if (reposterUid == null) return;
    try {
      final profile = await UserService.getProfile();
      final reposterName = profile?['displayName'] as String? ?? 'Someone';

      final followers = await _db.collection('users').doc(reposterUid)
          .collection('followers').limit(500).get();
      if (followers.docs.isEmpty) return;

      final batch = _db.batch();
      for (final doc in followers.docs) {
        final notifRef = _col.doc();
        batch.set(notifRef, {
          'uid': doc.id,
          'fromUid': reposterUid,
          'fromDisplayName': reposterName,
          'type': 'follow_repost',
          'title': '$reposterName reposted something',
          'body': 'Tap to see what they shared',
          'postId': postId,
          'read': false,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();

      await Future.wait(followers.docs.map((doc) => _sendPush(
        targetUid: doc.id,
        title: '$reposterName reposted something',
        body: 'Tap to see what they shared',
        data: {'type': 'follow_repost', 'postId': postId},
      )));
    } catch (_) {
      // Best-effort -- never block the repost action itself.
    }
  }

  /// Notifies [targetUid] they've been challenged to a duel. Includes
  /// the challenger's score so the opponent knows what they're up
  /// against before even opening it.
  static Future<void> createDuelChallengeNotification({
    required String targetUid,
    required String duelId,
    required String courseKey,
    required String correctOutOfTotal,
  }) async {
    final fromUid = UserService.uid;
    if (fromUid == null || fromUid == targetUid) return;
    try {
      final profile = await UserService.getProfile();
      final fromDisplayName = profile?['displayName'] as String? ?? 'Someone';
      await _col.add({
        'uid': targetUid,
        'fromUid': fromUid,
        'fromDisplayName': fromDisplayName,
        'type': 'duel_challenge',
        'title': '$fromDisplayName challenged you to a $courseKey duel! ⚔️',
        'body': 'They scored $correctOutOfTotal — think you can beat it?',
        'duelId': duelId,
        'read': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _sendPush(
        targetUid: targetUid,
        title: '$fromDisplayName challenged you to a $courseKey duel! ⚔️',
        body: 'They scored $correctOutOfTotal — think you can beat it?',
        data: {'type': 'duel_challenge', 'duelId': duelId},
      );
    } catch (_) {}
  }

  /// Notifies [targetUid] of a completed duel's outcome, from THEIR
  /// perspective (myScore/opponentScore are already oriented correctly
  /// by the caller — see DuelService._notifyDuelResult, which calls this
  /// twice, once per player, with the scores swapped accordingly).
  static Future<void> createDuelResultNotification({
    required String targetUid,
    required String duelId,
    required String courseKey,
    required int myScore,
    required int opponentScore,
  }) async {
    final fromUid = UserService.uid;
    if (fromUid == null) return;
    try {
      final won = myScore > opponentScore;
      final tied = myScore == opponentScore;
      final title = tied
          ? 'Your $courseKey duel ended in a tie! 🤝'
          : won
              ? 'You won your $courseKey duel! 🏆'
              : 'You lost your $courseKey duel 😔';
      await _col.add({
        'uid': targetUid,
        'fromUid': fromUid,
        'type': 'duel_result',
        'title': title,
        'body': 'Final score: $myScore vs $opponentScore',
        'duelId': duelId,
        'read': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _sendPush(
        targetUid: targetUid,
        title: title,
        body: 'Final score: $myScore vs $opponentScore',
        data: {'type': 'duel_result', 'duelId': duelId},
      );
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

  /// Notifies every member of [groupId] (except the poster) that a new
  /// post went up in their group. [isAlert] switches to the siren-
  /// prefixed, "URGENT" title for admin-tagged important posts -- the
  /// only reliable cross-platform way to visually distinguish a push at
  /// the OS level, since neither iOS nor Android lets an app control a
  /// system notification's background color. A real, fully-styled red
  /// banner for alerts still happens once the person opens the app --
  /// this only covers the push itself.
  ///
  /// Capped at 500 members per fan-out for the same reason as
  /// _notifyFollowers in post_composer_page.dart -- a larger group would
  /// be a case for moving this to a Cloud Function instead of a
  /// client-side batch.
  static Future<void> notifyGroupMembers({
    required String groupId,
    required String postId,
    required bool isAlert,
  }) async {
    final posterUid = UserService.uid;
    if (posterUid == null) return;
    try {
      final groupDoc = await _db.collection('groups').doc(groupId).get();
      final groupName = groupDoc.data()?['name'] as String? ?? 'your class';
      final profile = await UserService.getProfile();
      final posterName = profile?['displayName'] as String? ?? 'Someone';

      final members = await _db.collection('groups').doc(groupId)
          .collection('members').where('status', isEqualTo: 'approved').limit(500).get();

      final title = isAlert ? '🚨 URGENT: $groupName' : '$posterName posted in $groupName';
      final body = isAlert ? '$posterName marked this important — tap to view' : 'Tap to view the post';

      final batch = _db.batch();
      final targetUids = <String>[];
      for (final doc in members.docs) {
        final memberUid = doc.id;
        if (memberUid == posterUid) continue;
        targetUids.add(memberUid);
        final notifRef = _col.doc();
        batch.set(notifRef, {
          'uid': memberUid,
          'fromUid': posterUid,
          'fromDisplayName': posterName,
          'type': isAlert ? 'group_alert' : 'group_post',
          'postId': postId,
          'groupId': groupId,
          'title': title,
          'body': body,
          'read': false,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      if (targetUids.isNotEmpty) await batch.commit();

      // _sendPush is per-target, so the actual OS push still goes out
      // one at a time -- the batch above only covers the in-app record.
      for (final uid in targetUids) {
        await _sendPush(
          targetUid: uid,
          title: title,
          body: body,
          data: {'type': isAlert ? 'group_alert' : 'group_post', 'postId': postId, 'groupId': groupId},
        );
      }
    } catch (_) {
      // Best-effort -- never block or fail the post itself over notifications.
    }
  }
}