// lib/core/services/insights_interaction_service.dart
//
// Likes for Insights (Discover tab) videos, same pattern as post likes:
// one doc per user under insights/{videoId}/likes/{uid} — so the liker
// only ever writes their own doc, count is just how many docs exist,
// no cross-user write needed.
//
// Firestore rule required — ADD nested inside your existing
// `match /insights/{docId} { ... }` block (the existing `allow write:
// if false` on the video doc itself is unaffected — Firestore rules
// don't cascade into subcollections, so this needs its own rule):
//
//   match /likes/{uid} {
//     allow read: if request.auth != null;
//     allow create, delete: if request.auth != null && request.auth.uid == uid;
//   }

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
    return _videos().doc(videoId).collection('likes')
        .snapshots().map((s) => s.docs.length);
  }

  static Future<void> toggleLike(String videoId) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final ref = _videos().doc(videoId).collection('likes').doc(uid);
    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
    } else {
      await ref.set({'uid': uid, 'createdAt': FieldValue.serverTimestamp()});
    }
  }
}