// lib/features/social/presentation/pages/social_feed_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialFeedPage extends StatefulWidget {
  const SocialFeedPage({super.key});

  @override
  State<SocialFeedPage> createState() => _SocialFeedPageState();
}

class _SocialFeedPageState extends State<SocialFeedPage> {
  int _selectedTab = 0; // 0=Global, 1=My Uni, 2=News
  String _university = 'My Uni';

  @override
  void initState() {
    super.initState();
    _loadUniversity();
  }

  Future<void> _loadUniversity() async {
    final prefs = await SharedPreferences.getInstance();
    final uni = prefs.getString('user_university') ?? '';
    if (mounted && uni.isNotEmpty) {
      setState(() => _university = uni.length > 10
          ? uni.substring(0, 10).trim()
          : uni);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: AppColors.textTertiary),
                ),
                const SizedBox(width: 12),
                Text('Social', style: GoogleFonts.dmSans(
                  fontSize: 22, fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.edit_rounded,
                      size: 18, color: Colors.white),
                  ),
                ),
              ]),
            ),

            const SizedBox(height: 14),

            // Channel filter pills — same style as Insights
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _Pill(label: 'Global', selected: _selectedTab == 0,
                    onTap: () => setState(() => _selectedTab = 0)),
                  const SizedBox(width: 8),
                  _Pill(label: _university, selected: _selectedTab == 1,
                    onTap: () => setState(() => _selectedTab = 1)),
                  const SizedBox(width: 8),
                  _Pill(label: 'News', selected: _selectedTab == 2,
                    onTap: () => setState(() => _selectedTab = 2)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Feed
            Expanded(
              child: Builder(builder: (_) {
                final posts = _selectedTab == 0
                    ? _globalPosts
                    : _selectedTab == 1
                        ? _uniPosts
                        : _newsPosts;
                if (posts.isEmpty) {
                  return Center(
                    child: Text('No posts yet',
                      style: GoogleFonts.dmSans(
                        fontSize: 15, color: AppColors.textTertiary)),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: posts.length,
                  separatorBuilder: (_, __) => const Divider(
                    color: Color(0xFF1E1E24), height: 1, thickness: 1),
                  itemBuilder: (_, i) => _PostCard(
                    post: posts[i],
                    isNews: _selectedTab == 2,
                  ),
                );
              }),
            ),
          ]),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pill tab (same style as Insights channel bar)
// ─────────────────────────────────────────────────────────────────────────────
class _Pill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Pill({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : Colors.white12,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.accent : Colors.white24),
        ),
        child: Text(label, style: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          color: Colors.white)),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dummy data
// ─────────────────────────────────────────────────────────────────────────────
final _globalPosts = [
  _PostData(
    username: 'Sore Goodness',
    handle: '@soregoodness',
    time: '1m',
    content: 'Found this in my camera roll during a study break 😭 what is this creature actually',
    imagePath: 'https://images.unsplash.com/photo-1608848461950-0fe51dfc41cb?w=600&q=80',
    likes: 12,
    comments: 3,
    reposts: 1,
    views: 89,
    verified: false,
    initials: 'SG',
    avatarColor: const Color(0xFF7C3AED),
  ),
  _PostData(
    username: 'Tinu Towoju',
    handle: '@tinu_towoju',
    time: '5h',
    content: 'Small progress is still progress.\n\nKeep showing up for yourself. 🔥',
    imagePath: null,
    likes: 892,
    comments: 47,
    reposts: 201,
    views: 12400,
    verified: false,
    initials: 'TT',
    avatarColor: const Color(0xFF0891B2),
  ),
  _PostData(
    username: 'Messi Fanatic',
    handle: '@MessiFanatic_',
    time: '20h',
    content: 'PHY 102 assignment submitted at 11:59 PM. I deserve an award for this one 😭',
    imagePath: null,
    likes: 1200,
    comments: 89,
    reposts: 312,
    views: 28000,
    verified: true,
    initials: 'MF',
    avatarColor: const Color(0xFF0D9488),
  ),
  _PostData(
    username: 'Ada Okonkwo',
    handle: '@ada_okonkwo',
    time: '1d',
    content: 'Anyone else noticed how BIO 102 exam questions always have a trick option that\'s almost correct? Train yourself to slow down on those. 🧬',
    imagePath: null,
    likes: 567,
    comments: 34,
    reposts: 88,
    views: 9200,
    verified: false,
    initials: 'AO',
    avatarColor: const Color(0xFF9333EA),
  ),
  _PostData(
    username: 'Kola Babs',
    handle: '@kolababs__',
    time: '2d',
    content: 'Used Edul\'s AI Tutor to understand the Kirchhoff\'s Laws topic I\'ve been avoiding since January. Took 20 minutes. My lecturer took 3 weeks. 💀',
    imagePath: null,
    likes: 3400,
    comments: 201,
    reposts: 567,
    views: 61000,
    verified: false,
    initials: 'KB',
    avatarColor: const Color(0xFFD97706),
  ),
];

final _uniPosts = [
  _PostData(
    username: 'UI Physics Dept',
    handle: '@UIPhysicsDept',
    time: '1h',
    content: 'Reminder: PHY 102 continuous assessment results are now available on the student portal. Check before Friday. ✅',
    imagePath: null,
    likes: 134,
    comments: 22,
    reposts: 67,
    views: 3200,
    verified: true,
    initials: 'UI',
    avatarColor: const Color(0xFF1D4ED8),
  ),
  _PostData(
    username: 'Biodun Adeola',
    handle: '@biodunadeola',
    time: '3h',
    content: 'Anyone in 200L Agric want to form a study group for GNS 102? We meet Saturday mornings at the library. Drop a comment 👇',
    imagePath: null,
    likes: 45,
    comments: 12,
    reposts: 8,
    views: 890,
    verified: false,
    initials: 'BA',
    avatarColor: const Color(0xFF16A34A),
  ),
  _PostData(
    username: 'Funmi Adeyemi',
    handle: '@funmiadeyemi',
    time: '6h',
    content: 'The new reading room in Trenchard Hall is actually amazing. AC is working, outlets available. 10/10 would recommend for exam prep.',
    imagePath: null,
    likes: 312,
    comments: 28,
    reposts: 54,
    views: 5600,
    verified: false,
    initials: 'FA',
    avatarColor: const Color(0xFFBE185D),
  ),
];

final _newsPosts = [
  _PostData(
    username: 'UI Student Union',
    handle: '@UIStudentUnion',
    time: '30m',
    content: '📢 IMPORTANT ANNOUNCEMENT\n\nThe SUG elections hold next Thursday, July 24th. Polls open 8AM–6PM. All registered students must present their ID cards. Make your voice count.',
    imagePath: null,
    likes: 892,
    comments: 134,
    reposts: 445,
    views: 34000,
    verified: true,
    initials: 'SU',
    avatarColor: const Color(0xFF1D4ED8),
  ),
  _PostData(
    username: 'Faculty of Science',
    handle: '@UIFacSci',
    time: '2h',
    content: '🗓️ Second semester examination timetable is now available on the Faculty notice board and portal.\n\nAll students should confirm their venue assignments before July 20th.',
    imagePath: null,
    likes: 1200,
    comments: 89,
    reposts: 567,
    views: 28000,
    verified: true,
    initials: 'FS',
    avatarColor: const Color(0xFF0891B2),
  ),
  _PostData(
    username: 'UI Sports Council',
    handle: '@UISports',
    time: '1d',
    content: 'Congratulations to the UI Table Tennis team on winning gold at the NUGA Games! 🥇 You\'ve made us proud.',
    imagePath: null,
    likes: 2300,
    comments: 201,
    reposts: 788,
    views: 45000,
    verified: true,
    initials: 'SC',
    avatarColor: const Color(0xFF15803D),
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// Post data model
// ─────────────────────────────────────────────────────────────────────────────
class _PostData {
  final String username, handle, time, content;
  final String? imagePath;
  final int likes, comments, reposts, views;
  final bool verified;
  final String initials;
  final Color avatarColor;

  const _PostData({
    required this.username, required this.handle, required this.time,
    required this.content, required this.imagePath, required this.likes,
    required this.comments, required this.reposts, required this.views,
    required this.verified, required this.initials, required this.avatarColor,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Post card
// ─────────────────────────────────────────────────────────────────────────────
class _PostCard extends StatefulWidget {
  final _PostData post;
  final bool isNews;

  const _PostCard({required this.post, this.isNews = false});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  bool _liked = false;

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final likes = post.likes + (_liked ? 1 : 0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Avatar
        Container(
          width: 42, height: 42,
          decoration: BoxDecoration(
            color: post.avatarColor,
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(post.initials,
            style: GoogleFonts.dmSans(
              fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white))),
        ),

        const SizedBox(width: 12),

        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Name row
          Row(children: [
            Flexible(child: Text(post.username, style: GoogleFonts.dmSans(
              fontSize: 14, fontWeight: FontWeight.w600,
              color: AppColors.textPrimary),
              overflow: TextOverflow.ellipsis)),
            if (post.verified) ...[
              const SizedBox(width: 4),
              Container(
                width: 16, height: 16,
                decoration: const BoxDecoration(
                  color: AppColors.accent, shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded,
                  size: 10, color: Colors.white),
              ),
            ],
            const SizedBox(width: 6),
            Text(post.handle, style: GoogleFonts.dmSans(
              fontSize: 12, color: AppColors.textTertiary)),
            const SizedBox(width: 4),
            Text('· ${post.time}', style: GoogleFonts.dmSans(
              fontSize: 12, color: AppColors.textTertiary)),
            const Spacer(),
            const Icon(Icons.more_horiz_rounded,
              size: 18, color: AppColors.textTertiary),
          ]),

          const SizedBox(height: 6),

          // Content
          Text(post.content, style: GoogleFonts.dmSans(
            fontSize: 14, color: AppColors.textPrimary,
            height: 1.5)),

          // Image placeholder if needed
          if (post.imagePath != null) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => _FullScreenImage(url: post.imagePath!),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post.imagePath!,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) => progress == null
                      ? child
                      : Container(
                          height: 220,
                          color: AppColors.surfaceVariant,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.accent, strokeWidth: 2)),
                        ),
                  errorBuilder: (_, __, ___) => Container(
                    height: 180, color: AppColors.surfaceVariant,
                    child: const Center(child: Icon(Icons.broken_image_rounded,
                      size: 32, color: AppColors.textDisabled))),
                ),
              ),
            ),
          ],

          const SizedBox(height: 12),

          // Actions row
          Row(children: [
            _ActionBtn(
              icon: Icons.chat_bubble_outline_rounded,
              label: _fmt(post.comments),
              color: AppColors.textTertiary,
              onTap: () {},
            ),
            const SizedBox(width: 20),
            _ActionBtn(
              icon: Icons.repeat_rounded,
              label: _fmt(post.reposts),
              color: AppColors.textTertiary,
              onTap: () {},
            ),
            const SizedBox(width: 20),
            _ActionBtn(
              icon: _liked
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              label: _fmt(likes),
              color: _liked ? const Color(0xFFE24B4A) : AppColors.textTertiary,
              onTap: () => setState(() => _liked = !_liked),
            ),
            const SizedBox(width: 20),
            _ActionBtn(
              icon: Icons.bar_chart_rounded,
              label: _fmt(post.views),
              color: AppColors.textTertiary,
              onTap: () {},
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.bookmark_border_rounded,
                size: 18, color: AppColors.textTertiary),
            ),
          ]),
        ])),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Action button
// ─────────────────────────────────────────────────────────────────────────────
class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon, required this.label,
    required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 17, color: color),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.dmSans(
          fontSize: 12, color: color)),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Full screen image viewer
// ─────────────────────────────────────────────────────────────────────────────
class _FullScreenImage extends StatefulWidget {
  final String url;
  const _FullScreenImage({required this.url});

  @override
  State<_FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<_FullScreenImage> {
  final _transformCtrl = TransformationController();

  @override
  void dispose() {
    _transformCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(fit: StackFit.expand, children: [
          InteractiveViewer(
            transformationController: _transformCtrl,
            minScale: 0.8,
            maxScale: 5.0,
            child: Center(
              child: Image.network(
                widget.url,
                fit: BoxFit.contain,
                loadingBuilder: (_, child, progress) => progress == null
                    ? child
                    : const Center(child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2)),
              ),
            ),
          ),
          // Close button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close_rounded,
                  color: Colors.white, size: 20),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}