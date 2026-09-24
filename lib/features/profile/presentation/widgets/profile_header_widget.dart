import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/user_tier_service.dart';
import '../../../../core/services/post_image_upload_service.dart';
import '../../../../core/widgets/user_score_badges.dart';

class ProfileHeaderWidget extends StatefulWidget {
  const ProfileHeaderWidget({super.key});
  @override
  State<ProfileHeaderWidget> createState() => _State();
}

class _State extends State<ProfileHeaderWidget> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _uploadingPhoto = false;

  Future<void> _changePhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked == null || !mounted) return;
    setState(() => _uploadingPhoto = true);
    try {
      final urls = await PostImageUploadService.uploadAll([File(picked.path)]);
      if (urls.isNotEmpty) {
        await UserService.updateProfile(photoUrl: urls.first);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Could not update photo: $e', style: GoogleFonts.dmSans(fontSize: 13)),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ));
      }
    } finally {
      if (mounted) setState(() => _uploadingPhoto = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 300), () { if (mounted) _ctrl.forward(); });
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(width: 74, height: 74, child: Stack(alignment: Alignment.center, children: [
        AnimatedBuilder(animation: _anim,
            builder: (_, animation) => CustomPaint(size: const Size(74, 74),
                painter: _ArcPainter(progress: 0))),
        GestureDetector(
          onTap: _uploadingPhoto ? null : _changePhoto,
          child: StreamBuilder<Map<String, dynamic>?>(
            stream: UserService.profileStream(),
            builder: (context, snap) {
              final photoUrl = snap.data?['photoUrl'] as String?;
              return Container(
                width: 58, height: 58,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF1E1D3A)),
                child: ClipOval(
                  child: _uploadingPhoto
                    ? const Center(child: SizedBox(width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFAFA9EC))))
                    : (photoUrl != null && photoUrl.isNotEmpty)
                      ? Image.network(photoUrl, width: 58, height: 58, fit: BoxFit.cover,
                          // Falls back to initials if the URL fails to
                          // load (deleted, network hiccup) instead of
                          // showing a broken-image icon.
                          errorBuilder: (_, __, ___) => _InitialsFallback())
                      : _InitialsFallback(),
                ),
              );
            },
          ),
        ),
        // Small camera-icon hint, bottom-right of the avatar -- the
        // same visual language as the existing "Lvl 12" badge overlay
        // just below, signaling this circle is tappable.
        Positioned(bottom: -2, right: -2, child: Container(
          width: 22, height: 22,
          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.accent,
            border: Border.all(color: AppColors.background, width: 2)),
          child: const Icon(Icons.camera_alt_rounded, size: 11, color: Colors.white),
        )),
        Positioned(bottom: 0, right: 0, child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            IgnorePointer(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFF2A1F00), borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFBA7517), width: 1.5)),
                  child: Text('Lvl 12', style: GoogleFonts.dmSans(fontSize: 8, fontWeight: FontWeight.w500, color: const Color(0xFFEF9F27))),
                ),
              ),
            ),
            Positioned.fill(child: Container(color: Colors.black.withValues(alpha: 0.35))),
            Positioned.fill(child: Center(child: Text('🔥', style: GoogleFonts.dmSans(fontSize: 10)))),
          ]),
        )),
      ])),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        StreamBuilder<Map<String, dynamic>?>(
  stream: UserService.profileStream(),
  builder: (context, snapshot) {
    final profile = snapshot.data;
    final name = profile?['displayName'] as String? ?? 'User';
    final tier = profile?['tier'] as String?;
    IconData? icon; Color? color;
    if (tier == 'active') { icon = Icons.circle; color = const Color(0xFF1D9E75); }
    else if (tier == 'contributor') { icon = Icons.verified_rounded; color = const Color(0xFF534AB7); }
    else if (tier == 'plug') { icon = Icons.workspace_premium_rounded; color = const Color(0xFF854F0B); }
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text(name, style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
      if (icon != null) Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Tooltip(message: UserTierService.label(tier!),
          child: Icon(icon, size: tier == 'active' ? 11 : 15, color: color)),
      ),
    ]);
  },
),
        const SizedBox(height: 3),
        UserScoreBadges(uid: UserService.uid ?? ''),
        const SizedBox(height: 2),
        StreamBuilder<Map<String, dynamic>?>(
          stream: UserService.profileStream(),
          builder: (context, snapshot) {
            final profile = snapshot.data;
            final studentType = profile?['studentType'] as String? ?? 'university';
            final course = profile?['course'] as String? ?? '';
            final typeLabel = studentType == 'secondary' ? 'Secondary School' : 'University';
            final subtitle = course.isNotEmpty ? '$typeLabel · $course' : typeLabel;
            return Text(subtitle, style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary));
          },
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: const Color(0xFF1E1D3A), borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF534AB7), width: 0.5)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.workspace_premium_outlined, size: 11, color: Color(0xFFAFA9EC)),
            const SizedBox(width: 5),
            Text('Rising Scholar', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w500, color: const Color(0xFFAFA9EC))),
          ]),
        ),
      ])),
    ]);
  }
}

// The original initials circle, now the fallback shown whenever no
// photo has been uploaded yet, or an uploaded photo's URL fails to
// load.
class _InitialsFallback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58, height: 58,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF1E1D3A)),
      child: Center(child: Builder(builder: (ctx) {
        final state = ctx.read<AuthBloc>().state;
        final name = state is AuthAuthenticated ? state.user.displayName : 'U';
        final initials = name.trim().split(' ').where((p) => p.isNotEmpty).take(2).map((p) => p[0].toUpperCase()).join();
        return Text(initials, style: GoogleFonts.dmSans(
          fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xFFAFA9EC), letterSpacing: 1));
      })),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  _ArcPainter({required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(c, 34, Paint()..style = PaintingStyle.stroke..strokeWidth = 4..color = const Color(0xFF222222));
    if (progress <= 0) return;
    canvas.drawArc(Rect.fromCircle(center: c, radius: 34), -math.pi / 2, 2 * math.pi * progress, false,
        Paint()..style = PaintingStyle.stroke..strokeWidth = 4..strokeCap = StrokeCap.round..color = const Color(0xFF534AB7));
  }
  @override
  bool shouldRepaint(_ArcPainter o) => o.progress != progress;
}