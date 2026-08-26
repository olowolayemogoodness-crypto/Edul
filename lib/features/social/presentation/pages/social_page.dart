// lib/features/social/presentation/pages/social_page.dart
//
// The new Social screen: no more separate News/Groups tabs. A single,
// unified scrolling feed IS the default view -- announcements surface
// naturally as you scroll, no capsule needed to "raise them up"
// separately. A horizontal groups row sits above it; tapping a group
// opens its own dedicated screen, which is itself a real, personalized
// feed for that group specifically, not just a flat announcement list.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/widgets/voice_note_bubble.dart'; // voiceNoteColor -- same per-user color law
import 'group_detail_page.dart';
import 'group_search_page.dart';
import 'post_detail_page.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  String _authorLabel(Map<String, dynamic> data) {
    final username = data['usernameDisplay'] as String?;
    if (username != null && username.trim().isNotEmpty) return '@$username';
    return data['displayName'] as String? ?? 'User';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Image.asset('assets/images/edulink_logo.png', width: 22, height: 22),
          const SizedBox(width: 8),
          Text('Social', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        ]),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded, color: AppColors.textSecondary),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GroupSearchPage())),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(children: [
        const _GroupsRow(),
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
                return Center(child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.campaign_outlined, color: AppColors.textTertiary, size: 40),
                    const SizedBox(height: 12),
                    Text('No announcements yet', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text('Official updates and group broadcasts will show up here.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                  ]),
                ));
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: all.length,
                itemBuilder: (context, i) {
                  final p = all[i];
                  return ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => PostDetailPage(postId: p['id'] as String))),
                    title: Text(_authorLabel(p), style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    subtitle: Text(p['content'] as String? ?? '', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary),
                      maxLines: 3, overflow: TextOverflow.ellipsis),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}

class _GroupsRow extends StatelessWidget {
  const _GroupsRow();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: GroupService.myGroups(),
      builder: (context, snapshot) {
        final groups = snapshot.data ?? [];
        if (groups.isEmpty) return const SizedBox.shrink();

        return Container(
          height: 92,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: groups.length,
            itemBuilder: (context, i) {
              final g = groups[i];
              final groupId = g['id'] as String;
              final name = g['name'] as String? ?? 'Group';
              final iconUrl = g['iconUrl'] as String?;
              final isAdmin = g['role'] == 'admin';
              final color = voiceNoteColor(groupId); // same per-entity color law used for stories/voice notes

              return Padding(
                padding: const EdgeInsets.only(right: 14),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => GroupDetailPage(groupId: groupId, groupName: name, isAdmin: isAdmin))),
                  child: Column(children: [
                    Container(
                      width: 52, height: 52,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14), // rounded-square, not circular -- matches how group icons are shown elsewhere
                      ),
                      child: (iconUrl != null && iconUrl.isNotEmpty)
                          ? ClipRRect(borderRadius: BorderRadius.circular(14),
                              child: Image.network(iconUrl, width: 52, height: 52, fit: BoxFit.cover))
                          : Center(child: Text(name.isNotEmpty ? name[0].toUpperCase() : 'G',
                              style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w700, color: color))),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(width: 56, child: Text(name, textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(fontSize: 10.5, color: AppColors.textSecondary),
                      overflow: TextOverflow.ellipsis, maxLines: 1)),
                  ]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}