// lib/features/campaign/presentation/pages/campaign_competition_page.dart
//
// The dedicated competition screen, separate from regular Stories --
// only active contestants can post here, and the pool visibly shrinks
// as evictions happen. No vote counts are ever shown anywhere in this
// UI, on purpose -- votes are write-only from the client's perspective,
// enforced at the Firestore rule level, not just hidden here.
//
// Active/Evicted tabs share the same category filter and the same
// grid-rendering logic (_buildGrid), just pointed at different
// streams and with the vote button swapped for an "evicted" badge --
// evicted creators' entries stay visible for people to look back on,
// they don't just vanish from the screen once cut.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/campaign_service.dart';
import '../../../../core/widgets/voice_note_bubble.dart'; // voiceNoteColor -- reuse the per-user color law
import 'campaign_compose_page.dart';

class CampaignCompetitionPage extends StatefulWidget {
  final String campaignId;
  final String campaignName;
  final int currentRound;
  const CampaignCompetitionPage({
    super.key,
    required this.campaignId,
    required this.campaignName,
    required this.currentRound,
  });

  @override
  State<CampaignCompetitionPage> createState() => _CampaignCompetitionPageState();
}

class _CampaignCompetitionPageState extends State<CampaignCompetitionPage> with SingleTickerProviderStateMixin {
  static const _categories = [
    (null, 'All'),
    ('poetry', 'Poetry'),
    ('comedy', 'Comedy'),
    ('storytelling', 'Storytelling'),
    ('photography', 'Photography'),
    ('study', 'Study'),
  ];

  // Below this, vote counts stay fully hidden -- the anti-bandwagon
  // protection discussed earlier. Crossing it is meant to feel like a
  // genuine milestone (matching the same 500 threshold already used
  // for post-like milestone notifications elsewhere in the app), not
  // just a number quietly turning visible.
  static const _voteRevealThreshold = 500;

  late final TabController _tabController = TabController(length: 2, vsync: this);
  String? _selectedCategory;
  final Set<String> _votedThisSession = {}; // optimistic local state, confirmed against real checks below

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _vote(String votedForUid, String label) async {
    final result = await CampaignService.castVote(
      campaignId: widget.campaignId,
      round: widget.currentRound,
      votedForUid: votedForUid,
    );
    if (!mounted) return;
    final message = switch (result) {
      VoteResult.success => 'Voted for $label',
      VoteResult.alreadyVoted => 'You\'ve already voted this round',
      VoteResult.accountTooNew => 'Your account was created after this campaign started, so it isn\'t eligible to vote',
      VoteResult.notActive => 'This creator isn\'t active this round',
      VoteResult.notSignedIn => 'Sign in to vote',
      VoteResult.contestantNotFound => 'Could not find that creator',
    };
    if (result == VoteResult.success) {
      HapticFeedback.lightImpact();
      setState(() => _votedThisSession.add(votedForUid));
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildGrid(Stream<List<Map<String, dynamic>>> stream, {required bool isActiveTab, required bool isVotingEnabled}) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snap) {
        final all = snap.data ?? [];
        final contestants = _selectedCategory == null
            ? all
            : all.where((c) => c['category'] == _selectedCategory).toList();

        if (contestants.isEmpty) {
          return Center(child: Text(
            isActiveTab ? 'No active creators in this category' : 'No one\'s been evicted yet',
            style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)));
        }

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.82),
          itemCount: contestants.length,
          itemBuilder: (context, i) {
            final c = contestants[i];
            final uid = c['uid'] as String;
            final label = (c['usernameDisplay'] as String?)?.isNotEmpty == true
                ? '@${c['usernameDisplay']}' : (c['displayName'] as String? ?? 'User');
            final color = voiceNoteColor(uid);
            final votedAlready = _votedThisSession.contains(uid);
            final voteCount = c['totalVotes'] as int? ?? 0;

            return Container(
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border)),
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    color: isActiveTab ? color.withOpacity(0.15) : AppColors.surfaceVariant,
                    shape: BoxShape.circle),
                  child: Center(child: Text(label.replaceAll('@', '').isNotEmpty ? label.replaceAll('@', '')[0].toUpperCase() : 'U',
                    style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700,
                      color: isActiveTab ? color : AppColors.textTertiary))),
                ),
                const SizedBox(height: 8),
                Text(label, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500,
                  color: isActiveTab ? AppColors.textPrimary : AppColors.textTertiary),
                  overflow: TextOverflow.ellipsis, maxLines: 1),
                if (isActiveTab && voteCount >= _voteRevealThreshold) ...[
                  const SizedBox(height: 2),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.local_fire_department_rounded, size: 13, color: AppColors.accent),
                    const SizedBox(width: 3),
                    Text('$voteCount votes', style: GoogleFonts.dmSans(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.accent)),
                  ]),
                ],
                const Spacer(),
                if (isActiveTab && isVotingEnabled)
                  SizedBox(width: double.infinity, child: OutlinedButton(
                    onPressed: votedAlready ? null : () => _vote(uid, label),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: votedAlready ? AppColors.surfaceVariant : AppColors.accent,
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(votedAlready ? 'Voted' : 'Vote', style: GoogleFonts.dmSans(
                      fontSize: 12.5, fontWeight: FontWeight.w600,
                      color: votedAlready ? AppColors.textTertiary : Colors.white)),
                  ))
                else if (isActiveTab)
                  SizedBox(width: double.infinity, child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(8)),
                    child: Center(child: Text('Voting not open yet', style: GoogleFonts.dmSans(
                      fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textTertiary))),
                  ))
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(color: AppColors.errorSurface, borderRadius: BorderRadius.circular(8)),
                    child: Center(child: Text('Evicted', style: GoogleFonts.dmSans(
                      fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.error))),
                  ),
              ]),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        title: Text(widget.campaignName, style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.accent,
          unselectedLabelColor: AppColors.textTertiary,
          indicatorColor: AppColors.accent,
          labelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500),
          tabs: const [Tab(text: 'Active'), Tab(text: 'Evicted')],
        ),
      ),
      body: StreamBuilder<Map<String, dynamic>?>(
        stream: CampaignService.campaignStream(widget.campaignId),
        builder: (context, campaignSnap) {
          final isVotingEnabled = campaignSnap.data?['status'] == 'active';
          return Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border)),
          child: Row(children: [
            Icon(Icons.emoji_events_outlined, color: AppColors.accent, size: 18),
            const SizedBox(width: 8),
            Text('Round ${widget.currentRound}', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            if (!isVotingEnabled) ...[
              const Spacer(),
              Text('Voting not open yet', style: GoogleFonts.dmSans(fontSize: 11.5, color: AppColors.textTertiary)),
            ],
          ]),
        ),

        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: _categories.map((c) {
              final (id, label) = c;
              final selected = _selectedCategory == id;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedCategory = id),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.accent : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(label, style: GoogleFonts.dmSans(fontSize: 12.5, fontWeight: FontWeight.w500,
                      color: selected ? Colors.white : AppColors.textSecondary)),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildGrid(CampaignService.activeContestants(widget.campaignId), isActiveTab: true, isVotingEnabled: isVotingEnabled),
              _buildGrid(CampaignService.evictedContestants(widget.campaignId), isActiveTab: false, isVotingEnabled: isVotingEnabled),
            ],
          ),
        ),
          ]);
        },
      ),
      floatingActionButton: FutureBuilder<bool>(
        future: CampaignService.isActiveContestant(widget.campaignId),
        builder: (context, snap) {
          if (snap.data != true) return const SizedBox.shrink();
          return FloatingActionButton.extended(
            backgroundColor: AppColors.accent,
            icon: const Icon(Icons.add_rounded, color: Colors.white),
            label: Text('Post', style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w600)),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => CampaignComposePage(campaignId: widget.campaignId))),
          );
        },
      ),
    );
  }
}