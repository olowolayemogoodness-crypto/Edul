// lib/features/masterclass/presentation/pages/masterclass_player_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/premium_service.dart';
import '../../../../core/utils/paywall_helper.dart';

class MasterclassPlayerPage extends StatefulWidget {
  final String videoId;
  final String title;
  final String videoUrl;
  const MasterclassPlayerPage({
    super.key, required this.videoId, required this.title, required this.videoUrl,
  });

  @override
  State<MasterclassPlayerPage> createState() => _MasterclassPlayerPageState();
}

class _MasterclassPlayerPageState extends State<MasterclassPlayerPage> {
  static const _freePreviewLimit = Duration(minutes: 3);

  VideoPlayerController? _controller;
  bool _loading = true;
  String? _error;
  bool _isPremium = false;
  bool _showPaywallOverlay = false;

  @override
  void initState() {
    super.initState();
    _isPremium = !PremiumService.isRealFree;
    _init();
  }

  Future<void> _init() async {
    try {
      final controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
      await controller.initialize();
      controller.addListener(_onTick);
      if (!mounted) { controller.dispose(); return; }
      setState(() {
        _controller = controller;
        _loading = false;
      });
      controller.play();
    } catch (e) {
      if (!mounted) return;
      setState(() { _error = 'Could not load this video: $e'; _loading = false; });
    }
  }

  void _onTick() {
    final controller = _controller;
    if (controller == null || _isPremium || _showPaywallOverlay) return;
    if (controller.value.position >= _freePreviewLimit) {
      controller.pause();
      setState(() => _showPaywallOverlay = true);
    }
  }

  Future<void> _openPaywall() async {
    final result = await showPaywall(context,
      triggerReason: 'Watch the full Masterclass — unlimited crash course videos on Plus and Pro.',
      initialTier: 1);
    if (!mounted) return;
    if (result != null) {
      // They upgraded -- unlock immediately, no restart needed.
      setState(() {
        _isPremium = true;
        _showPaywallOverlay = false;
      });
      _controller?.play();
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onTick);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white)),
              const SizedBox(width: 14),
              Expanded(child: Text(widget.title, overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))),
            ]),
          ),
          Expanded(
            child: Center(
              child: _loading
                  ? CircularProgressIndicator(color: AppColors.accent)
                  : _error != null
                      ? Padding(padding: const EdgeInsets.all(24), child: Text(_error!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white70)))
                      : Stack(alignment: Alignment.center, children: [
                          AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          ),
                          if (!_isPremium)
                            Positioned(
                              bottom: 12, left: 12, right: 12,
                              child: LinearProgressIndicator(
                                value: (_controller!.value.position.inMilliseconds /
                                    _freePreviewLimit.inMilliseconds).clamp(0.0, 1.0),
                                minHeight: 3,
                                backgroundColor: Colors.white24,
                                valueColor: AlwaysStoppedAnimation(AppColors.accent),
                              ),
                            ),
                          if (_showPaywallOverlay)
                            Container(
                              color: Colors.black87,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                const Icon(Icons.lock_rounded, color: Colors.white, size: 40),
                                const SizedBox(height: 14),
                                Text('Free preview ended', style: GoogleFonts.dmSans(
                                  fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white)),
                                const SizedBox(height: 6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: Text('Upgrade to Plus or Pro to keep watching this Masterclass, ad-free.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white70)),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: _openPaywall,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent,
                                      borderRadius: BorderRadius.circular(24)),
                                    child: Text('Continue watching', style: GoogleFonts.dmSans(
                                      fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                                  ),
                                ),
                              ]),
                            )
                          else
                            GestureDetector(
                              onTap: () => setState(() =>
                                _controller!.value.isPlaying ? _controller!.pause() : _controller!.play()),
                              child: AnimatedOpacity(
                                opacity: _controller!.value.isPlaying ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                child: const Icon(Icons.play_circle_fill_rounded,
                                  color: Colors.white70, size: 64),
                              ),
                            ),
                        ]),
            ),
          ),
        ]),
      ),
    );
  }
}