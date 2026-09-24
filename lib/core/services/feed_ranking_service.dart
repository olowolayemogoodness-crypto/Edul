// lib/core/services/feed_ranking_service.dart
//
// Turns the feed from pure reverse-chronological into a lightweight
// "For You"-style ranking: recency + a boost for posts reposted by
// someone you follow (free -- reuses the following set the feed
// already caches) + a boost for posts liked by someone you follow
// (the one signal that actually costs real reads, see below).
//
// This is a client-side scoring pass over an already-bounded recent
// batch of posts, not a true server-side ranking pipeline -- a known,
// accepted v1 limitation, not an oversight.
//
// COST TRADE-OFF on the like-signal specifically: finding "did anyone
// I follow like this post" cheaply isn't possible with the current
// data shape (no reverse index of "what has person X liked"). The
// alternative -- flip the question to "what has each person I follow
// liked recently" via a collection-group query on `likes` (each like
// doc already stores a `uid` field, not just being keyed by it) --
// costs one query PER followed person checked. Left uncapped, that
// scales with how many people someone follows, and multiplied across
// every user opening their feed repeatedly, becomes a real, recurring
// Firestore bill (worked out to roughly $130/month at rough estimated
// usage in the conversation this was scoped in) plus real added feed
// load time. Capping to a person's most-recent N followed accounts
// keeps this bounded and roughly flat regardless of total follow
// count, at the cost of missing the signal for people they follow but
// rarely see activity from anyway -- an acceptable trade.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class FeedRankingService {
  FeedRankingService._();

  static final _db = FirebaseFirestore.instance;

  /// Capped, not exhaustive -- see the cost trade-off note above. This
  /// is intentionally separate from UserFollowService.myFollowingUids(),
  /// which the feed already uses uncapped for repost-visibility
  /// filtering; that one needs the FULL set, this one deliberately
  /// doesn't.
  static Future<List<String>> myFollowingCapped({int limit = 20}) async {
    final myUid = UserService.uid;
    if (myUid == null) return [];
    final snap = await _db.collection('users').doc(myUid)
        .collection('following').limit(limit).get();
    return snap.docs.map((d) => d.id).toList();
  }

  /// Maps post id -> up to a few {uid, name} pairs of followed people
  /// who liked that post (uid needed so the UI can render a
  /// consistent avatar color per person, not just their name), plus
  /// the flat set of post ids (for ranking). Built from the same
  /// bounded per-person queries -- adds one extra read per followed
  /// person (their displayName), still bounded by the same cap.
  static Future<({Map<String, List<Map<String, String>>> likers, Set<String> postIds})>
      postsLikedByFollowing(List<String> followedUids) async {
    if (followedUids.isEmpty) return (likers: <String, List<Map<String, String>>>{}, postIds: <String>{});
    try {
      final results = await Future.wait(followedUids.map((uid) async {
        final userDoc = await _db.collection('users').doc(uid).get();
        final likesSnap = await _db.collectionGroup('likes')
            .where('uid', isEqualTo: uid)
            .orderBy('createdAt', descending: true)
            .limit(10)
            .get();
        final name = userDoc.data()?['displayName'] as String? ?? 'Someone';
        final photoUrl = userDoc.data()?['photoUrl'] as String?;
        return (uid: uid, name: name, photoUrl: photoUrl, likes: likesSnap);
      }));

      final likers = <String, List<Map<String, String>>>{};
      for (final entry in results) {
        for (final doc in entry.likes.docs) {
          // Each like doc lives at posts/{postId}/likes/{likerUid} --
          // the post id is the parent-of-parent segment.
          final postId = doc.reference.parent.parent?.id;
          if (postId == null) continue;
          likers.putIfAbsent(postId, () => []);
          if (!likers[postId]!.any((l) => l['uid'] == entry.uid)) {
            likers[postId]!.add({
              'uid': entry.uid,
              'name': entry.name,
              if (entry.photoUrl != null) 'photoUrl': entry.photoUrl!,
            });
          }
        }
      }
      return (likers: likers, postIds: likers.keys.toSet());
    } catch (e) {
      // ignore: avoid_print
      print('[FeedRankingService] postsLikedByFollowing failed: $e');
      return (likers: <String, List<Map<String, String>>>{}, postIds: <String>{});
    }
  }

  /// Scores and sorts [posts]. Higher score first.
  static List<Map<String, dynamic>> rank(
    List<Map<String, dynamic>> posts, {
    required Set<String> myFollowing,
    required Set<String> likedByFollowingPostIds,
    Set<String> recentlySearchedUids = const {},
  }) {
    final now = DateTime.now();
    final scored = posts.map((post) {
      double score = 0;

      final createdAt = post['createdAt'];
      if (createdAt is Timestamp) {
        final hoursAgo = now.difference(createdAt.toDate()).inMinutes / 60.0;
        // Decays over roughly a couple of days but never hits zero --
        // a great old post can still surface, just needs the other
        // signals to outweigh a fresher, less-engaged one.
        score += 100 * (1 / (1 + hoursAgo / 12));
      }

      // Free -- reuses the already-cached following set, no extra read.
      if (post['type'] == 'repost') {
        final reposterUid = post['uid'] as String?;
        if (reposterUid != null && myFollowing.contains(reposterUid)) score += 40;
      }

      final postId = (post['id'] as String?) ?? (post['originalPostId'] as String?);
      if (postId != null && likedByFollowingPostIds.contains(postId)) score += 25;


      final authorUid = post['uid'] as String?;
      if (authorUid != null && recentlySearchedUids.contains(authorUid)) score += 30;
      
      return MapEntry(post, score);
    }).toList();

    scored.sort((a, b) => b.value.compareTo(a.value));
    return scored.map((e) => e.key).toList();
  }
}