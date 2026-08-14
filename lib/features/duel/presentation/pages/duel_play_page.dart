// lib/features/duel/presentation/pages/duel_play_page.dart
//
// The live battle screen -- matches the prototype: shadow avatars, a
// dual timer (chess-clock style), one question at a time, answers
// revealing to both sides, then passing to the next round. Everything
// here is a reflection of Firestore state via duel_service.dart's
// streams -- this screen doesn't own the timer or turn logic, it just
// displays turnEndsAt and lets the active player submit an answer.
//
// A local 1s ticker recomputes the countdown display AND calls
// submitTimeout() once the deadline passes -- any client watching can
// notice this, not just the active player's device, so a duel can't
// get stuck if someone's connection drops mid-turn.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/duel_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/hint_service.dart';

class DuelPlayPage extends StatefulWidget {
  final String duelId;
  const DuelPlayPage({super.key, required this.duelId});

  @override
  State<DuelPlayPage> createState() => _DuelPlayPageState();
}

class _DuelPlayPageState extends State<DuelPlayPage> {
  Timer? _ticker;
  int _secondsLeft = 0;
  int? _selectedIndex;
  final _spellingCtrl = TextEditingController();
  bool _submitted = false;
  DateTime? _lastKnownTurnEnd;
  int _lastKnownRound = -1;
  String? _lastKnownTurn;
  Set<int> _eliminatedIndices = {};
  String? _revealedPrefix;

  @override
  void initState() {
    super.initState();
    // Boosters are pre-stocked before entering a duel (watching an ad
    // mid-turn would burn into the shared clock, or require pausing it
    // -- neither is acceptable). This just loads whatever's already in
    // the bank; nothing here grants new boosters.
    HintService.ensureLoaded().then((_) { if (mounted) setState(() {}); });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _spellingCtrl.dispose();
    super.dispose();
  }

  void _useEliminateBooster(Map<String, dynamic> round) {
    if (!HintService.useEliminate()) return;
    final correctIndex = round['correctIndex'] as int?;
    final options = (round['options'] as List<dynamic>? ?? []);
    final wrongIndices = List.generate(options.length, (i) => i)
        .where((i) => i != correctIndex && !_eliminatedIndices.contains(i))
        .toList()
      ..shuffle();
    setState(() => _eliminatedIndices.addAll(wrongIndices.take(2)));
  }

  void _useRevealBooster(Map<String, dynamic> round) {
    if (!HintService.useReveal()) return;
    final correctText = round['correctText'] as String? ?? '';
    setState(() => _revealedPrefix = correctText.length >= 2 ? correctText.substring(0, 2) : correctText);
  }

  void _syncTicker(Map<String, dynamic> duel) {
    final turnEndsAt = (duel['turnEndsAt'] as Timestamp?)?.toDate();
    final round = duel['currentRound'] as int? ?? 0;
    final turn = duel['turn'] as String?;
    if (turnEndsAt == null) return;

    // Only reset local answer state when the round or whose-turn actually
    // changes -- avoids wiping a half-typed spelling answer on every
    // Firestore snapshot re-render.
    if (round != _lastKnownRound || turn != _lastKnownTurn) {
      _lastKnownRound = round;
      _lastKnownTurn = turn;
      _selectedIndex = null;
      _spellingCtrl.clear();
      _submitted = false;
      _eliminatedIndices = {};
      _revealedPrefix = null;
    }
    _lastKnownTurnEnd = turnEndsAt;

    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) { t.cancel(); return; }
      final remaining = _lastKnownTurnEnd!.difference(DateTime.now()).inSeconds;
      setState(() => _secondsLeft = remaining.clamp(0, 999));
      if (remaining <= 0) {
        t.cancel();
        DuelService.submitTimeout(duelId: widget.duelId, roundIndex: _lastKnownRound);
      }
    });
    _secondsLeft = turnEndsAt.difference(DateTime.now()).inSeconds.clamp(0, 999);
  }

  String _fmt(int s) => '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final myUid = UserService.uid;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: StreamBuilder<Map<String, dynamic>?>(
          stream: DuelService.duelStream(widget.duelId),
          builder: (context, duelSnap) {
            final duel = duelSnap.data;
            if (duel == null) return const Center(child: CircularProgressIndicator());

            if (duel['status'] == 'completed') {
              return _ResultScreen(duel: duel, myUid: myUid);
            }

            _syncTicker(duel);
            final myRole = myUid != null ? DuelService.roleFor(myUid, duel) : DuelRole.host;
            final myTurn = duel['turn'] == myRole.name;
            final currentRound = duel['currentRound'] as int? ?? 0;
            final oppName = myRole == DuelRole.host ? duel['opponentName'] : duel['hostName'];
            final myWins = myRole == DuelRole.host ? duel['hostRoundWins'] : duel['opponentRoundWins'];
            final oppWins = myRole == DuelRole.host ? duel['opponentRoundWins'] : duel['hostRoundWins'];

            return StreamBuilder<Map<String, dynamic>?>(
              stream: DuelService.roundStream(widget.duelId, currentRound),
              builder: (context, roundSnap) {
                final round = roundSnap.data;
                if (round == null) return const Center(child: CircularProgressIndicator());

                final hostAnswered = round['hostAnswer'] != null;
                final oppAnswered = round['opponentAnswer'] != null;
                final myAnswered = myRole == DuelRole.host ? hostAnswered : oppAnswered;
                final theirAnswered = myRole == DuelRole.host ? oppAnswered : hostAnswered;
                final bothAnswered = hostAnswered && oppAnswered;

                return Column(children: [
                  _TopBar(round: currentRound, onExit: () => Navigator.of(context).maybePop()),
                  const SizedBox(height: 6),
                  _TimerRow(
                    mySeconds: myTurn ? _secondsLeft : DuelService.roundBudgetsSeconds[currentRound],
                    oppSeconds: !myTurn ? _secondsLeft : DuelService.roundBudgetsSeconds[currentRound],
                    myActive: myTurn,
                    fmt: _fmt,
                  ),
                  const SizedBox(height: 18),
                  _ShadowAvatar(label: oppName as String? ?? 'Opponent', active: !myTurn, wins: oppWins as int? ?? 0),
                  const SizedBox(height: 10),
                  Text(
                    bothAnswered ? 'Round complete' : (myTurn ? 'Your turn' : "$oppName's turn"),
                    style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500,
                      color: myTurn && !bothAnswered ? AppColors.accentLight : AppColors.textTertiary),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _QuestionCard(
                        round: round,
                        myTurn: myTurn,
                        myAnswered: myAnswered,
                        theirAnswered: theirAnswered,
                        bothAnswered: bothAnswered,
                        selectedIndex: _selectedIndex,
                        spellingCtrl: _spellingCtrl,
                        onSelectMcq: (i) => setState(() => _selectedIndex = i),
                        onSubmit: () => _submit(currentRound, round),
                        eliminatedIndices: _eliminatedIndices,
                        revealedPrefix: _revealedPrefix,
                        onUseEliminate: () => _useEliminateBooster(round),
                        onUseReveal: () => _useRevealBooster(round),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _ShadowAvatar(label: 'You', active: myTurn, wins: myWins as int? ?? 0),
                  const SizedBox(height: 16),
                ]);
              },
            );
          },
        ),
      ),
    );
  }

  void _submit(int roundIndex, Map<String, dynamic> round) {
    if (_submitted) return;
    if (round['type'] == 'spelling' && _spellingCtrl.text.trim().isEmpty) return;
    if (round['type'] == 'mcq' && _selectedIndex == null) return;
    setState(() => _submitted = true);
    DuelService.submitAnswer(
      duelId: widget.duelId,
      roundIndex: roundIndex,
      selectedIndex: round['type'] == 'mcq' ? _selectedIndex : null,
      spellingText: round['type'] == 'spelling' ? _spellingCtrl.text : null,
    );
  }
}

class _TopBar extends StatelessWidget {
  final int round;
  final VoidCallback onExit;
  const _TopBar({required this.round, required this.onExit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(onTap: onExit, child: Icon(Icons.close_rounded, color: AppColors.textTertiary, size: 22)),
        Row(children: List.generate(DuelService.roundCount, (i) {
          final state = i < round ? AppColors.accent
              : i == round ? AppColors.accent.withValues(alpha: 0.4)
              : AppColors.border;
          return Container(margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 22, height: 4, decoration: BoxDecoration(color: state, borderRadius: BorderRadius.circular(2)));
        })),
        const SizedBox(width: 22),
      ]),
    );
  }
}

class _TimerRow extends StatelessWidget {
  final int mySeconds, oppSeconds;
  final bool myActive;
  final String Function(int) fmt;
  const _TimerRow({required this.mySeconds, required this.oppSeconds, required this.myActive, required this.fmt});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _pill(fmt(oppSeconds), !myActive),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text('vs', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary))),
      _pill(fmt(mySeconds), myActive),
    ]);
  }

  Widget _pill(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: active ? AppColors.accentSurface : AppColors.surface,
        border: Border.all(color: active ? AppColors.accent : AppColors.border),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600,
        fontFeatures: const [FontFeature.tabularFigures()],
        color: active ? AppColors.accentLight : AppColors.textTertiary)),
    );
  }
}

class _ShadowAvatar extends StatelessWidget {
  final String label;
  final bool active;
  final int wins;
  const _ShadowAvatar({required this.label, required this.active, required this.wins});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 48, height: 48,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant, shape: BoxShape.circle,
          border: active ? Border.all(color: AppColors.accent, width: 2.5) : null,
        ),
        child: Icon(Icons.person_rounded, color: AppColors.textTertiary, size: 24),
      ),
      const SizedBox(height: 4),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Text(label, style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textSecondary)),
        const SizedBox(width: 5),
        ...List.generate(wins, (_) => Padding(padding: const EdgeInsets.only(left: 1),
          child: Icon(Icons.circle, size: 6, color: AppColors.success))),
      ]),
    ]);
  }
}

class _QuestionCard extends StatelessWidget {
  final Map<String, dynamic> round;
  final bool myTurn, myAnswered, theirAnswered, bothAnswered;
  final int? selectedIndex;
  final TextEditingController spellingCtrl;
  final void Function(int) onSelectMcq;
  final VoidCallback onSubmit;
  final Set<int> eliminatedIndices;
  final String? revealedPrefix;
  final VoidCallback onUseEliminate;
  final VoidCallback onUseReveal;

  const _QuestionCard({
    required this.round, required this.myTurn, required this.myAnswered,
    required this.theirAnswered, required this.bothAnswered,
    required this.selectedIndex, required this.spellingCtrl,
    required this.onSelectMcq, required this.onSubmit,
    required this.eliminatedIndices, required this.revealedPrefix,
    required this.onUseEliminate, required this.onUseReveal,
  });

  @override
  Widget build(BuildContext context) {
    final isMcq = round['type'] == 'mcq';
    final canInteract = myTurn && !myAnswered;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface, border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (canInteract) _buildBoosterRow(isMcq),
        if (canInteract) const SizedBox(height: 10),
        Text(round['prompt'] as String? ?? '', style: GoogleFonts.dmSans(
          fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textPrimary, height: 1.4)),
        const SizedBox(height: 14),

        if (isMcq)
          ..._buildMcqOptions(canInteract)
        else
          _buildSpellingInput(canInteract),

        if (!isMcq && canInteract) ...[
          const SizedBox(height: 10),
          SizedBox(width: double.infinity, child: ElevatedButton(
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: Text('Submit', style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w600)),
          )),
        ],

        if (!myTurn && !theirAnswered) ...[
          const SizedBox(height: 10),
          Text('Waiting for opponent to move…', style: GoogleFonts.dmSans(
            fontSize: 12, color: AppColors.textTertiary)),
        ],
      ]),
    );
  }

  Widget _buildBoosterRow(bool isMcq) {
    final alreadyUsedElim = eliminatedIndices.isNotEmpty;
    final alreadyUsedReveal = revealedPrefix != null;
    if (isMcq) {
      final balance = HintService.eliminateBalance;
      final usable = balance > 0 && !alreadyUsedElim;
      return GestureDetector(
        onTap: usable ? onUseEliminate : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: usable ? AppColors.accentSurface : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('✂️ Eliminate 2 · $balance left', style: GoogleFonts.dmSans(
            fontSize: 11, fontWeight: FontWeight.w600,
            color: usable ? AppColors.accentLight : AppColors.textTertiary)),
        ),
      );
    }
    final balance = HintService.revealBalance;
    final usable = balance > 0 && !alreadyUsedReveal;
    return GestureDetector(
      onTap: usable ? onUseReveal : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: usable ? AppColors.accentSurface : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text('💡 Reveal 2 letters · $balance left', style: GoogleFonts.dmSans(
          fontSize: 11, fontWeight: FontWeight.w600,
          color: usable ? AppColors.accentLight : AppColors.textTertiary)),
      ),
    );
  }

  List<Widget> _buildMcqOptions(bool canInteract) {
    final options = (round['options'] as List<dynamic>? ?? []).cast<String>();
    final correctIndex = round['correctIndex'] as int?;
    final revealed = myAnswered; // once I've answered, show correctness on my own picks

    return options.asMap().entries.map((e) {
      final i = e.key;
      final isEliminated = eliminatedIndices.contains(i);
      final isCorrect = revealed && i == correctIndex;
      final isMyWrongPick = revealed && i == selectedIndex && i != correctIndex;
      Color bg = AppColors.surfaceVariant;
      Color border = AppColors.border;
      Color text = AppColors.textSecondary;
      if (isCorrect) { bg = AppColors.successSurface; border = AppColors.success; text = AppColors.success; }
      if (isMyWrongPick) { bg = AppColors.errorSurface; border = AppColors.error; text = AppColors.error; }

      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GestureDetector(
          onTap: (canInteract && !isEliminated) ? () => onSelectMcq(i) : null,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isEliminated ? AppColors.background : bg,
              border: Border.all(color: isEliminated ? AppColors.border : border),
              borderRadius: BorderRadius.circular(10)),
            child: Text(e.value, style: GoogleFonts.dmSans(
              fontSize: 13,
              color: isEliminated ? AppColors.textDisabled : text,
              decoration: isEliminated ? TextDecoration.lineThrough : null)),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildSpellingInput(bool canInteract) {
    if (myAnswered) {
      final myText = spellingCtrl.text.isNotEmpty ? spellingCtrl.text : '(submitted)';
      final correctText = round['correctText'] as String? ?? '';
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('You spelled: $myText', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Text('Correct: $correctText', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.success)),
      ]);
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (revealedPrefix != null) ...[
        Text('Hint: starts with "$revealedPrefix"', style: GoogleFonts.dmSans(
          fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.accentLight)),
        const SizedBox(height: 6),
      ],
      TextField(
        controller: spellingCtrl,
        enabled: canInteract,
        style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'Type your answer…',
          hintStyle: GoogleFonts.dmSans(color: AppColors.textTertiary),
          filled: true, fillColor: AppColors.surfaceVariant,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
    ]);
  }
}

class _ResultScreen extends StatelessWidget {
  final Map<String, dynamic> duel;
  final String? myUid;
  const _ResultScreen({required this.duel, required this.myUid});

  @override
  Widget build(BuildContext context) {
    final winnerUid = duel['winnerUid'] as String?;
    final isTie = winnerUid == null;
    final iWon = winnerUid != null && winnerUid == myUid;
    final myRole = myUid != null ? DuelService.roleFor(myUid!, duel) : DuelRole.host;
    final myWins = myRole == DuelRole.host ? duel['hostRoundWins'] : duel['opponentRoundWins'];
    final oppWins = myRole == DuelRole.host ? duel['opponentRoundWins'] : duel['hostRoundWins'];

    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(isTie ? '🤝' : (iWon ? '🏆' : '💪'), style: const TextStyle(fontSize: 48)),
        const SizedBox(height: 14),
        Text(isTie ? "It's a tie" : (iWon ? 'You won!' : 'You lost'), style: GoogleFonts.dmSans(
          fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        Text('$myWins - $oppWins rounds', style: GoogleFonts.dmSans(
          fontSize: 14, color: AppColors.textTertiary)),
        const SizedBox(height: 28),
        ElevatedButton(
          onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          child: Text('Done', style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }
}