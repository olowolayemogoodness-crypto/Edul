// lib/core/services/affinity_service.dart
//
// Turns interest-picker data into actual community candidates. Every
// tag a student picks at onboarding (the 12 broad categories, plus
// football clubs specifically) increments a campus-wide counter for
// that tag. The moment a counter crosses the threshold, a hidden
// 'candidate' community gets created automatically -- hidden, not
// live, because an empty room with a random threshold-crossing
// stranger as its only member is a worse first impression than no
// room at all. An ambassador (or you, for now, directly in Firestore
// console -- no admin UI for this exists yet) reviews candidates and
// flips status to 'active' once it's been seeded with a real first
// post, same reasoning as the ambassador-seeding plan discussed
// earlier tonight.
//
// Football clubs use the exact same mechanic as broad categories --
// "Arsenal" is just another tag being counted. This is what lets a
// live Arsenal vs Man U banner eventually target exactly the people
// who'd care, without needing separate logic for sports vs interests.
//
// Deliberately does NOT decrement -- interest picks are a one-time
// onboarding action right now (no "unpick" flow exists yet), so
// there's nothing to remove a count for yet. Worth revisiting if/when
// interests become editable after onboarding.

import 'package:cloud_firestore/cloud_firestore.dart';

class AffinityService {
  AffinityService._();

  static final _db = FirebaseFirestore.instance;

  /// How many students need to share a tag before it becomes a real
  /// candidate community. Deliberately not tiny -- a 3-person "club"
  /// is worse than no club, per the empty-room reasoning above.
  static const int clusterThreshold = 30;

  /// Call once, right after a user's interest picks are saved, with
  /// every tag id they picked (categories + football clubs together).
  /// Atomic across all of them in one transaction -- either every
  /// counter updates and any newly-crossed thresholds create their
  /// candidate community, or none of it does, never a partial state.
  static Future<void> recordInterestPicks(
    List<String> tagIds, {
    Map<String, String>? labels,
  }) async {
    if (tagIds.isEmpty) return;

    try {
      await _db.runTransaction((tx) async {
        // Firestore transactions require every read before any write --
        // so all the counter lookups happen first, in their own pass.
        final snaps = <String, DocumentSnapshot<Map<String, dynamic>>>{};
        for (final tagId in tagIds) {
          snaps[tagId] = await tx.get(_db.collection('interest_counts').doc(tagId));
        }

        for (final tagId in tagIds) {
          final snap = snaps[tagId]!;
          final data = snap.data();
          final currentCount = (data?['count'] as int?) ?? 0;
          final newCount = currentCount + 1;
          final alreadyHasCommunity = data?['communityCreated'] == true;
          final label = labels?[tagId] ?? tagId;

          tx.set(snap.reference, {
            'count': newCount,
            'label': label,
          }, SetOptions(merge: true));

          if (newCount >= clusterThreshold && !alreadyHasCommunity) {
            final communityRef = _db.collection('communities').doc();
            tx.set(communityRef, {
              'interestId': tagId,
              'name': label,
              'status': 'candidate', // hidden from Discover until an ambassador activates it
              'memberCount': 0,
              'createdAt': FieldValue.serverTimestamp(),
            });
            tx.update(snap.reference, {
              'communityCreated': true,
              'communityId': communityRef.id,
            });
          }
        }
      });
        } catch (e) {
      // Still non-blocking (registration must never fail over this),
      // but printed rather than silently swallowed -- a bare empty
      // catch here would hide exactly the kind of missing-Firestore-
      // rule error that's bitten this project all night.
      // ignore: avoid_print
      print('[AffinityService] recordInterestPicks failed: $e');
      // Best-effort, same reasoning as saveInterests -- a failed
      // clustering side-effect should never surface as a broken
      // registration flow to the person who just picked their
      // interests.
    }
  }

  /// Candidates waiting for an ambassador to review -- there's no
  /// dedicated screen for this yet, but this method exists so one can
  /// be built without touching the write side above.
  static Future<List<Map<String, dynamic>>> pendingCandidates() async {
    final snap = await _db.collection('communities').where('status', isEqualTo: 'candidate').get();
    return snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
  }

  /// Promotes a candidate to a real, visible community. Call this
  /// once an ambassador has actually posted something real into it --
  /// not the moment the threshold crosses.
  static Future<void> activateCommunity(String communityId) async {
    await _db.collection('communities').doc(communityId).update({'status': 'active'});
  }
}