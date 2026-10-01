// lib/core/services/relationship_service.dart
//
// users/{myUid}/relationshipStrength/{otherUid}: { score: int }
//
// Incremented whenever you like or comment on a SPECIFIC person's
// post -- comments count more than likes, matching how Instagram
// itself weighs these differently. This is what lets "someone you
// follow and actually engage with constantly" rank higher than
// "someone you follow but have never once interacted with", rather
// than treating every followed account identically.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class RelationshipService {
  RelationshipService._();

  static final _db = FirebaseFirestore.instance;

  static Future<void> recordInteraction(String otherUid, {required int weight}) async {
    final myUid = UserService.uid;
    if (myUid == null || otherUid == myUid) return; // don't track interacting with your own posts
    final ref = _db.collection('users').doc(myUid).collection('relationshipStrength').doc(otherUid);
    try {
      await ref.set({'score': FieldValue.increment(weight)}, SetOptions(merge: true));
    } catch (e) {
      // ignore: avoid_print
      print('[RelationshipService] recordInteraction failed: $e');
    }
  }

  /// My own strongest relationships, as {uid: score} -- bounded to
  /// the top N so this stays a cheap, one-time read per feed load,
  /// not something that grows with your entire interaction history.
  static Future<Map<String, int>> myTopRelationships({int limit = 50}) async {
    final myUid = UserService.uid;
    if (myUid == null) return {};
    try {
      final snap = await _db.collection('users').doc(myUid).collection('relationshipStrength')
          .orderBy('score', descending: true)
          .limit(limit)
          .get();
      return {for (final d in snap.docs) d.id: (d.data()['score'] as num?)?.toInt() ?? 0};
    } catch (e) {
      // ignore: avoid_print
      print('[RelationshipService] myTopRelationships failed: $e');
      return {};
    }
  }
}