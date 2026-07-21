import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class StreakCardWidget extends StatefulWidget {
  final int currentStreak;
  final int longestStreak;
  const StreakCardWidget({
    super.key,
    this.currentStreak = 0,
    this.longestStreak = 0,
  });

  @override
  State<StreakCardWidget> createState() => _State();
}

class _State extends State<StreakCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale, _rotate;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.14).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _rotate = Tween<double>(begin: -0.07, end: 0.07).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final streak = widget.currentStreak;
    final longest = widget.longestStreak;
    final title = streak > 0 ? '$streak-day streak!' : 'No streak yet';
    final subtitle = streak > 0
        ? (longest > streak
            ? 'Best ever: $longest days — keep going'
            : "That's your best streak yet 🎉")
        : 'Complete a quiz or lesson today to start one';

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: const Color(0xFF1A1A18), borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        AnimatedBuilder(animation: _ctrl,
            builder: (_, child) => Transform.rotate(angle: _rotate.value,
                child: Transform.scale(scale: _scale.value, child: child)),
            child: Text(streak > 0 ? '🔥' : '⚪', style: const TextStyle(fontSize: 32))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: GoogleFonts.dmSans(
            fontSize: 18, fontWeight: FontWeight.w500,
            color: streak > 0 ? const Color(0xFFD85A30) : AppColors.textTertiary)),
          Text(subtitle, style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
        ])),
      ]),
    );
  }
}