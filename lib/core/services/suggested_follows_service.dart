// lib/core/services/suggested_follows_service.dart
//
// Reuses the interest picker data from onboarding (users/{uid}.
// interests) for two things at once: this suggested-follows list,
// and (separately) interest-overlap boosting in FeedRankingService.
// No new tagging system on posts needed -- we already know who
// people are, just not what any given post is "about", which is
// fine since this only needs the former.
//
// Firestore's array-contains-any can't rank by HOW MANY interests
// overlap, only "at least one matches" -- so this pulls a bounded
// candidate pool that way, then computes the real overlap count and
// sorts client-side, same "bounded query + client-side refinement"
// pattern used elsewhere tonight (post/community search).

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';
import 'user_follow_service.dart';

class SuggestedFollowsService {
  SuggestedFollowsService._();

  static final _db = FirebaseFirestore.instance;

  static Future<List<Map<String, dynamic>>> suggestedFollows({int limit = 10}) async {
    final uid = UserService.uid;
    if (uid == null) return [];

    final myProfile = await UserService.getProfile();
    final myInterests = (myProfile?['interests'] as List<dynamic>?)?.cast<String>() ?? [];
    if (myInterests.isEmpty) return [];

    // array-contains-any accepts at most 10 values -- interests are
    // capped at a handful per user from onboarding anyway, so this
    // rarely truncates anything real.
    final queryInterests = myInterests.take(10).toList();

    final myFollowing = await UserFollowService.myFollowingUids();

    final snap = await _db.collection('users')
        .where('interests', arrayContainsAny: queryInterests)
        .limit(50)
        .get();

    final candidates = snap.docs
        .where((d) => d.id != uid && !myFollowing.contains(d.id))
        .map((d) {
          final data = d.data();
          final theirInterests = (data['interests'] as List<dynamic>?)?.cast<String>() ?? [];
          final overlap = theirInterests.where((i) => myInterests.contains(i)).length;
          return {'uid': d.id, ...data, 'overlapCount': overlap};
        })
        .where((c) => (c['overlapCount'] as int) > 0)
        .toList();

    candidates.sort((a, b) => (b['overlapCount'] as int).compareTo(a['overlapCount'] as int));
    return candidates.take(limit).toList();
  }
}