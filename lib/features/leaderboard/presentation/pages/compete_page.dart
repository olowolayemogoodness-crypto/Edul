// lib/features/leaderboard/presentation/pages/compete_page.dart
//
// Replaces the old CompeteComingSoonPage. Lists duels the current user
// is part of, split into three buckets:
//   - Your turn: someone challenged you, you haven't played yet
//   - Waiting: you challenged someone, they haven't played yet
//   - Completed: results are in

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/user_service.dart';
import '../../../duel/presentation/pages/duel_setup_page.dart';
import '../../../duel/presentation/pages/duel_play_page.dart';

class CompetePage extends StatelessWidget {
  const CompetePage({super.key});

  @override
  Widget build(BuildContext context) {
    final myUid = UserService.uid;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Compete', style: GoogleFonts.dmSans(
          fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DuelSetupPage())),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accent, borderRadius: BorderRadius.circular(20)),
                child: Text('⚔️ New Duel', style: GoogleFonts.dmSans(
                  fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
      // NOTE: DuelService.myDuels() no longer exists -- it was specific
      // to the old async duel model. The new live duel system has no
      // persisted "duel history" list to show here (you're either in an
      // active duel or you're not). Stubbed to an empty stream so this
      // dormant file compiles honestly rather than faking data.
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Stream.value(const <Map<String, dynamic>>[]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: AppColors.accent));
          }
          final duels = snapshot.data!;
          final yourTurn = duels.where((d) =>
              d['status'] == 'pending' && d['opponentUid'] == myUid).toList();
          final waiting = duels.where((d) =>
              d['status'] == 'pending' && d['challengerUid'] == myUid).toList();
          final completed = duels.where((d) => d['status'] == 'completed').toList();

          if (duels.isEmpty) {
            return Center(child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('⚔️', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 16),
                Text('No duels yet', style: GoogleFonts.dmSans(
                  fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 6),
                Text('Challenge a friend to a quiz duel and see who knows the course better.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
              ]),
            ));
          }

          return ListView(padding: const EdgeInsets.all(16), children: [
            if (yourTurn.isNotEmpty) ...[
              _sectionLabel('YOUR TURN'),
              ...yourTurn.map((d) => _DuelCard(duel: d, myUid: myUid)),
              const SizedBox(height: 16),
            ],
            if (waiting.isNotEmpty) ...[
              _sectionLabel('WAITING'),
              ...waiting.map((d) => _DuelCard(duel: d, myUid: myUid)),
              const SizedBox(height: 16),
            ],
            if (completed.isNotEmpty) ...[
              _sectionLabel('COMPLETED'),
              ...completed.map((d) => _DuelCard(duel: d, myUid: myUid)),
            ],
          ]);
        },
      ),
    );
  }

  Widget _sectionLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 4),
    child: Text(label, style: GoogleFonts.dmSans(
      fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textTertiary,
      letterSpacing: 0.6)),
  );
}

class _DuelCard extends StatelessWidget {
  final Map<String, dynamic> duel;
  final String? myUid;
  const _DuelCard({required this.duel, required this.myUid});

  bool get _isChallenger => duel['challengerUid'] == myUid;
  bool get _isMyTurn => duel['status'] == 'pending' && duel['opponentUid'] == myUid;

  @override
  Widget build(BuildContext context) {
    final courseKey = duel['courseKey'] as String? ?? '';
    final opponentName = _isChallenger
        ? duel['opponentName'] as String? ?? 'Opponent'
        : duel['challengerName'] as String? ?? 'Challenger';
    final status = duel['status'] as String? ?? 'pending';

    String subtitle;
    Color subtitleColor = AppColors.textTertiary;
    if (status == 'pending') {
      subtitle = _isMyTurn ? 'Tap to play' : 'Waiting for $opponentName…';
    } else {
      final myCorrect = (_isChallenger
          ? duel['challengerCorrect'] : duel['opponentCorrect']) as int? ?? 0;
      final theirCorrect = (_isChallenger
          ? duel['opponentCorrect'] : duel['challengerCorrect']) as int? ?? 0;
      final won = myCorrect > theirCorrect;
      final tied = myCorrect == theirCorrect;
      subtitle = tied ? 'Tied $myCorrect–$theirCorrect'
          : won ? 'You won $myCorrect–$theirCorrect 🏆' : 'You lost $myCorrect–$theirCorrect';
      subtitleColor = tied ? AppColors.warning : won ? AppColors.success : AppColors.error;
    }

    return GestureDetector(
      onTap: _isMyTurn ? () => _playResponse(context) : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: AppColors.accentSurface, shape: BoxShape.circle),
            child: const Center(child: Text('⚔️', style: TextStyle(fontSize: 18)))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('$courseKey vs $opponentName', style: GoogleFonts.dmSans(
              fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 2),
            Text(subtitle, style: GoogleFonts.dmSans(fontSize: 12, color: subtitleColor)),
          ])),
          if (_isMyTurn) Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
        ]),
      ),
    );
  }

  // NOTE: this whole method is stale -- built against the OLD async duel
  // model (a 'questions' array stored on the duel doc). That model was
  // replaced by duel_service.dart's live/synchronous version, which has
  // no such field. Since this whole compete_page.dart file is dormant
  // and unreachable (deliberately left unwired), this is patched just
  // enough to compile, not to actually work -- needs a real rewrite
  // against the new DuelService if/when Compete gets revived.
  void _playResponse(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => DuelPlayPage(duelId: duel['id'] as String),
    ));
  }
}