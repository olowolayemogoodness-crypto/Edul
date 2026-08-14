// lib/features/social/presentation/pages/group_detail_page.dart
//
// The pending-approval popup fires once, right when an admin opens
// THEIR OWN group -- deliberately not a push notification. If there
// are pending requests waiting, this is where they surface.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/services/post_interaction_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/widgets/voice_note_bubble.dart';
import 'post_composer_page.dart';
import '../widgets/comments_popup.dart';

class GroupDetailPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final bool isAdmin;
  const GroupDetailPage({super.key, required this.groupId, required this.groupName, this.isAdmin = false});

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  bool _checkedPending = false;

  @override
  void initState() {
    super.initState();
    if (widget.isAdmin) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _maybeShowPendingPopup());
    }
  }

  Future<void> _confirmDeletePost(String postId, String collectionPath) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Delete post?', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        content: Text('This can\'t be undone.', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('Cancel', style: GoogleFonts.dmSans(color: AppColors.textTertiary))),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Delete', style: GoogleFonts.dmSans(color: AppColors.error, fontWeight: FontWeight.w600))),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await PostInteractionService.deletePost(postId, collectionPath: collectionPath);
    } catch (e) {
      debugPrint('[GroupDetail] Delete failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not delete post')));
      }
    }
  }

  Future<void> _maybeShowPendingPopup() async {
    if (_checkedPending) return;
    _checkedPending = true;
    final pending = await GroupService.pendingRequests(widget.groupId).first;
    if (pending.isEmpty || !mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.5, minChildSize: 0.3, maxChildSize: 0.85, expand: false,
        builder: (_, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Pending requests', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            Text('${pending.length} waiting to join ${widget.groupName}', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: GroupService.pendingRequests(widget.groupId),
                builder: (context, snap) {
                  final list = snap.data ?? [];
                  if (list.isEmpty) {
                    return Center(child: Text('All caught up', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)));
                  }
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final req = list[i];
                      final username = req['usernameDisplay'] as String?;
                      final label = (username != null && username.trim().isNotEmpty)
                          ? '@$username' : (req['displayName'] as String? ?? 'User');
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(children: [
                          Expanded(child: Text(label,
                            style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary),
                            overflow: TextOverflow.ellipsis)),
                          TextButton(
                            onPressed: () => GroupService.rejectMember(widget.groupId, req['uid'] as String),
                            child: Text('Decline', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              GroupService.approveMember(widget.groupId, req['uid'] as String, widget.groupName);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            child: Text('Approve', style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                          ),
                        ]),
                      );
                    },
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        title: Text(widget.groupName, style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_square, color: AppColors.textSecondary, size: 20),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PostComposerPage(groupId: widget.groupId, groupName: widget.groupName))),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: GroupService.groupPosts(widget.groupId),
        builder: (context, snapshot) {
          final posts = snapshot.data ?? [];
          if (posts.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('No posts yet', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text('Tap the compose icon to share something with the group',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                ]),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: posts.length,
            itemBuilder: (context, i) {
              final post = posts[i];
              final postId = post['id'] as String;
              final postOwnerUid = post['uid'] as String? ?? '';
              final username = post['usernameDisplay'] as String?;
              final label = (username != null && username.trim().isNotEmpty)
                  ? '@$username' : (post['displayName'] as String? ?? 'User');
              final imageUrls = (post['imageUrls'] as List<dynamic>?) ?? [];
              final collectionPath = 'groups/${widget.groupId}/posts';
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text(label, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
                    if (postOwnerUid == UserService.uid)
                      GestureDetector(
                        onTap: () => _confirmDeletePost(postId, collectionPath),
                        child: Icon(Icons.delete_outline_rounded, size: 17, color: AppColors.textTertiary),
                      ),
                  ]),
                  if ((post['content'] as String? ?? '').isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(post['content'] as String, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                  ],
                  if (imageUrls.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(imageUrls.first as String, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(height: 160, color: AppColors.surfaceVariant)),
                    ),
                  ],
                  if ((post['audioUrl'] as String?)?.isNotEmpty == true) ...[
                    const SizedBox(height: 8),
                    VoiceNoteBubble(
                      id: postId,
                      audioUrl: post['audioUrl'] as String,
                      durationMs: (post['durationMs'] as int?) ?? 0,
                      waveform: ((post['waveform'] as List<dynamic>?) ?? [])
                          .map((e) => (e as num).toDouble()).toList(),
                    ),
                  ],
                  if ((post['videoUrl'] as String?)?.isNotEmpty == true) ...[
                    const SizedBox(height: 8),
                    _GroupVideoThumb(videoUrl: post['videoUrl'] as String),
                  ],
                  const SizedBox(height: 10),
                  Row(children: [
                    StreamBuilder<bool>(
                      stream: PostInteractionService.isLikedByMe(postId, collectionPath: collectionPath),
                      builder: (context, likedSnap) {
                        final liked = likedSnap.data ?? false;
                        return StreamBuilder<int>(
                          stream: PostInteractionService.likeCount(postId, collectionPath: collectionPath),
                          builder: (context, countSnap) => GestureDetector(
                            onTap: () => PostInteractionService.toggleLike(postId, postOwnerUid, collectionPath: collectionPath),
                            child: Row(children: [
                              Icon(liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                size: 17, color: liked ? AppColors.error : AppColors.textTertiary),
                              const SizedBox(width: 4),
                              Text('${countSnap.data ?? 0}', style: GoogleFonts.dmSans(fontSize: 11.5, color: AppColors.textTertiary)),
                            ]),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context, isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => CommentsPopup(postId: postId, collectionPath: collectionPath),
                      ),
                      child: StreamBuilder<int>(
                        stream: PostInteractionService.commentCount(postId, collectionPath: collectionPath),
                        builder: (context, s) => Row(children: [
                          Icon(Icons.chat_bubble_outline_rounded, size: 15, color: AppColors.textTertiary),
                          const SizedBox(width: 4),
                          Text('${s.data ?? 0}', style: GoogleFonts.dmSans(fontSize: 11.5, color: AppColors.textTertiary)),
                        ]),
                      ),
                    ),
                  ]),
                ]),
              );
            },
          );
        },
      ),
    );
  }
}

// Simple tap-to-play video widget for group posts -- same tap-to-play
// convention as the main feed's video card, without needing its full
// autoplay-lifecycle complexity (group feeds are a simple list, not a
// scroll-triggered autoplay context).
class _GroupVideoThumb extends StatefulWidget {
  final String videoUrl;
  const _GroupVideoThumb({required this.videoUrl});

  @override
  State<_GroupVideoThumb> createState() => _GroupVideoThumbState();
}

class _GroupVideoThumbState extends State<_GroupVideoThumb> {
  VideoPlayerController? _controller;
  bool _loading = false;

  Future<void> _start() async {
    if (_controller != null) {
      setState(() => _controller!.value.isPlaying ? _controller!.pause() : _controller!.play());
      return;
    }
    setState(() => _loading = true);
    final controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    try {
      await controller.initialize();
      if (!mounted) { controller.dispose(); return; }
      setState(() { _controller = controller; _loading = false; });
      controller..setLooping(true)..play();
    } catch (_) {
      if (mounted) setState(() => _loading = false);
      controller.dispose();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: _start,
        onDoubleTap: () {
          if (_controller == null || !_controller!.value.isInitialized) return;
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => _GroupVideoFullscreen(videoUrl: widget.videoUrl)));
        },
        child: Container(
          height: 200, width: double.infinity, color: AppColors.surfaceVariant,
          child: Stack(alignment: Alignment.center, children: [
            if (_controller != null && _controller!.value.isInitialized)
              FittedBox(fit: BoxFit.cover,
                child: SizedBox(width: _controller!.value.size.width, height: _controller!.value.size.height,
                  child: VideoPlayer(_controller!))),
            if (_loading) const CircularProgressIndicator()
            else if (_controller == null || !_controller!.value.isPlaying)
              Container(width: 46, height: 46,
                decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
                child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 26)),
          ]),
        ),
      ),
    );
  }
}

// Simple single-video fullscreen viewer for group posts -- deliberately
// NOT the main feed's FullscreenVideoFeedPage, which queries the
// top-level posts collection with a same-creator-then-recent queue.
// None of that applies here: this video lives in a different
// collection, and a group's fullscreen view has no reason to queue up
// unrelated videos from across the whole app.
class _GroupVideoFullscreen extends StatefulWidget {
  final String videoUrl;
  const _GroupVideoFullscreen({required this.videoUrl});

  @override
  State<_GroupVideoFullscreen> createState() => _GroupVideoFullscreenState();
}

class _GroupVideoFullscreenState extends State<_GroupVideoFullscreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    try {
      await controller.initialize();
      if (!mounted) { controller.dispose(); return; }
      setState(() => _controller = controller);
      controller..setLooping(true)..play();
    } catch (_) {
      controller.dispose();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(fit: StackFit.expand, children: [
        if (_controller != null && _controller!.value.isInitialized)
          // BoxFit.contain (via AspectRatio), not cover -- shows the
          // whole video rather than zooming/cropping to fill, same fix
          // already applied to the main feed's fullscreen view earlier
          // tonight.
          Center(
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
          )
        else
          const Center(child: CircularProgressIndicator(color: Colors.white)),
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (_controller == null) return;
              setState(() => _controller!.value.isPlaying ? _controller!.pause() : _controller!.play());
            },
          ),
        ),
        Positioned(
          top: 8, left: 8,
          child: SafeArea(
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                width: 36, height: 36,
                decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
                child: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}