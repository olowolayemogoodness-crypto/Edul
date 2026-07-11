// lib/features/insights/presentation/pages/insights_feed_page.dart
//
// Full-screen vertical swipe feed that reads from the Firestore
// 'insights' collection (written by the edul-upload-tool) and plays
// videos directly from Cloudflare R2 URLs using video_player.
//
// Only shows documents where expiresAt > now (active videos).
// Ordered by uploadedAt descending (newest first).

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_colors.dart';

class InsightsFeedPage extends StatefulWidget {
  const InsightsFeedPage({super.key});

  @override
  State<InsightsFeedPage> createState() => _InsightsFeedPageState();
}

class _InsightsFeedPageState extends State<InsightsFeedPage> {
  List<Map<String, dynamic>> _videos = [];
  bool _loading = true;
  String? _error;
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadVideos() async {
  try {
    final snap = await FirebaseFirestore.instance
        .collection('insights')
        .orderBy('uploadedAt', descending: true)
        .limit(20)
        .get();

    final now = Timestamp.now();
    final filtered = snap.docs
        .where((d) {
          final exp = d.data()['expiresAt'] as Timestamp?;
          return exp != null && exp.compareTo(now) > 0;
        })
        .map((d) => {'id': d.id, ...d.data()})
        .toList();

    if (!mounted) return;
    setState(() {
      _videos = filtered;
      _loading = false;
    });
  } catch (e) {
    debugPrint('Insights error: $e');
    if (!mounted) return;
    setState(() {
      _error = 'Failed to load videos: $e';
      _loading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    // Force full-screen portrait with hidden status bar for immersive feel
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.wifi_off_rounded, color: AppColors.textTertiary, size: 40),
          const SizedBox(height: 12),
          Text(_error!, style: GoogleFonts.dmSans(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          TextButton(onPressed: _loadVideos, child: const Text('Retry')),
        ]),
      );
    }

    if (_videos.isEmpty) {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('🎬', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text('No insights yet', style: GoogleFonts.dmSans(
            fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Check back soon for new content', style: GoogleFonts.dmSans(
            fontSize: 13, color: AppColors.textTertiary)),
        ]),
      );
    }

    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _videos.length,
      onPageChanged: (i) => setState(() => _currentIndex = i),
      itemBuilder: (context, i) => _VideoCard(
        video: _videos[i],
        isActive: i == _currentIndex,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Individual video card — full screen, auto-plays when active
// ─────────────────────────────────────────────────────────────────────────────
class _VideoCard extends StatefulWidget {
  final Map<String, dynamic> video;
  final bool isActive;

  const _VideoCard({required this.video, required this.isActive});

  @override
  State<_VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<_VideoCard> {
  VideoPlayerController? _controller;
  bool _initialized = false;
  bool _liked = false;
  bool _showControls = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void didUpdateWidget(_VideoCard old) {
    super.didUpdateWidget(old);
    if (widget.isActive && !old.isActive) {
      _controller?.play();
    } else if (!widget.isActive && old.isActive) {
      _controller?.pause();
    }
  }

  Future<void> _initVideo() async {
    final url = widget.video['videoUrl'] as String? ?? '';
    if (url.isEmpty) return;

    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    try {
      await controller.initialize();
      if (!mounted) {
        controller.dispose();
        return;
      }
      controller.setLooping(true);
      if (widget.isActive) controller.play();
      setState(() {
        _controller = controller;
        _initialized = true;
      });
    } catch (e) {
      controller.dispose();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller == null) return;
    setState(() => _showControls = true);
    if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
    }
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showControls = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final caption = widget.video['caption'] as String? ?? '';
    final courseTag = widget.video['courseTag'] as String? ?? '';

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(fit: StackFit.expand, children: [
        // ── Video / placeholder ───────────────────────────────────────────
        _initialized && _controller != null
            ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller!.value.size.width,
                  height: _controller!.value.size.height,
                  child: VideoPlayer(_controller!),
                ),
              )
            : Container(
                color: Colors.black,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.accent, strokeWidth: 2),
                ),
              ),

        // ── Dark gradient overlay at bottom ───────────────────────────────
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            height: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.85),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // ── Play/pause indicator ──────────────────────────────────────────
        if (_showControls)
          Center(
            child: AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _controller?.value.isPlaying == true
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),

        // ── Right side actions ────────────────────────────────────────────
        Positioned(
          right: 12,
          bottom: 120,
          child: Column(children: [
            _ActionButton(
              icon: _liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              label: '${(widget.video['likes'] as int? ?? 0) + (_liked ? 1 : 0)}',
              color: _liked ? Colors.red : Colors.white,
              onTap: () => setState(() => _liked = !_liked),
            ),
            const SizedBox(height: 20),
            _ActionButton(
              icon: Icons.share_rounded,
              label: 'Share',
              color: Colors.white,
              onTap: () {},
            ),
          ]),
        ),

        // ── Bottom info ───────────────────────────────────────────────────
        Positioned(
          left: 16, right: 80, bottom: 60,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Course tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accentSurface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.accent.withOpacity(0.5)),
              ),
              child: Text(courseTag,
                style: GoogleFonts.dmSans(
                  fontSize: 11, fontWeight: FontWeight.w500,
                  color: AppColors.accentLight)),
            ),
            const SizedBox(height: 8),
            // Caption
            Text(caption,
              style: GoogleFonts.dmSans(
                fontSize: 14, fontWeight: FontWeight.w500,
                color: Colors.white, height: 1.4),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            // Edul brand
            Row(children: [
              Container(
                width: 20, height: 20,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.school_rounded, size: 12, color: Colors.white),
              ),
              const SizedBox(width: 6),
              Text('Edul', style: GoogleFonts.dmSans(
                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
            ]),
          ]),
        ),

        // ── Progress bar ──────────────────────────────────────────────────
        if (_initialized && _controller != null)
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: VideoProgressIndicator(
              _controller!,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: AppColors.accent,
                bufferedColor: Colors.white24,
                backgroundColor: Colors.white10,
              ),
              padding: EdgeInsets.zero,
            ),
          ),

        // ── Safe area top: back label ────────────────────────────────────
        Positioned(
          top: MediaQuery.of(context).padding.top + 12,
          left: 16,
          child: Text('Insights',
            style: GoogleFonts.dmSans(
              fontSize: 16, fontWeight: FontWeight.w700,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 8, color: Colors.black54)],
            )),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable right-side action button
// ─────────────────────────────────────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon, required this.label,
    required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Icon(icon, color: color, size: 30,
          shadows: const [Shadow(blurRadius: 8, color: Colors.black54)]),
        const SizedBox(height: 3),
        Text(label, style: GoogleFonts.dmSans(
          fontSize: 11, color: Colors.white,
          shadows: const [Shadow(blurRadius: 6, color: Colors.black54)])),
      ]),
    );
  }
}