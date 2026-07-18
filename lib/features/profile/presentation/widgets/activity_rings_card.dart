import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class ActivityRingsCard extends StatefulWidget {
  final int studyMinutes;
  final int tasksCompleted;
  final int quizCorrect;
  final int quizTotal;
  final int peakHour;

  const ActivityRingsCard({
    super.key,
    this.studyMinutes = 0,
    this.tasksCompleted = 0,
    this.quizCorrect = 0,
    this.quizTotal = 0,
    this.peakHour = 0,
  });

  @override
  State<ActivityRingsCard> createState() => _State();
}

class _State extends State<ActivityRingsCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  // Goals
  static const int _studyGoalMinutes = 240; // 4h goal
  static const int _taskGoal = 10;

  double get _studyPct => (_studyGoalMinutes > 0
      ? (widget.studyMinutes / _studyGoalMinutes).clamp(0.0, 1.0)
      : 0.0);

  double get _taskPct => (_taskGoal > 0
      ? (widget.tasksCompleted / _taskGoal).clamp(0.0, 1.0)
      : 0.0);

  double get _quizPct => (widget.quizTotal > 0
      ? (widget.quizCorrect / widget.quizTotal).clamp(0.0, 1.0)
      : 0.0);

  int get _overallPct =>
      (((_studyPct + _taskPct + _quizPct) / 3) * 100).round();

  String get _studyTimeLabel {
    final h = widget.studyMinutes ~/ 60;
    final m = widget.studyMinutes % 60;
    if (h > 0) return '${h}h ${m}m / 4h goal';
    return '${m}m / 4h goal';
  }

  String get _quizLabel {
    if (widget.quizTotal == 0) return 'No quizzes yet';
    final pct = (_quizPct * 100).round();
    return '$pct% accuracy';
  }

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _anim.addListener(() => setState(() {}));
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void didUpdateWidget(ActivityRingsCard old) {
    super.didUpdateWidget(old);
    // Re-animate when data changes
    if (old.studyMinutes != widget.studyMinutes ||
        old.tasksCompleted != widget.tasksCompleted ||
        old.quizCorrect != widget.quizCorrect) {
      _ctrl.reset();
      _ctrl.forward();
    }
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final r1 = _anim.value * _studyPct;
    final r2 = _anim.value * _taskPct;
    final r3 = _anim.value * _quizPct;
    final displayPct = (_anim.value * _overallPct).round();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A18),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(children: [
        SizedBox(width: 110, height: 110,
          child: Stack(alignment: Alignment.center, children: [
            CustomPaint(
              size: const Size(110, 110),
              painter: _RingsPainter(r1: r1, r2: r2, r3: r3),
            ),
            Column(mainAxisSize: MainAxisSize.min, children: [
              Text('$displayPct%', style: GoogleFonts.dmSans(
                fontSize: 22, fontWeight: FontWeight.w500,
                color: AppColors.textPrimary, height: 1)),
              Text('today', style: GoogleFonts.dmSans(
                fontSize: 9, color: AppColors.textTertiary)),
            ]),
          ]),
        ),
        const SizedBox(width: 16),
        Expanded(child: Column(children: [
          _LegRow(
            color: const Color(0xFF534AB7),
            name: 'Study time',
            value: _studyTimeLabel,
            p: r1,
          ),
          const SizedBox(height: 8),
          _LegRow(
            color: const Color(0xFF1D9E75),
            name: 'Tasks done',
            value: '${widget.tasksCompleted} / $_taskGoal today',
            p: r2,
          ),
          const SizedBox(height: 8),
          _LegRow(
            color: const Color(0xFFBA7517),
            name: 'Quiz accuracy',
            value: _quizLabel,
            p: r3,
          ),
        ])),
      ]),
    );
  }
}

class _LegRow extends StatelessWidget {
  final Color color;
  final String name, value;
  final double p;

  const _LegRow({
    required this.color, required this.name,
    required this.value, required this.p,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 8, height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 8),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: GoogleFonts.dmSans(
          fontSize: 11, fontWeight: FontWeight.w500,
          color: const Color(0xFFCCCCCC))),
        Text(value, style: GoogleFonts.dmSans(
          fontSize: 10, color: AppColors.textTertiary)),
        const SizedBox(height: 3),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: p, minHeight: 3,
            backgroundColor: const Color(0xFF222222),
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ])),
    ]);
  }
}

class _RingsPainter extends CustomPainter {
  final double r1, r2, r3;
  _RingsPainter({required this.r1, required this.r2, required this.r3});

  void _ring(Canvas c, Size s, double radius, double sw,
      Color track, Color fill, double p) {
    final center = Offset(s.width / 2, s.height / 2);
    c.drawCircle(center, radius,
      Paint()..style = PaintingStyle.stroke..strokeWidth = sw..color = track);
    if (p > 0) {
      c.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, 2 * math.pi * p, false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = sw
          ..color = fill
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _ring(canvas, size, 50, 8, const Color(0xFF2A2A35), const Color(0xFF534AB7), r1);
    _ring(canvas, size, 38, 8, const Color(0xFF1A2A22), const Color(0xFF1D9E75), r2);
    _ring(canvas, size, 26, 8, const Color(0xFF2A2010), const Color(0xFFBA7517), r3);
  }

  @override
  bool shouldRepaint(_RingsPainter old) =>
      old.r1 != r1 || old.r2 != r2 || old.r3 != r3;
}