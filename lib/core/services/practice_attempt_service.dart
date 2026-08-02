// lib/core/services/practice_attempt_service.dart
//
// Real attempt history for practice tests, replacing the hardcoded
// "Best: 68% · 3 attempts" placeholders that used to be baked into the
// practice test cards.
//
// Stored per course under users/{uid}/practiceAttempts/{courseId}, one
// aggregate doc per course rather than one doc per attempt — the UI only
// ever needs best/average/count, so keeping a rolling aggregate avoids
// reading back a growing attempt list every time the browse screen
// opens. (Same reasoning as the denormalized like/comment counters on
// posts.) If you later want a full per-attempt history graph, that's a
// subcollection underneath this doc, not a change to these fields.
//
// courseKey ('MTS 102') is sanitized to a doc id ('MTS_102') — Firestore
// tolerates spaces in ids but they're awkward in console URLs and paths.
//
// Firestore rule required — add alongside your existing studyStats /
// tutorUsage / seenInsights rules inside `match /users/{userId}`:
//
//   match /practiceAttempts/{courseId} {
//     allow read, write: if request.auth != null && request.auth.uid == userId;
//   }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class PracticeAttempt {
  final int bestPercent;
  final int lastPercent;
  final int attempts;
  final int totalPercent; // running sum, for a true average

  const PracticeAttempt({
    required this.bestPercent,
    required this.lastPercent,
    required this.attempts,
    required this.totalPercent,
  });

  int get averagePercent =>
      attempts > 0 ? (totalPercent / attempts).round() : 0;

  static PracticeAttempt fromMap(Map<String, dynamic> m) => PracticeAttempt(
        bestPercent: (m['bestPercent'] as int?) ?? 0,
        lastPercent: (m['lastPercent'] as int?) ?? 0,
        attempts: (m['attempts'] as int?) ?? 0,
        totalPercent: (m['totalPercent'] as int?) ?? 0,
      );
}

class PracticeAttemptService {
  PracticeAttemptService._();

  static final _db = FirebaseFirestore.instance;

  static String docIdFor(String courseKey) => courseKey.replaceAll(' ', '_');

  static CollectionReference<Map<String, dynamic>>? _col() {
    final uid = UserService.uid;
    if (uid == null) return null;
    return _db.collection('users').doc(uid).collection('practiceAttempts');
  }

  /// Live map of courseKey -> attempt history, for the browse screen.
  /// Emits an empty map when signed out rather than erroring, so the
  /// screen still renders (just with no history).
  static Stream<Map<String, PracticeAttempt>> streamAll() {
    final col = _col();
    if (col == null) return Stream.value({});
    return col.snapshots().map((snap) {
      final out = <String, PracticeAttempt>{};
      for (final doc in snap.docs) {
        // Doc ids are sanitized ('MTS_102'); map back to course keys.
        out[doc.id.replaceAll('_', ' ')] = PracticeAttempt.fromMap(doc.data());
      }
      return out;
    });
  }

  /// Records one finished attempt. Uses a transaction so two attempts
  /// finishing close together can't clobber each other's totals.
  static Future<void> recordAttempt({
    required String courseKey,
    required int percent,
  }) async {
    final col = _col();
    if (col == null) return;
    final ref = col.doc(docIdFor(courseKey));
    try {
      await _db.runTransaction((tx) async {
        final snap = await tx.get(ref);
        final prev = snap.exists
            ? PracticeAttempt.fromMap(snap.data()!)
            : const PracticeAttempt(
                bestPercent: 0, lastPercent: 0, attempts: 0, totalPercent: 0);
        tx.set(ref, {
          'bestPercent':
              percent > prev.bestPercent ? percent : prev.bestPercent,
          'lastPercent': percent,
          'attempts': prev.attempts + 1,
          'totalPercent': prev.totalPercent + percent,
          'lastAttemptAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      });
    } catch (_) {
      // Best-effort — a failed history write shouldn't block the user
      // seeing their results, which are already computed locally.
    }
  }
}