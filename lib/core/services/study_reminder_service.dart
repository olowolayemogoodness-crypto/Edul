// lib/core/services/study_reminder_service.dart
//
// Local, device-scheduled notifications — study reminders, streak
// protection, and social feed nudges. These are pure time-based prompts,
// not tied to real data, so they work entirely offline and need no
// backend infrastructure.
//
// NOT covered here: "new Insight videos" notifications. That genuinely
// needs to know when content is actually added, which local scheduling
// can't do — it needs a push notification (Firebase Cloud Messaging)
// sent at upload time. Since edul_upload_tool already has Firebase
// Admin access, that's the natural place to trigger it later, once FCM
// is wired into the Flutter app (a separate, smaller follow-up).

import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:flutter_timezone/flutter_timezone.dart';

class StudyReminderService {
  StudyReminderService._();

  static final _plugin = FlutterLocalNotificationsPlugin();

  // Fixed IDs so each scheduled notification can be individually
  // cancelled/replaced instead of piling up duplicates.
  static const _idMorning = 1001;
  static const _idNoon = 1002;
  static const _idEvening = 1003;
  static const _idFeedNudge = 1004;

  static const _channelId = 'edulink_reminders';
  static const _channelName = 'Study & activity reminders';

  static final _random = Random();

  // Rotates across the three daily study/streak slots.
  static const _studyMessages = [
    'Your books are waiting 📚 — even 15 minutes counts today.',
    'Quick reminder: a short study session now beats a long cram later.',
    '🔥 Don\'t lose your streak — open Edulink and log a session today.',
    'Your streak is counting on you today. Keep it alive!',
    'Time to lock in. Open Edulink and pick up where you left off.',
    'A few minutes of focused study now means less stress later.',
  ];

  static const _feedMessages = [
    'See what your coursemates are talking about on the feed 👀',
    'New posts are waiting in your feed — go say hi.',
    'Your feed\'s been busy today. Take a peek?',
  ];

  static Future<void> init() async {
    tzdata.initializeTimeZones();
    try {
      final currentTimeZone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(currentTimeZone));
    } catch (_) {
      // If detection fails for any reason, fall back to UTC rather than
      // crash — reminders will just fire at the wrong hour until the
      // next successful init, better than not scheduling at all.
    }

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    await _plugin.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
    );

    // Android 13+ requires this runtime permission request explicitly,
    // separate from the manifest declaration.
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  /// Call once per app launch — reschedules everything, including
  /// picking a fresh random hour for the feed-check nudge so it doesn't
  /// land at the exact same time every single day.
  static Future<void> scheduleAll() async {
    await _scheduleDaily(_idMorning, hour: 7, minute: 0, pool: _studyMessages);
    await _scheduleDaily(_idNoon, hour: 12, minute: 0, pool: _studyMessages);
    await _scheduleDaily(_idEvening, hour: 21, minute: 0, pool: _studyMessages);

    // Random hour between 1pm and 7pm, re-picked on every app launch.
    final randomHour = 13 + _random.nextInt(6);
    final randomMinute = _random.nextInt(60);
    await _scheduleDaily(_idFeedNudge, hour: randomHour, minute: randomMinute,
        pool: _feedMessages);
  }

  static Future<void> cancelAll() => _plugin.cancelAll();

  static Future<void> _scheduleDaily(int id, {
    required int hour,
    required int minute,
    required List<String> pool,
  }) async {
    final message = pool[_random.nextInt(pool.length)];
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id,
      'Edulink',
      message,
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId, _channelName,
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // repeats daily at this time
    );
  }
}