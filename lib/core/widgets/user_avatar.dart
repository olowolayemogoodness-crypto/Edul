// lib/core/widgets/user_avatar.dart
//
// One widget, used everywhere an avatar currently shows initials.
// Pass a photoUrl and it shows the real photo; pass null (or leave it
// out) and it falls back to the exact same initials-circle look
// that's already used throughout the app. This is what makes "show
// real photos instead of initials" tractable without hand-editing
// every single call site that currently builds its own initials
// circle -- new code (and, over time, existing code) just calls this
// instead of reimplementing the fallback logic locally.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class UserAvatar extends StatelessWidget {
  final String? photoUrl;
  final String name;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;

  const UserAvatar({
    super.key,
    required this.photoUrl,
    required this.name,
    this.size = 44,
    this.backgroundColor,
    this.textColor,
  });

  String get _initials {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (parts.isNotEmpty) return parts[0][0].toUpperCase();
    return 'U';
  }

  @override
  Widget build(BuildContext context) {
    final hasPhoto = photoUrl != null && photoUrl!.trim().isNotEmpty;
    final bg = backgroundColor ?? AppColors.accentSurface;
    final fg = textColor ?? AppColors.accent;

    if (hasPhoto) {
      return ClipOval(
        child: Image.network(
          photoUrl!,
          width: size, height: size, fit: BoxFit.cover,
          // If the photo genuinely fails to load (broken URL, offline),
          // fall back to initials rather than showing a broken-image icon.
          errorBuilder: (_, __, ___) => _initialsCircle(bg, fg),
          loadingBuilder: (context, child, progress) =>
              progress == null ? child : _initialsCircle(bg, fg),
        ),
      );
    }
    return _initialsCircle(bg, fg);
  }

  Widget _initialsCircle(Color bg, Color fg) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(_initials, style: GoogleFonts.dmSans(
        fontSize: size * 0.38, fontWeight: FontWeight.w700, color: fg)),
    );
  }
}