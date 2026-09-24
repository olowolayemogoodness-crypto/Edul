// lib/features/streak/presentation/pages/streak_celebration_page.dart
//
// Deliberately simple: a fire emoji on a burnt-orange background,
// shows the streak count, fades in and back out on its own after a
// few seconds -- no tap required, no elaborate physics/idle animation,
// no sound, no share button. Replaces an earlier version with a
// custom-painted 3-layer flame, digit-flip counting, and idle
// breathing/glow effects that read as too "childish" for what should
// be a quick, confident acknowledgment, not a mini show.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class StreakCelebrationPage extends StatefulWidget {
  final int streakCount;
  const StreakCelebrationPage({super.key, required this.streakCount});

  @override
  State<StreakCelebrationPage> createState() => _StreakCelebrationPageState();
}

class _StreakCelebrationPageState extends State<StreakCelebrationPage> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) setState(() => _opacity = 1.0);
    });
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) setState(() => _opacity = 0.0);
    });
    Future.delayed(const Duration(milliseconds: 2700), () {
      if (mounted) context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB33A0E),
      body: GestureDetector(
        onTap: () => context.go('/home'),
        behavior: HitTestBehavior.opaque,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: _opacity,
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('🔥', style: TextStyle(fontSize: 96)),
              const SizedBox(height: 16),
              Text('${widget.streakCount}',
                style: GoogleFonts.dmSans(
                  fontSize: 48, fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 4),
              Text('day streak',
                style: GoogleFonts.dmSans(
                  fontSize: 15, color: Colors.white.withValues(alpha: 0.85))),
            ]),
          ),
        ),
      ),
    );
  }
}