// lib/features/insights/presentation/pages/insights_feed_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/insights_interaction_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/insights_ad_service.dart';
import '../../../../core/services/premium_service.dart';

class InsightsFeedPage extends StatefulWidget {
  final bool isVisible;
  const InsightsFeedPage({super.key, this.isVisible = false});

  @override
  State<InsightsFeedPage> createState() => _InsightsFeedPageState();
}

class _InsightsFeedPageState extends State<InsightsFeedPage> {
  List<Map<String, dynamic>> _videos = [];
  List<Map<String, dynamic>> _allVideos = [];
  Set<String> _seenIds = {};
  int _videosSinceLastAd = 0;
  bool _loading = true;
  String? _error;
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  String _selectedChannel = 'All';

  static const List<String> _channels = [
    'All',
    '🧠 Brain Bites', '🌍 World Explained', '🏛 History Stories',
    '⚙️ How It Works', '🔬 Science in 60', '🧬 Human Body',
    '🧠 Psychology Lab', '📚 Study Smarter', '🚀 Space Scroll',
    '🤖 AI & Future', '💰 Money Minute', '💼 Career Compass',
    '📖 Book Sparks', '🎬 Screen Science', '🌱 Nature Files',
    '🔍 Mystery Vault', '⚖️ Law Made Easy', '🌐 Internet Culture',
  ];

  @override
  void initState() {
    super.initState();
    _loadVideos();
    if (PremiumService.isRealFree) InsightsAdService.preload();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadVideos() async {
    try {
      final now = Timestamp.now();
      final snap = await FirebaseFirestore.instance
          .collection('insights')
          .orderBy('uploadedAt', descending: true)
          .limit(50)
          .get();
      final filtered = snap.docs
          .where((d) {
            final exp = d.data()['expiresAt'] as Timestamp?;
            return exp != null && exp.compareTo(now) > 0;
          })
          .map((d) => {'id': d.id, ...d.data()})
          .toList();

      // Fetch which of these the user has already watched, so the feed
      // can always surface unseen content first — otherwise every app
      // open would start from whatever's newest, mixing in videos the
      // user already sat through in a previous session.
      final uid = UserService.uid;
      Set<String> seenIds = {};
      if (uid != null) {
        try {
          final seenSnap = await FirebaseFirestore.instance
              .collection('users').doc(uid).collection('seenInsights').get();
          seenIds = seenSnap.docs.map((d) => d.id).toSet();
        } catch (_) {
          // Best-effort — if this fails, just fall back to normal order.
        }
      }

      final unseen = filtered.where((v) => !seenIds.contains(v['id'])).toList();
      final seen = filtered.where((v) => seenIds.contains(v['id'])).toList();
      final ordered = [...unseen, ...seen];

      if (!mounted) return;
      setState(() {
        _seenIds = seenIds;
        _allVideos = ordered;
        _videos = ordered;
        _loading = false;
      });
      if (ordered.isNotEmpty) _markSeen(ordered[0]['id'] as String);
    } catch (e) {
      debugPrint('Insights error: $e');
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load videos: $e';
        _loading = false;
      });
    }
  }

  void _markSeen(String videoId) {
    if (_seenIds.contains(videoId)) return;
    final uid = UserService.uid;
    if (uid == null) return;
    _seenIds.add(videoId); // update locally right away, no need to wait
    FirebaseFirestore.instance
        .collection('users').doc(uid).collection('seenInsights').doc(videoId)
        .set({'seenAt': FieldValue.serverTimestamp()})
        .catchError((_) {}); // best-effort, never block playback on this
  }

  void _filterByChannel(String channel) {
    setState(() {
      _selectedChannel = channel;
      _currentIndex = 0;
      _videos = channel == 'All'
          ? _allVideos
          : _allVideos.where((v) =>
              (v['channel'] ?? v['courseTag'] ?? '') == channel).toList();
    });
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
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
      return Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.wifi_off_rounded, color: AppColors.textTertiary, size: 40),
          const SizedBox(height: 12),
          Text(_error!, style: GoogleFonts.dmSans(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          TextButton(onPressed: _loadVideos, child: const Text('Retry')),
        ]),
      );
    }

    return Stack(children: [
      PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _videos.isEmpty ? 1 : _videos.length,
        onPageChanged: (i) {
          setState(() => _currentIndex = i);
          if (i < _videos.length) _markSeen(_videos[i]['id'] as String);
          if (PremiumService.isRealFree) {
            _videosSinceLastAd++;
            if (_videosSinceLastAd >= 5) {
              _videosSinceLastAd = 0;
              InsightsAdService.showIfReady();
            }
          }
        },
        itemBuilder: (context, i) {
          if (_videos.isEmpty) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('🎬', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 16),
                Text('No videos in this channel yet',
                  style: GoogleFonts.dmSans(
                    fontSize: 16, fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Text('Check back soon',
                  style: GoogleFonts.dmSans(
                    fontSize: 13, color: AppColors.textTertiary)),
              ]),
            );
          }
          return _VideoCard(
            key: ValueKey(_videos[i]['id']),
            video: _videos[i],
            isActive: i == _currentIndex && widget.isVisible,
          );
        },
      ),

      // ── Channel filter bar ──────────────────────────────────────────────
      Positioned(
        top: MediaQuery.of(context).padding.top + 44,
        left: 0, right: 0,
        child: _ChannelFilterBar(
          channels: _channels,
          selected: _selectedChannel,
          onSelect: _filterByChannel,
        ),
      ),

      // Notifications bell moved to the Profile page, beside Settings.
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Channel filter bar
// ─────────────────────────────────────────────────────────────────────────────
class _ChannelFilterBar extends StatelessWidget {
  final List<String> channels;
  final String selected;
  final ValueChanged<String> onSelect;

  const _ChannelFilterBar({
    required this.channels,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: channels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final ch = channels[i];
          final isSelected = ch == selected;
          return GestureDetector(
            onTap: () => onSelect(ch),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accent : Colors.white12,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.accent : Colors.white24,
                ),
              ),
              child: Text(ch,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: Colors.white,
                )),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Individual video card
// ─────────────────────────────────────────────────────────────────────────────
class _VideoCard extends StatefulWidget {
  final Map<String, dynamic> video;
  final bool isActive;

  const _VideoCard({super.key, required this.video, required this.isActive});

  @override
  State<_VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<_VideoCard> {
  VideoPlayerController? _controller;
  bool _initialized = false;
  bool _showControls = false;
  bool _quizShown = false;

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
      if (!mounted) { controller.dispose(); return; }
      controller.setLooping(false);
      controller.addListener(() {
        if (!mounted) return;
        final pos = controller.value.position;
        final dur = controller.value.duration;
        if (dur.inSeconds > 0 && pos >= dur && !_quizShown) {
          _quizShown = true;
          _showQuizOverlay();
        }
      });
      if (widget.isActive) controller.play();
      setState(() { _controller = controller; _initialized = true; });
    } catch (e) {
      controller.dispose();
    }
  }

  void _showQuizOverlay() {
    final questions = (widget.video['questions'] as List<dynamic>?) ?? [];
    if (questions.isEmpty) return;
    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _QuizOverlay(questions: questions),
    );
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
    final channel = widget.video['channel'] as String?
        ?? widget.video['courseTag'] as String? ?? '';

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(fit: StackFit.expand, children: [
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
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.accent, strokeWidth: 2)),
              ),

        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            height: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.85), Colors.transparent],
              ),
            ),
          ),
        ),

        if (_showControls)
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _controller?.value.isPlaying == true
                    ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: Colors.white, size: 40,
              ),
            ),
          ),

        Positioned(
          right: 12, bottom: 120,
          child: Column(children: [
            Builder(builder: (context) {
              final videoId = widget.video['id'] as String? ?? '';
              return StreamBuilder<bool>(
                stream: InsightsInteractionService.isLikedByMe(videoId),
                builder: (context, likedSnap) {
                  final liked = likedSnap.data ?? false;
                  return StreamBuilder<int>(
                    stream: InsightsInteractionService.likeCount(videoId),
                    builder: (context, countSnap) => _ActionButton(
                      icon: liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      label: '${countSnap.data ?? 0}',
                      color: liked ? Colors.red : Colors.white,
                      onTap: () => InsightsInteractionService.toggleLike(videoId),
                    ),
                  );
                },
              );
            }),
            const SizedBox(height: 20),
            _ActionButton(
              icon: Icons.share_rounded, label: 'Share',
              color: Colors.white, onTap: () {},
            ),
          ]),
        ),

        Positioned(
          left: 16, right: 80, bottom: 60,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (channel.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.accent.withOpacity(0.5)),
                ),
                child: Text(channel,
                  style: GoogleFonts.dmSans(
                    fontSize: 11, fontWeight: FontWeight.w500,
                    color: AppColors.accentLight)),
              ),
            const SizedBox(height: 8),
            Text(caption,
              style: GoogleFonts.dmSans(
                fontSize: 14, fontWeight: FontWeight.w500,
                color: Colors.white, height: 1.4),
              maxLines: 3, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
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

        Positioned(
          top: MediaQuery.of(context).padding.top + 12,
          left: 16,
          child: Text('Insights',
            style: GoogleFonts.dmSans(
              fontSize: 16, fontWeight: FontWeight.w700,
              color: Colors.white,
              shadows: [const Shadow(blurRadius: 8, color: Colors.black54)],
            )),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Post-video quiz overlay
// ─────────────────────────────────────────────────────────────────────────────
class _QuizOverlay extends StatefulWidget {
  final List<dynamic> questions;
  const _QuizOverlay({required this.questions});

  @override
  State<_QuizOverlay> createState() => _QuizOverlayState();
}

class _QuizOverlayState extends State<_QuizOverlay> {
  int _current = 0;
  int? _selected;
  int _correct = 0;

  @override
  Widget build(BuildContext context) {
    // Results screen
    if (_current >= widget.questions.length) {
      return Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('🎯', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text('$_correct / ${widget.questions.length} correct',
            style: GoogleFonts.dmSans(fontSize: 22, fontWeight: FontWeight.w700,
              color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text(
            _correct == widget.questions.length ? 'Perfect! 🔥' :
            _correct >= widget.questions.length ~/ 2 ? 'Good job! 👍' : 'Keep practising! 💪',
            style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              ),
              child: Text('Continue', style: GoogleFonts.dmSans(
                fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
            )),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ]),
      );
    }

    final q = widget.questions[_current] as Map<String, dynamic>;
    final question = q['question'] as String? ?? '';
    final options = (q['options'] as List<dynamic>?)
        ?.map((e) => e.toString()).toList() ?? [];
    final correct = q['correct'] as int? ?? 0;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text('Question ${_current + 1} of ${widget.questions.length}',
            style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Skip', style: GoogleFonts.dmSans(
              fontSize: 12, color: AppColors.textTertiary))),
        ]),
        const SizedBox(height: 12),
        Text(question, style: GoogleFonts.dmSans(
          fontSize: 15, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary, height: 1.4)),
        const SizedBox(height: 16),
        ...List.generate(options.length, (i) {
          Color bg = const Color(0xFF0D0D0F);
          Color border = AppColors.border;
          if (_selected != null) {
            if (i == correct) {
              bg = AppColors.successSurface;
              border = AppColors.success;
            } else if (i == _selected) {
              bg = AppColors.errorSurface;
              border = AppColors.error;
            }
          }
          return GestureDetector(
            onTap: _selected != null ? null : () {
              setState(() {
                _selected = i;
                if (i == correct) _correct++;
              });
              Future.delayed(const Duration(milliseconds: 1200), () {
                if (mounted) setState(() { _current++; _selected = null; });
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: bg,
                border: Border.all(color: border),
                borderRadius: BorderRadius.circular(12)),
              child: Text(options[i], style: GoogleFonts.dmSans(
                fontSize: 14, color: AppColors.textPrimary)),
            ),
          );
        }),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Action button
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