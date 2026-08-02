// lib/core/services/insights_interaction_service.dart
//
// Likes for Insights (Discover tab) videos: one doc per user under
// insights/{videoId}/likes/{uid} answers "did I like this" in O(1) (no
// cross-user write needed, liker only ever writes their own doc). The
// DISPLAYED count, though, is a denormalized `likeCount` field on the
// video doc itself, updated transactionally — NOT derived by counting
// the likes subcollection. Reading a subcollection to count it bills one
// Firestore read per document in it, every time the count is shown; a
// video with thousands of likes would cost thousands of reads just to
// display "thousands of likes" to one viewer. A field costs zero extra
// reads (it's already part of the video doc you fetch to show the
// video at all).
//
// Firestore rules required — ADD nested inside your existing
// `match /insights/{docId} { ... }` block (the existing `allow write:
// if false` on the video doc itself is unaffected by either of these —
// Firestore stacks rules, it doesn't replace them):
//
//   match /likes/{uid} {
//     allow read: if request.auth != null;
//     allow create, delete: if request.auth != null && request.auth.uid == uid;
//   }
//   allow update: if request.auth != null
//                 && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['likeCount']);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class InsightsInteractionService {
  InsightsInteractionService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference _videos() => _db.collection('insights');

  static Stream<bool> isLikedByMe(String videoId) {
    final uid = UserService.uid;
    if (uid == null) return Stream.value(false);
    return _videos().doc(videoId).collection('likes').doc(uid)
        .snapshots().map((d) => d.exists);
  }

  static Stream<int> likeCount(String videoId) {
    return _videos().doc(videoId).snapshots()
        .map((d) => (d.data() as Map<String, dynamic>?)?['likeCount'] as int? ?? 0);
  }

  static Future<void> toggleLike(String videoId) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final likeRef = _videos().doc(videoId).collection('likes').doc(uid);
    final videoRef = _videos().doc(videoId);
    final doc = await likeRef.get();

    // A batch, not a transaction: transactions are for read-then-write,
    // and neither branch here needs to read the current count —
    // FieldValue.increment resolves atomically server-side on its own.
    // The batch just guarantees the like doc and the counter move
    // together, so they can't drift apart if one write fails.
    final batch = _db.batch();
    if (doc.exists) {
      batch.delete(likeRef);
      batch.update(videoRef, {'likeCount': FieldValue.increment(-1)});
    } else {
      batch.set(likeRef, {'uid': uid, 'createdAt': FieldValue.serverTimestamp()});
      batch.update(videoRef, {'likeCount': FieldValue.increment(1)});
    }
    await batch.commit();
  }
}