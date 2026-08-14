// lib/core/services/user_follow_service.dart
//
// Follow relationships are stored as one doc per follower under the
// FOLLOWED user's own document — same pattern as post likes:
//   users/{targetUid}/followers/{followerId}
//
// This means the only person who ever writes a given doc is the follower
// themselves (writing their own uid as the doc ID), so it's safe under
// Firestore rules without needing the target user's permission — no
// spoofing risk, same reasoning as posts/{postId}/likes/{uid}.
//
// Firestore rule required — ADD nested inside your existing
// `match /users/{userId} { ... }` block:
//
//   match /followers/{followerId} {
//     allow read: if request.auth != null;
//     allow create, delete: if request.auth != null
//                            && request.auth.uid == followerId;
//   }

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notifications_service.dart';
import 'user_service.dart';
import 'user_tier_service.dart';

class UserFollowService {
  UserFollowService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference _followersOf(String uid) =>
      _db.collection('users').doc(uid).collection('followers');

  /// Whether the current user follows [targetUid].
  static Stream<bool> isFollowing(String targetUid) {
    final myUid = UserService.uid;
    if (myUid == null) return Stream.value(false);
    return _followersOf(targetUid).doc(myUid).snapshots().map((d) => d.exists);
  }

  /// Live follower count for [uid].
  static Stream<int> followerCount(String uid) {
    return _followersOf(uid).snapshots().map((s) => s.docs.length);
  }

  /// Live count of how many people [uid] follows. Direct query on their
  /// own following subcollection -- toggleFollow() already mirrors the
  /// relationship there specifically so this never needs a
  /// collection-group scan. The previous version used
  /// collectionGroup('followers') searching the ENTIRE app for
  /// followerUid==uid, which was both unnecessary (this simpler data
  /// was sitting right there the whole time) and broken (no rule
  /// permits a collection-group query on followers, so it was failing
  /// with PERMISSION_DENIED on every single call).
  static Stream<int> followingCount(String uid) {
    return _db.collection('users').doc(uid).collection('following').snapshots().map((s) => s.docs.length);
  }

  /// Toggles follow state for [targetUid]. Sends a notification on a new
  /// follow (not on unfollow). Also mirrors the relationship into
  /// users/{myUid}/following/{targetUid} — I own that subcollection, so
  /// I can always query "who do I follow" directly and reliably, instead
  /// of a collection-group query (which needs its own careful rule
  /// matching and has been flaky before in this app).
  static Future<void> toggleFollow(String targetUid) async {
    final myUid = UserService.uid;
    if (myUid == null || myUid == targetUid) return;
    final ref = _followersOf(targetUid).doc(myUid);
    final mirrorRef = _db.collection('users').doc(myUid)
        .collection('following').doc(targetUid);
    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
      await mirrorRef.delete();
      await UserTierService.adjustScore(targetUid, -5);
    } else {
      await ref.set({
        'followerUid': myUid,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await mirrorRef.set({
        'targetUid': targetUid,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await UserTierService.adjustScore(targetUid, 5);
      await NotificationService.createFollowNotification(targetUid);
    }
  }

  /// Every uid the current user follows — used to scope repost visibility
  /// to followers only. A direct query on my own subcollection, not a
  /// collection-group query, so it's fast and doesn't need special rules.
  static Future<Set<String>> myFollowingUids() async {
    final myUid = UserService.uid;
    if (myUid == null) return {};
    final snap = await _db.collection('users').doc(myUid).collection('following').get();
    return snap.docs.map((d) => d.id).toSet();
  }

  /// Every uid that follows the current user — direct query on my own
  /// followers subcollection.
  static Future<Set<String>> myFollowerUids() async {
    final myUid = UserService.uid;
    if (myUid == null) return {};
    final snap = await _followersOf(myUid).get();
    return snap.docs.map((d) => d.id).toSet();
  }

  /// "Friends" = mutual follows: people in both my following and my
  /// followers list. One-time fetch; use [myFriendCount] for a live
  /// updating count instead.
  static Future<Set<String>> myFriendUids() async {
    final following = await myFollowingUids();
    final followers = await myFollowerUids();
    return following.intersection(followers);
  }

  /// Live mutual-follow ("friends") count for the current user. Combines
  /// the following and followers streams manually -- a friend can appear
  /// or disappear from either side independently, so both need to be
  /// watched live, not just fetched once. No rxdart dependency; this repo
  /// doesn't have it, and one combine-latest doesn't justify adding it.
  static Stream<int> myFriendCount() {
    final myUid = UserService.uid;
    if (myUid == null) return Stream.value(0);

    Set<String>? followingUids;
    Set<String>? followerUids;
    StreamSubscription? followingSub, followerSub;
    late StreamController<int> controller;

    void emit() {
      if (followingUids != null && followerUids != null) {
        controller.add(followingUids!.intersection(followerUids!).length);
      }
    }

    controller = StreamController<int>.broadcast(
      onListen: () {
        followingSub = _db
            .collection('users').doc(myUid).collection('following')
            .snapshots()
            .listen((snap) {
          followingUids = snap.docs.map((d) => d.id).toSet();
          emit();
        });
        followerSub = _followersOf(myUid).snapshots().listen((snap) {
          followerUids = snap.docs.map((d) => d.id).toSet();
          emit();
        });
      },
      onCancel: () {
        followingSub?.cancel();
        followerSub?.cancel();
      },
    );

    return controller.stream;
  }
}