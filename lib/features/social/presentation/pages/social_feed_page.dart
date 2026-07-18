// lib/features/social/presentation/pages/social_feed_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import 'post_composer_page.dart';


class SocialFeedPage extends StatefulWidget {
  const SocialFeedPage({super.key});

  @override
  State<SocialFeedPage> createState() => _SocialFeedPageState();
}

class _SocialFeedPageState extends State<SocialFeedPage> {
  int _selectedTab = 0;
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
          ? uni.substring(0, 10).trim() : uni);
    }
  }

  Stream<List<Map<String, dynamic>>> _postsStream() {
    Query query = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(50);

    if (_selectedTab == 1) {
      query = query.where('university', isEqualTo: _university);
    } else if (_selectedTab == 2) {
      query = query.where('verified', isEqualTo: true);
    } else {
      // Global — all posts
    }

    return query.snapshots().map((snap) =>
        snap.docs.map((d) => {'id': d.id, ...d.data() as Map<String, dynamic>}).toList());
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
                Text('Social', style: GoogleFonts.dmSans(
                  fontSize: 22, fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PostComposerPage()),
                    );
                    if (result == true && mounted) setState(() {});
                  },
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

            // Tab pills
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
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: _postsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(
                      color: AppColors.accent));
                  }

                  final posts = snapshot.data ?? [];

                  if (posts.isEmpty) {
                    return Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        const Text('💬', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 16),
                        Text('No posts yet', style: GoogleFonts.dmSans(
                          fontSize: 16, fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary)),
                        const SizedBox(height: 8),
                        Text('Be the first to post something!',
                          style: GoogleFonts.dmSans(
                            fontSize: 13, color: AppColors.textTertiary)),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const PostComposerPage())),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(20)),
                            child: Text('Write a post',
                              style: GoogleFonts.dmSans(
                                fontSize: 13, fontWeight: FontWeight.w500,
                                color: Colors.white)),
                          ),
                        ),
                      ]),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: posts.length,
                    separatorBuilder: (_, __) => const Divider(
                      color: Color(0xFF1E1E24), height: 1, thickness: 1),
                    itemBuilder: (_, i) => _PostCard(post: posts[i]),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pill tab
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
// Post card
// ─────────────────────────────────────────────────────────────────────────────
class _PostCard extends StatefulWidget {
  final Map<String, dynamic> post;
  const _PostCard({required this.post});

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

  String _timeAgo(dynamic createdAt) {
    if (createdAt == null) return 'now';
    DateTime dt;
    if (createdAt is Timestamp) {
      dt = createdAt.toDate();
    } else {
      return 'now';
    }
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }

  Color _avatarColor(String uid) {
    final colors = [
      const Color(0xFF7C3AED), const Color(0xFF0891B2),
      const Color(0xFF16A34A), const Color(0xFFD97706),
      const Color(0xFFBE185D), const Color(0xFF9333EA),
    ];
    return colors[uid.hashCode.abs() % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final displayName = post['displayName'] as String? ?? 'User';
    final uid = post['uid'] as String? ?? '';
    final content = post['content'] as String? ?? '';
    final likes = (post['likes'] as int? ?? 0) + (_liked ? 1 : 0);
    final comments = post['comments'] as int? ?? 0;
    final reposts = post['reposts'] as int? ?? 0;
    final views = post['views'] as int? ?? 0;
    final verified = post['verified'] as bool? ?? false;
    final imageUrls = (post['imageUrls'] as List<dynamic>?) ?? [];
    final timeAgo = _timeAgo(post['createdAt']);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Avatar
        Container(
          width: 42, height: 42,
          decoration: BoxDecoration(
            color: _avatarColor(uid), shape: BoxShape.circle),
          child: Center(child: Text(_initials(displayName),
            style: GoogleFonts.dmSans(
              fontSize: 14, fontWeight: FontWeight.w700,
              color: Colors.white))),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Name row
          Row(children: [
            Flexible(child: Text(displayName, style: GoogleFonts.dmSans(
              fontSize: 14, fontWeight: FontWeight.w600,
              color: AppColors.textPrimary),
              overflow: TextOverflow.ellipsis)),
            if (verified) ...[
              const SizedBox(width: 4),
              Container(
                width: 16, height: 16,
                decoration: const BoxDecoration(
                  color: AppColors.accent, shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded,
                  size: 10, color: Colors.white)),
            ],
            const SizedBox(width: 6),
            Text('· $timeAgo', style: GoogleFonts.dmSans(
              fontSize: 12, color: AppColors.textTertiary)),
            const Spacer(),
            const Icon(Icons.more_horiz_rounded,
              size: 18, color: AppColors.textTertiary),
          ]),
          const SizedBox(height: 6),
          // Content
          Text(content, style: GoogleFonts.dmSans(
            fontSize: 14, color: AppColors.textPrimary, height: 1.5)),
          // Images
          if (imageUrls.isNotEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrls[0] as String,
                width: double.infinity, height: 200,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox())),
          ],
          const SizedBox(height: 12),
          // Actions
          Row(children: [
            _ActionBtn(
              icon: Icons.chat_bubble_outline_rounded,
              label: _fmt(comments),
              color: AppColors.textTertiary,
              onTap: () {},
            ),
            const SizedBox(width: 20),
            _ActionBtn(
              icon: Icons.repeat_rounded,
              label: _fmt(reposts),
              color: AppColors.textTertiary,
              onTap: () {},
            ),
            const SizedBox(width: 20),
            _ActionBtn(
              icon: _liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              label: _fmt(likes),
              color: _liked ? const Color(0xFFE24B4A) : AppColors.textTertiary,
              onTap: () => setState(() => _liked = !_liked),
            ),
            const SizedBox(width: 20),
            _ActionBtn(
              icon: Icons.bar_chart_rounded,
              label: _fmt(views),
              color: AppColors.textTertiary,
              onTap: () {},
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.bookmark_border_rounded,
                size: 18, color: AppColors.textTertiary)),
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
        Text(label, style: GoogleFonts.dmSans(fontSize: 12, color: color)),
      ]),
    );
  }
}