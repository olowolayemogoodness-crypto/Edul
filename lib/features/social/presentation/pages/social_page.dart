// lib/features/social/presentation/pages/social_page.dart
//
// The bottom-nav Social destination. Three tabs (Groups/Stories/News),
// with the story row sitting ABOVE the tab bar rather than duplicated
// per-tab -- a judgment call, not explicitly specified: matches how
// Instagram keeps its story row visible regardless of which feed tab
// is active, and avoids building the same row three times.
//
// The "Add Story" FAB only shows on the Stories tab -- tracked via a
// TabController listener, since the Scaffold (and its FAB) is shared
// across all three tabs.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/story_service.dart';
import '../../../../core/widgets/voice_note_bubble.dart';
import 'groups_page.dart';
import 'stories_tab.dart';
import 'news_tab.dart';
import 'group_search_page.dart';
import 'story_viewer_page.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this)
    ..addListener(() {
      // Only rebuild on a genuine settled tab change, not every frame
      // of the swipe animation between tabs.
      if (!_tabController.indexIsChanging) setState(() {});
    });

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.accent,
          unselectedLabelColor: AppColors.textTertiary,
          indicatorColor: AppColors.accent,
          labelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500),
          tabs: const [Tab(text: 'Groups'), Tab(text: 'Stories'), Tab(text: 'News')],
        ),
      ),
      body: Column(children: [
        const _StoryRow(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [GroupsPage(), StoriesTab(), NewsTab()],
          ),
        ),
      ]),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton(
              backgroundColor: AppColors.accent,
              onPressed: () => showAddStorySheet(context),
              child: const Icon(Icons.add_rounded, color: Colors.white),
            )
          : null,
    );
  }
}

class _StoryRow extends StatelessWidget {
  const _StoryRow();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: StoryService.activeStoriesByUser(),
      builder: (context, snapshot) {
        final stories = snapshot.data ?? [];
        if (stories.isEmpty) return const SizedBox.shrink();

        return Container(
          height: 104,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: stories.length,
            itemBuilder: (context, i) {
              final s = stories[i];
              final watched = s['watched'] as bool? ?? false;
              final isMe = s['isMe'] as bool? ?? false;
              final uid = s['uid'] as String;
              final name = isMe
                  ? 'Your story'
                  : ((s['usernameDisplay'] as String?)?.isNotEmpty == true
                      ? '@${s['usernameDisplay']}' : (s['displayName'] as String? ?? 'User'));
              final photoUrl = s['photoUrl'] as String?;
              final ringColor = voiceNoteColor(uid); // same per-user color law as voice notes -- not one fixed gradient for everyone
              return Padding(
                padding: const EdgeInsets.only(right: 14),
                child: GestureDetector(
                  // Tapping the avatar itself always opens the viewer
                  // (yours included, to watch what you posted) -- the
                  // small + badge below is the separate, dedicated way
                  // to add new content.
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => StoryViewerPage(uid: uid))),
                  child: Column(children: [
                    Stack(children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: watched ? null : LinearGradient(colors: [ringColor, ringColor.withOpacity(0.6)]),
                          border: watched ? Border.all(color: AppColors.border, width: 2) : null,
                        ),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: AppColors.accentSurface,
                          backgroundImage: (photoUrl != null && photoUrl.isNotEmpty) ? NetworkImage(photoUrl) : null,
                          child: (photoUrl == null || photoUrl.isEmpty)
                              ? Text(name.replaceAll('@', '').isNotEmpty ? name.replaceAll('@', '')[0].toUpperCase() : 'U',
                                  style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.accent))
                              : null,
                        ),
                      ),
                      if (isMe)
                        Positioned(bottom: 0, right: 0, child: GestureDetector(
                          onTap: () => showAddStorySheet(context),
                          child: Container(
                            width: 18, height: 18,
                            decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle, border: Border.all(color: AppColors.background, width: 2)),
                            child: const Icon(Icons.add_rounded, color: Colors.white, size: 11)))),
                    ]),
                    const SizedBox(height: 4),
                    SizedBox(width: 56, child: Text(name, textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(fontSize: 10.5, color: watched ? AppColors.textTertiary : AppColors.textSecondary),
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