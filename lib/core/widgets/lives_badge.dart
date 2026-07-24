// lib/core/widgets/lives_badge.dart
//
// Shared hearts/lives display -- shows the real, persistent life
// count (from LivesService) plus a live-ticking countdown to the
// next regeneration, and a "watch ad to refill" button. Used on both
// the home screen top bar and the quiz screen, so they always show
// the exact same number (single source of truth, no risk of drift).
//
// ⚠️ The ad-refill button is intentionally DISABLED for now -- no ad
// SDK is wired into this app yet. Wire it up by removing the
// `onPressed: null` once LivesService.refillOneLifeViaAd() is called
// from behind a real rewarded-ad flow instead of directly.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../services/lives_service.dart';

class LivesBadge extends StatefulWidget {
  /// Compact mode drops the countdown/ad-button and just shows
  /// hearts + count, for tight spaces like the home top bar.
  final bool compact;
  const LivesBadge({super.key, this.compact = false});

  @override
  State<LivesBadge> createState() => _LivesBadgeState();
}

class _LivesBadgeState extends State<LivesBadge> {
  int _lives = LivesService.maxLives;
  Duration? _timeUntilNext;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _refresh();
    // Re-check every second so the countdown visibly ticks down and
    // lives update the moment a regen completes, without needing a
    // stream/background service.
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _refresh());
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _refresh() async {
    final lives = await LivesService.getCurrentLives();
    final remaining = await LivesService.getTimeUntilNextLife();
    if (!mounted) return;
    setState(() {
      _lives = lives;
      _timeUntilNext = remaining;
    });
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final hearts = Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(LivesService.maxLives, (i) => Padding(
        padding: const EdgeInsets.only(left: 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: i < _lives ? 1.0 : 0.25,
          child: Text('❤️', style: TextStyle(fontSize: widget.compact ? 13 : 16)),
        ),
      )),
    );

    if (widget.compact) {
      return hearts;
    }

    return Row(mainAxisSize: MainAxisSize.min, children: [
      hearts,
      const SizedBox(width: 6),
      Text('$_lives lives', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
      if (_timeUntilNext != null) ...[
        const SizedBox(width: 8),
        Text('· next in ${_formatDuration(_timeUntilNext!)}',
            style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
      ],
      const SizedBox(width: 8),
      // Ad-refill button -- disabled until a real ad SDK is wired up.
      // See LivesService.refillOneLifeViaAd() for the placeholder it
      // would call once ads are integrated.
      Opacity(
        opacity: 0.4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.play_circle_outline, size: 12, color: AppColors.textDisabled),
            const SizedBox(width: 3),
            Text('Watch ad', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textDisabled)),
          ]),
        ),
      ),
    ]);
  }
}