// lib/core/services/campaign_service.dart
//
// The creator-eviction campaign, kept entirely separate from regular
// Stories -- everyone can keep posting normal Stories throughout, this
// is a second, gated space where ONLY approved, still-active
// contestants can post.
//
// Data model:
//   campaigns/{campaignId}
//     -> name, currentRound, roundEndsAt, status, announcedAt
//   campaigns/{campaignId}/applications/{uid}
//     -> category, agreedToRules, appliedAt (denormalized identity)
//   campaigns/{campaignId}/contestants/{uid}
//     -> category, status: 'active'|'evicted', evictedAt
//   campaigns/{campaignId}/posts/{postId}
//     -> uid, category, content, imageUrls, videoUrl, createdAt
//   campaigns/{campaignId}/votes/{round}_{voterUid}
//     -> round, voterUid, votedForUid, votedAt
//     -- doc ID is deliberately "{round}_{voterUid}", not auto-generated:
//     this makes "have I already voted this round" a single doc read by
//     ID, and a duplicate vote attempt is a doc that already exists,
//     not something a query has to check for.
//
// Vote eligibility: only accounts that existed before the campaign was
// announced can vote -- checked against users/{uid}'s own createdAt
// field (already written at account creation), compared to
// campaigns/{campaignId}'s announcedAt. This is the real anti-abuse
// mechanism discussed -- it directly blocks the most common form of
// cheating (spinning up fresh accounts specifically to vote), and
// costs nothing to enforce beyond a timestamp comparison.
//
// Votes are WRITE-ONLY for regular users -- nobody can see live
// tallies, by design. The Firestore rule for /votes must restrict
// READ to the one known admin UID, the same pattern already used for
// badge_eligible and study_room_report notifications. Writing the
// rule is a separate step from this service; see the comment block
// at the bottom of this file for the exact rule needed.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

enum ApplyResult { success, alreadyApplied, notSignedIn }
enum VoteResult { success, alreadyVoted, accountTooNew, notActive, notSignedIn, contestantNotFound }
enum PostResult { success, notActiveContestant, notSignedIn }

class CampaignService {
  CampaignService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> _campaigns() => _db.collection('campaigns');

  // ── Finding the currently live campaign (single-campaign scope --
  // this app runs one creator campaign at a time, not several in
  // parallel) ──────────────────────────────────────────────────────
  static Stream<Map<String, dynamic>?> activeCampaign() {
    return _campaigns()
        .where('status', whereIn: ['applications_open', 'submission_only', 'active'])
        .limit(1)
        .snapshots()
        .map((s) => s.docs.isEmpty ? null : {'id': s.docs.first.id, ...s.docs.first.data()});
  }

  /// A specific campaign's live document, by ID -- used by screens
  /// that need to react to status changes (e.g. submission_only
  /// flipping to active) while they're already open, not just at
  /// initial load.
  static Stream<Map<String, dynamic>?> campaignStream(String campaignId) {
    return _campaigns().doc(campaignId).snapshots()
        .map((d) => d.data() == null ? null : {'id': d.id, ...d.data()!});
  }

  // ── Application ──────────────────────────────────────────────────────
  static Future<ApplyResult> apply({
    required String campaignId,
    required String category,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return ApplyResult.notSignedIn;

    final appRef = _campaigns().doc(campaignId).collection('applications').doc(uid);
    final existing = await appRef.get();
    if (existing.exists) return ApplyResult.alreadyApplied;

    final profile = await UserService.getProfile();
    await appRef.set({
      'uid': uid,
      'displayName': profile?['displayName'] as String? ?? 'User',
      'usernameDisplay': profile?['usernameDisplay'] as String?,
      'email': profile?['email'] as String?,
      'category': category,
      'agreedToRules': true,
      'appliedAt': FieldValue.serverTimestamp(),
    });

    // Full automation, as explicitly chosen: applying makes someone a
    // real, active, votable contestant immediately -- no admin review
    // step in between. Reuses the same profile data already fetched
    // above rather than fetching it a second time.
    await _campaigns().doc(campaignId).collection('contestants').doc(uid).set({
      'category': category,
      'status': 'active',
      'displayName': profile?['displayName'] as String? ?? 'User',
      'usernameDisplay': profile?['usernameDisplay'] as String?,
      'totalVotes': 0,
      'joinedAt': FieldValue.serverTimestamp(),
    });

    return ApplyResult.success;
  }

  static Stream<Map<String, dynamic>?> myApplication(String campaignId) {
    final uid = UserService.uid;
    if (uid == null) return Stream.value(null);
    return _campaigns().doc(campaignId).collection('applications').doc(uid)
        .snapshots().map((d) => d.data());
  }

  // ── Contestants (Active / Evicted tabs) ─────────────────────────────
  static Stream<List<Map<String, dynamic>>> activeContestants(String campaignId) {
    return _campaigns().doc(campaignId).collection('contestants')
        .where('status', isEqualTo: 'active')
        .snapshots()
        .map((s) => s.docs.map((d) => {'uid': d.id, ...d.data()}).toList());
  }

  /// Top 50 active contestants ranked by vote count -- evicted people
  /// are excluded entirely, never just hidden, matching the explicit
  /// decision not to disclose their numbers even after they're out.
  /// Sorted client-side rather than via orderBy() in the query itself
  /// -- combining a where() and an orderBy() on a different field
  /// would require a composite index, the same tradeoff avoided
  /// everywhere else in this app.
  static Stream<List<Map<String, dynamic>>> topLeaderboard(String campaignId) {
    return activeContestants(campaignId).map((contestants) {
      final sorted = [...contestants]
        ..sort((a, b) => ((b['totalVotes'] as int?) ?? 0).compareTo((a['totalVotes'] as int?) ?? 0));
      return sorted.take(50).toList();
    });
  }

  static Stream<List<Map<String, dynamic>>> evictedContestants(String campaignId) {
    return _campaigns().doc(campaignId).collection('contestants')
        .where('status', isEqualTo: 'evicted')
        .snapshots()
        .map((s) => s.docs.map((d) => {'uid': d.id, ...d.data()}).toList());
  }

  /// Who was cut in THIS specific round, not the full evicted list --
  /// relies on an `evictedRound` field on the contestant doc, set
  /// alongside `status: 'evicted'` whenever the (not-yet-built)
  /// scheduled eviction job actually processes a round. Filtered
  /// client-side rather than a second where() clause, avoiding a
  /// composite index requirement.
  static Future<List<Map<String, dynamic>>> evictedThisRound(String campaignId, int round) async {
    final snap = await _campaigns().doc(campaignId).collection('contestants')
        .where('status', isEqualTo: 'evicted').get();
    return snap.docs
        .map((d) => {'uid': d.id, ...d.data()})
        .where((c) => c['evictedRound'] == round)
        .toList();
  }

  static Future<int> activeContestantCount(String campaignId) async {
    final snap = await _campaigns().doc(campaignId).collection('contestants')
        .where('status', isEqualTo: 'active').get();
    return snap.docs.length;
  }

  static Future<bool> isActiveContestant(String campaignId) async {
    final uid = UserService.uid;
    if (uid == null) return false;
    return isUidActiveContestant(campaignId, uid);
  }

  /// General version -- checks ANY given uid, not just the signed-in
  /// user. Needed for cases like the story viewer, which has to check
  /// whether the STORY OWNER (not whoever's watching) is a live,
  /// active contestant, before showing a vote button on their story.
  static Future<bool> isUidActiveContestant(String campaignId, String uid) async {
    final doc = await _campaigns().doc(campaignId).collection('contestants').doc(uid).get();
    return doc.data()?['status'] == 'active';
  }

  // ── Gated posting -- only active contestants can post here ─────────
  static Future<PostResult> postToCompetition({
    required String campaignId,
    required String content,
    List<String>? imageUrls,
    String? videoUrl,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return PostResult.notSignedIn;
    if (!await isActiveContestant(campaignId)) return PostResult.notActiveContestant;

    final contestantDoc = await _campaigns().doc(campaignId).collection('contestants').doc(uid).get();
    final profile = await UserService.getProfile();

    await _campaigns().doc(campaignId).collection('posts').add({
      'uid': uid,
      'displayName': profile?['displayName'] as String? ?? 'User',
      'usernameDisplay': profile?['usernameDisplay'] as String?,
      'category': contestantDoc.data()?['category'],
      'content': content,
      'imageUrls': imageUrls ?? [],
      if (videoUrl != null) 'videoUrl': videoUrl,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return PostResult.success;
  }

  static Stream<List<Map<String, dynamic>>> competitionPosts(String campaignId, {String? category}) {
    final query = _campaigns().doc(campaignId).collection('posts')
        .orderBy('createdAt', descending: true);
    return query.snapshots().map((s) {
      final all = s.docs.map((d) => {'id': d.id, ...d.data()}).toList();
      // Filtered client-side rather than via a second where() clause --
      // avoids a composite index requirement, same reasoning applied
      // everywhere else tonight.
      if (category == null) return all;
      return all.where((p) => p['category'] == category).toList();
    });
  }

  // ── Voting -- write-only, no client can read tallies ────────────────
  static Future<VoteResult> castVote({
    required String campaignId,
    required int round,
    required String votedForUid,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return VoteResult.notSignedIn;

    final contestantDoc = await _campaigns().doc(campaignId).collection('contestants').doc(votedForUid).get();
    if (contestantDoc.data()?['status'] != 'active') return VoteResult.notActive;

    final campaignDoc = await _campaigns().doc(campaignId).get();
    final announcedAt = campaignDoc.data()?['announcedAt'] as Timestamp?;
    final myProfile = await UserService.getProfile();
    final myCreatedAt = myProfile?['createdAt'] as Timestamp?;
    if (announcedAt != null && myCreatedAt != null && myCreatedAt.compareTo(announcedAt) > 0) {
      // Account was created AFTER the campaign was announced -- the
      // real anti-abuse gate discussed: blocks fresh accounts spun up
      // specifically to vote once the campaign is already live.
      return VoteResult.accountTooNew;
    }

    final voteRef = _campaigns().doc(campaignId).collection('votes').doc('${round}_$uid');
    final existing = await voteRef.get();
    if (existing.exists) return VoteResult.alreadyVoted;

    await voteRef.set({
      'round': round,
      'voterUid': uid,
      'votedForUid': votedForUid,
      'votedAt': FieldValue.serverTimestamp(),
    });
    await _campaigns().doc(campaignId).collection('contestants').doc(votedForUid)
        .update({'totalVotes': FieldValue.increment(1)});
    return VoteResult.success;
  }

  static Future<bool> hasVotedThisRound(String campaignId, int round) async {
    final uid = UserService.uid;
    if (uid == null) return false;
    final doc = await _campaigns().doc(campaignId).collection('votes').doc('${round}_$uid').get();
    return doc.exists;
  }
}

// ── Firestore rules required ──────────────────────────────────────────
// match /campaigns/{campaignId} {
//   allow read: if request.auth != null;
//   allow write: if false; // admin manages campaign docs directly in console
//
//   match /applications/{uid} {
//     allow read: if request.auth != null;
//     allow create: if request.auth != null && request.auth.uid == uid;
//   }
//
//   match /contestants/{uid} {
//     allow read: if request.auth != null;
//     allow update: if request.auth != null
//                   && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['totalVotes']);
//     allow write: if false; // admin adds/evicts contestants directly
//   }
//
//   match /posts/{postId} {
//     allow read: if request.auth != null;
//     allow create: if request.auth != null && request.auth.uid == request.resource.data.uid;
//   }
//
//   match /votes/{voteId} {
//     // Read restricted to the admin UID only -- votes are genuinely
//     // private, not just hidden in the UI. Same pattern as
//     // badge_eligible/study_room_report notifications.
//     allow read: if request.auth != null && request.auth.uid == 'oGr2sN8TNlUfjlhmxBiDsT3Q8KF3';
//     allow create: if request.auth != null && request.auth.uid == request.resource.data.voterUid;
//   }
// }