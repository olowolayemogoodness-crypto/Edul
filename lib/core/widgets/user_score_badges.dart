// lib/core/widgets/user_score_badges.dart
//
// Two small "Snap Score"-style badges shown next to a username, wherever
// one appears — profile header, feed post author lines, comment author
// lines, and (as a fast follow-up, not built yet) notifications sender
// names, the follow/profile sheet, and the leaderboard.
//
//   ⚡ Study Score  — derived from the existing `xp` field. No new
//     tracking needed: quizzes, lessons, streaks, and practice tests
//     already feed `xp` via UserService.awardXP() throughout the app.
//     Reuses the ⚡ symbol already established on the home screen's top
//     bar, so it doesn't introduce a second meaning for a symbol users
//     already learned.
//
//   💜 Social Score — derived from a NEW `socialScore` field, kept
//     deliberately separate from the existing `score` field (which
//     drives tier-badge eligibility and must stay exactly as
//     calibrated). socialScore = 2 per like received + 1 per comment
//     received + 5 per follower — see UserTierService.adjustScore and
//     PostInteractionService._notifyPostOwner for where it's earned.
//
// Both displayed numbers are SCALED UP from the raw stored value, same
// idea as Snapchat's own score not being a 1:1 count of anything a user
// can see individually — it's meant to climb fast and feel big. Both
// multipliers live in one place (below) so they're trivial to retune
// later without touching any UI code.
//
// Firestore rule note: `socialScore` needs the SAME scoped-update
// pattern as `score` already has — add `socialScore` to the existing
// hasOnly(['score']) rule's field list (i.e. update that one rule to
// hasOnly(['score', 'socialScore']), since both are written together in
// the same transaction for likes/follows, and hasOnly checks the whole
// diffed key set in a single write).

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../services/presence_service.dart';

class ScoreDisplay {
  ScoreDisplay._();

  // Tune these to change how "big" each score feels, without touching
  // any widget code.
  static const int studyMultiplier = 5;
  static const int socialMultiplier = 10;

  static int study(int xp) => xp * studyMultiplier;
  static int social(int socialScoreRaw) => socialScoreRaw * socialMultiplier;

  /// Compact display for large numbers — 1,240 -> "1.2k", matching the
  /// "feels big" goal without the badge overflowing on smaller screens.
  static String compact(int n) {
    if (n < 1000) return '$n';
    if (n < 1000000) {
      final k = n / 1000;
      return '${k.toStringAsFixed(k < 10 ? 1 : 0)}k';
    }
    final m = n / 1000000;
    return '${m.toStringAsFixed(m < 10 ? 1 : 0)}M';
  }
}

/// Live-updating pair of score badges for [uid]. Streams the user doc
/// once and derives both numbers from it, so this is a single Firestore
/// listener per instance — cheap even used many times on one screen
/// (e.g. once per post author in a feed), since each listener only
/// re-fires when that specific user's doc actually changes.
class UserScoreBadges extends StatelessWidget {
  final String uid;
  final double iconSize;
  final double fontSize;
  final bool compact;

  const UserScoreBadges({
    super.key,
    required this.uid,
    this.iconSize = 12,
    this.fontSize = 11,
    this.compact = true,
  });

  @override
  Widget build(BuildContext context) {
    if (uid.isEmpty) return const SizedBox.shrink();
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (context, snap) {
        final data = snap.data?.data();
        if (data == null) return const SizedBox.shrink();

        final xp = (data['xp'] as num?)?.toInt() ?? 0;
        final socialRaw = (data['socialScore'] as num?)?.toInt() ?? 0;
        final studyVal = ScoreDisplay.study(xp);
        final socialVal = ScoreDisplay.social(socialRaw);
        // Presence read from the SAME snapshot/listener as the scores
        // above — deliberately not a second widget with its own
        // .snapshots() call, which would open a duplicate live listener
        // on the identical document just to read one more field.
        final online = PresenceService.isOnline(data['lastActiveAt'] as Timestamp?);

        // Nothing earned yet on either side, and offline — don't
        // clutter every fresh/inactive account's name with two "0"
        // badges and a grey dot nobody needs to see.
        if (studyVal == 0 && socialVal == 0 && !online) return const SizedBox.shrink();

        return Row(mainAxisSize: MainAxisSize.min, children: [
          if (online) ...[
            Container(width: 6, height: 6,
              decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle)),
            const SizedBox(width: 5),
          ],
          if (studyVal > 0) _badge('⚡', studyVal, AppColors.warning),
          if (studyVal > 0 && socialVal > 0) const SizedBox(width: 6),
          if (socialVal > 0) _badge('💜', socialVal, AppColors.accentLight),
        ]);
      },
    );
  }

  Widget _badge(String emoji, int value, Color tint) {
    final label = compact ? ScoreDisplay.compact(value) : '$value';
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text(emoji, style: TextStyle(fontSize: iconSize)),
      const SizedBox(width: 2),
      Text(label, style: GoogleFonts.dmSans(
        fontSize: fontSize, fontWeight: FontWeight.w600, color: tint)),
    ]);
  }
}