// lib/core/services/duel_service.dart
//
// REPLACES the old async "Words With Friends" style duel system. That
// version was deliberately non-live (challenger plays all questions
// immediately, opponent plays the same set whenever they get to it,
// days later if they want) -- explicitly NOT what this is. This is a
// live, synchronous, turn-based duel: two players matched together,
// alternating turns on a shared per-round clock, answers revealing to
// both sides in real time.
//
// Architecture mirrors StudyRoomService's proven pattern from this same
// app: server-authoritative deadlines (a `turnEndsAt` timestamp, not a
// client-trusted countdown), lazy expiration (any client can flip an
// expired turn once it notices, guarded by security rules checking
// request.time), and Firestore transactions for anything with a race
// condition (matchmaking, answer submission).
//
// Two modes, per the agreed spec:
//   - 'spelling': type the word matching a clue
//   - 'subject':  standard MCQ, drawn from an existing course's question bank
//
// 3 rounds, one question exchange per round (host answers, then
// opponent, then the round resolves). Round time budgets: 180s, 180s,
// 120s. Each player's clock is fresh per turn -- it does NOT carry
// over between rounds or between the two players' turns within a
// round. If both answer correctly, or both incorrectly, that round is
// a tie (no point). A correct answer beats an incorrect one.
//
// Firestore rules required -- see the end of this file for the exact
// rules to add, replacing the OLD duels rules entirely (the old schema
// is gone, this is a different shape).

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';
import '../../features/quiz/data/topic_question_source.dart';

enum DuelMode { spelling, subject }
enum DuelRole { host, opponent }

class DuelRoundConfig {
  final String type; // 'mcq' | 'spelling'
  final String prompt;
  final List<String>? options; // null for spelling
  final int? correctIndex; // null for spelling
  final String? correctText; // null for mcq (normalized lowercase, trimmed)
  const DuelRoundConfig({
    required this.type,
    required this.prompt,
    this.options,
    this.correctIndex,
    this.correctText,
  });

  Map<String, dynamic> toMap() => {
        'type': type,
        'prompt': prompt,
        if (options != null) 'options': options,
        if (correctIndex != null) 'correctIndex': correctIndex,
        if (correctText != null) 'correctText': correctText,
        'hostAnswer': null,
        'hostCorrect': null,
        'opponentAnswer': null,
        'opponentCorrect': null,
      };
}

// Starter spelling word bank -- placeholder content, worth expanding
// with real WAEC/JAMB-relevant vocabulary later. Clue-based so it's
// not a bare "spell this word" with zero context.
const List<Map<String, String>> _spellingBank = [
  {'clue': 'The process by which plants make food using sunlight', 'word': 'photosynthesis'},
  {'clue': 'A word that means the opposite of another word', 'word': 'antonym'},
  {'clue': 'The scientific study of living organisms', 'word': 'biology'},
  {'clue': 'A number that can only be divided by 1 and itself', 'word': 'prime'},
  {'clue': 'The force that pulls objects toward the earth', 'word': 'gravity'},
  {'clue': 'A shape with three sides', 'word': 'triangle'},
  {'clue': 'The study of the stars and planets', 'word': 'astronomy'},
  {'clue': 'A word that sounds the same as another but means something different', 'word': 'homophone'},
  {'clue': 'The branch of science dealing with substances and their reactions', 'word': 'chemistry'},
  {'clue': 'A government where citizens vote for their leaders', 'word': 'democracy'},
  {'clue': 'The organ that pumps blood around the body', 'word': 'heart'},
  {'clue': 'A statement believed to be true without proof, used as a basis for reasoning', 'word': 'axiom'},
  {'clue': 'The smallest unit of an element that retains its properties', 'word': 'atom'},
  {'clue': 'A word for a large group of stars, gas, and dust bound by gravity', 'word': 'galaxy'},
  {'clue': 'The process of breaking down food in the body', 'word': 'digestion'},
];

class DuelService {
  DuelService._();

  static const int roundCount = 3;
  static const List<int> roundBudgetsSeconds = [180, 180, 120];
  static const int mcqQuestionCount = 3; // one per round

  static final _db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> _duels() => _db.collection('duels');
  static CollectionReference<Map<String, dynamic>> _queue() => _db.collection('duel_queue');

  static DuelRole roleFor(String uid, Map<String, dynamic> duel) =>
      duel['hostUid'] == uid ? DuelRole.host : DuelRole.opponent;

  // ── Content drawing ─────────────────────────────────────────────────

  static List<DuelRoundConfig> _drawRounds(DuelMode mode, String? courseKey) {
    if (mode == DuelMode.spelling) {
      final bank = List<Map<String, String>>.from(_spellingBank)..shuffle();
      return bank.take(roundCount).map((w) => DuelRoundConfig(
            type: 'spelling',
            prompt: w['clue']!,
            correctText: w['word']!.trim().toLowerCase(),
          )).toList();
    }
    final pool = TopicQuestionSource.questionsForCourse(courseKey ?? '')..shuffle();
    return pool.take(mcqQuestionCount).map((q) => DuelRoundConfig(
          type: 'mcq',
          prompt: q.question,
          options: q.options,
          correctIndex: q.correctIndex,
        )).toList();
  }

  // ── Friend challenges (alternative to matchmaking) ───────────────────
  //
  // Separate from queueForMatch -- this targets one specific person
  // (someone you mutually follow) instead of anyone waiting. Since the
  // challenged friend might not have the app open right now, this is
  // necessarily a two-step flow: an invite gets created and they get
  // notified, and the actual live duel (with its shared clock) only
  // starts once they explicitly accept -- there's no live state to
  // sync until both people are actually present.

  static CollectionReference<Map<String, dynamic>> _invites() => _db.collection('duel_invites');

  /// Creates a challenge with no specific recipient -- anyone who opens
  /// the resulting link can accept it. Same underlying doc shape as
  /// [sendChallenge], just with toUid/toName left null until someone
  /// actually claims it at accept time. No notification is sent since
  /// there's no specific person to notify yet.
  static Future<String?> createLinkChallenge({
    required DuelMode mode,
    String? courseKey,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return null;
    final profile = await UserService.getProfile();
    final myName = profile?['displayName'] as String? ?? 'Someone';

    final inviteRef = _invites().doc();
    await inviteRef.set({
      'fromUid': uid,
      'fromName': myName,
      'toUid': null,
      'toName': null,
      'mode': mode.name,
      'courseKey': courseKey,
      'status': 'pending',
      'resultDuelId': null,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return inviteRef.id;
  }

  /// Fetches an invite's basic info for display before accepting --
  /// used by the link-landing screen to show "X challenged you to a
  /// Y battle" without needing to already be a participant (unlike
  /// [inviteStream], which is for the sender watching their own sent
  /// invite and requires participant-level read access).
  static Future<Map<String, dynamic>?> peekInvite(String inviteId) async {
    final snap = await _invites().doc(inviteId).get();
    return snap.data();
  }

  /// Sends a direct challenge to [toUid]. Reuses the 'duel_challenge'
  /// notification type already permitted in rules, but with fresh
  /// content -- the old helper in NotificationService was built for the
  /// async model (expects a pre-computed score that doesn't exist yet
  /// here), so this writes the notification directly instead of forcing
  /// it through that mismatched shape.
  static Future<String?> sendChallenge({
    required String toUid,
    required String toName,
    required DuelMode mode,
    String? courseKey,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return null;
    final profile = await UserService.getProfile();
    final myName = profile?['displayName'] as String? ?? 'Someone';

    final inviteRef = _invites().doc();
    await inviteRef.set({
      'fromUid': uid,
      'fromName': myName,
      'toUid': toUid,
      'toName': toName,
      'mode': mode.name,
      'courseKey': courseKey,
      'status': 'pending',
      'resultDuelId': null,
      'createdAt': FieldValue.serverTimestamp(),
    });

    try {
      await _db.collection('notifications').add({
        'uid': toUid,
        'fromUid': uid,
        'fromDisplayName': myName,
        'type': 'duel_challenge',
        'title': '$myName challenged you to a battle',
        'body': mode == DuelMode.spelling
            ? 'Spelling battle — tap to accept'
            : '${courseKey ?? 'Quiz'} battle — tap to accept',
        'inviteId': inviteRef.id,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (_) {
      // Best-effort -- the invite itself still exists even if the push
      // notification write fails; the incoming-invites stream below is
      // the real source of truth, not the notification.
    }

    return inviteRef.id;
  }

  /// Live view of your own outgoing invite -- watch for [resultDuelId]
  /// to appear once your friend accepts.
  static Stream<Map<String, dynamic>?> inviteStream(String inviteId) {
    return _invites().doc(inviteId).snapshots().map((d) => d.data());
  }

  /// Every pending challenge sent TO you, newest first.
  static Stream<List<Map<String, dynamic>>> myIncomingInvites() {
    final uid = UserService.uid;
    if (uid == null) return Stream.value([]);
    return _invites()
        .where('toUid', isEqualTo: uid)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => {'id': d.id, ...d.data()}).toList());
  }

  /// Accepts a challenge -- creates the actual live duel (same shape
  /// matchmaking produces) and marks the invite accepted so the
  /// challenger's waiting screen picks it up. Works for both a
  /// targeted friend challenge (invite already has toUid) and an open
  /// link invite (toUid is null, filled in here with whoever's
  /// accepting -- first to claim it wins, enforced by the transaction
  /// re-checking status == 'pending').
  static Future<String?> acceptChallenge(String inviteId) async {
    final uid = UserService.uid;
    if (uid == null) return null;
    final profile = await UserService.getProfile();
    final myName = profile?['displayName'] as String? ?? 'Student';
    final inviteRef = _invites().doc(inviteId);
    final duelRef = _duels().doc();

    final accepted = await _db.runTransaction<bool>((tx) async {
      final snap = await tx.get(inviteRef);
      final invite = snap.data();
      if (invite == null || invite['status'] != 'pending') return false;
      if (invite['fromUid'] == uid) return false; // can't accept your own invite
      final targetUid = invite['toUid'] as String?;
      if (targetUid != null && targetUid != uid) return false; // targeted at someone else

      final mode = invite['mode'] == 'spelling' ? DuelMode.spelling : DuelMode.subject;
      final courseKey = invite['courseKey'] as String?;
      final rounds = _drawRounds(mode, courseKey);
      final opponentName = invite['toName'] as String? ?? myName;

      tx.set(duelRef, {
        'mode': invite['mode'],
        'courseKey': courseKey,
        'hostUid': invite['fromUid'], // challenger hosts
        'hostName': invite['fromName'],
        'opponentUid': uid,
        'opponentName': opponentName,
        'status': 'active',
        'currentRound': 0,
        'turn': 'host',
        'turnEndsAt': Timestamp.fromDate(
          DateTime.now().add(Duration(seconds: roundBudgetsSeconds[0]))),
        'hostRoundWins': 0,
        'opponentRoundWins': 0,
        'winnerUid': null,
        'createdAt': FieldValue.serverTimestamp(),
      });
      for (var i = 0; i < rounds.length; i++) {
        tx.set(duelRef.collection('rounds').doc('$i'), rounds[i].toMap());
      }
      tx.update(inviteRef, {
        'status': 'accepted',
        'resultDuelId': duelRef.id,
        if (targetUid == null) 'toUid': uid,
        if (targetUid == null) 'toName': myName,
      });
      return true;
    });

    return accepted ? duelRef.id : null;
  }

  static Future<void> declineChallenge(String inviteId) async {
    await _invites().doc(inviteId).update({'status': 'declined'});
  }

  // ── Matchmaking ──────────────────────────────────────────────────────

  /// Tries to find a waiting opponent for [mode]/[courseKey]. If one
  /// exists, atomically claims them, creates the live duel, and returns
  /// the new duelId immediately -- no queue wait for the second player.
  /// If no one's waiting, adds the caller to the queue and returns null;
  /// the caller should then listen to [myQueueEntryStream] for a match.
  static Future<String?> queueForMatch({
    required DuelMode mode,
    String? courseKey,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return null;
    final profile = await UserService.getProfile();
    final myName = profile?['displayName'] as String? ?? 'Student';

    // Look for an existing, unmatched, compatible queue entry.
    Query<Map<String, dynamic>> q = _queue()
        .where('mode', isEqualTo: mode.name)
        .where('matchedDuelId', isNull: true)
        .orderBy('queuedAt')
        .limit(5); // small buffer in case the first candidate is myself/stale
    if (mode == DuelMode.subject) {
      q = q.where('courseKey', isEqualTo: courseKey);
    }
    final candidates = await q.get();
    final opponentDocs = candidates.docs.where((d) => d.id != uid).toList();
    final opponent = opponentDocs.isNotEmpty ? opponentDocs.first : null;

    if (opponent == null) {
      // Nobody waiting -- become the waiting entry.
      await _queue().doc(uid).set({
        'mode': mode.name,
        'courseKey': courseKey,
        'displayName': myName,
        'queuedAt': FieldValue.serverTimestamp(),
        'matchedDuelId': null,
      });
      return null;
    }

    // Found someone -- claim them and create the duel in one transaction
    // so two simultaneous second-players can't both claim the same entry.
    final opponentUid = opponent.id;
    final opponentData = opponent.data();
    final duelRef = _duels().doc();

    final claimed = await _db.runTransaction<bool>((tx) async {
      final freshOpp = await tx.get(_queue().doc(opponentUid));
      if (!freshOpp.exists || freshOpp.data()?['matchedDuelId'] != null) {
        return false; // someone else claimed them first
      }
      final rounds = _drawRounds(mode, courseKey);
      tx.set(duelRef, {
        'mode': mode.name,
        'courseKey': courseKey,
        'hostUid': opponentUid, // whoever was already waiting hosts
        'hostName': opponentData['displayName'] ?? 'Student',
        'opponentUid': uid,
        'opponentName': myName,
        'status': 'active',
        'currentRound': 0,
        'turn': 'host',
        'turnEndsAt': Timestamp.fromDate(
          DateTime.now().add(Duration(seconds: roundBudgetsSeconds[0]))),
        'hostRoundWins': 0,
        'opponentRoundWins': 0,
        'winnerUid': null,
        'createdAt': FieldValue.serverTimestamp(),
      });
      for (var i = 0; i < rounds.length; i++) {
        tx.set(duelRef.collection('rounds').doc('$i'), rounds[i].toMap());
      }
      tx.update(_queue().doc(opponentUid), {'matchedDuelId': duelRef.id});
      return true;
    });

    if (!claimed) {
      // Race lost -- fall back to queueing ourselves instead.
      await _queue().doc(uid).set({
        'mode': mode.name,
        'courseKey': courseKey,
        'displayName': myName,
        'queuedAt': FieldValue.serverTimestamp(),
        'matchedDuelId': null,
      });
      return null;
    }
    return duelRef.id;
  }

  /// Watch your own queue entry -- when [matchedDuelId] appears, someone
  /// matched with you. Navigate into the duel, then call [cancelQueue]
  /// to clean up (harmless no-op if already gone).
  static Stream<String?> myQueueEntryStream() {
    final uid = UserService.uid;
    if (uid == null) return Stream.value(null);
    return _queue().doc(uid).snapshots().map((d) => d.data()?['matchedDuelId'] as String?);
  }

  static Future<void> cancelQueue() async {
    final uid = UserService.uid;
    if (uid == null) return;
    await _queue().doc(uid).delete();
  }

  // ── Live duel state ──────────────────────────────────────────────────

  static Stream<Map<String, dynamic>?> duelStream(String duelId) {
    return _duels().doc(duelId).snapshots().map((d) => d.data());
  }

  static Stream<Map<String, dynamic>?> roundStream(String duelId, int roundIndex) {
    return _duels().doc(duelId).collection('rounds').doc('$roundIndex').snapshots().map((d) => d.data());
  }

  // ── Answering ────────────────────────────────────────────────────────

  /// Submits an answer for the current round. [selectedIndex] for mcq,
  /// [spellingText] for spelling -- pass whichever matches the round type.
  /// Handles turn-passing and round resolution inside one transaction.
  static Future<void> submitAnswer({
    required String duelId,
    required int roundIndex,
    int? selectedIndex,
    String? spellingText,
  }) async {
    final uid = UserService.uid;
    if (uid == null) return;
    final duelRef = _duels().doc(duelId);
    final roundRef = duelRef.collection('rounds').doc('$roundIndex');

    await _db.runTransaction((tx) async {
      final duelSnap = await tx.get(duelRef);
      final roundSnap = await tx.get(roundRef);
      final duel = duelSnap.data();
      final round = roundSnap.data();
      if (duel == null || round == null) return;
      if (duel['status'] != 'active' || duel['currentRound'] != roundIndex) return;

      final myRole = roleFor(uid, duel);
      final myTurn = duel['turn'] == myRole.name;
      if (!myTurn) return; // not your turn -- ignore (client should prevent this anyway)

      final alreadyAnswered = myRole == DuelRole.host
          ? round['hostAnswer'] != null
          : round['opponentAnswer'] != null;
      if (alreadyAnswered) return;

      bool correct;
      dynamic storedAnswer;
      if (round['type'] == 'spelling') {
        final normalized = (spellingText ?? '').trim().toLowerCase();
        correct = normalized == round['correctText'];
        storedAnswer = normalized;
      } else {
        correct = selectedIndex == round['correctIndex'];
        storedAnswer = selectedIndex;
      }

      final roundUpdate = myRole == DuelRole.host
          ? {'hostAnswer': storedAnswer, 'hostCorrect': correct}
          : {'opponentAnswer': storedAnswer, 'opponentCorrect': correct};
      tx.update(roundRef, roundUpdate);

      final otherAnswered = myRole == DuelRole.host
          ? round['opponentAnswer'] != null
          : round['hostAnswer'] != null;

      if (!otherAnswered) {
        // Pass the turn to the other player, fresh clock for their turn.
        final nextRole = myRole == DuelRole.host ? DuelRole.opponent : DuelRole.host;
        tx.update(duelRef, {
          'turn': nextRole.name,
          'turnEndsAt': Timestamp.fromDate(
            DateTime.now().add(Duration(seconds: roundBudgetsSeconds[roundIndex]))),
        });
        return;
      }

      // Both sides have now answered this round -- resolve it.
      final hostCorrect = myRole == DuelRole.host ? correct : round['hostCorrect'] as bool? ?? false;
      final opponentCorrect = myRole == DuelRole.opponent ? correct : round['opponentCorrect'] as bool? ?? false;

      int hostWins = duel['hostRoundWins'] as int? ?? 0;
      int opponentWins = duel['opponentRoundWins'] as int? ?? 0;
      if (hostCorrect && !opponentCorrect) hostWins++;
      if (opponentCorrect && !hostCorrect) opponentWins++;
      // Both correct or both wrong -> tie, no point either way.

      final isLastRound = roundIndex == roundCount - 1;
      if (isLastRound) {
        String? winnerUid;
        if (hostWins > opponentWins) winnerUid = duel['hostUid'] as String?;
        if (opponentWins > hostWins) winnerUid = duel['opponentUid'] as String?;
        tx.update(duelRef, {
          'status': 'completed',
          'hostRoundWins': hostWins,
          'opponentRoundWins': opponentWins,
          'winnerUid': winnerUid,
        });
      } else {
        tx.update(duelRef, {
          'currentRound': roundIndex + 1,
          'turn': 'host',
          'hostRoundWins': hostWins,
          'opponentRoundWins': opponentWins,
          'turnEndsAt': Timestamp.fromDate(
            DateTime.now().add(Duration(seconds: roundBudgetsSeconds[roundIndex + 1]))),
        });
      }
    });

    UserService.awardXP(20, reason: 'duel');
  }

  /// Call when a client notices turnEndsAt has passed with no answer --
  /// counts as a wrong/no answer for whoever's turn it was. Same lazy-
  /// expiration pattern as Study Rooms: any client can call this, rules
  /// guard it server-side by checking request.time against turnEndsAt.
  static Future<void> submitTimeout({required String duelId, required int roundIndex}) async {
    final duelSnap = await _duels().doc(duelId).get();
    final duel = duelSnap.data();
    if (duel == null || duel['status'] != 'active') return;
    if (duel['currentRound'] != roundIndex) return;
    final turn = duel['turn'] as String?;
    if (turn == null) return;
    // Submitting an "impossible" answer (-1 / a sentinel string) as
    // whoever's turn it is guarantees it's scored wrong, reusing the
    // same resolution path as a real answer -- no separate timeout
    // logic to keep in sync with the scoring rules above.
    final asHost = turn == 'host';
    await submitAnswer(
      duelId: duelId,
      roundIndex: roundIndex,
      selectedIndex: asHost ? -1 : null,
      spellingText: asHost ? null : '\u0000timeout\u0000',
    );
  }
}

/*
Firestore rules -- REPLACE the old `match /duels/{duelId} { ... }` block
entirely (old async schema is gone) with:

  match /duel_queue/{uid} {
    allow read: if request.auth != null;
    allow create: if request.auth != null && request.auth.uid == uid
                  && request.resource.data.matchedDuelId == null;
    allow delete: if request.auth != null && request.auth.uid == uid;
    // The matching transaction runs from the SECOND player's client and
    // needs to set matchedDuelId on the FIRST player's (someone else's)
    // queue doc -- that's the whole point of matchmaking. Scope it
    // tightly to only that one field so nothing else about someone
    // else's entry can be touched.
    allow update: if request.auth != null
                  && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['matchedDuelId']);
  }

  match /duels/{duelId} {
    allow read: if request.auth != null
                && (request.auth.uid == resource.data.hostUid
                    || request.auth.uid == resource.data.opponentUid);
    allow create: if request.auth != null
                  && (request.auth.uid == request.resource.data.hostUid
                      || request.auth.uid == request.resource.data.opponentUid)
                  && request.resource.data.status == 'active'
                  && request.resource.data.currentRound == 0;
    allow update: if request.auth != null
                  && (request.auth.uid == resource.data.hostUid
                      || request.auth.uid == resource.data.opponentUid);

    match /rounds/{roundIndex} {
      allow read: if request.auth != null
                  && (request.auth.uid == get(/databases/$(database)/documents/duels/$(duelId)).data.hostUid
                      || request.auth.uid == get(/databases/$(database)/documents/duels/$(duelId)).data.opponentUid);
      allow create: if request.auth != null
                    && (request.auth.uid == get(/databases/$(database)/documents/duels/$(duelId)).data.hostUid
                        || request.auth.uid == get(/databases/$(database)/documents/duels/$(duelId)).data.opponentUid);
      allow update: if request.auth != null
                    && (request.auth.uid == get(/databases/$(database)/documents/duels/$(duelId)).data.hostUid
                        || request.auth.uid == get(/databases/$(database)/documents/duels/$(duelId)).data.opponentUid);
    }
  }
*/