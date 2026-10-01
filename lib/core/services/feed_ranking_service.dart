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
    Set<String> myInterests = const {},
    Map<String, int> relationshipStrength = const {},
    Set<String> seenPostIds = const {},
    Set<String> myJoinedCommunityIds = const {},
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

        // Popularity velocity: how FAST a post is gaining engagement
        // relative to its age, not just its raw totals -- rewards a
        // post blowing up quickly over one that slowly accumulated
        // the same numbers over days. Uses fields already on every
        // post (likeCount/commentCount), no new tracking needed.
        // Comments count double since they're a stronger signal of
        // engagement than a like. A floor of 0.5h avoids a divide-by-
        // near-zero spike for posts that are only seconds old.
        final likeCount = (post['likeCount'] as num?)?.toInt() ?? 0;
        final commentCount = (post['commentCount'] as num?)?.toInt() ?? 0;
        final velocityAge = hoursAgo < 0.5 ? 0.5 : hoursAgo;
        final velocity = (likeCount + commentCount * 2) / velocityAge;
        score += (velocity * 3).clamp(0, 20);
      }

      // Free -- reuses the already-cached following set, no extra read.
      if (post['type'] == 'repost') {
        final reposterUid = post['uid'] as String?;
        if (reposterUid != null && myFollowing.contains(reposterUid)) score += 40;
      }

      final postId = (post['id'] as String?) ?? (post['originalPostId'] as String?);
      if (postId != null && likedByFollowingPostIds.contains(postId)) score += 25;

      // Also free -- search history is local SharedPreferences, not a
      // Firestore read, so this costs nothing beyond what
      // SearchHistoryService already keeps in memory. Weighted between
      // the repost boost (a stronger, ongoing follow relationship) and
      // the like boost (a passive signal from someone else) -- actively
      // searching for a specific person is a deliberate act of
      // interest, stronger than a passive like but not as strong as
      // already following them.
      final authorUid = post['uid'] as String?;
      if (authorUid != null && recentlySearchedUids.contains(authorUid)) score += 30;

      // Free -- authorInterests is denormalized onto the post at
      // creation time (same pattern as displayName/photoUrl), so this
      // needs no extra read. Capped so one person with a huge overlap
      // doesn't dominate every post they've ever made; this is meant
      // to be a gentle nudge toward relevance, not a hard override.
      if (myInterests.isNotEmpty) {
        final authorInterests = (post['authorInterests'] as List<dynamic>?)?.cast<String>() ?? [];
        final overlap = authorInterests.where((i) => myInterests.contains(i)).length;
        score += (overlap * 8).clamp(0, 24);
      }

      // Free -- relationshipStrength is fetched once per feed load
      // (top 50 people you've actually engaged with), not per post.
      // Someone you follow AND regularly like/comment on ranks above
      // someone you follow but have never once interacted with --
      // "following" alone is a weaker signal than genuine engagement
      // history, matching how Instagram treats relationship strength.
      final postAuthorUid = post['uid'] as String?;
      if (postAuthorUid != null && relationshipStrength.containsKey(postAuthorUid)) {
        score += (relationshipStrength[postAuthorUid]! * 1.5).clamp(0, 30);
      }

      // A post tagged with a community shows preferentially to THAT
      // community's own members specifically -- not a general boost
      // for everyone, tied to actual membership. Deliberately strong
      // (35) since this is meant to feel like "your community's post
      // reached you", not a minor nudge.
      final taggedCommunityId = post['communityId'] as String?;
      if (taggedCommunityId != null && myJoinedCommunityIds.contains(taggedCommunityId)) {
        score += 35;
      }

      // Heavily deprioritized, not removed -- if someone has genuinely
      // seen everything available (e.g. nothing new posted in hours),
      // they should still see something rather than an empty feed.
      // The moment anything new or unseen exists, it wins by a wide
      // margin regardless of this post's other scores.
      if (postId != null && seenPostIds.contains(postId)) {
        score *= 0.15;
      }

      return MapEntry(post, score);
    }).toList();

    scored.sort((a, b) => b.value.compareTo(a.value));
    return _applyAntiFatigueSpacing(scored.map((e) => e.key).toList());
  }

  /// Ensures no two adjacent posts share the same author, applied
  /// after ranking -- a structural rule, not a scoring change,
  /// matching how Instagram's own "creator spacing" works. Greedy
  /// lookahead: if two same-author posts would land adjacent, the
  /// nearest later post from a different author gets swapped forward
  /// to break up the run, preserving the overall ranked order as much
  /// as possible rather than reshuffling everything.
  static List<Map<String, dynamic>> _applyAntiFatigueSpacing(List<Map<String, dynamic>> ranked) {
    final result = List<Map<String, dynamic>>.from(ranked);
    for (var i = 1; i < result.length; i++) {
      final prevAuthor = result[i - 1]['uid'];
      if (result[i]['uid'] == prevAuthor) {
        var swapIndex = -1;
        for (var j = i + 1; j < result.length; j++) {
          if (result[j]['uid'] != prevAuthor) {
            swapIndex = j;
            break;
          }
        }
        if (swapIndex != -1) {
          final temp = result[i];
          result[i] = result[swapIndex];
          result[swapIndex] = temp;
        }
        // If nothing later has a different author (e.g. the rest of
        // the pool is all the same person), leave it -- nothing to
        // swap with, and forcing a gap would mean dropping content
        // rather than just reordering it.
      }
    }
    return result;
  }
}