// lib/core/widgets/voice_note_bubble.dart
//
// The established pattern: 40 colors evenly spaced around the hue
// wheel, picked deterministically by hashing an ID -- the SAME voice
// note always renders the same color, different voice notes get
// different colors. Extracted from social_feed_page.dart's private
// implementation so group posts/comments (and anywhere else) can
// reuse the exact same widget instead of a second, drifting copy.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

final List<Color> voiceNoteColorPalette = List.generate(40, (i) {
  final hue = (i * 360 / 40) % 360;
  return HSLColor.fromAHSL(1.0, hue, 0.62, 0.55).toColor();
});

Color voiceNoteColor(String seed) =>
    voiceNoteColorPalette[seed.hashCode.abs() % voiceNoteColorPalette.length];

String fmtVoiceDuration(Duration d) {
  final m = d.inMinutes;
  final s = d.inSeconds % 60;
  return '$m:${s.toString().padLeft(2, '0')}';
}

class VoiceNoteBubble extends StatefulWidget {
  final String id; // used as the color seed -- pass commentId/postId
  final String audioUrl;
  final int durationMs;
  final List<double> waveform;

  const VoiceNoteBubble({
    super.key,
    required this.id,
    required this.audioUrl,
    required this.durationMs,
    required this.waveform,
  });

  @override
  State<VoiceNoteBubble> createState() => _VoiceNoteBubbleState();
}

class _VoiceNoteBubbleState extends State<VoiceNoteBubble> {
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

  @override
  Widget build(BuildContext context) {
    final color = voiceNoteColor(widget.id);
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
        Text(fmtVoiceDuration(displayDuration),
          style: GoogleFonts.dmSans(fontSize: 10, color: color)),
      ]),
    );
  }
}