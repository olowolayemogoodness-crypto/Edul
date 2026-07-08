// lib/core/services/quiz_sound_service.dart
//
// Plays a correct-answer sound (escalating through 4 tiers as the
// current streak builds) and a wrong-answer sound + haptic vibration
// for missed/incorrect questions.
//
// ⚠️ ASSET FILES NOT INCLUDED: this service references 5 sound files
// that must be added to assets/sounds/ (registered in pubspec.yaml):
//   - assets/sounds/correct_tier1.mp3  (streak 0-2: a light, normal chime)
//   - assets/sounds/correct_tier2.mp3  (streak 3-5: a bit more energetic)
//   - assets/sounds/correct_tier3.mp3  (streak 6-9: bigger, more excited)
//   - assets/sounds/correct_tier4.mp3  (streak 10+: max hype/celebration)
//   - assets/sounds/wrong.mp3          (any miss or timeout)
// Free sources: mixkit.co/free-sound-effects, zapsplat.com, freesound.org.
// Keep each file short (under ~1s) so it doesn't lag behind fast answering.
//
// All playback calls fail silently (caught and ignored) so a missing
// or corrupt sound file never crashes the quiz -- worth removing that
// silent catch during development so you notice if a file is missing.

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class QuizSoundService {
  QuizSoundService._();

  static final AudioPlayer _player = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop);

  static const List<_StreakTier> _tiers = [
    _StreakTier(minStreak: 10, asset: 'sounds/correct_tier4.mp3'),
    _StreakTier(minStreak: 6, asset: 'sounds/correct_tier3.mp3'),
    _StreakTier(minStreak: 3, asset: 'sounds/correct_tier2.mp3'),
    _StreakTier(minStreak: 0, asset: 'sounds/correct_tier1.mp3'),
  ];

  /// Plays the correct-answer sound for the given streak count (the
  /// streak value AFTER this correct answer, not before). Picks the
  /// highest tier whose minStreak the current streak satisfies.
  static Future<void> playCorrect(int streak) async {
    final tier = _tiers.firstWhere(
      (t) => streak >= t.minStreak,
      orElse: () => _tiers.last,
    );
    await _play(tier.asset);
  }

  /// Plays the wrong-answer sound and triggers a medium haptic thud.
  /// Used for both an incorrect selection and a question timing out.
  static Future<void> playWrong() async {
    HapticFeedback.mediumImpact();
    await _play('sounds/wrong.mp3');
  }

  static Future<void> _play(String asset) async {
    try {
      // Restarting from position 0 each call so rapid-fire answering
      // (e.g. spamming through easy questions) doesn't leave a sound
      // half-played and silently drop the next one.
      await _player.stop();
      await _player.play(AssetSource(asset));
    } catch (_) {
      // Missing/corrupt asset -- never let a sound failure interrupt
      // the quiz itself. Remove this catch while testing locally so
      // a missing file is obvious instead of silent.
    }
  }
}

class _StreakTier {
  final int minStreak;
  final String asset;
  const _StreakTier({required this.minStreak, required this.asset});
}