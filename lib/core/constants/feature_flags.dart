// lib/core/constants/feature_flags.dart
//
// Toggles for UI belonging to features that aren't built yet.
//
// Each flag below hides a "Coming soon" placeholder. The widgets and all
// their code still exist and still compile — they're just not rendered.
// To bring one back when the real feature ships, flip its flag to true.
// That's the whole change; no code needs to be restored or rewritten.
//
// NOT covered here, deliberately:
//   - Quiz setup's per-course "Coming soon" badge, and the learning map's
//     _buildComingSoon() screen. Those aren't roadmap teasers — they
//     describe the state of INDIVIDUAL courses that don't have question
//     banks or lessons yet. Hiding them would leave a user tapping a
//     course and landing on nothing, so they stay visible.
//   - The Compete tab and Library page placeholders, which are whole
//     dedicated screens rather than sections tucked inside a working one.

class FeatureFlags {
  FeatureFlags._();

  // ── Profile page sections ────────────────────────────────────────────
  static const bool showThisWeek = false;
  static const bool showCourseProgress = false;
  static const bool showStrengths = false;
  static const bool showLearningStyle = false;
  static const bool showSuccessPrediction = false;
  static const bool showBadges = false;

  // ── Home page sections ───────────────────────────────────────────────
  static const bool showLiveRooms = false;
  static const bool showLeaderboard = false;

  // ── Study rooms ──────────────────────────────────────────────────────
  static const bool showLiveStudySession = false;
}