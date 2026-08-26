// lib/features/social/presentation/widgets/campaign_banner.dart
//
// The actual entry point into the whole campaign feature -- without
// this, the application page, competition page, and composer all
// exist but nothing in the app links to any of them. Shows nothing
// at all if there's no live campaign, rather than an empty placeholder
// implying a feature that isn't currently running.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/campaign_service.dart';
import '../../../campaign/presentation/pages/campaign_application_page.dart';
import '../../../campaign/presentation/pages/campaign_competition_page.dart';

class CampaignBanner extends StatelessWidget {
  const CampaignBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>?>(
      stream: CampaignService.activeCampaign(),
      builder: (context, snap) {
        final campaign = snap.data;
        if (campaign == null) return const SizedBox.shrink();

        final campaignId = campaign['id'] as String;
        final name = campaign['name'] as String? ?? 'Creator Challenge';
        final status = campaign['status'] as String? ?? 'active';
        final round = campaign['currentRound'] as int? ?? 1;
        final isApplicationsOpen = status == 'applications_open';

        String subtitle;
        if (isApplicationsOpen) {
          subtitle = 'Applications are open — tap to apply';
        } else if (status == 'submission_only') {
          subtitle = 'Submissions are open — post your entry';
        } else {
          subtitle = 'Round $round is live — vote now';
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: GestureDetector(
            onTap: () async {
              if (isApplicationsOpen) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => CampaignApplicationPage(campaignId: campaignId, campaignName: name)));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => CampaignCompetitionPage(campaignId: campaignId, campaignName: name, currentRound: round)));
              }
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.accent, AppColors.accent.withValues(alpha: 0.75)]),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(children: [
                Icon(Icons.emoji_events_rounded, color: Colors.white, size: 26),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(name, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white.withValues(alpha: 0.9))),
                ])),
                Icon(Icons.chevron_right_rounded, color: Colors.white, size: 22),
              ]),
            ),
          ),
        );
      },
    );
  }
}