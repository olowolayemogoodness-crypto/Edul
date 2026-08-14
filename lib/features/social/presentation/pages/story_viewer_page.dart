// lib/features/social/presentation/pages/story_viewer_page.dart
//
// The piece that was explicitly deferred earlier: tapping a story
// actually opens and plays it now. Handles all three story types
// (image, video, text) in one sequence for a given user, Instagram-
// style segmented progress bar at top, tap-right/tap-left to
// advance/go back, marks each story watched as it's viewed, and fires
// an interstitial every 2nd story -- a plain session counter (resets
// every time this screen opens fresh), not the persisted kind used
// for the main video feed.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/services/story_service.dart';
import '../../../../core/services/interstitial_ad_service.dart';
import '../../../../core/widgets/voice_note_bubble.dart'; // voiceNoteColor -- same per-user color law

class StoryViewerPage extends StatefulWidget {
  final String uid;
  const StoryViewerPage({super.key, required this.uid});

  @override
  State<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends State<StoryViewerPage> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> _stories = [];
  int _index = 0;
  bool _loading = true;
  late AnimationController _progressController;
  VideoPlayerController? _videoController;
  StreamSubscription? _storiesSub;

  // Session-only counter -- resets every time this screen opens fresh,
  // per the explicit decision made earlier (not the persisted kind).
  int _watchedThisSession = 0;

  static const _imageDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _advance();
      });
    _storiesSub = StoryService.storiesForUser(widget.uid).listen((stories) {
      if (!mounted) return;
      final wasEmpty = _stories.isEmpty;
      setState(() { _stories = stories; _loading = false; });
      if (wasEmpty && stories.isNotEmpty) _playCurrent();
    });
  }

  @override
  void dispose() {
    _storiesSub?.cancel();
    _progressController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _playCurrent() async {
    if (_index >= _stories.length) {
      if (mounted) Navigator.of(context).maybePop();
      return;
    }
    final story = _stories[_index];
    final type = story['type'] as String? ?? 'text';

    await StoryService.markWatched(story['id'] as String, widget.uid);
    _watchedThisSession++;
    if (_watchedThisSession % 2 == 0) {
      InterstitialAdService.showIfReady();
    }

    _videoController?.dispose();
    _videoController = null;
    _progressController.reset();

    if (type == 'video') {
      final url = story['mediaUrl'] as String?;
      if (url == null) { _advance(); return; }
      final controller = VideoPlayerController.networkUrl(Uri.parse(url));
      try {
        await controller.initialize();
        if (!mounted) return;
        setState(() => _videoController = controller);
        controller.play();
        _progressController.duration = controller.value.duration;
        _progressController.forward();
      } catch (_) {
        _advance();
      }
    } else {
      // Image and text stories both use the same fixed duration.
      _progressController.duration = _imageDuration;
      _progressController.forward();
    }
  }

  void _advance() {
    if (_index < _stories.length - 1) {
      setState(() => _index++);
      _playCurrent();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _goBack() {
    if (_index > 0) {
      setState(() => _index--);
      _playCurrent();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator(color: Colors.white)));
    }
    if (_stories.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: Text('No active stories', style: GoogleFonts.dmSans(color: Colors.white70))),
      );
    }

    final story = _stories[_index];
    final type = story['type'] as String? ?? 'text';
    final ringColor = voiceNoteColor(widget.uid); // same per-user color law as voice notes

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(fit: StackFit.expand, children: [
        _buildContent(story, type, ringColor),

        // Tap zones -- left third goes back, right two-thirds advances.
        Row(children: [
          Expanded(flex: 1, child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: _goBack)),
          Expanded(flex: 2, child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: _advance)),
        ]),

        // Segmented progress bar, Instagram-style.
        Positioned(
          top: 8, left: 8, right: 8,
          child: SafeArea(
            bottom: false,
            child: Row(children: List.generate(_stories.length, (i) => Expanded(
              child: Container(
                height: 3,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
                child: AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, _) => FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: i < _index ? 1.0 : (i == _index ? _progressController.value : 0.0),
                    child: Container(decoration: BoxDecoration(color: ringColor, borderRadius: BorderRadius.circular(2))),
                  ),
                ),
              ),
            ))),
          ),
        ),

        Positioned(
          top: 20, left: 12,
          child: SafeArea(
            bottom: false,
            child: Row(children: [
              CircleAvatar(radius: 15, backgroundColor: ringColor,
                child: Text((story['displayName'] as String? ?? 'U')[0].toUpperCase(),
                  style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white))),
              const SizedBox(width: 8),
              Text(
                (story['usernameDisplay'] as String?)?.isNotEmpty == true
                    ? '@${story['usernameDisplay']}' : (story['displayName'] as String? ?? 'User'),
                style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ]),
          ),
        ),

        Positioned(
          top: 20, right: 12,
          child: SafeArea(
            bottom: false,
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(width: 32, height: 32,
                decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
                child: const Icon(Icons.close_rounded, color: Colors.white, size: 18)),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildContent(Map<String, dynamic> story, String type, Color ringColor) {
    switch (type) {
      case 'image':
        final url = story['mediaUrl'] as String?;
        if (url == null) return const SizedBox.shrink();
        return Image.network(url, fit: BoxFit.contain, width: double.infinity, height: double.infinity,
          errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image_outlined, color: Colors.white38, size: 48)));
      case 'video':
        if (_videoController == null || !_videoController!.value.isInitialized) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }
        return Center(
          child: AspectRatio(aspectRatio: _videoController!.value.aspectRatio, child: VideoPlayer(_videoController!)),
        );
      case 'text':
      default:
        // Same Substack-style editorial treatment as the compose
        // screen -- cream background, serif type, not a bold gradient.
        return Container(
          color: const Color(0xFFFBF8F3),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 100),
          child: Center(
            child: Text(
              story['textContent'] as String? ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.ptSerif(fontSize: 24, height: 1.5, color: const Color(0xFF1A1815)),
            ),
          ),
        );
    }
  }
}