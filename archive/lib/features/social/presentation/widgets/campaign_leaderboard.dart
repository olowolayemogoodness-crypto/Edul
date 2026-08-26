// lib/features/social/presentation/widgets/campaign_leaderboard.dart
//
// The ranking itself is genuinely live -- who's currently in the top
// 50 updates in real time as votes come in. The actual vote NUMBERS
// next to each name stay hidden until the admin flips a campaign-level
// reveal flag, typically the moment a voting window closes -- same
// "hidden until a deliberate moment" principle as the eviction reveal
// screen, just applied to a ranked list instead of an eviction result.
//
// Evicted contestants are never queried here at all -- not hidden,
// genuinely excluded -- matching the explicit decision not to
// disclose their numbers even after they're out of the competition.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/campaign_service.dart';
import '../../../../core/widgets/voice_note_bubble.dart'; // voiceNoteColor -- same per-user color law
import '../pages/story_viewer_page.dart';

class CampaignLeaderboard extends StatelessWidget {
  const CampaignLeaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>?>(
      stream: CampaignService.activeCampaign(),
      builder: (context, campaignSnap) {
        final campaign = campaignSnap.data;
        if (campaign == null) return const SizedBox.shrink();
        final campaignId = campaign['id'] as String;
        final revealed = campaign['leaderboardRevealed'] == true;

        return StreamBuilder<List<Map<String, dynamic>>>(
          stream: CampaignService.topLeaderboard(campaignId),
          builder: (context, leaderboardSnap) {
            final contestants = leaderboardSnap.data ?? [];
            if (contestants.isEmpty) return const SizedBox.shrink();

            // Once narrowed to the final 10, scores stay hidden
            // permanently -- the reveal flag no longer applies here,
            // by explicit decision, to preserve suspense into the
            // finale.
            final isFinalTen = contestants.length <= 10;
            final showScores = revealed && !isFinalTen;

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Container(
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border)),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                    child: Row(children: [
                      Icon(Icons.leaderboard_rounded, color: AppColors.accent, size: 18),
                      const SizedBox(width: 8),
                      Text(isFinalTen ? 'Final 10' : 'Top 50', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      const Spacer(),
                      if (!showScores)
                        Text(isFinalTen ? 'Scores stay hidden' : 'Votes hidden until reveal', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
                    ]),
                  ),
                  ...contestants.asMap().entries.map((entry) {
                    final rank = entry.key + 1;
                    final c = entry.value;
                    final uid = c['uid'] as String;
                    final label = (c['usernameDisplay'] as String?)?.isNotEmpty == true
                        ? '@${c['usernameDisplay']}' : (c['displayName'] as String? ?? 'User');
                    final votes = c['totalVotes'] as int? ?? 0;
                    final color = voiceNoteColor(uid);

                    return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => StoryViewerPage(uid: uid))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Row(children: [
                          SizedBox(width: 24, child: Text('$rank', style: GoogleFonts.dmSans(
                            fontSize: 13, fontWeight: FontWeight.w600,
                            color: rank <= 3 ? AppColors.accent : AppColors.textTertiary))),
                          Container(width: 30, height: 30,
                            decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
                            child: Center(child: Text(label.replaceAll('@', '').isNotEmpty ? label.replaceAll('@', '')[0].toUpperCase() : 'U',
                              style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: color)))),
                          const SizedBox(width: 10),
                          Expanded(child: Text(label, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
                            overflow: TextOverflow.ellipsis)),
                          if (showScores)
                            Text('$votes votes', style: GoogleFonts.dmSans(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textSecondary))
                          else
                            Icon(Icons.lock_outline_rounded, size: 14, color: AppColors.textTertiary),
                        ]),
                      ),
                    );
                  }),
                ]),
              ),
            );
          },
        );
      },
    );
  }
}