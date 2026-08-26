// lib/features/social/presentation/pages/news_tab.dart
//
// Reuses the exact same filter condition the old feed's News tab used
// (verified == true, locked down by Firestore rules on both create
// and update -- nobody can self-mark a post as verified). Same
// "fetch broad, filter client-side" query pattern as everywhere else,
// avoiding a composite-index dependency.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_colors.dart';
import 'post_detail_page.dart';

class NewsTab extends StatelessWidget {
  const NewsTab({super.key});

  String _authorLabel(Map<String, dynamic> data) {
    final username = data['usernameDisplay'] as String?;
    if (username != null && username.trim().isNotEmpty) return '@$username';
    return data['displayName'] as String? ?? 'User';
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
     
      Expanded(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('posts')
          .orderBy('createdAt', descending: true).limit(50).snapshots(),
      builder: (context, snapshot) {
        final all = (snapshot.data?.docs ?? [])
            .map((d) => {'id': d.id, ...d.data()})
            .where((p) => p['verified'] == true)
            .toList();

        if (all.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('📰', style: const TextStyle(fontSize: 40)),
                const SizedBox(height: 12),
                Text('No news available yet', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              ]),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: all.length,
          itemBuilder: (context, i) {
            final post = all[i];
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => PostDetailPage(postId: post['id'] as String))),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Icon(Icons.verified_rounded, color: AppColors.accent, size: 15),
                    const SizedBox(width: 6),
                    Text(_authorLabel(post), style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  ]),
                  const SizedBox(height: 6),
                  Text(post['content'] as String? ?? '', maxLines: 3, overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                ]),
              ),
            );
          },
        );
      },
        ),
      ),
    ]);
  }
}