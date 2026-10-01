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
  ///
  /// Also bumps the separate `socialScore` field by the same delta — this
  /// is the user-FACING "Social Score" shown next to usernames app-wide.
  /// Kept deliberately separate from `score` (which drives badge
  /// eligibility and should stay exactly as calibrated) so that adding
  /// comment-received points to socialScore later never accidentally
  /// shifts who becomes eligible for a tier badge.
  static Future<void> adjustScore(String uid, int delta) async {
    final userRef = _db.collection('users').doc(uid);
    try {
      await _db.runTransaction((txn) async {
        final snap = await txn.get(userRef);
        final oldScore = (snap.data()?['score'] as num?)?.toInt() ?? 0;
        final newScore = oldScore + delta;
        final displayName = snap.data()?['displayName'] as String? ?? 'A user';
        txn.update(userRef, {
          'score': newScore,
          'socialScore': FieldValue.increment(delta),
        });

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

  /// Adds a comment-received point to socialScore only — deliberately
  /// does NOT touch `score`/badge eligibility, since a comment is much
  /// easier to leave than a genuine like and shouldn't move someone
  /// toward a tier badge the same way engagement does.
  static Future<void> bumpSocialScoreForComment(String uid) async {
    try {
      await _db.collection('users').doc(uid).update({
        'socialScore': FieldValue.increment(1),
      });
    } catch (_) {
      // Best-effort — never block a comment on this.
    }
  }

  // ── Clout: per-community reputation ──────────────────────────────
  // Separate from `score`/`socialScore` above by design -- those stay
  // exactly as calibrated (they drive the existing badge-eligibility
  // review flow, untouched). Clout is a different concept: not "how
  // liked are you app-wide", but "how recognized are you in THIS
  // specific community" -- a department, a class, an affinity group.
  // Same validated-interaction philosophy though: only counts when
  // someone ELSE engages with your content, never your own.
  //
  // Firestore rule required -- nest this inside your existing
  // `match /users/{userId} { ... }` block, alongside followers/
  // following/studyStats etc.:
  //   match /clout/{communityId} {
  //     allow read: if request.auth != null;
  //     allow write: if request.auth != null;
  //   }
  static const Map<String, int> cloutTierThresholds = {
    'regular': 10,
    'top_voice': 50,
    'legend': 200,
  };

  static String cloutTierLabel(int score) {
    if (score >= cloutTierThresholds['legend']!) return 'Legend';
    if (score >= cloutTierThresholds['top_voice']!) return 'Top Voice';
    if (score >= cloutTierThresholds['regular']!) return 'Regular';
    return 'Newcomer';
  }

  /// Credits (or debits) [targetUid]'s Clout in whichever community
  /// [postId] belongs to. Looks up the post's own groupId itself --
  /// callers (toggleLike, setReaction, comment notifications) don't
  /// need their signatures changed, just one extra read per call,
  /// which is a normal cost for a direct client Firestore call (not
  /// the Cloudflare Worker subrequest-limited context from elsewhere
  /// in this project).
  /// Core Clout transaction, scoped directly (a community id, a
  /// group id -- whatever the caller already knows) rather than
  /// derived from a post. adjustCommunityClout below is the
  /// post-derived entry point for likes/comments/reactions;
  /// this is the direct one, e.g. for a chat message getting
  /// marked as the accepted answer to a question -- there's no
  /// post involved there at all.
  // Automatic milestones a community unlocks on its own -- no admin
  // action needed. Checked every time the relevant number changes
  // (member joins, or here on total Clout crossing a threshold), and
  // once unlocked an achievement id is never removed even if the
  // number later drops back down (e.g. a member leaves).
  static const Map<String, int> cloutMilestones = {
    'clout_100': 100, 'clout_500': 500, 'clout_1000': 1000, 'clout_5000': 5000,
  };

  static Future<void> adjustCloutForScope({
    required String scopeId,
    required String targetUid,
    required int delta,
  }) async {
    try {
      final cloutRef = _db.collection('users').doc(targetUid).collection('clout').doc(scopeId);
      final communityRef = _db.collection('communities').doc(scopeId);
      await _db.runTransaction((tx) async {
        final snap = await tx.get(cloutRef);
        final oldScore = (snap.data()?['score'] as num?)?.toInt() ?? 0;
        final newScore = oldScore + delta;
        tx.set(cloutRef, {
          'score': newScore,
          'tier': cloutTierLabel(newScore),
        }, SetOptions(merge: true));

        // Room Clout: a running total on the community doc itself,
        // summing every member's individual Clout in this community.
        // Only written if scopeId is actually a community -- this
        // same function is also used for old-style department groups
        // sharing the identical Clout mechanism, which have no
        // totalClout field of their own and must never get one
        // fabricated for them.
        final communitySnap = await tx.get(communityRef);
        if (communitySnap.exists) {
          final oldTotal = (communitySnap.data()?['totalClout'] as num?)?.toInt() ?? 0;
          final newTotal = oldTotal + delta;
          final achievements = ((communitySnap.data()?['achievements'] as List<dynamic>?) ?? []).cast<String>().toSet();
          for (final entry in cloutMilestones.entries) {
            if (newTotal >= entry.value) achievements.add(entry.key);
          }
          tx.set(communityRef, {
            'totalClout': newTotal,
            'achievements': achievements.toList(),
          }, SetOptions(merge: true));
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print('[UserTierService] adjustCloutForScope failed: $e');
    }
  }

  static Future<void> adjustCommunityClout({
    required String postId,
    required String targetUid,
    required int delta,
  }) async {
    try {
      final postSnap = await _db.collection('posts').doc(postId).get();
      // Community-tagged posts stamp communityId, not groupId -- this
      // was only ever checking the old field, so likes/comments/
      // reactions on a community post were silently crediting zero
      // Clout until now.
      final scopeId = (postSnap.data()?['groupId'] as String?) ?? (postSnap.data()?['communityId'] as String?);
      if (scopeId == null) return; // post has no community scope -- nothing to credit

      await adjustCloutForScope(scopeId: scopeId, targetUid: targetUid, delta: delta);
    } catch (e) {
      // Same reasoning as AffinityService's fix earlier -- printed,
      // not silently swallowed, so a real problem doesn't hide behind
      // "best-effort" the way it did before.
      // ignore: avoid_print
      print('[UserTierService] adjustCommunityClout failed: $e');
    }
  }
}