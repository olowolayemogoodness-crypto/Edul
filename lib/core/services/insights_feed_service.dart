// lib/core/services/insights_feed_service.dart
//
// Query logic for the Insights feed, separated out from the page's UI
// code. Handles three things that used to be one giant client-side
// filter over a single flat 50-doc batch:
//
//   1. Category-scoped queries (Educational vs Entertainment), each
//      with its own Firestore query rather than filtering one shared
//      batch — otherwise uploading 50 entertainment clips in an evening
//      could leave the Educational tab looking empty (the shared batch
//      would be entirely entertainment).
//
//   2. Recency + randomization mix: the first _recentSlotCount videos
//      are newest-first (so a fresh upload gets a guaranteed initial
//      push), the rest are drawn randomly from the whole category pool
//      via a `rand` field written at upload time. Pure newest (the old
//      behaviour) caps every user to the same ~50 videos forever; pure
//      random risks a brand-new upload never surfacing for hours.
//
//   3. seenInsights consolidated into ONE document per user (an array
//      of recently-watched ids, capped) instead of one document PER
//      watched video. The old shape meant every app open read the
//      user's entire watch history — a user 500 videos deep cost 500
//      reads just to open the feed. One document costs one read,
//      regardless of history size.
//
// Firestore rules required:
//
//   Two composite indexes (Firestore will also offer to auto-create
//   these the first time the query runs and fails — click the link in
//   the error, or create manually):
//     insights: category ASC, uploadedAt DESC   (recency slice)
//     insights: category ASC, rand ASC          (random slice)
//
//   Rule change — REPLACE the old per-video seenInsights rule with a
//   single-document version:
//
//   OLD (remove this):
//     match /seenInsights/{videoId} {
//       allow read, write: if request.auth != null && request.auth.uid == userId;
//     }
//
//   NEW (add this instead, as a sibling to studyStats/tutorUsage, not
//   nested — it's now a single doc, not a subcollection):
//     match /seenInsightsLog/{userId} {
//       allow read, write: if request.auth != null && request.auth.uid == userId;
//     }
//
//   (Yes, this second one lives at the top level next to `users`, not
//   nested inside it — see _seenDocRef below for why: a single doc per
//   user keyed by uid is simpler to reference than digging into a
//   subcollection for what's now just one document.)

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

enum InsightsCategory { educational, entertainment }

extension InsightsCategoryX on InsightsCategory {
  String get key => this == InsightsCategory.educational ? 'educational' : 'entertainment';
}

class InsightsFeedService {
  InsightsFeedService._();

  static final _db = FirebaseFirestore.instance;

  // How many of the first N cards in a session are "newest first" before
  // the rest becomes randomized. Tune this without touching the query
  // logic itself.
  static const int recentSlotCount = 8;
  static const int totalPerLoad = 40;

  // Cap on how many watched-video ids we remember. Old entries roll off
  // the front once this is exceeded — see _recordSeen.
  static const int seenHistoryCap = 500;

  static CollectionReference<Map<String, dynamic>> _insights() =>
      _db.collection('insights');

  /// Loads one batch for [category]: the first [recentSlotCount] are
  /// newest-first, the remainder is drawn randomly from the category's
  /// whole pool. Expired videos (past `expiresAt`) are filtered out.
  /// Already-seen videos are pushed to the back rather than excluded,
  /// so a category with little content doesn't run dry.
  static Future<List<Map<String, dynamic>>> loadBatch({
    required InsightsCategory category,
    required Set<String> seenIds,
  }) async {
    final now = Timestamp.now();
    final catKey = category.key;

    // ── Recent slice ──────────────────────────────────────────────────
    final recentSnap = await _insights()
        .where('category', isEqualTo: catKey)
        .orderBy('uploadedAt', descending: true)
        .limit(recentSlotCount)
        .get();

    // ── Random slice ──────────────────────────────────────────────────
    // Firestore has no native random query — the standard workaround is
    // a stored `rand` field (0.0–1.0 written at upload) queried from a
    // random pivot point, wrapping around if the tail end comes up
    // short. Two queries because the first one might not return enough
    // documents if the pivot lands near the top of the range.
    final pivot = Random().nextDouble();
    final remaining = totalPerLoad - recentSnap.docs.length;

    var randomDocs = (await _insights()
        .where('category', isEqualTo: catKey)
        .where('rand', isGreaterThanOrEqualTo: pivot)
        .orderBy('rand')
        .limit(remaining)
        .get()).docs;

    if (randomDocs.length < remaining) {
      final wrapSnap = await _insights()
          .where('category', isEqualTo: catKey)
          .where('rand', isLessThan: pivot)
          .orderBy('rand')
          .limit(remaining - randomDocs.length)
          .get();
      randomDocs = [...randomDocs, ...wrapSnap.docs];
    }

    // Merge, de-dupe (a video could land in both slices), filter expired.
    final seenDocIds = <String>{};
    final merged = <Map<String, dynamic>>[];

    for (final doc in [...recentSnap.docs, ...randomDocs]) {
      if (seenDocIds.contains(doc.id)) continue;
      seenDocIds.add(doc.id);
      final data = doc.data();
      final exp = data['expiresAt'] as Timestamp?;
      if (exp == null || exp.compareTo(now) <= 0) continue;
      merged.add({'id': doc.id, ...data});
    }

    // Already-seen videos sink to the back rather than being dropped —
    // a thin category shouldn't ever show "no videos" just because the
    // user watched everything in it once already.
    final unseen = merged.where((v) => !seenIds.contains(v['id'])).toList();
    final seen = merged.where((v) => seenIds.contains(v['id'])).toList();
    return [...unseen, ...seen];
  }

  // ── Consolidated seenInsights (one doc per user, not one per video) ──

  static DocumentReference<Map<String, dynamic>>? _seenDocRef() {
    final uid = UserService.uid;
    if (uid == null) return null;
    return _db.collection('seenInsightsLog').doc(uid);
  }

  /// Single read, regardless of how much watch history exists — this is
  /// the fix for the old one-document-per-watched-video shape, which
  /// cost one Firestore read per video ever watched, every app open.
  static Future<Set<String>> loadSeenIds() async {
    final ref = _seenDocRef();
    if (ref == null) return {};
    try {
      final snap = await ref.get();
      final ids = (snap.data()?['ids'] as List<dynamic>?) ?? [];
      return ids.cast<String>().toSet();
    } catch (_) {
      return {};
    }
  }

  /// Appends [videoId] to the user's seen list, capped at
  /// [seenHistoryCap] (oldest entries drop off the front). Best-effort —
  /// never blocks playback if it fails.
  static void recordSeen(String videoId, List<String> currentOrder) {
    final ref = _seenDocRef();
    if (ref == null) return;
    final updated = [...currentOrder, videoId];
    final capped = updated.length > seenHistoryCap
        ? updated.sublist(updated.length - seenHistoryCap)
        : updated;
    ref.set({'ids': capped}, SetOptions(merge: false)).catchError((_) {});
  }
}