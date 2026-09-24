// lib/features/masterclass/presentation/pages/masterclass_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/premium_service.dart';
import 'masterclass_player_page.dart';

class MasterclassPage extends StatelessWidget {
  const MasterclassPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isPremium = !PremiumService.isRealFree;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary)),
              const SizedBox(width: 14),
              Text('Masterclass', style: GoogleFonts.dmSans(
                fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              isPremium
                  ? 'Full crash course lectures — unlimited access'
                  : 'Full crash course lectures — free preview is 3 minutes per video',
              style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('masterclass')
                  .orderBy('uploadedAt', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: AppColors.accent));
                }
                if (snapshot.hasError) {
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text('Could not load videos:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.error))));
                }
                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text('🎬', style: TextStyle(fontSize: 40)),
                    const SizedBox(height: 12),
                    Text('No crash courses yet', style: GoogleFonts.dmSans(
                      fontSize: 14, color: AppColors.textSecondary)),
                  ]));
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    final data = docs[i].data() as Map<String, dynamic>;
                    final title = data['title'] as String? ?? 'Untitled';
                    final subject = data['subject'] as String? ?? '';
                    final thumbnailUrl = data['thumbnailUrl'] as String?;
                    final durationSecs = data['durationSecs'] as int? ?? 0;
                    final mins = durationSecs ~/ 60;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => MasterclassPlayerPage(
                            videoId: docs[i].id,
                            title: title,
                            videoUrl: data['videoUrl'] as String? ?? '',
                          ),
                        )),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(16)),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Stack(fit: StackFit.expand, children: [
                                  thumbnailUrl != null
                                      ? Image.network(thumbnailUrl, fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Container(color: AppColors.surfaceVariant))
                                      : Container(color: AppColors.surfaceVariant),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                                        colors: [Colors.transparent, Colors.black.withValues(alpha: 0.5)])),
                                  ),
                                  const Center(child: Icon(Icons.play_circle_fill_rounded,
                                    color: Colors.white, size: 48)),
                                  if (!isPremium)
                                    Positioned(top: 10, right: 10, child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.6),
                                        borderRadius: BorderRadius.circular(20)),
                                      child: Text('3 min preview', style: GoogleFonts.dmSans(
                                        fontSize: 10, color: Colors.white)))),
                                  if (durationSecs > 0)
                                    Positioned(bottom: 8, right: 10, child: Text('${mins}m',
                                      style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white,
                                        fontWeight: FontWeight.w600))),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(title, style: GoogleFonts.dmSans(fontSize: 14,
                                  fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                if (subject.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(subject, style: GoogleFonts.dmSans(fontSize: 12,
                                    color: AppColors.textTertiary)),
                                ],
                              ]),
                            ),
                          ]),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}