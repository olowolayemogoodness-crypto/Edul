// lib/features/social/presentation/pages/post_composer_page.dart

import 'dart:io';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/premium_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/utils/paywall_helper.dart';

class PostComposerPage extends StatefulWidget {
  const PostComposerPage({super.key});

  @override
  State<PostComposerPage> createState() => _PostComposerPageState();
}

class _PostComposerPageState extends State<PostComposerPage> {
  final _textCtrl = TextEditingController();
  final _picker = ImagePicker();
  final List<File> _images = [];
  String _feedTarget = 'global';
  bool _posting = false;
  String _university = 'My Uni';

  static const int _maxChars = 500;
  int get _maxImages => PremiumService.isPro ? 5 : 3;
  bool get _canPost => _textCtrl.text.trim().isNotEmpty && !_posting;

  @override
  void initState() {
    super.initState();
    _loadUniversity();
    _textCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadUniversity() async {
    final prefs = await SharedPreferences.getInstance();
    final uni = prefs.getString('user_university') ?? 'My Uni';
    if (mounted) setState(() => _university = uni);
  }

  Future<void> _pickImage() async {
    if (PremiumService.isFree) {
      showPaywall(context,
        triggerReason: 'Image posts are available on Plus and Pro.',
        initialTier: 1);
      return;
    }
    if (_images.length >= _maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Maximum $_maxImages images on your plan',
          style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating));
      return;
    }
    final picked = await _picker.pickImage(
      source: ImageSource.gallery, imageQuality: 80, maxWidth: 1080);
    if (picked != null && mounted) {
      setState(() => _images.add(File(picked.path)));
    }
  }

  Future<void> _post() async {
    if (!_canPost) return;
    setState(() => _posting = true);
    HapticFeedback.lightImpact();
    try {
      final uid = UserService.uid;
      if (uid == null) throw Exception('Not logged in');
      final profile = await UserService.getProfile();
      final displayName = profile?['displayName'] as String? ?? 'User';
      final uni = profile?['university'] as String? ?? _university;
      await FirebaseFirestore.instance.collection('posts').add({
        'uid': uid,
        'displayName': displayName,
        'university': uni,
        'content': _textCtrl.text.trim(),
        'imageUrls': <String>[],
        'feedTarget': _feedTarget,
        'likes': 0, 'comments': 0, 'reposts': 0, 'views': 0,
        'verified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to post: $e',
          style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating));
    } finally {
      if (mounted) setState(() => _posting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final charCount = _textCtrl.text.length;
    final charColor = charCount > _maxChars * 0.9
        ? AppColors.error : Colors.white38;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Stack(fit: StackFit.expand, children: [
        // ── Galaxy background ─────────────────────────────────────────────
        const _GalaxyBackground(),

        // ── Content ───────────────────────────────────────────────────────
        SafeArea(
          child: Column(children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24)),
                    child: const Icon(Icons.close_rounded,
                      color: Colors.white70, size: 18)),
                ),
                const Spacer(),
                // Feed target pills
                _TargetPill(
                  label: '🌍 Global',
                  selected: _feedTarget == 'global',
                  onTap: () => setState(() => _feedTarget = 'global')),
                const SizedBox(width: 6),
                _TargetPill(
                  label: '🏛 ${_university.length > 6 ? _university.substring(0, 6) : _university}',
                  selected: _feedTarget == 'uni',
                  onTap: () => setState(() => _feedTarget = 'uni')),
                const Spacer(),
                // Post button
                GestureDetector(
                  onTap: _canPost ? _post : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: _canPost
                          ? AppColors.accent
                          : Colors.white12,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _canPost
                            ? AppColors.accent : Colors.white24),
                    ),
                    child: _posting
                        ? const SizedBox(width: 14, height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                        : Text('Post', style: GoogleFonts.dmSans(
                            fontSize: 13, fontWeight: FontWeight.w600,
                            color: _canPost
                                ? Colors.white : Colors.white38)),
                  ),
                ),
              ]),
            ),

            const SizedBox(height: 16),

            // Images area (top)
            if (_images.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: SizedBox(
                  height: _images.length == 1 ? 200 : 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) => Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.file(_images[i],
                          width: _images.length == 1 ? double.infinity : 120,
                          height: _images.length == 1 ? 200 : 120,
                          fit: BoxFit.cover)),
                      Positioned(top: 6, right: 6,
                        child: GestureDetector(
                          onTap: () => setState(() => _images.removeAt(i)),
                          child: Container(
                            width: 24, height: 24,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              shape: BoxShape.circle),
                            child: const Icon(Icons.close_rounded,
                              size: 13, color: Colors.white)))),
                    ]),
                  ),
                ),
              ),

            // Spacer pushes input to bottom
            const Spacer(),

            // Hint text when empty
            if (_textCtrl.text.isEmpty && _images.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Text('Share what\'s on your mind',
                    style: GoogleFonts.dmSans(
                      fontSize: 20, fontWeight: FontWeight.w300,
                      color: Colors.white38),
                    textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text('Your post will reach students across Edulink',
                    style: GoogleFonts.dmSans(
                      fontSize: 13, color: Colors.white24),
                    textAlign: TextAlign.center),
                ]),
              ),

            const Spacer(),

            // Bottom composer bar
            AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.only(bottom: bottomInset),
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.15),
                      blurRadius: 20, spreadRadius: 2),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  // Camera/image button
                  GestureDetector(
                    onTap: _pickImage,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 22,
                        color: PremiumService.isFree
                            ? Colors.white24 : Colors.white60),
                    ),
                  ),

                  // Text field
                  Expanded(
                    child: TextField(
                      controller: _textCtrl,
                      maxLines: 5,
                      minLines: 1,
                      maxLength: _maxChars,
                      style: GoogleFonts.dmSans(
                        fontSize: 15, color: Colors.white, height: 1.4),
                      decoration: InputDecoration(
                        hintText: "What's happening?",
                        hintStyle: GoogleFonts.dmSans(
                          fontSize: 15, color: Colors.white38),
                        border: InputBorder.none,
                        counterText: '',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      ),
                    ),
                  ),

                  // Char count + image count
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 10, 12, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                      Text('$charCount/$_maxChars',
                        style: GoogleFonts.dmSans(
                          fontSize: 10, color: charColor)),
                      if (!PremiumService.isFree && _images.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text('${_images.length}/$_maxImages 📷',
                          style: GoogleFonts.dmSans(
                            fontSize: 10, color: Colors.white38)),
                      ],
                    ]),
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Galaxy background painter
// ─────────────────────────────────────────────────────────────────────────────
class _GalaxyBackground extends StatelessWidget {
  const _GalaxyBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GalaxyPainter(),
      child: Container(),
    );
  }
}

class _GalaxyPainter extends CustomPainter {
  static final List<_Star> _stars = _generateStars();

  static List<_Star> _generateStars() {
    final rng = math.Random(42); // fixed seed = consistent layout
    return List.generate(180, (_) => _Star(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      r: rng.nextDouble() * 1.8 + 0.2,
      opacity: rng.nextDouble() * 0.7 + 0.15,
    ));
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Deep space gradient
    final bg = Paint();
    final bgGrad = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF03001C),
        const Color(0xFF0A0620),
        const Color(0xFF100830),
        const Color(0xFF180B40),
        const Color(0xFF0D0520),
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );
    bg.shader = bgGrad.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    // Nebula glow — top right
    final nebula1 = Paint()
      ..color = const Color(0xFF7C3AED).withOpacity(0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.2),
        size.width * 0.6, nebula1);

    // Nebula glow — bottom left
    final nebula2 = Paint()
      ..color = const Color(0xFF0891B2).withOpacity(0.10)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.75),
        size.width * 0.5, nebula2);

    // Milky way band
    final mw = Paint()
      ..color = Colors.white.withOpacity(0.025)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    final mwPath = Path()
      ..moveTo(0, size.height * 0.3)
      ..quadraticBezierTo(
        size.width * 0.5, size.height * 0.5,
        size.width, size.height * 0.65)
      ..lineTo(size.width, size.height * 0.75)
      ..quadraticBezierTo(
        size.width * 0.5, size.height * 0.62,
        0, size.height * 0.42)
      ..close();
    canvas.drawPath(mwPath, mw);

    // Stars
    for (final star in _stars) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(star.opacity);
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.r, paint);
    }

    // Bright star clusters
    final bright = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);
    final rng = math.Random(99);
    for (int i = 0; i < 12; i++) {
      canvas.drawCircle(
        Offset(rng.nextDouble() * size.width, rng.nextDouble() * size.height),
        rng.nextDouble() * 1.2 + 0.8, bright);
    }
  }

  @override
  bool shouldRepaint(_GalaxyPainter old) => false;
}

class _Star {
  final double x, y, r, opacity;
  const _Star({required this.x, required this.y,
    required this.r, required this.opacity});
}

// ─────────────────────────────────────────────────────────────────────────────
// Feed target pill
// ─────────────────────────────────────────────────────────────────────────────
class _TargetPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TargetPill({
    required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.accent.withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.accent : Colors.white24)),
        child: Text(label, style: GoogleFonts.dmSans(
          fontSize: 11,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          color: selected ? Colors.white : Colors.white54)),
      ),
    );
  }
}