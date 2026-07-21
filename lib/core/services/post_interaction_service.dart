// lib/core/services/post_interaction_service.dart
//
// Likes and reposts are stored as one doc per user under the post
// (posts/{postId}/likes/{uid} and posts/{postId}/reposts/{uid}) rather
// than as a counter field on the post document itself. This matters
// because your posts rule only lets the POST OWNER update the post doc
// — so another user liking your post could never increment a `likes`
// field on it. Using a subcollection means the liker only ever writes
// their own doc (which they own), and the count is just how many docs
// exist — no cross-user write required, no rule conflict.
//
// Comments work the same way: posts/{postId}/comments/{commentId}.
//
// Firestore rules required — ADD these nested inside your existing
// `match /posts/{postId} { ... }` block (don't replace what's there,
// just add these three nested matches alongside it):
//
//   match /likes/{uid} {
//     allow read: if request.auth != null;
//     allow create, delete: if request.auth != null && request.auth.uid == uid;
//   }
//   match /reposts/{uid} {
//     allow read: if request.auth != null;
//     allow create, delete: if request.auth != null && request.auth.uid == uid;
//   }
//   match /comments/{commentId} {
//     allow read: if request.auth != null;
//     allow create: if request.auth != null
//                    && request.auth.uid == request.resource.data.uid;
//     allow delete: if request.auth != null
//                    && request.auth.uid == resource.data.uid;
//
//     match /likes/{uid} {
//       allow read: if request.auth != null;
//       allow create, delete: if request.auth != null && request.auth.uid == uid;
//     }
//   }
//
// Post deletion reuses your EXISTING posts rule (owner-only update/delete)
// — no rule change needed for that part.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'notifications_service.dart';
import 'user_service.dart';

class PostInteractionService {
  PostInteractionService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference _posts() => _db.collection('posts');

  // ── Likes ──────────────────────────────────────────────────────────────
  static Stream<bool> isLikedByMe(String postId) {
    final uid = UserService.uid;
    if (uid == null) return Stream.value(false);
    return _posts().doc(postId).collection('likes').doc(uid)
        .snapshots().map((d) => d.exists);
  }

  static Stream<int> likeCount(String postId) {
    return _posts().doc(postId).collection('likes')
        .snapshots().map((s) => s.docs.length);
  }

  static Future<void> toggleLike(String postId) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final ref = _posts().doc(postId).collection('likes').doc(uid);
    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
    } else {
      await ref.set({'uid': uid, 'createdAt': FieldValue.serverTimestamp()});
    }
  }

  // ── Reposts ────────────────────────────────────────────────────────────
  static Stream<bool> isRepostedByMe(String postId) {
    final uid = UserService.uid;
    if (uid == null) return Stream.value(false);
    return _posts().doc(postId).collection('reposts').doc(uid)
        .snapshots().map((d) => d.exists);
  }

  static Stream<int> repostCount(String postId) {
    return _posts().doc(postId).collection('reposts')
        .snapshots().map((s) => s.docs.length);
  }

  static Future<void> toggleRepost(String postId) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final ref = _posts().doc(postId).collection('reposts').doc(uid);
    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
    } else {
      await ref.set({'uid': uid, 'createdAt': FieldValue.serverTimestamp()});
    }
  }

  // ── Comments ───────────────────────────────────────────────────────────
  static Stream<int> commentCount(String postId) {
    return _posts().doc(postId).collection('comments')
        .snapshots().map((s) => s.docs.length);
  }

  static Stream<List<Map<String, dynamic>>> comments(String postId) {
    return _posts().doc(postId).collection('comments')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((s) => s.docs.map((d) {
              final data = d.data();
              data['id'] = d.id;
              return data;
            }).toList());
  }

  static Future<void> addComment(String postId, String text) async {
    final uid = UserService.uid;
    if (uid == null || text.trim().isEmpty) return;
    final profile = await UserService.getProfile();
    final displayName = profile?['displayName'] as String? ?? 'User';
    final trimmed = text.trim();
    await _posts().doc(postId).collection('comments').add({
      'uid': uid,
      'displayName': displayName,
      'content': trimmed,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await _notifyPostOwner(postId: postId, commentPreview: trimmed);
  }

  /// Adds a voice-note comment. `content` is left empty — the UI renders
  /// a waveform player instead of text when `audioUrl` is present.
  static Future<void> addVoiceComment({
    required String postId,
    required String audioUrl,
    required int durationMs,
    required List<double> waveform,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final profile = await UserService.getProfile();
    final displayName = profile?['displayName'] as String? ?? 'User';
    await _posts().doc(postId).collection('comments').add({
      'uid': uid,
      'displayName': displayName,
      'content': '',
      'audioUrl': audioUrl,
      'durationMs': durationMs,
      'waveform': waveform,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await _notifyPostOwner(postId: postId, commentPreview: '');
  }

  /// Looks up the post's owner and fires a comment notification to them
  /// (no-op if commenting on your own post). Best-effort — a failed
  /// lookup/notification never blocks the comment itself, since the
  /// comment write above has already succeeded by the time this runs.
  static Future<void> _notifyPostOwner({
    required String postId,
    required String commentPreview,
  }) async {
    try {
      final postDoc = await _posts().doc(postId).get();
      final ownerUid = postDoc.data() as Map<String, dynamic>?;
      final targetUid = ownerUid?['uid'] as String?;
      if (targetUid == null) return;
      await NotificationService.createCommentNotification(
        targetUid: targetUid,
        postId: postId,
        commentPreview: commentPreview,
      );
    } catch (_) {}
  }

  // ── Comment likes ──────────────────────────────────────────────────────
  // Same one-doc-per-user pattern as post likes, one level deeper:
  // posts/{postId}/comments/{commentId}/likes/{uid}
  static Stream<bool> isCommentLikedByMe(String postId, String commentId) {
    final uid = UserService.uid;
    if (uid == null) return Stream.value(false);
    return _posts().doc(postId).collection('comments').doc(commentId)
        .collection('likes').doc(uid)
        .snapshots().map((d) => d.exists);
  }

  static Stream<int> commentLikeCount(String postId, String commentId) {
    return _posts().doc(postId).collection('comments').doc(commentId)
        .collection('likes')
        .snapshots().map((s) => s.docs.length);
  }

  static Future<void> toggleCommentLike(String postId, String commentId) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final ref = _posts().doc(postId).collection('comments').doc(commentId)
        .collection('likes').doc(uid);
    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
    } else {
      await ref.set({'uid': uid, 'createdAt': FieldValue.serverTimestamp()});
    }
  }

  // ── Delete post (owner only — enforced by existing Firestore rule) ────
  static Future<void> deletePost(String postId) async {
    await _posts().doc(postId).delete();
  }
}