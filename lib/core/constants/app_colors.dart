import 'package:flutter/material.dart';
import '../services/theme_override_service.dart';

/// Colors are time-based by default: light theme from 7:00am to 3:00pm,
/// dark theme the rest of the day. A manual override (set from Settings
/// → Appearance) takes priority over the schedule when present. These
/// can no longer be `static const` (a const is fixed at compile time and
/// can never change) — they're computed getters instead, checked fresh
/// each time they're read.
class AppColors {
  AppColors._();

  /// True if light theme should currently be shown — manual override
  /// wins if set, otherwise falls back to the 7am–3pm schedule.
  static bool get _isDayTime {
    final override = ThemeOverrideService.override;
    if (override == 'light') return true;
    if (override == 'dark') return false;
    final hour = DateTime.now().hour;
    return hour >= 7 && hour < 15;
  }

  // ── Surfaces ────────────────────────────────────────────────────────────
  static Color get background     => _isDayTime ? const Color(0xFFFAFAFA) : const Color(0xFF0D0D0F);
  static Color get surface        => _isDayTime ? const Color(0xFFFFFFFF) : const Color(0xFF1A1A1F);
  static Color get surfaceVariant => _isDayTime ? const Color(0xFFEFEFF2) : const Color(0xFF222228);
  static Color get card           => _isDayTime ? const Color(0xFFFFFFFF) : const Color(0xFF1E1E24);

  // ── Accent ──────────────────────────────────────────────────────────────
  static Color get accent         => const Color(0xFF7C3AED);
  static Color get accentLight    => _isDayTime ? const Color(0xFF8B5CF6) : const Color(0xFF9F67F5);
  static Color get accentDark     => const Color(0xFF5B21B6);
  static Color get accentSurface  => _isDayTime ? const Color(0xFFF3EEFF) : const Color(0xFF2D1B69);

  // ── Text ────────────────────────────────────────────────────────────────
  static Color get textPrimary    => _isDayTime ? const Color(0xFF18181B) : const Color(0xFFF5F5F7);
  static Color get textSecondary  => _isDayTime ? const Color(0xFF55555C) : const Color(0xFFAAAAAF);
  static Color get textTertiary   => _isDayTime ? const Color(0xFF8A8A92) : const Color(0xFF6B6B74);
  static Color get textDisabled   => _isDayTime ? const Color(0xFFC5C5CC) : const Color(0xFF44444A);

  // ── Borders ─────────────────────────────────────────────────────────────
  static Color get border         => _isDayTime ? const Color(0xFFE2E2E6) : const Color(0xFF2A2A32);
  static Color get borderFocus    => const Color(0xFF7C3AED);

  // ── Semantic ────────────────────────────────────────────────────────────
  static Color get success        => _isDayTime ? const Color(0xFF16A34A) : const Color(0xFF22C55E);
  static Color get successSurface => _isDayTime ? const Color(0xFFE8F8EE) : const Color(0xFF0F2A1A);
  static Color get warning        => _isDayTime ? const Color(0xFFD97706) : const Color(0xFFF59E0B);
  static Color get warningSurface => _isDayTime ? const Color(0xFFFEF3E0) : const Color(0xFF2A1F0A);
  static Color get error          => _isDayTime ? const Color(0xFFDC2626) : const Color(0xFFEF4444);
  static Color get errorSurface   => _isDayTime ? const Color(0xFFFCE8E8) : const Color(0xFF2A0F0F);
  static Color get info           => _isDayTime ? const Color(0xFF2563EB) : const Color(0xFF3B82F6);
  static Color get infoSurface    => _isDayTime ? const Color(0xFFE8F0FE) : const Color(0xFF0F1A2A);

  // ── Misc brand ──────────────────────────────────────────────────────────
  static Color get streak         => const Color(0xFFFF6B2B);
  static Color get gold           => const Color(0xFFFFD700);
  static Color get silver         => const Color(0xFFC0C0C0);
  static Color get bronze         => const Color(0xFFCD7F32);
  static Color get xp             => _isDayTime ? const Color(0xFF0891B2) : const Color(0xFF06B6D4);

  static Color get chart1         => const Color(0xFF7C3AED);
  static Color get chart2         => _isDayTime ? const Color(0xFF0891B2) : const Color(0xFF06B6D4);
  static Color get chart3         => _isDayTime ? const Color(0xFF16A34A) : const Color(0xFF22C55E);
  static Color get chart4         => _isDayTime ? const Color(0xFFD97706) : const Color(0xFFF59E0B);
  static Color get chart5         => _isDayTime ? const Color(0xFFDC2626) : const Color(0xFFEF4444);

  static LinearGradient get accentGradient => const LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF9F67F5)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient get streakGradient => const LinearGradient(
    colors: [Color(0xFFFF6B2B), Color(0xFFFFD700)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get cardGradient => _isDayTime
      ? const LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFF3F3F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      : const LinearGradient(
          colors: [Color(0xFF1E1E24), Color(0xFF222228)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
}
