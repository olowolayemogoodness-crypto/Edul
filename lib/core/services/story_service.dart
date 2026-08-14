// lib/core/services/story_service.dart
//
// Data model:
//   stories/{storyId}                    -- uid, type, mediaUrl/textContent,
//                                            createdAt, expiresAt (24h)
//   users/{uid}/watchedStories/{storyId} -- mirror, one doc per story
//                                            this user has viewed
//
// Fully public per the earlier decision -- no follower/group scoping.
// "Watched" tracking mirrors into the VIEWER's own subcollection (same
// pattern as myGroups/following) so checking "have I seen this" is a
// cheap read on my own data, not a query against every story.
//
// Stories are grouped by uid for the row/grid UI -- each person shows
// once, with their most recent story as the preview and "unwatched" if
// ANY of their stories haven't been seen yet.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';
import 'notifications_service.dart';

enum StoryType { image, video, text }

class StoryService {
  StoryService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> _stories() => _db.collection('stories');

  static Future<void> postStory({
    required StoryType type,
    String? mediaUrl,
    String? textContent,
    String? backgroundColor,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final profile = await UserService.getProfile();
    final displayName = profile?['displayName'] as String? ?? 'User';
    final usernameDisplay = profile?['usernameDisplay'] as String?;
    final photoUrl = profile?['photoUrl'] as String?;

    final now = DateTime.now();
    final storyRef = await _stories().add({
      'uid': uid,
      'displayName': displayName,
      'usernameDisplay': usernameDisplay,
      'photoUrl': photoUrl,
      'type': type.name,
      'mediaUrl': mediaUrl,
      'textContent': textContent,
      'backgroundColor': backgroundColor,
      'createdAt': Timestamp.fromDate(now),
      'expiresAt': Timestamp.fromDate(now.add(const Duration(hours: 24))),
    });

    final audience = await notificationAudienceFor(uid);
    final label = usernameDisplay != null && usernameDisplay.trim().isNotEmpty
        ? '@$usernameDisplay' : displayName;
    await NotificationService.notifyMultipleUsers(
      targetUids: audience,
      fromUid: uid,
      title: '$label posted a new story',
      body: 'Tap to view it before it disappears',
      data: {'type': 'new_story', 'storyId': storyRef.id},
    );
  }

  /// Live, grouped-by-user story list for the row/grid. Each entry is
  /// one person with their stories (newest first) and whether ALL of
  /// them have been watched by the current viewer.
  ///
  /// Genuinely live now -- listens to BOTH the stories collection AND
  /// the current user's own watchedStories collection, and recomputes
  /// whenever EITHER changes. The original version only listened to
  /// stories, so marking something watched never triggered a refresh
  /// on its own (a completely different collection was being written
  /// to) -- the ring would only update whenever something unrelated
  /// happened to re-fire the stream next.
  static Stream<List<Map<String, dynamic>>> activeStoriesByUser() {
    final myUid = UserService.uid;
    final controller = StreamController<List<Map<String, dynamic>>>.broadcast();

    List<QueryDocumentSnapshot<Map<String, dynamic>>>? latestStories;

    Future<void> emit() async {
      if (latestStories == null) return;
      final all = latestStories!.map((d) => {'id': d.id, ...d.data()}).toList();
      all.sort((a, b) => (b['createdAt'] as Timestamp).compareTo(a['createdAt'] as Timestamp));

      final watchedIds = myUid == null ? <String>{} : await _myWatchedIds();

      final grouped = <String, List<Map<String, dynamic>>>{};
      for (final s in all) {
        grouped.putIfAbsent(s['uid'] as String, () => []).add(s);
      }

      final result = grouped.entries.map((e) {
        final stories = e.value; // already recency-sorted, so .first is the newest
        final allWatched = stories.every((s) => watchedIds.contains(s['id']));
        return {
          'uid': e.key,
          'displayName': stories.first['displayName'],
          'usernameDisplay': stories.first['usernameDisplay'],
          'photoUrl': stories.first['photoUrl'],
          'storyCount': stories.length,
          'watched': allWatched,
          'isMe': e.key == myUid,
          'mostRecentCreatedAt': stories.first['createdAt'] as Timestamp,
        };
      }).toList()
        // Your own story always first, then unwatched before watched --
        // and NOW genuinely tie-broken by recency within each group,
        // not left to incidental map-iteration order.
        ..sort((a, b) {
          if (a['isMe'] == true) return -1;
          if (b['isMe'] == true) return 1;
          if (a['watched'] != b['watched']) return a['watched'] == true ? 1 : -1;
          return (b['mostRecentCreatedAt'] as Timestamp).compareTo(a['mostRecentCreatedAt'] as Timestamp);
        });

      if (!controller.isClosed) controller.add(result);
    }

    final storiesSub = _stories()
        .where('expiresAt', isGreaterThan: Timestamp.now())
        .snapshots()
        .listen((snap) { latestStories = snap.docs; emit(); });

    StreamSubscription? watchedSub;
    if (myUid != null) {
      watchedSub = _db.collection('users').doc(myUid).collection('watchedStories')
          .snapshots()
          .listen((_) { emit(); });
    }

    controller.onCancel = () {
      storiesSub.cancel();
      watchedSub?.cancel();
    };

    return controller.stream;
  }

  static Future<Set<String>> _myWatchedIds() async {
    final uid = UserService.uid;
    if (uid == null) return {};
    final snap = await _db.collection('users').doc(uid).collection('watchedStories').get();
    return snap.docs.map((d) => d.id).toSet();
  }

  static Stream<List<Map<String, dynamic>>> storiesForUser(String uid) {
    // Deliberately a single where() -- combining uid== with expiresAt>
    // needs a composite index, the exact same trap that caused the
    // profile-grid bug earlier tonight. Filtering expiry client-side
    // avoids that dependency entirely.
    return _stories()
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((s) {
      final now = Timestamp.now();
      final list = s.docs
          .map((d) => {'id': d.id, ...d.data()})
          .where((story) => (story['expiresAt'] as Timestamp).compareTo(now) > 0)
          .toList();
      list.sort((a, b) => (a['createdAt'] as Timestamp).compareTo(b['createdAt'] as Timestamp));
      return list;
    });
  }

  /// [ownerUid] is the story's creator -- required now so this can also
  /// mirror onto THEIR side (users/{ownerUid}/storyViewers/{viewerUid}),
  /// which is what makes "notify people who've viewed my stories before"
  /// a cheap direct read instead of a collection-group query.
  static Future<void> markWatched(String storyId, String ownerUid) async {
    final uid = UserService.uid;
    if (uid == null || uid == ownerUid) return; // don't mirror watching your own story
    await _db.collection('users').doc(uid).collection('watchedStories').doc(storyId).set({
      'watchedAt': FieldValue.serverTimestamp(),
    });
    await _db.collection('users').doc(ownerUid).collection('storyViewers').doc(uid).set({
      'lastViewedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Who should be notified when [uid] posts a new story: their
  /// followers, plus anyone who's viewed one of their stories before --
  /// deduplicated, so someone who's both a follower AND a past viewer
  /// only gets notified once.
  static Future<Set<String>> notificationAudienceFor(String uid) async {
    final followers = await _db.collection('users').doc(uid).collection('followers').get();
    final pastViewers = await _db.collection('users').doc(uid).collection('storyViewers').get();
    return {
      ...followers.docs.map((d) => d.id),
      ...pastViewers.docs.map((d) => d.id),
    };
  }
}