// lib/features/social/presentation/pages/fullscreen_video_feed_page.dart
//
// Opened by double-tapping a video in the regular feed. Vertically
// swipeable, one video per screen, autoplays the current one and
// pauses everything else -- the actual "occupies the screen and you
// can scroll" feature.
//
// Ordering: same creator's other videos first (real continuity), then
// the rest of the recent video pool by recency. Deliberately NOT a
// smart engagement-ranked recommendation yet -- the hashtag/engagement
// data built earlier tonight is exactly what a future ranking pass
// would use, but shipping that ranking algorithm is a separate, larger
// piece from just getting the fullscreen-scroll mechanic working.
//
// Reuses the exact same "fetch 50 recent posts, filter client-side"
// query already established in social_feed_page.dart -- no new
// composite index needed, same reasoning: a combined where+orderBy
// query needs one to be manually created, and a missing index fails
// silently. This avoids that class of bug entirely.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/post_interaction_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/feed_video_watch_service.dart';
import 'post_detail_page.dart';

class FullscreenVideoFeedPage extends StatefulWidget {
  final String initialPostId;
  const FullscreenVideoFeedPage({super.key, required this.initialPostId});

  @override
  State<FullscreenVideoFeedPage> createState() => _FullscreenVideoFeedPageState();
}

class _FullscreenVideoFeedPageState extends State<FullscreenVideoFeedPage> {
  List<Map<String, dynamic>> _videos = [];
  int _currentIndex = 0;
  PageController? _pageController;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    // Same simple, always-valid query as the main feed -- fetch broad,
    // filter and reorder client-side, no composite index dependency.
    final snap = await FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();

    final all = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
    final allVideos = all.where((p) => p['videoUrl'] != null).toList();

    final initial = allVideos.firstWhere(
      (p) => p['id'] == widget.initialPostId,
      orElse: () => allVideos.isNotEmpty ? allVideos.first : <String, dynamic>{},
    );
    if (initial.isEmpty) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    final creatorUid = initial['uid'];

    // Same creator's other videos next (real continuity), then
    // everything else in its existing recency order.
    final sameCreator = allVideos.where((p) => p['id'] != initial['id'] && p['uid'] == creatorUid).toList();
    final rest = allVideos.where((p) => p['id'] != initial['id'] && p['uid'] != creatorUid).toList();
    final ordered = [initial, ...sameCreator, ...rest];

    if (!mounted) return;
    setState(() {
      _videos = ordered;
      _pageController = PageController(initialPage: 0);
      _loading = false;
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : _videos.isEmpty
              ? Center(child: Text('No videos to show', style: GoogleFonts.dmSans(color: Colors.white70)))
              : Stack(children: [
                  PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: _videos.length,
                    onPageChanged: (i) => setState(() => _currentIndex = i),
                    itemBuilder: (context, i) => _FullscreenVideoItem(
                      post: _videos[i],
                      isActive: i == _currentIndex,
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

class _FullscreenVideoItem extends StatefulWidget {
  final Map<String, dynamic> post;
  final bool isActive;
  const _FullscreenVideoItem({required this.post, required this.isActive});

  @override
  State<_FullscreenVideoItem> createState() => _FullscreenVideoItemState();
}

class _FullscreenVideoItemState extends State<_FullscreenVideoItem> {
  VideoPlayerController? _controller;
  bool _hasRecordedWatch = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  Future<void> _initController() async {
    final url = widget.post['videoUrl'] as String?;
    if (url == null) return;
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    try {
      await controller.initialize();
      if (!mounted) { controller.dispose(); return; }
      controller.setLooping(true);
      setState(() => _controller = controller);
      if (widget.isActive) _play();
    } catch (_) {
      controller.dispose();
    }
  }

  void _play() {
    _controller?.play();
    if (!_hasRecordedWatch) {
      _hasRecordedWatch = true;
      FeedVideoWatchService.recordWatch();
    }
  }

  @override
  void didUpdateWidget(_FullscreenVideoItem old) {
    super.didUpdateWidget(old);
    if (widget.isActive && !old.isActive) {
      _play();
    } else if (!widget.isActive && old.isActive) {
      _controller?.pause();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _repost(BuildContext context, String postId, Map<String, dynamic> post) async {
    final profile = await UserService.getProfile();
    final myDisplayName = profile?['displayName'] as String? ?? 'User';
    final myUniversity = profile?['university'] as String? ?? '';
    await PostInteractionService.toggleRepost(
      postId,
      feedTarget: post['feedTarget'] as String? ?? 'global',
      myDisplayName: myDisplayName,
      myUniversity: myUniversity,
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reposted')));
    }
  }

  String _authorLabel(Map<String, dynamic> data) {
    final username = data['usernameDisplay'] as String?;
    if (username != null && username.trim().isNotEmpty) return '@$username';
    return data['displayName'] as String? ?? 'User';
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final postId = post['id'] as String;
    final postOwnerUid = post['uid'] as String? ?? '';

    return Stack(fit: StackFit.expand, children: [
      if (_controller != null && _controller!.value.isInitialized)
        FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: _controller!.value.size.width,
            height: _controller!.value.size.height,
            child: VideoPlayer(_controller!),
          ),
        )
      else
        const Center(child: CircularProgressIndicator(color: Colors.white)),

      // Tap anywhere on the video to pause/resume -- placed here,
      // directly after the video and BEFORE the text overlay/action
      // rail, so it sits beneath them in the Stack. It has no child, so
      // Flutter defaults it to HitTestBehavior.opaque; being underneath
      // the buttons (not on top, like it was before) means the buttons
      // get first claim on their own area, and only genuine taps on the
      // open video area fall through to this.
      Positioned.fill(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (_controller == null) return;
            setState(() => _controller!.value.isPlaying ? _controller!.pause() : _controller!.play());
          },
        ),
      ),

      // Dark gradient at the bottom for text legibility, same visual
      // language as the room cards and Masterclass lesson thumbnails.
      Positioned(
        left: 0, right: 0, bottom: 0,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 60, 80, 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.75)]),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(_authorLabel(post), style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
            if ((post['content'] as String? ?? '').isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(post['content'] as String, maxLines: 2, overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white)),
            ],
          ]),
        ),
      ),

      // Right-side action rail -- like/comment/repost, reusing the same
      // interaction service as everywhere else, no duplicated logic.
      Positioned(
        right: 12, bottom: 90,
        child: Column(children: [
          StreamBuilder<bool>(
            stream: PostInteractionService.isLikedByMe(postId),
            builder: (context, likedSnap) {
              final liked = likedSnap.data ?? false;
              return StreamBuilder<int>(
                stream: PostInteractionService.likeCount(postId),
                builder: (context, countSnap) => GestureDetector(
                  onTap: () => PostInteractionService.toggleLike(postId, postOwnerUid),
                  child: Column(children: [
                    Icon(liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: liked ? AppColors.error : Colors.white, size: 30),
                    const SizedBox(height: 3),
                    Text('${countSnap.data ?? 0}', style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white)),
                  ]),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          StreamBuilder<int>(
            stream: PostInteractionService.commentCount(postId),
            builder: (context, s) => GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PostDetailPage(postId: postId))),
              child: Column(children: [
                const Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 27),
                const SizedBox(height: 3),
                Text('${s.data ?? 0}', style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white)),
              ]),
            ),
          ),
          const SizedBox(height: 20),
          StreamBuilder<int>(
            stream: PostInteractionService.repostCount(postId),
            builder: (context, s) => GestureDetector(
              onTap: () => _repost(context, postId, post),
              child: Column(children: [
                const Icon(Icons.repeat_rounded, color: Colors.white, size: 28),
                const SizedBox(height: 3),
                Text('${s.data ?? 0}', style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white)),
              ]),
            ),
          ),
        ]),
      ),
    ]);
  }
}