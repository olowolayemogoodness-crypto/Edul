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
//
// Replies to comments live in this SAME `comments` subcollection (just
// with a `parentCommentId` field pointing at the comment they reply to,
// null for top-level comments) — no rule change needed there either,
// since the create/delete rules above don't inspect that field.
//
// Comment DELETE was already permitted by the rule above — it just had
// no method/UI wired up to it until now (see deleteComment below).
//
// Reply notifications DO need a new rule — add this alongside your
// existing `comment` notification rule in notifications_service.dart's
// rule block (same file has the full up-to-date notifications rule):
//
//   allow create: if request.auth != null
//                 && request.auth.uid == request.resource.data.fromUid
//                 && request.resource.data.uid != request.auth.uid
//                 && request.resource.data.type == 'reply'
//                 && request.resource.data.title
//                      == request.resource.data.fromDisplayName + ' replied to your comment'
//                 && request.resource.data.body is string
//                 && request.resource.data.body.size() <= 200;
//
// COUNTER ARCHITECTURE CHANGE (cost fix) — likeCount/commentCount/
// repostCount are now denormalized fields on the post doc itself,
// instead of deriving the count by reading every doc in the likes/
// comments/reposts subcollection. The subcollections still exist (they're
// what answers "did I already like/repost this" in O(1), and comments
// still need their own docs for content) — only the DISPLAYED COUNT
// moved. Reason: a subcollection-count read bills one Firestore read
// PER DOCUMENT in that subcollection, every single time the count is
// displayed — so a video with 5,000 likes cost 5,000 reads just to show
// "5,000" to one viewer. A denormalized field costs zero extra reads
// (it's already part of the doc you fetch to show the post at all).
//
// New rule required — same pattern as your existing `views` field rule,
// add these three alongside it inside `match /posts/{docId} { ... }`:
//
//   allow update: if request.auth != null
//                 && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['likeCount']);
//   allow update: if request.auth != null
//                 && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['commentCount']);
//   allow update: if request.auth != null
//                 && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['repostCount']);
//
// Like milestone notifications (new type, replaces notifying on every
// single like) — add this alongside your other notification rules:
//
//   allow create: if request.auth != null
//                 && request.auth.uid == request.resource.data.fromUid
//                 && request.resource.data.uid != request.auth.uid
//                 && request.resource.data.type == 'like_milestone'
//                 && request.resource.data.milestoneCount is int
//                 && request.resource.data.milestoneCount > 0
//                 && request.resource.data.title is string
//                 && request.resource.data.title.size() <= 100
//                 && request.resource.data.body is string
//                 && request.resource.data.body.size() <= 200;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'notifications_service.dart';
import 'user_service.dart';
import 'user_tier_service.dart';

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
    return _posts().doc(postId).snapshots()
        .map((d) => (d.data() as Map<String, dynamic>?)?['likeCount'] as int? ?? 0);
  }

  // Milestones at which the post owner gets a "your post hit N likes"
  // notification, instead of one notification per single like.
  static const List<int> _likeMilestones = [1, 10, 50, 100, 500, 1000, 5000, 10000, 50000];

  static Future<void> toggleLike(String postId, String postOwnerUid) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final likeRef = _posts().doc(postId).collection('likes').doc(uid);
    final postRef = _posts().doc(postId);
    final doc = await likeRef.get();

    if (doc.exists) {
      // Unlike — no milestone check needed on the way down.
      await likeRef.delete();
      await postRef.update({'likeCount': FieldValue.increment(-1)});
      if (uid != postOwnerUid) {
        await UserTierService.adjustScore(postOwnerUid, -2);
      }
      return;
    }

    // Like — do the like-doc create + counter bump in one transaction so
    // we get back the exact resulting count (not just "+1 from whatever
    // it was"), which is what makes milestone detection race-safe: two
    // concurrent likes can never both think they were "the 100th".
    int newCount = 0;
    await _db.runTransaction((tx) async {
      final snap = await tx.get(postRef);
      final current = (snap.data() as Map<String, dynamic>?)?['likeCount'] as int? ?? 0;
      newCount = current + 1;
      tx.set(likeRef, {'uid': uid, 'createdAt': FieldValue.serverTimestamp()});
      tx.update(postRef, {'likeCount': newCount});
    });

    if (uid != postOwnerUid) {
      await UserTierService.adjustScore(postOwnerUid, 2);
      if (_likeMilestones.contains(newCount)) {
        await NotificationService.createLikeMilestoneNotification(
          targetUid: postOwnerUid,
          postId: postId,
          milestoneCount: newCount,
        );
      }
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
    return _posts().doc(postId).snapshots()
        .map((d) => (d.data() as Map<String, dynamic>?)?['repostCount'] as int? ?? 0);
  }

  static Future<void> toggleRepost(String postId, {
    required String feedTarget,
    required String myDisplayName,
    required String myUniversity,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final ref = _posts().doc(postId).collection('reposts').doc(uid);
    // Deterministic ID so we can find-and-delete this pointer without an
    // extra query. This pointer is what makes the repost show up in the
    // feed's chronological order — it carries NO likes/comments/views of
    // its own. All interactions on a repost read/write the ORIGINAL post
    // (see _PostCard's repost-wrapper rendering), so engagement always
    // stays tied to whoever actually wrote the post.
    final pointerRef = FirebaseFirestore.instance
        .collection('posts').doc('repost_${postId}_$uid');
    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
      await pointerRef.delete();
      await _posts().doc(postId).update({'repostCount': FieldValue.increment(-1)});
    } else {
      await ref.set({'uid': uid, 'createdAt': FieldValue.serverTimestamp()});
      await pointerRef.set({
        'type': 'repost',
        'originalPostId': postId,
        'uid': uid,
        'displayName': myDisplayName,
        'university': myUniversity,
        'feedTarget': feedTarget,
        'verified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _posts().doc(postId).update({'repostCount': FieldValue.increment(1)});
      await _notifyPostOwnerOfRepost(postId);
    }
  }

  /// Looks up the original post's owner and fires a repost notification
  /// to them (no-op if reposting your own post). Best-effort, same as
  /// [_notifyPostOwner].
  static Future<void> _notifyPostOwnerOfRepost(String postId) async {
    try {
      final postDoc = await _posts().doc(postId).get();
      final data = postDoc.data() as Map<String, dynamic>?;
      final targetUid = data?['uid'] as String?;
      if (targetUid == null) return;
      await NotificationService.createRepostNotification(
        targetUid: targetUid,
        postId: postId,
      );
    } catch (_) {}
  }

  // ── Comments ───────────────────────────────────────────────────────────
  static Stream<int> commentCount(String postId) {
    return _posts().doc(postId).snapshots()
        .map((d) => (d.data() as Map<String, dynamic>?)?['commentCount'] as int? ?? 0);
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

  /// [parentCommentId] is null for a top-level comment, or the id of the
  /// comment being replied to. Replies live in the SAME `comments`
  /// collection (not a subcollection) so the whole thread can be fetched
  /// and grouped client-side with a single stream.
  static Future<void> addComment(
    String postId,
    String text, {
    String? parentCommentId,
  }) async {
    final uid = UserService.uid;
    if (uid == null || text.trim().isEmpty) return;
    final profile = await UserService.getProfile();
    final displayName = profile?['displayName'] as String? ?? 'User';
    final trimmed = text.trim();
    await _posts().doc(postId).collection('comments').add({
      'uid': uid,
      'displayName': displayName,
      'content': trimmed,
      'parentCommentId': parentCommentId,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await _posts().doc(postId).update({'commentCount': FieldValue.increment(1)});
    if (parentCommentId != null) {
      await _notifyParentCommentAuthor(
        postId: postId,
        parentCommentId: parentCommentId,
        replyPreview: trimmed,
      );
    }
    await _notifyPostOwner(postId: postId, commentPreview: trimmed);
  }

  /// Adds a voice-note comment. `content` is left empty — the UI renders
  /// a waveform player instead of text when `audioUrl` is present.
  static Future<void> addVoiceComment({
    required String postId,
    required String audioUrl,
    required int durationMs,
    required List<double> waveform,
    String? parentCommentId,
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
      'parentCommentId': parentCommentId,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await _posts().doc(postId).update({'commentCount': FieldValue.increment(1)});
    if (parentCommentId != null) {
      await _notifyParentCommentAuthor(
        postId: postId,
        parentCommentId: parentCommentId,
        replyPreview: '',
      );
    }
    await _notifyPostOwner(postId: postId, commentPreview: '');
  }

  /// Deletes a comment or reply. Firestore rules already restrict this to
  /// the comment's own author (`resource.data.uid == request.auth.uid`),
  /// so this is safe to call directly — no extra ownership check needed
  /// client-side, though the UI should still only show the option to the
  /// author. Replies left pointing at a deleted parent are handled by the
  /// UI (shown ungrouped) rather than cascade-deleted, since a client
  /// can't delete another user's reply docs under the existing rules.
  static Future<void> deleteComment(String postId, String commentId) async {
    await _posts().doc(postId).collection('comments').doc(commentId).delete();
    await _posts().doc(postId).update({'commentCount': FieldValue.increment(-1)});
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
      // Social Score: commenting on someone else's post earns THEM a
      // point (not the commenter) — guarded the same way likes/follows
      // are, so commenting on your own post farms nothing.
      if (targetUid != UserService.uid) {
        UserTierService.bumpSocialScoreForComment(targetUid);
      }
      await NotificationService.createCommentNotification(
        targetUid: targetUid,
        postId: postId,
        commentPreview: commentPreview,
      );
    } catch (_) {}
  }

  /// Looks up the parent comment's author and fires a reply notification
  /// to them (no-op if replying to your own comment). Best-effort, same
  /// as [_notifyPostOwner].
  static Future<void> _notifyParentCommentAuthor({
    required String postId,
    required String parentCommentId,
    required String replyPreview,
  }) async {
    try {
      final parentDoc = await _posts()
          .doc(postId).collection('comments').doc(parentCommentId).get();
      final data = parentDoc.data();
      final targetUid = data?['uid'] as String?;
      if (targetUid == null) return;
      await NotificationService.createReplyNotification(
        targetUid: targetUid,
        postId: postId,
        replyPreview: replyPreview,
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