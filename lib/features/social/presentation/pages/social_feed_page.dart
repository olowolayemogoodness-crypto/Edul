// lib/features/social/presentation/pages/social_feed_page.dart

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/post_interaction_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/voice_note_service.dart';
import 'post_composer_page.dart';
import '../../../../core/services/user_follow_service.dart';



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
                    itemBuilder: (_, i) => _PostCard(
                      key: ValueKey(posts[i]['id']),
                      post: posts[i],
                    ),
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
  const _PostCard({super.key, required this.post});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
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

  void _showPostMenu(BuildContext context, String postId, bool isOwner) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetContext) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          Container(width: 36, height: 4,
            decoration: BoxDecoration(color: AppColors.border,
              borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 8),
          if (isOwner)
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded,
                color: AppColors.error),
              title: Text('Delete post', style: GoogleFonts.dmSans(
                fontSize: 14, color: AppColors.error)),
              onTap: () {
                Navigator.pop(sheetContext);
                _confirmDelete(context, postId);
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.flag_outlined,
                color: AppColors.textTertiary),
              title: Text('Report post', style: GoogleFonts.dmSans(
                fontSize: 14, color: AppColors.textSecondary)),
              onTap: () => Navigator.pop(sheetContext),
            ),
          ListTile(
            leading: const Icon(Icons.close_rounded,
              color: AppColors.textTertiary),
            title: Text('Cancel', style: GoogleFonts.dmSans(
              fontSize: 14, color: AppColors.textSecondary)),
            onTap: () => Navigator.pop(sheetContext),
          ),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String postId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Delete this post?', style: GoogleFonts.dmSans(
          fontSize: 16, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary)),
        content: Text("This can't be undone.", style: GoogleFonts.dmSans(
          fontSize: 13, color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: GoogleFonts.dmSans(
              color: AppColors.textSecondary))),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              PostInteractionService.deletePost(postId);
            },
            child: Text('Delete', style: GoogleFonts.dmSans(
              color: AppColors.error, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  void _openComments(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CommentsSheet(postId: postId),
    );
  }

  void _openUserProfile(BuildContext context, Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _UserProfileSheet(
        uid: post['uid'] as String? ?? '',
        displayName: post['displayName'] as String? ?? 'User',
        university: post['university'] as String? ?? '',
        course: post['course'] as String? ?? '',
        verified: post['verified'] as bool? ?? false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final postId = post['id'] as String;
    final displayName = post['displayName'] as String? ?? 'User';
    final uid = post['uid'] as String? ?? '';
    final content = post['content'] as String? ?? '';
    final views = post['views'] as int? ?? 0;
    final verified = post['verified'] as bool? ?? false;
    final imageUrls = (post['imageUrls'] as List<dynamic>?) ?? [];
    final audioUrl = post['audioUrl'] as String?;
    final timeAgo = _timeAgo(post['createdAt']);
    final isOwner = UserService.uid != null && UserService.uid == uid;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Avatar
        // Avatar
        GestureDetector(
          onTap: () => _openUserProfile(context, post),
          child: Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: _avatarColor(uid), shape: BoxShape.circle),
            child: Center(child: Text(_initials(displayName),
              style: GoogleFonts.dmSans(
                fontSize: 14, fontWeight: FontWeight.w700,
                color: Colors.white))),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Name row
          Row(children: [
            GestureDetector(
              onTap: () => _openUserProfile(context, post),
              child: Flexible(child: Text(displayName, style: GoogleFonts.dmSans(
                fontSize: 14, fontWeight: FontWeight.w600,
                color: AppColors.textPrimary),
                overflow: TextOverflow.ellipsis)),
            ),
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
            GestureDetector(
              onTap: () => _showPostMenu(context, postId, isOwner),
              child: const Icon(Icons.more_horiz_rounded,
                size: 18, color: AppColors.textTertiary),
            ),
          ]),
          const SizedBox(height: 6),
          // Content
          if (content.isNotEmpty)
            Text(content, style: GoogleFonts.dmSans(
              fontSize: 14, color: AppColors.textPrimary, height: 1.5)),
          // Voice note
          if (audioUrl != null && audioUrl.isNotEmpty) ...[
            const SizedBox(height: 10),
            
            _VoiceNoteBubble(
              commentId: postId,
              audioUrl: audioUrl,
              durationMs: post['durationMs'] as int? ?? 0,
              waveform: ((post['waveform'] as List<dynamic>?) ?? [])
                  .map((e) => (e as num).toDouble())
                  .toList(),
            ),
          ],
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
            StreamBuilder<int>(
              stream: PostInteractionService.commentCount(postId),
              builder: (context, snap) => _ActionBtn(
                icon: Icons.chat_bubble_outline_rounded,
                label: _fmt(snap.data ?? 0),
                color: AppColors.textTertiary,
                onTap: () => _openComments(context, postId),
              ),
            ),
            const SizedBox(width: 20),
            StreamBuilder<bool>(
              stream: PostInteractionService.isRepostedByMe(postId),
              builder: (context, repostedSnap) {
                final reposted = repostedSnap.data ?? false;
                return StreamBuilder<int>(
                  stream: PostInteractionService.repostCount(postId),
                  builder: (context, countSnap) => _ActionBtn(
                    icon: Icons.repeat_rounded,
                    label: _fmt(countSnap.data ?? 0),
                    color: reposted ? AppColors.success : AppColors.textTertiary,
                    onTap: () => PostInteractionService.toggleRepost(postId),
                  ),
                );
              },
            ),
            const SizedBox(width: 20),
            StreamBuilder<bool>(
              stream: PostInteractionService.isLikedByMe(postId),
              builder: (context, likedSnap) {
                final liked = likedSnap.data ?? false;
                return StreamBuilder<int>(
                  stream: PostInteractionService.likeCount(postId),
                  builder: (context, countSnap) => _ActionBtn(
                    icon: liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    label: _fmt(countSnap.data ?? 0),
                    color: liked ? const Color(0xFFE24B4A) : AppColors.textTertiary,
                    onTap: () => PostInteractionService.toggleLike(postId),
                  ),
                );
              },
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
// Comments sheet
// ─────────────────────────────────────────────────────────────────────────────
// A palette of 40 distinct hues, evenly spaced — so across many voice
// notes you see real color variety (not a random color per note, which
// would look noisy) while still only cycling through ~40 total colors.
// Same comment always gets the same color (hashed from its id).
final List<Color> _voiceNoteColorPalette = List.generate(40, (i) {
  final hue = (i * 360 / 40) % 360;
  return HSLColor.fromAHSL(1.0, hue, 0.62, 0.55).toColor();
});

Color _voiceNoteColor(String seed) =>
    _voiceNoteColorPalette[seed.hashCode.abs() % _voiceNoteColorPalette.length];

String _fmtSeconds(int totalSeconds) {
  final m = totalSeconds ~/ 60;
  final s = totalSeconds % 60;
  return '$m:${s.toString().padLeft(2, '0')}';
}

class _CommentsSheet extends StatefulWidget {
  final String postId;
  const _CommentsSheet({required this.postId});

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  final _ctrl = TextEditingController();
  bool _sending = false;

  bool _isRecording = false;
  bool _uploadingVoice = false;
  int _recordingSeconds = 0;
  Timer? _recordTimer;

  @override
  void dispose() {
    _ctrl.dispose();
    _recordTimer?.cancel();
    super.dispose();
  }

  String _timeAgo(dynamic createdAt) {
    if (createdAt == null) return 'now';
    if (createdAt is! Timestamp) return 'now';
    final diff = DateTime.now().difference(createdAt.toDate());
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      await PostInteractionService.addComment(widget.postId, text);
      _ctrl.clear();
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _startRecording() async {
    try {
      await VoiceNoteService.startRecording();
      if (!mounted) return;
      setState(() {
        _isRecording = true;
        _recordingSeconds = 0;
      });
      _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() => _recordingSeconds++);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Could not start recording: $e',
          style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating));
    }
  }

  Future<void> _cancelRecording() async {
    _recordTimer?.cancel();
    await VoiceNoteService.cancelRecording();
    if (mounted) {
      setState(() {
        _isRecording = false;
        _recordingSeconds = 0;
      });
    }
  }

  Future<void> _sendRecording() async {
    _recordTimer?.cancel();
    setState(() {
      _isRecording = false;
      _uploadingVoice = true;
    });
    try {
      final result = await VoiceNoteService.stopRecording();
      if (result == null) return; // too short — silently discarded
      await VoiceNoteService.sendAsComment(
        postId: widget.postId,
        file: result.file,
        durationMs: result.durationMs,
        waveform: result.waveform,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Voice note failed: $e',
          style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating));
    } finally {
      if (mounted) setState(() => _uploadingVoice = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(children: [
          const SizedBox(height: 8),
          Container(width: 36, height: 4,
            decoration: BoxDecoration(color: AppColors.border,
              borderRadius: BorderRadius.circular(2))),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Comments', style: GoogleFonts.dmSans(
              fontSize: 16, fontWeight: FontWeight.w600,
              color: AppColors.textPrimary)),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: PostInteractionService.comments(widget.postId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Could not load comments:\n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 12, color: AppColors.error),
                      ),
                    ),
                  );
                }
                final comments = snapshot.data ?? [];
                if (comments.isEmpty) {
                  return Center(
                    child: Text('No comments yet — be the first',
                      style: GoogleFonts.dmSans(
                        fontSize: 13, color: AppColors.textTertiary)),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: comments.length,
                  itemBuilder: (_, i) {
                    final c = comments[i];
                    final commentId = c['id'] as String;
                    final name = c['displayName'] as String? ?? 'User';
                    final audioUrl = c['audioUrl'] as String?;
                    final isVoice = audioUrl != null && audioUrl.isNotEmpty;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                          width: 32, height: 32,
                          decoration: const BoxDecoration(
                            color: AppColors.accentSurface, shape: BoxShape.circle),
                          child: Center(child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : 'U',
                            style: GoogleFonts.dmSans(fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.accentLight))),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(children: [
                            Text(name, style: GoogleFonts.dmSans(
                              fontSize: 13, fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary)),
                            const SizedBox(width: 6),
                            Text(_timeAgo(c['createdAt']), style: GoogleFonts.dmSans(
                              fontSize: 11, color: AppColors.textTertiary)),
                          ]),
                          const SizedBox(height: 4),
                          if (isVoice)
                            _VoiceNoteBubble(
                              commentId: commentId,
                              audioUrl: audioUrl,
                              durationMs: c['durationMs'] as int? ?? 0,
                              waveform: ((c['waveform'] as List<dynamic>?) ?? [])
                                  .map((e) => (e as num).toDouble())
                                  .toList(),
                            )
                          else
                            Text(c['content'] as String? ?? '',
                              style: GoogleFonts.dmSans(
                                fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                          const SizedBox(height: 4),
                          StreamBuilder<bool>(
                            stream: PostInteractionService.isCommentLikedByMe(
                              widget.postId, commentId),
                            builder: (context, likedSnap) {
                              final liked = likedSnap.data ?? false;
                              return StreamBuilder<int>(
                                stream: PostInteractionService.commentLikeCount(
                                  widget.postId, commentId),
                                builder: (context, countSnap) => GestureDetector(
                                  onTap: () => PostInteractionService
                                      .toggleCommentLike(widget.postId, commentId),
                                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                                    Icon(
                                      liked ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                      size: 14,
                                      color: liked
                                          ? const Color(0xFFE24B4A)
                                          : AppColors.textTertiary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text('${countSnap.data ?? 0}',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 11,
                                        color: liked
                                            ? const Color(0xFFE24B4A)
                                            : AppColors.textTertiary)),
                                  ]),
                                ),
                              );
                            },
                          ),
                        ])),
                      ]),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16,
              MediaQuery.of(context).viewInsets.bottom + 12),
            child: _isRecording
                ? Row(children: [
                    const Icon(Icons.fiber_manual_record_rounded,
                      color: AppColors.error, size: 14),
                    const SizedBox(width: 8),
                    Text('Recording ${_fmtSeconds(_recordingSeconds)}',
                      style: GoogleFonts.dmSans(
                        fontSize: 13, color: AppColors.textPrimary)),
                    const Spacer(),
                    GestureDetector(
                      onTap: _cancelRecording,
                      child: Container(
                        width: 36, height: 36,
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceVariant, shape: BoxShape.circle),
                        child: const Icon(Icons.close_rounded,
                          color: AppColors.textSecondary, size: 18)),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _sendRecording,
                      child: Container(
                        width: 36, height: 36,
                        decoration: const BoxDecoration(
                          color: AppColors.accent, shape: BoxShape.circle),
                        child: const Icon(Icons.check_rounded,
                          color: Colors.white, size: 18)),
                    ),
                  ])
                : Row(children: [
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Add a comment…',
                          hintStyle: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textTertiary),
                          filled: true,
                          fillColor: AppColors.surface,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: AppColors.border)),
                        ),
                        onSubmitted: (_) => _send(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _uploadingVoice ? null : _startRecording,
                      child: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.surface, shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border)),
                        child: _uploadingVoice
                            ? const Padding(padding: EdgeInsets.all(10),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2, color: AppColors.accent))
                            : const Icon(Icons.mic_none_rounded,
                                color: AppColors.textSecondary, size: 18),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _send,
                      child: Container(
                        width: 40, height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.accent, shape: BoxShape.circle),
                        child: _sending
                            ? const Padding(padding: EdgeInsets.all(10),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                            : const Icon(Icons.arrow_upward_rounded,
                                size: 18, color: Colors.white),
                      ),
                    ),
                  ]),
          ),
        ]),
      ),
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// User profile preview sheet
// ─────────────────────────────────────────────────────────────────────────────
Future<int> _fetchPostCount(String uid) async {
  try {
    final snap = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: uid)
        .count()
        .get();
    return snap.count ?? 0;
  } catch (_) {
    return 0;
  }
}

class _UserProfileSheet extends StatelessWidget {
  final String uid;
  final String displayName;
  final String university;
  final String course;
  final bool verified;

  const _UserProfileSheet({
    required this.uid,
    required this.displayName,
    required this.university,
    required this.course,
    required this.verified,
  });

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
    final isSelf = UserService.uid != null && UserService.uid == uid;

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(children: [
          const SizedBox(height: 8),
          Container(width: 36, height: 4,
            decoration: BoxDecoration(color: AppColors.border,
              borderRadius: BorderRadius.circular(2))),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(children: [
                Container(
                  width: 72, height: 72,
                  decoration: BoxDecoration(
                    color: _avatarColor(uid), shape: BoxShape.circle),
                  child: Center(child: Text(_initials(displayName),
                    style: GoogleFonts.dmSans(
                      fontSize: 24, fontWeight: FontWeight.w700,
                      color: Colors.white))),
                ),
                const SizedBox(height: 14),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(displayName, style: GoogleFonts.dmSans(
                    fontSize: 18, fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary)),
                  if (verified) ...[
                    const SizedBox(width: 6),
                    Container(
                      width: 18, height: 18,
                      decoration: const BoxDecoration(
                        color: AppColors.accent, shape: BoxShape.circle),
                      child: const Icon(Icons.check_rounded,
                        size: 11, color: Colors.white)),
                  ],
                ]),
                const SizedBox(height: 4),
                if (university.isNotEmpty)
                  Text(course.isNotEmpty ? '$university · $course' : university,
                    style: GoogleFonts.dmSans(
                      fontSize: 13, color: AppColors.textTertiary),
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  FutureBuilder<int>(
                    future: _fetchPostCount(uid),
                    builder: (context, snap) =>
                        _StatColumn(label: 'Posts', value: snap.data ?? 0),
                  ),
                  StreamBuilder<int>(
                    stream: UserFollowService.followerCount(uid),
                    builder: (context, snap) =>
                        _StatColumn(label: 'Followers', value: snap.data ?? 0),
                  ),
                  StreamBuilder<int>(
                    stream: UserFollowService.followingCount(uid),
                    builder: (context, snap) =>
                        _StatColumn(label: 'Following', value: snap.data ?? 0),
                  ),
                ]),
                const SizedBox(height: 22),
                if (!isSelf)
                  StreamBuilder<bool>(
                    stream: UserFollowService.isFollowing(uid),
                    builder: (context, snap) {
                      final following = snap.data ?? false;
                      return GestureDetector(
                        onTap: () => UserFollowService.toggleFollow(uid),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: following ? Colors.transparent : AppColors.accent,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColors.accent),
                          ),
                          child: Text(following ? 'Following' : 'Follow',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              fontSize: 14, fontWeight: FontWeight.w600,
                              color: following ? AppColors.accent : Colors.white)),
                        ),
                      );
                    },
                  ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final int value;
  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('$value', style: GoogleFonts.dmSans(
        fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      const SizedBox(height: 2),
      Text(label, style: GoogleFonts.dmSans(
        fontSize: 11, color: AppColors.textTertiary)),
    ]);
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Voice note playback bubble
// ─────────────────────────────────────────────────────────────────────────────
class _VoiceNoteBubble extends StatefulWidget {
  final String commentId;
  final String audioUrl;
  final int durationMs;
  final List<double> waveform;

  const _VoiceNoteBubble({
    required this.commentId,
    required this.audioUrl,
    required this.durationMs,
    required this.waveform,
  });

  @override
  State<_VoiceNoteBubble> createState() => _VoiceNoteBubbleState();
}

class _VoiceNoteBubbleState extends State<_VoiceNoteBubble> {
  final _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _total = Duration.zero;
  StreamSubscription? _posSub, _durSub, _completeSub;

  @override
  void initState() {
    super.initState();
    _total = Duration(milliseconds: widget.durationMs);
    _posSub = _player.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    });
    _durSub = _player.onDurationChanged.listen((d) {
      if (mounted) setState(() => _total = d);
    });
    _completeSub = _player.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _position = Duration.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    _posSub?.cancel();
    _durSub?.cancel();
    _completeSub?.cancel();
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_isPlaying) {
      await _player.pause();
      if (mounted) setState(() => _isPlaying = false);
    } else {
      await _player.play(UrlSource(widget.audioUrl));
      if (mounted) setState(() => _isPlaying = true);
    }
  }

  String _fmtDuration(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final color = _voiceNoteColor(widget.commentId);
    final waveform = widget.waveform.isEmpty
        ? List<double>.filled(40, 0.15)
        : widget.waveform;
    final progress = _total.inMilliseconds == 0
        ? 0.0
        : (_position.inMilliseconds / _total.inMilliseconds).clamp(0.0, 1.0);
    final playedBars = (progress * waveform.length).round();
    final displayDuration =
        (_isPlaying || _position > Duration.zero) ? _position : _total;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 240),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Row(children: [
        GestureDetector(
          onTap: _toggle,
          child: Container(
            width: 30, height: 30,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white, size: 16),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 26,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(waveform.length, (i) {
                final amp = waveform[i].clamp(0.08, 1.0);
                final played = i < playedBars;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    height: 4 + amp * 18,
                    decoration: BoxDecoration(
                      color: played ? color : color.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(_fmtDuration(displayDuration),
          style: GoogleFonts.dmSans(fontSize: 10, color: color)),
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