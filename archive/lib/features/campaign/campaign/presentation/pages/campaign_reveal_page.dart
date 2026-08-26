// lib/features/campaign/presentation/pages/campaign_reveal_page.dart
//
// The real, working version of the HTML animation prototype -- same
// sequence (suspense spinner, then evicted names fade in, then
// survivors), now wired to actual eviction data for a specific round
// instead of hardcoded example names. Shared experience for everyone
// who opens it that day, not a separate contestant-only version.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/campaign_service.dart';

enum _RevealStage { preReveal, suspense, results }

class CampaignRevealPage extends StatefulWidget {
  final String campaignId;
  final int round;
  const CampaignRevealPage({super.key, required this.campaignId, required this.round});

  @override
  State<CampaignRevealPage> createState() => _CampaignRevealPageState();
}

class _CampaignRevealPageState extends State<CampaignRevealPage> {
  _RevealStage _stage = _RevealStage.preReveal;
  List<Map<String, dynamic>> _evicted = [];
  int _survivorCount = 0;
  bool _evictedVisible = false;
  bool _survivorsVisible = false;

  Future<void> _reveal() async {
    setState(() => _stage = _RevealStage.suspense);

    // Fetch while the suspense beat plays, not after -- the animation
    // shouldn't feel like it's waiting on a slow network call.
    final results = await Future.wait([
      CampaignService.evictedThisRound(widget.campaignId, widget.round),
      CampaignService.activeContestantCount(widget.campaignId),
    ]);
    final evicted = results[0] as List<Map<String, dynamic>>;
    final activeCount = results[1] as int;

    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() {
      _evicted = evicted;
      _survivorCount = activeCount;
      _stage = _RevealStage.results;
    });

    await Future.delayed(const Duration(milliseconds: 50));
    if (!mounted) return;
    setState(() => _evictedVisible = true);

    await Future.delayed(const Duration(milliseconds: 450));
    if (!mounted) return;
    setState(() => _survivorsVisible = true);
  }

  void _watchAgain() {
    setState(() {
      _stage = _RevealStage.preReveal;
      _evictedVisible = false;
      _survivorsVisible = false;
    });
  }

  String _label(Map<String, dynamic> c) {
    final username = c['usernameDisplay'] as String?;
    if (username != null && username.trim().isNotEmpty) return '@$username';
    return c['displayName'] as String? ?? 'User';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        title: Text('Round ${widget.round} results', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(child: _buildStage()),
      ),
    );
  }

  Widget _buildStage() {
    switch (_stage) {
      case _RevealStage.preReveal:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.emoji_events_rounded, color: AppColors.accent, size: 32),
            const SizedBox(height: 12),
            Text('Round ${widget.round} results are in', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _reveal,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: Text('Reveal results', style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ]),
        );

      case _RevealStage.suspense:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(width: 36, height: 36, child: CircularProgressIndicator(strokeWidth: 3, color: AppColors.error)),
            const SizedBox(height: 14),
            Text('Counting the votes…', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
          ]),
        );

      case _RevealStage.results:
        return Column(mainAxisSize: MainAxisSize.min, children: [
          AnimatedOpacity(
            opacity: _evictedVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(color: AppColors.errorSurface, borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                Icon(Icons.person_off_rounded, color: AppColors.error, size: 24),
                const SizedBox(height: 8),
                Text('Evicted this round', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.error)),
                const SizedBox(height: 4),
                Text(
                  _evicted.isEmpty ? 'Nobody — everyone survives this round' : _evicted.map(_label).join(' · '),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.error),
                ),
              ]),
            ),
          ),
          AnimatedOpacity(
            opacity: _survivorsVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(color: AppColors.successSurface, borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                Text('$_survivorCount creators move on', style: GoogleFonts.dmSans(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.success)),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: _watchAgain,
                  child: Text('Watch again', style: GoogleFonts.dmSans(fontSize: 12.5, color: AppColors.textSecondary)),
                ),
              ]),
            ),
          ),
        ]);
    }
  }
}