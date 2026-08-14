// lib/core/services/hashtag_service.dart
//
// Hashtags come from #word patterns typed naturally into a post's own
// text -- no separate tagging UI, matching how Twitter/Instagram do
// it. Extracted once at post-creation time and stored as a queryable
// array field on the post doc, so "find posts tagged #calculus" is a
// simple array-contains query, no separate collection needed for
// basic tagging.
//
// This is deliberately the groundwork piece, not the full video
// recommendation system -- the extracted tags are exactly what a
// future "more like this" ranking would use as one of its signals
// (alongside courseTag, university, and engagement counts), but
// building that ranking/UI is a separate, much larger piece.

import 'package:cloud_firestore/cloud_firestore.dart';

class HashtagService {
  HashtagService._();

  static final _db = FirebaseFirestore.instance;

  // #word -- letters, numbers, underscores, at least 2 characters so a
  // bare "#" typed alone doesn't count as a tag.
  static final RegExp _pattern = RegExp(r'#([a-zA-Z0-9_]{2,50})');

  /// Extracts and normalizes (lowercase, deduplicated) hashtags from
  /// raw post text. Call this once at post-creation time.
  static List<String> extractHashtags(String text) {
    final matches = _pattern.allMatches(text);
    final tags = matches.map((m) => m.group(1)!.toLowerCase()).toSet().toList();
    return tags;
  }

  /// Live feed of posts carrying a given hashtag, newest first. Useful
  /// both for a future "browse by hashtag" screen and as a direct input
  /// into content recommendation later.
  static Stream<List<Map<String, dynamic>>> postsWithHashtag(String tag) {
    final normalized = tag.toLowerCase().replaceAll('#', '');
    return _db
        .collection('posts')
        .where('hashtags', arrayContains: normalized)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((s) => s.docs.map((d) => {'id': d.id, ...d.data()}).toList());
  }
}