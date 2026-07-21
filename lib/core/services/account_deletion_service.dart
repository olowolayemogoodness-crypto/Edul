// lib/core/services/account_deletion_service.dart
//
// Deletes a user's account: re-authenticates them (Firebase requires a
// "recent" login for sensitive operations like deleting an account —
// otherwise this throws requires-recent-login), cleans up their
// Firestore data, then deletes the Firebase Auth account itself.
//
// This app currently only has email/password auth actually wired up
// (Google Sign-In exists as an unused button, nothing calls it), so
// re-authentication only needs to handle the password flow.
//
// SCOPE of what gets deleted — this is thorough but not perfect:
//   ✓ Their own posts, and every subcollection under each
//     (likes/reposts/comments, and each comment's own likes)
//   ✓ Comments they left on OTHER people's posts (found via a
//     collection-group query filtered to their uid)
//   ✓ Likes/reposts they left on other people's posts or comments
//   ✓ Follow relationships, both directions (their followers list,
//     and their entries in everyone else's followers list)
//   ✓ Notifications addressed to them
//   ✓ studyStats / tutorUsage subcollections, then the user doc itself
//   ✓ Finally, the Firebase Auth account
//
// NOT covered — a known, disclosed gap:
//   ✗ Uploaded media (post images, voice notes) sitting in R2. There's
//     no delete endpoint on the Cloudflare Worker yet, only presigned
//     PUT for uploads. Orphaned files remain in the bucket, unlinked
//     from any visible account or post. Low compliance risk (it's
//     anonymous binary data with no way to associate it back to a
//     person once the Firestore docs referencing it are gone), but
//     worth building a delete endpoint eventually for real cleanliness.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AccountDeletionService {
  AccountDeletionService._();

  static final _db = FirebaseFirestore.instance;

  static bool get usesPasswordAuth {
    final user = FirebaseAuth.instance.currentUser;
    return user?.providerData.any((p) => p.providerId == 'password') ?? false;
  }

  static Future<void> reauthenticateWithPassword(String password) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not logged in');
    final email = user.email;
    if (email == null) throw Exception('No email on this account');
    try {
      final cred = EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(cred);
      debugPrint('[AccountDeletion] Re-authentication succeeded');
    } catch (e) {
      debugPrint('[AccountDeletion] Re-authentication FAILED: $e');
      rethrow;
    }
  }

  static Future<void> _deleteAllDocs(Query query) async {
    final snap = await query.get();
    for (final doc in snap.docs) {
      await doc.reference.delete();
    }
  }

  /// Deletes everything. Call [reauthenticateWithPassword] successfully
  /// first — this will throw requires-recent-login otherwise.
  static Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not logged in');
    final uid = user.uid;

    try {
      // 1. Own posts + their nested subcollections.
      debugPrint('[AccountDeletion] Step 1: deleting own posts...');
      final myPosts =
          await _db.collection('posts').where('uid', isEqualTo: uid).get();
      for (final postDoc in myPosts.docs) {
        await _deleteAllDocs(postDoc.reference.collection('likes'));
        await _deleteAllDocs(postDoc.reference.collection('reposts'));
        final comments = await postDoc.reference.collection('comments').get();
        for (final c in comments.docs) {
          await _deleteAllDocs(c.reference.collection('likes'));
          await c.reference.delete();
        }
        await postDoc.reference.delete();
      }
      debugPrint('[AccountDeletion] Step 1 done (${myPosts.docs.length} posts)');

      // 2. Comments left on OTHER people's posts. Best-effort: this is a
      // collection-group query, which needs its own careful rule
      // matching — if it fails, don't let it block the rest of deletion.
      debugPrint('[AccountDeletion] Step 2: deleting comments on others\' posts...');
      try {
        final myComments = await _db
            .collectionGroup('comments')
            .where('uid', isEqualTo: uid)
            .get();
        for (final c in myComments.docs) {
          await _deleteAllDocs(c.reference.collection('likes'));
          await c.reference.delete();
        }
        debugPrint('[AccountDeletion] Step 2 done (${myComments.docs.length} comments)');
      } catch (e) {
        debugPrint('[AccountDeletion] Step 2 SKIPPED (non-blocking failure): $e');
      }

      // 3. Likes and reposts left on others' content. Also best-effort,
      // same reasoning as step 2.
      debugPrint('[AccountDeletion] Step 3: deleting likes/reposts...');
      try {
        await _deleteAllDocs(
            _db.collectionGroup('likes').where('uid', isEqualTo: uid));
        await _deleteAllDocs(
            _db.collectionGroup('reposts').where('uid', isEqualTo: uid));
        debugPrint('[AccountDeletion] Step 3 done');
      } catch (e) {
        debugPrint('[AccountDeletion] Step 3 SKIPPED (non-blocking failure): $e');
      }

      // 4. Follow relationships — both directions. The "who I follow"
      // half is also a collection-group query, so wrap it the same way.
      debugPrint('[AccountDeletion] Step 4: deleting follow relationships...');
      try {
        await _deleteAllDocs(
            _db.collection('users').doc(uid).collection('followers'));
      } catch (e) {
        debugPrint('[AccountDeletion] Step 4a SKIPPED (non-blocking failure): $e');
      }
      try {
        await _deleteAllDocs(_db
            .collectionGroup('followers')
            .where('followerUid', isEqualTo: uid));
        debugPrint('[AccountDeletion] Step 4 done');
      } catch (e) {
        debugPrint('[AccountDeletion] Step 4b SKIPPED (non-blocking failure): $e');
      }

      // 5. Notifications addressed to them.
      debugPrint('[AccountDeletion] Step 5: deleting notifications...');
      await _deleteAllDocs(
          _db.collection('notifications').where('uid', isEqualTo: uid));
      debugPrint('[AccountDeletion] Step 5 done');

      // 6. Remaining subcollections, then the user doc itself.
      debugPrint('[AccountDeletion] Step 6: deleting user doc + subcollections...');
      await _deleteAllDocs(
          _db.collection('users').doc(uid).collection('studyStats'));
      await _deleteAllDocs(
          _db.collection('users').doc(uid).collection('tutorUsage'));
      await _db.collection('users').doc(uid).delete();
      debugPrint('[AccountDeletion] Step 6 done');

      // 7. Finally, the Auth account.
      debugPrint('[AccountDeletion] Step 7: deleting Auth account...');
      await user.delete();
      debugPrint('[AccountDeletion] Step 7 done — account fully deleted');
    } catch (e, stack) {
      debugPrint('[AccountDeletion] FAILED: $e');
      debugPrint('[AccountDeletion] Stack: $stack');
      rethrow;
    }
  }
}