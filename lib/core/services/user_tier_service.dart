// lib/core/services/user_tier_service.dart
//
// Badges are still granted MANUALLY (Firebase Console -> users/{uid} ->
// set `tier` to 'active' / 'contributor' / 'plug') -- this file adds
// automatic DETECTION on top of that, without auto-granting anything.
//
// Every user has a `score` field, adjusted in real time as a side effect
// of existing actions (see PostInteractionService.toggleLike and
// UserFollowService.toggleFollow). When a user's score crosses one of
// the thresholds below for the first time, a doc gets written to the
// top-level `badgeEligibility` collection -- check that collection in
// Firebase Console to see who's ready for review. This keeps a human
// in the loop (so nobody can just spam-like their way to a badge
// unnoticed) while removing the need to manually watch everyone's
// numbers.
//
// A real email/push alert instead of a Console-visible collection would
// need a backend email service (e.g. a Cloud Function + SendGrid) --
// a bigger, separate addition. This gets you 90% of the value today
// with zero new infrastructure.
//
// Firestore rules required:
//   Inside users/{userId}, add:
//     allow update: if request.auth != null
//                   && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['score']);
//   New top-level collection:
//     match /badgeEligibility/{docId} {
//       allow read: if request.auth != null;
//       allow create: if request.auth != null;
//     }

import 'package:cloud_firestore/cloud_firestore.dart';

class UserTierService {
  UserTierService._();

  static final _db = FirebaseFirestore.instance;

  // Your own account — badge-eligibility alerts are sent here as a real
  // in-app notification, so you see it via the normal notification bell
  // instead of needing to check Firestore in Console.
  static const String adminUid = 'oGr2sN8TNlUfjlhmxBiDsT3Q8KF3';

  // Score needed to become newly ELIGIBLE for each tier (not auto-granted).
  static const Map<String, int> thresholds = {
    'active': 20,
    'contributor': 100,
    'plug': 500,
  };

  static final Map<String, String?> _cache = {};

  static Future<String?> getTier(String uid) async {
    if (_cache.containsKey(uid)) return _cache[uid];
    try {
      final doc = await _db.collection('users').doc(uid).get();
      final tier = doc.data()?['tier'] as String?;
      _cache[uid] = tier;
      return tier;
    } catch (_) {
      return null;
    }
  }

  static String label(String tier) {
    switch (tier) {
      case 'active': return 'Active member';
      case 'contributor': return 'Contributor';
      case 'plug': return 'The Plug';
      default: return '';
    }
  }

  /// Adjusts [uid]'s score by [delta] and flags them for badge review the
  /// moment they cross a new threshold for the first time. Uses a
  /// transaction so concurrent likes/follows can't cause a missed or
  /// duplicate crossing detection.
  static Future<void> adjustScore(String uid, int delta) async {
    final userRef = _db.collection('users').doc(uid);
    try {
      await _db.runTransaction((txn) async {
        final snap = await txn.get(userRef);
        final oldScore = (snap.data()?['score'] as num?)?.toInt() ?? 0;
        final newScore = oldScore + delta;
        final displayName = snap.data()?['displayName'] as String? ?? 'A user';
        txn.update(userRef, {'score': newScore});

        // Only worth checking on the way up -- losing points (an unlike/
        // unfollow) never newly crosses a threshold.
        if (delta > 0) {
          for (final entry in thresholds.entries) {
            final tier = entry.key;
            final needed = entry.value;
            if (oldScore < needed && newScore >= needed) {
              final alertRef = _db.collection('badgeEligibility').doc('${uid}_$tier');
              txn.set(alertRef, {
                'uid': uid,
                'tier': tier,
                'scoreAtCrossing': newScore,
                'reviewed': false,
                'createdAt': FieldValue.serverTimestamp(),
              });
              // Real in-app notification, so this actually alerts you
              // instead of sitting unseen in a collection.
              final notifRef = _db.collection('notifications').doc();
              txn.set(notifRef, {
                'uid': adminUid,
                'fromUid': uid,
                'fromDisplayName': displayName,
                'type': 'badge_eligible',
                'tier': tier,
                'title': 'Badge review needed',
                'body': '$displayName just crossed the threshold for ${label(tier)}',
                'read': false,
                'createdAt': FieldValue.serverTimestamp(),
              });
            }
          }
        }
      });
    } catch (_) {
      // Best-effort -- never let a scoring failure block the like/follow
      // action itself.
    }
  }
}