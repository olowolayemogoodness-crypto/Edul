// lib/core/services/course_schedule_service.dart
//
// Bridges a course to its real weekly schedule in Timetable, by
// matching course.subject (case-insensitive) against timetable
// entries' 'subject' field (see timetable_service.dart). Timetable
// entries store day-of-week + start/end time as a RECURRING weekly
// slot with no specific calendar date, so this computes the next
// real calendar occurrence of each matching slot from "now", rather
// than reading a literal stored date -- there isn't one.
//
// If the course has no subject set, the student isn't in an official
// group yet, or no timetable entries match, this returns an empty
// list. The Overview tab then shows "no scheduled classes linked
// yet" instead of a fabricated banner -- there is genuinely nothing
// scheduled to show, and that's a different, more honest state than
// a course simply having no textbooks or recaps yet.
//
// What this does NOT do: know whether a session is online or
// in-person (Timetable has no such field, only a room string), or
// provide any real video/streaming backend for "Join live class" --
// that's still the mock UI built earlier. This only makes the
// *schedule* (when, where) real.

import 'timetable_service.dart';

class ClassSession {
  final String subject;
  final String day; // e.g. "Monday", as stored in Timetable
  final String startTime; // "14:00"
  final String endTime;
  final String room;
  final DateTime start; // real computed next occurrence
  final DateTime? end;
  final bool isHappeningNow;

  const ClassSession({
    required this.subject,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.start,
    required this.end,
    required this.isHappeningNow,
  });
}

class CourseScheduleService {
  CourseScheduleService._();

  static const _weekdayNames = [
    'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday',
  ];

  /// Real upcoming sessions for [subject], soonest first. Empty if
  /// there's no group, no subject, or no matching timetable entries.
  static Future<List<ClassSession>> sessionsForSubject(String subject) async {
    if (subject.trim().isEmpty) return [];

    final groupId = await TimetableService.myOfficialGroupId();
    if (groupId == null) return [];

    final entries = await TimetableService.allEntries(groupId).first;
    final now = DateTime.now();
    final wanted = subject.trim().toLowerCase();

    final sessions = <ClassSession>[];
    for (final e in entries) {
      final entrySubject = (e['subject'] as String? ?? '').trim().toLowerCase();
      if (entrySubject != wanted) continue;

      final day = e['day'] as String? ?? '';
      final startTime = e['startTime'] as String? ?? '';
      final endTime = e['endTime'] as String? ?? '';
      final room = e['room'] as String? ?? '';

      final session = _toSession(now, e['subject'] as String? ?? subject, day, startTime, endTime, room);
      if (session != null) sessions.add(session);
    }

    sessions.sort((a, b) => a.start.compareTo(b.start));
    return sessions;
  }

  static ClassSession? _toSession(
    DateTime now, String subject, String day, String startTime, String endTime, String room,
  ) {
    final targetWeekday = _weekdayNames.indexOf(day.trim().toLowerCase()) + 1; // 1=Mon..7=Sun
    if (targetWeekday == 0) return null; // unrecognized day string

    final startParts = startTime.split(':');
    if (startParts.length != 2) return null;
    final startHour = int.tryParse(startParts[0]);
    final startMinute = int.tryParse(startParts[1]);
    if (startHour == null || startMinute == null) return null;

    var daysAhead = (targetWeekday - now.weekday + 7) % 7;
    var start = DateTime(now.year, now.month, now.day, startHour, startMinute).add(Duration(days: daysAhead));

    DateTime? end;
    final endParts = endTime.split(':');
    if (endParts.length == 2) {
      final endHour = int.tryParse(endParts[0]);
      final endMinute = int.tryParse(endParts[1]);
      if (endHour != null && endMinute != null) {
        end = DateTime(now.year, now.month, now.day, endHour, endMinute).add(Duration(days: daysAhead));
      }
    }

    // If today is the target day but the session has already fully
    // ended, the next real occurrence is next week, not today's
    // already-finished class.
    if (daysAhead == 0 && end != null && now.isAfter(end)) {
      start = start.add(const Duration(days: 7));
      end = end.add(const Duration(days: 7));
    }

    final isHappeningNow = end != null && now.isAfter(start) && now.isBefore(end);

    return ClassSession(
      subject: subject, day: day, startTime: startTime, endTime: endTime, room: room,
      start: start, end: end, isHappeningNow: isHappeningNow,
    );
  }
}