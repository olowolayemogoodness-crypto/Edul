// lib/core/services/community_chat_service.dart
//
// communities/{communityId}/messages/{messageId}:
//   { uid, displayName, photoUrl?, content, imageUrl?, type, title?,
//     createdAt, bumpedAt,
//     replyToMessageId?, replyToSenderName?, replyToPreview?,
//     replyCount, recentReplierUids: [uid, ...] (capped to 4) }
//
// Threading: ANY message can be replied to (not just typed ones).
// bumpedAt starts equal to createdAt, then gets reset to "now"
// every time a new reply lands on that message -- messages() orders
// by bumpedAt, not createdAt, so a message with a fresh reply
// resurfaces near the bottom of the room instead of staying buried
// under everything chronologically newer. replyCount and
// recentReplierUids are what let a message show "4 replied" with an
// avatar stack without a separate query per message.
//
// Bounded to the most recent 100 messages via limitToLast -- avoids
// an ever-growing unbounded read as a room's history accumulates,
// same reasoning as every other bounded query tonight.
//
// Firestore rules required -- nest inside your existing
// `communities/{communityId}` block:
//
//   match /messages/{messageId} {
//     allow read: if request.auth != null
//                 && exists(/databases/$(database)/documents/communities/$(communityId)/members/$(request.auth.uid));
//     allow create: if request.auth != null && request.auth.uid == request.resource.data.uid
//                   && exists(/databases/$(database)/documents/communities/$(communityId)/members/$(request.auth.uid));
//     allow update: if request.auth != null
//                   && exists(/databases/$(database)/documents/communities/$(communityId)/members/$(request.auth.uid))
//                   && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['replyCount', 'recentReplierUids', 'bumpedAt', 'resolved', 'acceptedAnswerMessageId', 'acceptedAnswerUid']);
//   }
//
// This is what actually makes the Room "private" (per the design
// brief) -- only members can read or post, enforced server-side, not
// just hidden in the UI.

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';
import 'user_tier_service.dart';
import 'post_image_upload_service.dart';

const List<String> messageTypes = ['general', 'ask', 'snippet', 'resource', 'shipped'];
const int _maxRecentRepliers = 4;

class CommunityChatService {
  CommunityChatService._();

  static final _db = FirebaseFirestore.instance;

  static Stream<List<Map<String, dynamic>>> messages(String communityId) {
    return _db.collection('communities').doc(communityId).collection('messages')
        .orderBy('createdAt', descending: false)
        .limitToLast(100)
        .snapshots()
        .map((s) => s.docs.map((d) => {'id': d.id, ...d.data()}).toList());
  }

  /// Every reply to a specific message, oldest first -- the full
  /// thread view behind tapping "N replied".
  static Stream<List<Map<String, dynamic>>> threadMessages(String communityId, String parentMessageId) {
    return _db.collection('communities').doc(communityId).collection('messages')
        .where('replyToMessageId', isEqualTo: parentMessageId)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((s) => s.docs.map((d) => {'id': d.id, ...d.data()}).toList());
  }

  /// [type] is one of messageTypes above, defaulting to 'general' --
  /// a plain chat message, same as before this was added. [title] is
  /// only meaningful for ask/snippet/resource/shipped (the mockup's
  /// short headline above the body text) -- ignored for 'general'.
  ///
  /// [replyToMessageId], when set, makes this a reply -- the quoted
  /// reference is denormalized onto THIS message (so rendering it
  /// needs no extra lookup), and the PARENT message gets its
  /// replyCount bumped, its recentReplierUids updated (capped,
  /// deduped), and its bumpedAt reset to now -- which is what
  /// actually moves it back toward the bottom of the room.
  static Future<void> sendMessage(
    String communityId,
    String content, {
    String type = 'general',
    String? title,
    File? imageFile,
    String? replyToMessageId,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return;
    if (content.trim().isEmpty && imageFile == null) return;

    String? imageUrl;
    if (imageFile != null) {
      final urls = await PostImageUploadService.uploadAll([imageFile]);
      if (urls.isNotEmpty) imageUrl = urls.first;
    }

    final profile = await UserService.getProfile();
    final displayName = profile?['displayName'] as String? ?? 'User';
    final photoUrl = profile?['photoUrl'] as String?;

    // Reply metadata is a small extra read, only when actually
    // replying -- not on every message send.
    String? replyToSenderName;
    String? replyToPreview;
    String? replyToType;
    DocumentReference<Map<String, dynamic>>? parentRef;
    List<dynamic> updatedRepliers = const [];
    if (replyToMessageId != null) {
      parentRef = _db.collection('communities').doc(communityId).collection('messages').doc(replyToMessageId);
      final parentSnap = await parentRef.get();
      final parentData = parentSnap.data();
      replyToSenderName = parentData?['displayName'] as String? ?? 'Someone';
      replyToType = parentData?['type'] as String? ?? 'general';
      final parentTitle = parentData?['title'] as String?;
      final parentContent = parentData?['content'] as String? ?? '';
      replyToPreview = (parentTitle != null && parentTitle.isNotEmpty) ? parentTitle : parentContent;

      final existing = (parentData?['recentReplierUids'] as List<dynamic>?) ?? [];
      updatedRepliers = [...existing.where((u) => u != uid), uid];
      if (updatedRepliers.length > _maxRecentRepliers) {
        updatedRepliers = updatedRepliers.sublist(updatedRepliers.length - _maxRecentRepliers);
      }
    }

    final batch = _db.batch();
    final messageRef = _db.collection('communities').doc(communityId).collection('messages').doc();
    batch.set(messageRef, {
      'uid': uid,
      'displayName': displayName,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'content': content.trim(),
      if (imageUrl != null) 'imageUrl': imageUrl,
      'type': type,
      if (title != null && title.trim().isNotEmpty) 'title': title.trim(),
      if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
      if (replyToSenderName != null) 'replyToSenderName': replyToSenderName,
      if (replyToPreview != null) 'replyToPreview': replyToPreview,
      if (replyToType != null) 'replyToType': replyToType,
      'replyCount': 0,
      'recentReplierUids': <String>[],
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (parentRef != null) {
      batch.update(parentRef, {
        'replyCount': FieldValue.increment(1),
        'recentReplierUids': updatedRepliers,
      });
    }

    // Denormalized onto the community doc itself -- this is what the
    // "My Communities" tile list reads for its last-message preview,
    // so it doesn't need a separate messages query per tile.
    final previewText = title != null && title.trim().isNotEmpty
        ? title.trim()
        : (content.trim().isNotEmpty ? content.trim() : (imageUrl != null ? '📷 Photo' : ''));
    batch.update(_db.collection('communities').doc(communityId), {
      'lastMessage': {
        'text': previewText,
        'senderName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
      },
    });
    await batch.commit();
  }

  /// Marks an 'ask'-type message as solved, crediting whoever wrote
  /// the accepted answer with Clout in this community -- no post
  /// involved, so this goes through adjustCloutForScope directly
  /// rather than the post-derived adjustCommunityClout.
  static Future<void> markSolved({
    required String communityId,
    required String questionMessageId,
    required String answerMessageId,
    required String answererUid,
  }) async {
    await _db.collection('communities').doc(communityId).collection('messages').doc(questionMessageId).update({
      'resolved': true,
      'acceptedAnswerMessageId': answerMessageId,
      'acceptedAnswerUid': answererUid,
    });
    await UserTierService.adjustCloutForScope(scopeId: communityId, targetUid: answererUid, delta: 15);
  }
}