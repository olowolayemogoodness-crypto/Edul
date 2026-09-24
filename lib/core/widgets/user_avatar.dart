// lib/core/widgets/user_avatar.dart
//
// Single reusable avatar: shows a real uploaded photo when [photoUrl]
// is set, falls back to the same colored-initials circle used
// throughout the app when it isn't (or if the photo URL fails to
// load). Centralizing this in one widget is what lets a real photo
// actually reach every avatar spot in the app (post cards, comments,
// the "Liked by" stack, search results) by swapping each one to use
// this, rather than teaching each spot's own separate initials logic
// about photos individually.
//
// Same 6-color palette as the original per-file _avatarColor helpers
// this replaces, so a given person's fallback color stays visually
// consistent with what it always was, not a jarring new palette.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserAvatar extends StatelessWidget {
  final String uid;
  final String displayName;
  final String? photoUrl;
  final double size;

  const UserAvatar({
    super.key,
    required this.uid,
    required this.displayName,
    this.photoUrl,
    this.size = 36,
  });

  static const List<Color> _palette = [
    Color(0xFF7C3AED), Color(0xFF0891B2),
    Color(0xFF16A34A), Color(0xFFD97706),
    Color(0xFFBE185D), Color(0xFF9333EA),
  ];

  static Color colorFor(String uid) => _palette[uid.hashCode.abs() % _palette.length];

  Widget _initials() {
    final initial = displayName.trim().isNotEmpty ? displayName.trim()[0].toUpperCase() : 'U';
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: colorFor(uid)),
      child: Center(
        child: Text(initial, style: GoogleFonts.dmSans(
          fontSize: size * 0.4, fontWeight: FontWeight.w700, color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (photoUrl == null || photoUrl!.isEmpty) return _initials();
    return ClipOval(
      child: Image.network(
        photoUrl!,
        width: size, height: size, fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _initials(),
      ),
    );
  }
}