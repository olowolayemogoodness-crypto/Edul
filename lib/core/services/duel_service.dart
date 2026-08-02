// lib/core/services/duel_service.dart
//
// Async 1v1 quiz duels — "Words With Friends" style, not live/real-time.
// Deliberately NOT synchronous head-to-head play: that needs shared
// live state, timing/disconnect handling, and a lot more surface area
// to get right. This ships today by reusing what already exists:
//   - questions come from TopicQuestionSource, same as practice tests
//   - challenge/result notifications reuse NotificationService's
//     existing push pipeline
//   - XP reward reuses UserService.awardXP
//
// Flow:
//   1. Challenger picks an opponent + course, plays the quiz immediately.
//      Their answers are locked in at creation time — a duel document is
//      only ever created with the challenger's side already complete.
//   2. Opponent gets notified, plays the SAME question set (stored
//      verbatim on the duel doc, not re-drawn — otherwise the two
//      players could end up answering different questions).
//   3. The moment the opponent submits, the duel is scored and BOTH
//      players get a result notification.
//
// Firestore rules required — new top-level collection:
//
//   match /duels/{duelId} {
//     allow read: if request.auth != null
//                 && (request.auth.uid == resource.data.challengerUid
//                     || request.auth.uid == resource.data.opponentUid);
//     allow create: if request.auth != null
//                   && request.auth.uid == request.resource.data.challengerUid
//                   && request.resource.data.status == 'pending';
//     // Opponent submitting their answers — the ONLY update a client
//     // may ever make, and only the opponent, and only while still
//     // pending. Everything else about a duel is immutable once created.
//     allow update: if request.auth != null
//                   && request.auth.uid == resource.data.opponentUid
//                   && resource.data.status == 'pending'
//                   && request.resource.data.diff(resource.data).affectedKeys()
//                        .hasOnly(['opponentScore', 'opponentCorrect', 'opponentAnswers',
//                                  'opponentCompletedAt', 'status', 'winnerUid']);
//   }
//
// Notification rules required — same shape as your other notification
// types, add alongside them in match /notifications/{docId}:
//
//   allow create: if request.auth != null
//                 && request.auth.uid == request.resource.data.fromUid
//                 && request.resource.data.uid != request.auth.uid
//                 && request.resource.data.type == 'duel_challenge'
//                 && request.resource.data.title is string
//                 && request.resource.data.title.size() <= 150
//                 && request.resource.data.body is string
//                 && request.resource.data.body.size() <= 200;
//   allow create: if request.auth != null
//                 && request.auth.uid == request.resource.data.fromUid
//                 && request.resource.data.uid != request.auth.uid
//                 && request.resource.data.type == 'duel_result'
//                 && request.resource.data.title is string
//                 && request.resource.data.title.size() <= 150
//                 && request.resource.data.body is string
//                 && request.resource.data.body.size() <= 200;

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';
import 'notifications_service.dart';
import '../../features/quiz/data/topic_question_source.dart';
import '../../features/quiz/domain/models/quiz_question.dart';

class DuelAnswer {
  final int? selectedIndex;
  final bool correct;
  const DuelAnswer({required this.selectedIndex, required this.correct});

  Map<String, dynamic> toMap() => {'selectedIndex': selectedIndex, 'correct': correct};
  static DuelAnswer fromMap(Map<String, dynamic> m) => DuelAnswer(
        selectedIndex: m['selectedIndex'] as int?,
        correct: m['correct'] as bool? ?? false,
      );
}

class DuelService {
  DuelService._();

  static const int questionCount = 10;
  static final _db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> _duels() =>
      _db.collection('duels');

  /// Draws a fresh 10-question set for [courseKey] — same source practice
  /// tests use, so no new content is needed anywhere for this feature.
  static List<QuizQuestion> drawQuestions(String courseKey) {
    final pool = TopicQuestionSource.questionsForCourse(courseKey);
    pool.shuffle();
    return pool.take(questionCount).toList();
  }

  /// Creates a duel with the CHALLENGER's answers already complete —
  /// a duel is never created half-finished. Notifies the opponent.
  static Future<String?> createDuel({
    required String opponentUid,
    required String opponentName,
    required String courseKey,
    required List<QuizQuestion> questions,
    required List<DuelAnswer> challengerAnswers,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return null;
    final profile = await UserService.getProfile();
    final challengerName = profile?['displayName'] as String? ?? 'Someone';

    final correct = challengerAnswers.where((a) => a.correct).length;

    final ref = _duels().doc();
    await ref.set({
      'challengerUid': uid,
      'challengerName': challengerName,
      'opponentUid': opponentUid,
      'opponentName': opponentName,
      'courseKey': courseKey,
      'questions': questions.map((q) => {
            'question': q.question,
            'options': q.options,
            'correctIndex': q.correctIndex,
            'explanation': q.explanation,
          }).toList(),
      'challengerScore': correct,
      'challengerCorrect': correct,
      'challengerAnswers': challengerAnswers.map((a) => a.toMap()).toList(),
      'opponentScore': null,
      'opponentCorrect': null,
      'opponentAnswers': null,
      'opponentCompletedAt': null,
      'status': 'pending',
      'winnerUid': null,
      'createdAt': FieldValue.serverTimestamp(),
      // Stale, unplayed challenges stop showing as "pending" after this —
      // handled client-side by filtering on read, no cleanup job needed.
      'expiresAt': Timestamp.fromDate(DateTime.now().add(const Duration(days: 7))),
    });

    await NotificationService.createDuelChallengeNotification(
      targetUid: opponentUid,
      duelId: ref.id,
      courseKey: courseKey,
      correctOutOfTotal: '$correct/${questions.length}',
    );

    return ref.id;
  }

  /// Submits the OPPONENT's answers, scores the duel, and notifies both
  /// players of the result. This is the only write a client makes to an
  /// existing duel doc — everything else is set once at creation.
  static Future<void> submitOpponentAnswers({
    required String duelId,
    required List<DuelAnswer> answers,
  }) async {
    final ref = _duels().doc(duelId);
    try {
      await _db.runTransaction((tx) async {
        final snap = await tx.get(ref);
        final data = snap.data();
        if (data == null || data['status'] != 'pending') return;

        final correct = answers.where((a) => a.correct).length;
        final challengerCorrect = data['challengerCorrect'] as int? ?? 0;

        String? winnerUid;
        if (correct > challengerCorrect) {
          winnerUid = data['opponentUid'] as String?;
        } else if (challengerCorrect > correct) {
          winnerUid = data['challengerUid'] as String?;
        } // else: tie, winnerUid stays null

        tx.update(ref, {
          'opponentScore': correct,
          'opponentCorrect': correct,
          'opponentAnswers': answers.map((a) => a.toMap()).toList(),
          'opponentCompletedAt': FieldValue.serverTimestamp(),
          'status': 'completed',
          'winnerUid': winnerUid,
        });
      });

      // Reward XP for playing, regardless of outcome — small win-bonus on
      // top. Best-effort, outside the transaction since it touches a
      // different document (the user doc, not the duel doc).
      final uid = UserService.uid;
      if (uid != null) {
        UserService.awardXP(20, reason: 'duel');
      }

      await _notifyDuelResult(duelId);
    } catch (_) {
      // Best-effort — a failed notification/XP step shouldn't undo an
      // already-recorded result.
    }
  }

  static Future<void> _notifyDuelResult(String duelId) async {
    try {
      final snap = await _duels().doc(duelId).get();
      final data = snap.data();
      if (data == null) return;
      final challengerUid = data['challengerUid'] as String;
      final opponentUid = data['opponentUid'] as String;
      final challengerCorrect = data['challengerCorrect'] as int? ?? 0;
      final opponentCorrect = data['opponentCorrect'] as int? ?? 0;
      final courseKey = data['courseKey'] as String? ?? '';

      await NotificationService.createDuelResultNotification(
        targetUid: challengerUid,
        duelId: duelId,
        courseKey: courseKey,
        myScore: challengerCorrect,
        opponentScore: opponentCorrect,
      );
      await NotificationService.createDuelResultNotification(
        targetUid: opponentUid,
        duelId: duelId,
        courseKey: courseKey,
        myScore: opponentCorrect,
        opponentScore: challengerCorrect,
      );
    } catch (_) {}
  }

  /// Live stream of every duel involving the current user — split into
  /// three buckets client-side (pending-mine-to-play, pending-waiting-on-
  /// them, completed) since that's a small, bounded list per user and
  /// doesn't need three separate queries.
  ///
  /// Firestore can't OR two different fields in one query, so this reads
  /// both directions (challenger and opponent) and merges. Manually
  /// combines the two streams (no rxdart dependency) — re-emits the full
  /// merged list whenever EITHER side changes, so a fresh incoming
  /// challenge shows up live, not just changes to duels you started.
  static Stream<List<Map<String, dynamic>>> myDuels() {
    final uid = UserService.uid;
    if (uid == null) return Stream.value([]);

    final controller = StreamController<List<Map<String, dynamic>>>.broadcast();
    List<Map<String, dynamic>> latestAsChallenger = [];
    List<Map<String, dynamic>> latestAsOpponent = [];

    void emit() {
      final all = [...latestAsChallenger, ...latestAsOpponent];
      all.sort((a, b) {
        final at = a['createdAt'] as Timestamp?;
        final bt = b['createdAt'] as Timestamp?;
        return (bt ?? Timestamp(0, 0)).compareTo(at ?? Timestamp(0, 0));
      });
      controller.add(all);
    }

    final sub1 = _duels().where('challengerUid', isEqualTo: uid).snapshots().listen((snap) {
      latestAsChallenger = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
      emit();
    });
    final sub2 = _duels().where('opponentUid', isEqualTo: uid).snapshots().listen((snap) {
      latestAsOpponent = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
      emit();
    });

    controller.onCancel = () {
      sub1.cancel();
      sub2.cancel();
    };

    return controller.stream;
  }
}