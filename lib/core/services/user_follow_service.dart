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

  /// Live count of how many people [uid] follows. Since a "following"
  /// entry only exists as a side-effect of a "followers" doc on the
  /// OTHER user's document, this requires a collection-group query.
  static Stream<int> followingCount(String uid) {
    return _db
        .collectionGroup('followers')
        .where('followerUid', isEqualTo: uid)
        .snapshots()
        .map((s) => s.docs.length);
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
}