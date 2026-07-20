// lib/core/services/tutor_usage_service.dart
//
// Tracks daily AI Tutor usage (minutes) so the free-tier 20-min/day cap
// survives the app being closed and reopened — a purely local timer can be
// reset just by leaving and re-entering the Tutor screen, which defeats the
// point of the cap (every message is a paid Groq API call).
//
// Writes to Firestore under:
//   users/{uid}/tutorUsage/{YYYY-MM-DD}
//
// Usage:
//   final usedToday = await TutorUsageService.getMinutesUsedToday();
//   ...
//   await TutorUsageService.addMinutes(2); // call periodically during use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class TutorUsageService {
  TutorUsageService._();

  static final _db = FirebaseFirestore.instance;

  static String get _todayKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  static DocumentReference? get _todayRef {
    final uid = UserService.uid;
    if (uid == null) return null;
    return _db.collection('users').doc(uid)
        .collection('tutorUsage').doc(_todayKey);
  }

  /// Minutes already used today, persisted from any previous session(s).
  /// Returns 0 if not signed in, offline, or nothing recorded yet today.
  static Future<int> getMinutesUsedToday() async {
    final ref = _todayRef;
    if (ref == null) return 0;
    try {
      final snap = await ref.get();
      final data = snap.data() as Map<String, dynamic>?;
      return (data?['minutesUsed'] as num?)?.toInt() ?? 0;
    } catch (_) {
      // Offline or read failed — caller falls back to local-only tracking
      // for this session, which is still better than no cap at all.
      return 0;
    }
  }

  /// Adds [minutes] to today's persisted usage total. Call this
  /// periodically during an active Tutor session (e.g. after each message),
  /// not just once at the end — so usage survives the app being killed
  /// mid-conversation rather than only being saved on a clean exit.
  static Future<void> addMinutes(int minutes) async {
    if (minutes <= 0) return;
    final ref = _todayRef;
    if (ref == null) return;
    try {
      await ref.set({
        'minutesUsed': FieldValue.increment(minutes),
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {
      // Best-effort — if this write fails, the local session timer still
      // enforces the cap for the remainder of this in-memory session.
    }
  }
}