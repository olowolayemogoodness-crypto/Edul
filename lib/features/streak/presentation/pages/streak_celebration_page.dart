// lib/features/streak/presentation/pages/streak_celebration_page.dart
//
// Full-screen animated streak award screen shown immediately after a
// qualifying activity (quiz >= 80%, lesson passed). The animation
// plays automatically, lasts <= 5 seconds, then settles into a
// calm "fire on dark" state identical to the Duolingo reference
// image the user provided. Tapping anywhere returns to home;
// the share button captures the settled screen as an image and
// opens the system share sheet.
//
// Design intent (per brief):
//   - Background: bold orange burst that fades/calms to near-black
//   - Fire: 3-layer SVG-like CSS flame, colours matching 🔥 emoji
//     (deep red core → orange mid → yellow outer), glowing ring
//   - Number: flips up with a 3-D digit-flip animation
//   - Text: "day streak" below the number
//   - Max animation duration: 5 seconds
//   - After animation settles: share button + "tap to continue" hint
//   - Share: saves current visual as image, opens system share sheet
//   - Any tap (outside share button): go to /home

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class StreakCelebrationPage extends StatefulWidget {
  final int streakCount;
  const StreakCelebrationPage({super.key, required this.streakCount});

  @override
  State<StreakCelebrationPage> createState() => _StreakCelebrationPageState();
}

class _StreakCelebrationPageState extends State<StreakCelebrationPage>
    with TickerProviderStateMixin {

  // ── Animation controllers ───────────────────────────────────────
  late AnimationController _bgCtrl;     // 0→1 over 1.8s: orange burst → dark
  late AnimationController _fireCtrl;   // 0→1 over 1.2s: fire scales in
  late AnimationController _numCtrl;    // 0→1 over 0.9s: number fades/slides up
  late AnimationController _idleCtrl;   // looping: fire flicker + sway
  late AnimationController _glowCtrl;   // looping: glow pulse

  late Animation<double> _bgFade;
  late Animation<double> _fireScale;
  late Animation<double> _fireOpacity;
  late Animation<double> _numSlide;
  late Animation<double> _numOpacity;

  bool _settled = false;       // animation finished, show share/hint
  bool _sharing = false;
  int _displayCount = 0;       // the number being rendered (animates 0→N)

  final GlobalKey _captureKey = GlobalKey();
  final AudioPlayer _audioPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop);

  @override
  void initState() {
    super.initState();

    // Background: orange burst fades over 1.8s then held dark
    _bgCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    _bgFade = CurvedAnimation(parent: _bgCtrl, curve: Curves.easeIn);

    // Fire pops in with elastic bounce over 1.2s
    _fireCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _fireScale = CurvedAnimation(parent: _fireCtrl, curve: Curves.elasticOut);
    _fireOpacity = CurvedAnimation(parent: _fireCtrl, curve: const Interval(0.0, 0.4));

    // Number slides up and fades in
    _numCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _numSlide = Tween<double>(begin: 28, end: 0).animate(
        CurvedAnimation(parent: _numCtrl, curve: Curves.easeOutCubic));
    _numOpacity = CurvedAnimation(parent: _numCtrl, curve: Curves.easeOut);

    // Idle breathing loop (fire bob + sway)
    _idleCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400))
      ..repeat(reverse: true);

    // Glow pulse loop
    _glowCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))
      ..repeat(reverse: true);

    _playSequence();
  }

  Future<void> _playSequence() async {
    // t=0ms: orange background burst fires
    _bgCtrl.forward();

    // t=200ms: fire pops in + celebration sound plays together
    await Future.delayed(const Duration(milliseconds: 200));
    _fireCtrl.forward();
    try {
      await _audioPlayer.play(AssetSource('sounds/streak_celebration.mp3'));
    } catch (_) {
      // Missing asset -- never crash the animation for a missing sound
    }

    // t=900ms: count up begins
    await Future.delayed(const Duration(milliseconds: 700));
    _numCtrl.forward();
    _countUp();

    // t=5000ms: settled state
    await Future.delayed(const Duration(milliseconds: 4100));
    if (mounted) setState(() => _settled = true);
  }

  void _countUp() {
    final target = widget.streakCount;
    const duration = Duration(milliseconds: 1200);
    final startTime = DateTime.now();
    void tick() {
      if (!mounted) return;
      final elapsed = DateTime.now().difference(startTime).inMilliseconds;
      final p = (elapsed / duration.inMilliseconds).clamp(0.0, 1.0);
      final eased = 1 - math.pow(1 - p, 3).toDouble();
      final val = (eased * target).round();
      setState(() => _displayCount = val);
      if (p < 1) {
        Future.delayed(const Duration(milliseconds: 16), tick);
      } else {
        setState(() => _displayCount = target);
      }
    }
    tick();
  }

  void _goHome() {
    if (!mounted) return;
    context.go('/home');
  }

  Future<void> _share() async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      final boundary = _captureKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) { setState(() => _sharing = false); return; }
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) { setState(() => _sharing = false); return; }
      final bytes = byteData.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/edul_streak_${widget.streakCount}.png');
      await file.writeAsBytes(bytes);
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'I\'m on a ${widget.streakCount}-day study streak on Edul! 🔥',
      );
    } catch (_) {
      // share failed silently -- don't block the user
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _fireCtrl.dispose();
    _numCtrl.dispose();
    _idleCtrl.dispose();
    _glowCtrl.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        // Tap anywhere except share button → home
        onTap: _settled ? _goHome : null,
        behavior: HitTestBehavior.opaque,
        child: RepaintBoundary(
          key: _captureKey,
          child: AnimatedBuilder(
            animation: Listenable.merge([_bgCtrl, _fireCtrl, _numCtrl, _idleCtrl, _glowCtrl]),
            builder: (context, _) {
              final bgProgress = _bgFade.value;     // 0=full orange, 1=dark
              final idle = _idleCtrl.value;          // 0-1 breathing
              final glow = _glowCtrl.value;          // 0-1 glow pulse
              final fireS = _fireScale.value;
              final fireO = _fireOpacity.value;

              // Background: radial orange burst that fades to near-black
              final bgColor = Color.lerp(
                const Color(0xFFFF6A00), // vivid amber-orange
                const Color(0xFF0D0D0F), // near-black (matches app bg)
                bgProgress,
              )!;
              final burstOpacity = (1.0 - bgProgress).clamp(0.0, 1.0);

              // Fire bob and sway in idle
              final bob = math.sin(idle * math.pi) * 6.0;
              final sway = math.sin(idle * math.pi * 0.7) * 0.02;

              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, -0.1),
                    radius: 1.3,
                    colors: [
                      bgColor,
                      const Color(0xFF0D0D0F),
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    // Burst ring on impact
                    if (burstOpacity > 0.01)
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.18,
                        child: Opacity(
                          opacity: burstOpacity,
                          child: Container(
                            width: 320 * (1.0 + (1.0 - burstOpacity) * 0.6),
                            height: 320 * (1.0 + (1.0 - burstOpacity) * 0.6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  const Color(0xFFFF6A00).withOpacity(0.6),
                                  const Color(0xFFFF6A00).withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Main content column
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).padding.top + 32),

                        // ── FIRE ────────────────────────────────────
                        Transform.translate(
                          offset: Offset(0, -bob),
                          child: Transform.rotate(
                            angle: sway,
                            child: Opacity(
                              opacity: fireO.clamp(0.0, 1.0),
                              child: Transform.scale(
                                scale: fireS,
                                child: _FireWidget(
                                  glowPulse: glow,
                                  settled: _settled,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 36),

                        // ── STREAK NUMBER ───────────────────────────
                        Transform.translate(
                          offset: Offset(0, _numSlide.value),
                          child: Opacity(
                            opacity: _numOpacity.value,
                            child: ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFFFB347), Color(0xFFFF6200)],
                              ).createShader(bounds),
                              child: Text(
                                '$_displayCount',
                                style: GoogleFonts.nunito(
                                  fontSize: 96,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  height: 1.0,
                                  letterSpacing: -2,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ── LABEL ───────────────────────────────────
                        Transform.translate(
                          offset: Offset(0, _numSlide.value),
                          child: Opacity(
                            opacity: _numOpacity.value,
                            child: Text(
                              'day streak',
                              style: GoogleFonts.nunito(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFF7A3C),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        // ── SHARE + HINT ─────────────────────────────
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 600),
                          opacity: _settled ? 1.0 : 0.0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Share button
                                GestureDetector(
                                  onTap: _sharing ? null : () {
                                    // Prevent onTap of parent GestureDetector
                                    _share();
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    width: 52, height: 52,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1C1C1E),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: const Color(0xFF2C2C2E),
                                      ),
                                    ),
                                    child: _sharing
                                        ? const Center(
                                            child: SizedBox(
                                              width: 20, height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Color(0xFFFF7A3C),
                                              ),
                                            ),
                                          )
                                        : const Icon(
                                            Icons.ios_share_rounded,
                                            color: Color(0xFFAAAAAF),
                                            size: 22,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 600),
                          opacity: _settled ? 1.0 : 0.0,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).padding.bottom + 16,
                            ),
                            child: Text(
                              'Tap anywhere to continue',
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                color: const Color(0xFF6B6B74),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// 3-layer CSS-style flame widget -- matches 🔥 emoji:
//   outer: golden yellow  (#FFD60A → #FF9F0A)
//   mid:   orange-red     (#FF6D00 → #FF3B30)
//   core:  white teardrop (#FFFFFF → #FFE4B5)
// ──────────────────────────────────────────────────────────────────────
class _FireWidget extends StatelessWidget {
  final double glowPulse;
  final bool settled;
  const _FireWidget({required this.glowPulse, required this.settled});

  @override
  Widget build(BuildContext context) {
    final glowRadius = 80 + glowPulse * 24;
    final glowOpacity = settled ? (0.55 + glowPulse * 0.15) : 0.45;

    return SizedBox(
      width: 220,
      height: 240,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Radial glow behind the flame
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: glowRadius * 2,
                height: glowRadius * 1.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6A00).withOpacity(glowOpacity),
                      blurRadius: glowRadius,
                      spreadRadius: glowRadius * 0.3,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Outer flame shell (golden yellow)
          Positioned(
            bottom: 8,
            left: 30,
            right: 30,
            top: 0,
            child: CustomPaint(painter: _FlamePainter(
              colorBottom: const Color(0xFFFF9F0A),
              colorTop: const Color(0xFFFFD60A),
              widthFactor: 1.0,
            )),
          ),

          // Mid flame shell (orange-red)
          Positioned(
            bottom: 8,
            left: 52,
            right: 52,
            top: 28,
            child: CustomPaint(painter: _FlamePainter(
              colorBottom: const Color(0xFFFF3B30),
              colorTop: const Color(0xFFFF6D00),
              widthFactor: 0.82,
            )),
          ),

          // Core (white → cream)
          Positioned(
            bottom: 8,
            left: 72,
            right: 72,
            top: 72,
            child: CustomPaint(painter: _FlamePainter(
              colorBottom: const Color(0xFFFFE4B5),
              colorTop: const Color(0xFFFFFFFF),
              widthFactor: 0.55,
            )),
          ),

          // Base disc (ember platform, like reference image)
          Positioned(
            bottom: 0,
            child: Container(
              width: 120,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: const Color(0xFF3A3A2A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FlamePainter extends CustomPainter {
  final Color colorBottom;
  final Color colorTop;
  final double widthFactor;
  const _FlamePainter({
    required this.colorBottom,
    required this.colorTop,
    required this.widthFactor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [colorBottom, colorTop],
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    final path = _flamePath(size);
    canvas.drawPath(path, paint);
  }

  Path _flamePath(Size size) {
    final w = size.width;
    final h = size.height;
    // Teardrop/flame shape: wide at bottom, tapers to a point at top
    final path = Path();

    // Bottom center start
    path.moveTo(w * 0.5, h);

    // Bottom-left curve
    path.cubicTo(
      w * 0.15, h * 0.95,
      0, h * 0.7,
      w * 0.1, h * 0.45,
    );

    // Left side curving to tip
    path.cubicTo(
      w * 0.15, h * 0.25,
      w * 0.25, h * 0.1,
      w * 0.5, 0,
    );

    // Right side from tip down
    path.cubicTo(
      w * 0.75, h * 0.1,
      w * 0.85, h * 0.25,
      w * 0.9, h * 0.45,
    );

    // Bottom-right curve back
    path.cubicTo(
      w, h * 0.7,
      w * 0.85, h * 0.95,
      w * 0.5, h,
    );

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(_FlamePainter old) =>
      old.colorBottom != colorBottom ||
      old.colorTop != colorTop;
}