// lib/core/services/album_service.dart
//
// Posting to Albums is deliberately as low-friction as regular
// posting: a photo, a caption that naturally contains a #hashtag --
// no separate "create an album first" step. The hashtag IS the
// grouping mechanism, reusing HashtagService's existing extraction
// and querying logic directly rather than building parallel hashtag
// handling just for this feature.
//
// Featured (last 7 days) vs archived (older) is still a pure
// client-side filter on createdAt, same "hidden, not gone" philosophy
// as Stories' 24-hour expiry -- nothing here is ever deleted, a post
// just naturally stops appearing in Featured once the window passes.

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';
import 'post_image_upload_service.dart';
import 'post_video_upload_service.dart';
import 'hashtag_service.dart';

enum PostToAlbumsResult { success, notSignedIn, needsHashtag, uploadFailed }
enum DeleteAlbumPostResult { success, notSignedIn, notOwner }

class AlbumService {
  AlbumService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> _posts() => _db.collection('album_posts');

  static const featuredWindowDays = 7;

  /// Exactly one of [image] or [video] should be provided -- photos
  /// upload as-is, videos are compressed on-device first via the same
  /// service already used for regular post videos.
  static Future<PostToAlbumsResult> post({
    File? image,
    File? video,
    required String caption,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return PostToAlbumsResult.notSignedIn;

    final hashtags = HashtagService.extractHashtags(caption);
    if (hashtags.isEmpty) return PostToAlbumsResult.needsHashtag;

    try {
      String? imageUrl;
      String? videoUrl;
      if (image != null) {
        final urls = await PostImageUploadService.uploadAll([image]);
        if (urls.isEmpty) return PostToAlbumsResult.uploadFailed;
        imageUrl = urls.first;
      } else if (video != null) {
        videoUrl = await PostVideoUploadService.compressAndUpload(video);
      } else {
        return PostToAlbumsResult.uploadFailed;
      }

      final profile = await UserService.getProfile();
      await _posts().add({
        'uid': uid,
        'displayName': profile?['displayName'] as String? ?? 'User',
        'usernameDisplay': profile?['usernameDisplay'] as String?,
        'type': videoUrl != null ? 'video' : 'image',
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (videoUrl != null) 'videoUrl': videoUrl,
        'caption': caption.trim(),
        'hashtags': hashtags,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return PostToAlbumsResult.success;
    } catch (e) {
      return PostToAlbumsResult.uploadFailed;
    }
  }

  /// Owner-only, matching the same delete pattern already used for
  /// regular posts and group posts elsewhere in this app.
  static Future<DeleteAlbumPostResult> deletePost(String postId) async {
    final uid = UserService.uid;
    if (uid == null) return DeleteAlbumPostResult.notSignedIn;
    final doc = await _posts().doc(postId).get();
    if (doc.data()?['uid'] != uid) return DeleteAlbumPostResult.notOwner;
    await _posts().doc(postId).delete();
    return DeleteAlbumPostResult.success;
  }

  // ── Featured (within the last 7 days) vs archived (older) ────────
  // Filtered client-side against a single, unfiltered createdAt
  // ordering -- avoids a composite index requirement, same tradeoff
  // used everywhere else in this app.
  static Stream<List<Map<String, dynamic>>> featuredPosts() {
    final cutoff = Timestamp.fromDate(DateTime.now().subtract(const Duration(days: featuredWindowDays)));
    return _posts().orderBy('createdAt', descending: true).limit(150).snapshots().map((s) {
      return s.docs
          .map((d) => {'id': d.id, ...d.data()})
          .where((p) {
            final createdAt = p['createdAt'] as Timestamp?;
            return createdAt != null && createdAt.compareTo(cutoff) > 0;
          })
          .toList();
    });
  }

  static Stream<List<Map<String, dynamic>>> archivedPosts() {
    final cutoff = Timestamp.fromDate(DateTime.now().subtract(const Duration(days: featuredWindowDays)));
    return _posts().orderBy('createdAt', descending: true).limit(300).snapshots().map((s) {
      return s.docs
          .map((d) => {'id': d.id, ...d.data()})
          .where((p) {
            final createdAt = p['createdAt'] as Timestamp?;
            return createdAt != null && createdAt.compareTo(cutoff) <= 0;
          })
          .toList();
    });
  }

  /// Posts sharing ANY hashtag with [tags], excluding [excludePostId]
  /// itself -- the "similar posts" row under a tapped post. Reuses
  /// HashtagService's own querying pattern (single hashtag,
  /// array-contains) rather than a compound query, avoiding the same
  /// composite-index tradeoff as everywhere else.
  static Stream<List<Map<String, dynamic>>> similarPosts(List<String> tags, {required String excludePostId}) {
    if (tags.isEmpty) return Stream.value([]);
    return _posts()
        .where('hashtags', arrayContains: tags.first)
        .orderBy('createdAt', descending: true)
        .limit(30)
        .snapshots()
        .map((s) => s.docs
            .where((d) => d.id != excludePostId)
            .map((d) => {'id': d.id, ...d.data()})
            .toList());
  }
}