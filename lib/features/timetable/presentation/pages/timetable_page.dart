// lib/features/timetable/presentation/pages/timetable_page.dart
//
// Redesigned to the app's real light theme (AppColors) -- previously
// used its own fixed dark purple palette. Approved design reference:
// the "Timetable — Light Theme Redesign" canvas.
//
// Structural changes from the previous version, beyond re-coloring:
//   - A real day selector (Mon-Fri) -- previously always showed today
//     with no way to look at another day. Tapping a day re-fetches
//     that day's entries stream.
//   - Streak banner and the 3-box stats row (Assignments/Due soon/
//     Classes) are dropped -- not part of the approved design.
//   - Assignments simplified to a vertical list of compact rows
//     showing "Due tomorrow" / "Due in N days" computed once, instead
//     of the previous live per-second countdown ticker -- also
//     removes the Timer/_CountdownBlocks machinery entirely.
//   - The class-rep add-entry action moved from a floating action
//     button to an icon button in the header, matching the design.
// Class-wide, class-rep-driven schedule -- scoped to the user's own
// official SET30 group, not personal.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/timetable_service.dart';
import '../../../../core/services/user_service.dart';
import 'add_timetable_entry_page.dart';

const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

int _endMinutes(Map<String, dynamic> entry) {
  final endTime = entry['endTime'] as String? ?? '';
  final parts = endTime.split(':');
  if (parts.length != 2) return entry['startMinutes'] as int? ?? 0;
  final hour = int.tryParse(parts[0]) ?? 0;
  final minute = int.tryParse(parts[1]) ?? 0;
  return hour * 60 + minute;
}

// Light-theme equivalents of TimetableService's dark subject palette
// -- same hue families (physics blue, math purple, etc.), kept local
// to this page rather than changed on the shared service, since other
// screens (e.g. add_timetable_entry_page.dart) may still rely on the
// original dark values for their own contexts.
const Map<String, Map<String, Color>> _lightSubjectColors = {
  'physics': {'bg': Color(0xFFEFF6FF), 'text': Color(0xFF2563EB), 'dot': Color(0xFF3B82F6)},
  'math':    {'bg': Color(0xFFF3EEFF), 'text': Color(0xFF7C3AED), 'dot': Color(0xFF7C3AED)},
  'english': {'bg': Color(0xFFFDF2F8), 'text': Color(0xFFDB2777), 'dot': Color(0xFFEC4899)},
  'history': {'bg': Color(0xFFFFFBEB), 'text': Color(0xFFB45309), 'dot': Color(0xFFD97706)},
  'music':   {'bg': Color(0xFFECFDF5), 'text': Color(0xFF047857), 'dot': Color(0xFF10B981)},
  'art':     {'bg': Color(0xFFFEF2F2), 'text': Color(0xFFB91C1C), 'dot': Color(0xFFEF4444)},
};

Map<String, Color> _lightColorFor(String subject) {
  final key = subject.trim().toLowerCase();
  if (_lightSubjectColors.containsKey(key)) return _lightSubjectColors[key]!;
  final keys = _lightSubjectColors.keys.toList();
  final fallback = keys[subject.hashCode.abs() % keys.length];
  return _lightSubjectColors[fallback]!;
}

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  String? _groupId;
  bool _isClassRep = false;
  String? _department;
  int _selectedDayIndex = 0;
  int _weekOffset = 0; // 0 = this week, 1 = next week, -1 = last week, etc.
  Stream<List<Map<String, dynamic>>>? _entriesStream;
  Stream<List<Map<String, dynamic>>>? _assignmentsStream;

    @override
  void initState() {
    super.initState();
    _selectedDayIndex = DateTime.now().weekday - 1;
    _load();
  }

  Future<void> _load() async {
    final results = await Future.wait([
      TimetableService.myOfficialGroupId(),
      UserService.getProfile(),
    ]);
    final groupId = results[0] as String?;
    final profile = results[1] as Map<String, dynamic>?;
    if (groupId == null) { if (mounted) setState(() {}); return; }
    setState(() {
      _groupId = groupId;
      _department = profile?['course'] as String?; // see course_service.dart's note on this field's real meaning
      // Created exactly once here, not inside any widget's build() --
      // that was the actual bug: each rebuild was creating a brand new
      // Firestore stream, which resets StreamBuilder to its empty
      // "waiting" state until the new stream's first result arrives,
      // producing the appears-and-disappears flicker.
      _entriesStream = TimetableService.entriesForDay(groupId, _days[_selectedDayIndex]);
      _assignmentsStream = TimetableService.assignments(groupId);
    });
    final isRep = await TimetableService.isClassRep(groupId);
    if (mounted) setState(() => _isClassRep = isRep);
  }

  void _selectDay(int index) {
    if (index == _selectedDayIndex || _groupId == null) return;
    setState(() {
      _selectedDayIndex = index;
      _entriesStream = TimetableService.entriesForDay(_groupId!, _days[index]);
    });
  }

  /// Moving weeks only changes which real dates the pills show --
  /// the entries query stays keyed by day-of-week label (e.g. "Mon"),
  /// same as before, since a class recurs every week regardless of
  /// which calendar week is being looked at. This is what makes a
  /// class added today for "Monday" already show up on next week's
  /// Monday tile too, without needing any extra data per week.
  void _shiftWeek(int delta) {
    setState(() => _weekOffset += delta);
  }

  /// Real Mon-Fri calendar dates for the current week, matching the
  /// day pills to actual dates rather than just weekday labels.
  List<DateTime> get _weekDates {
    final now = DateTime.now();
    final thisMonday = now.subtract(Duration(days: now.weekday - 1));
    final monday = thisMonday.add(Duration(days: _weekOffset * 7));
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    if (_groupId == null || _entriesStream == null || _assignmentsStream == null) {
      return Scaffold(backgroundColor: AppColors.background, body: Center(
        child: Text('Join your official class group to see its timetable',
          style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary))));
    }
        final groupId = _groupId!;
    final entriesStream = _entriesStream!;
    final assignmentsStream = _assignmentsStream!;
    final today = DateTime.now();
    final selectedDate = _weekDates[_selectedDayIndex];
    final isSelectedDayToday = selectedDate.year == today.year && selectedDate.month == today.month && selectedDate.day == today.day;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _Header(isClassRep: _isClassRep, department: _department, groupId: groupId, selectedDay: _days[_selectedDayIndex]),
            const SizedBox(height: 20),
            _DaySelector(selectedIndex: _selectedDayIndex, weekDates: _weekDates, weekOffset: _weekOffset, onSelect: _selectDay, onShiftWeek: _shiftWeek),
            const SizedBox(height: 20),
            _NextUpCard(entriesStream: entriesStream, groupId: groupId, isToday: isSelectedDayToday),
            const SizedBox(height: 20),
            Text('Today\'s classes', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            _TodayList(entriesStream: entriesStream, groupId: groupId, isClassRep: _isClassRep, isToday: isSelectedDayToday),
            const SizedBox(height: 20),
            Text('Assignments', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            _AssignmentsList(assignmentsStream: assignmentsStream),
            const SizedBox(height: 20),
            Text('SUBJECTS', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.4)),
            const SizedBox(height: 8),
            _SubjectsLegend(groupId: groupId),
          ]),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool isClassRep;
  final String? department;
  final String groupId;
  final String selectedDay;
  const _Header({required this.isClassRep, required this.department, required this.groupId, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Timetable', style: GoogleFonts.dmSans(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary, letterSpacing: -0.3)),
          if (department != null && department!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(department!, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
            ),
        ]),
      ),
      if (isClassRep)
        Material(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AddTimetableEntryPage(groupId: groupId, initialDay: selectedDay))),
            child: Container(
              width: 40, height: 40, alignment: Alignment.center,
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
            ),
          ),
        ),
    ]);
  }
}

class _DaySelector extends StatelessWidget {
  final int selectedIndex;
  final List<DateTime> weekDates;
  final int weekOffset;
  final void Function(int) onSelect;
  final void Function(int) onShiftWeek;
  const _DaySelector({
    required this.selectedIndex, required this.weekDates, required this.weekOffset,
    required this.onSelect, required this.onShiftWeek,
  });

  static const _months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

  bool _isToday(DateTime d) {
    final now = DateTime.now();
    return d.year == now.year && d.month == now.month && d.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final range = '${_months[weekDates.first.month - 1]} ${weekDates.first.day} – ${weekDates.last.day}';
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          onPressed: () => onShiftWeek(-1),
          icon: Icon(Icons.chevron_left_rounded, color: AppColors.textSecondary),
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.all(4),
        ),
        Row(children: [
          Text(range, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          if (weekOffset != 0) ...[
            const SizedBox(width: 6),
            GestureDetector(
              onTap: () => onShiftWeek(-weekOffset),
              child: Text('Today', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.accent)),
            ),
          ],
        ]),
        IconButton(
          onPressed: () => onShiftWeek(1),
          icon: Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.all(4),
        ),
      ]),
      const SizedBox(height: 8),
      Row(children: [
        for (var i = 0; i < _days.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: Material(
              color: i == selectedIndex ? AppColors.accent : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => onSelect(i),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(children: [
                    Text(_days[i].toUpperCase(), style: GoogleFonts.dmSans(
                      fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.3,
                      color: i == selectedIndex ? Colors.white : AppColors.textTertiary)),
                    const SizedBox(height: 4),
                    Text('${weekDates[i].day}', style: GoogleFonts.dmSans(
                      fontSize: 15, fontWeight: FontWeight.w700,
                      color: i == selectedIndex ? Colors.white : AppColors.textPrimary)),
                    const SizedBox(height: 3),
                    Container(
                      width: 4, height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isToday(weekDates[i]) ? (i == selectedIndex ? Colors.white : AppColors.accent) : Colors.transparent,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ]),
    ]);
  }
}

class _NextUpCard extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> entriesStream;
  final String groupId;
  final bool isToday;
  const _NextUpCard({required this.entriesStream, required this.groupId, required this.isToday});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: entriesStream,
      builder: (context, snap) {
        final entries = List<Map<String, dynamic>>.from(snap.data ?? []);
        entries.sort((a, b) => (a['startMinutes'] as int? ?? 0).compareTo(b['startMinutes'] as int? ?? 0));
        final nowMinutes = DateTime.now().hour * 60 + DateTime.now().minute;
        // Only filter by "hasn't started yet" when actually viewing
        // today -- comparing a different day's classes against the
        // live clock is meaningless and was hiding real entries when
        // browsing any day other than today.
        final next = isToday
            ? entries.where((e) => (e['startMinutes'] as int? ?? 0) >= nowMinutes).toList()
            : entries;

        if (next.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(18)),
            child: Text(isToday ? 'No more classes today' : 'No classes scheduled', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
          );
        }

        final entry = next.first;
        final entryId = entry['id'] as String? ?? '';
        final subject = entry['subject'] as String? ?? '';
        final room = entry['room'] as String? ?? '';
        final startTime = entry['startTime'] as String? ?? '';
        final endTime = entry['endTime'] as String? ?? '';
        final startsInMin = (entry['startMinutes'] as int? ?? 0) - nowMinutes;

        return StreamBuilder<String>(
          stream: TimetableService.entryStatusStream(groupId, entryId, DateTime.now()),
          builder: (context, statusSnap) {
            final status = statusSnap.data ?? 'holding';
            final statusColor = status == 'cancelled' ? AppColors.error : status == 'delayed' ? AppColors.warning : AppColors.success;
            final statusBg = status == 'cancelled' ? AppColors.errorSurface : status == 'delayed' ? AppColors.warningSurface : AppColors.successSurface;

            return Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.card, borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.accent, width: 1.5),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(isToday ? 'NEXT UP' : 'FIRST CLASS', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.accent, letterSpacing: 0.6)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(999)),
                    child: Text(status.toUpperCase(), style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w700, color: statusColor, letterSpacing: 0.3)),
                  ),
                ]),
                const SizedBox(height: 10),
                Text(subject, style: GoogleFonts.dmSans(fontSize: 19, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Row(children: [
                  Icon(Icons.access_time_rounded, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 5),
                  Text('$startTime – $endTime', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary)),
                  if (room.isNotEmpty) ...[
                    const SizedBox(width: 16),
                    Icon(Icons.place_outlined, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 5),
                    Text(room, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ]),
                if (isToday && startsInMin > 0) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                    decoration: BoxDecoration(color: AppColors.accentSurface, borderRadius: BorderRadius.circular(999)),
                    child: Text(
                      startsInMin < 60 ? 'Starts in $startsInMin min' : 'Starts in ${(startsInMin / 60).floor()}h ${startsInMin % 60}m',
                      style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.accent)),
                  ),
                ],
              ]),
            );
          },
        );
      },
    );
  }
}

class _TodayList extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> entriesStream;
  final String groupId;
  final bool isClassRep;
  final bool isToday;
  const _TodayList({required this.entriesStream, required this.groupId, required this.isClassRep, required this.isToday});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: entriesStream,
      builder: (context, snap) {
        var entries = List<Map<String, dynamic>>.from(snap.data ?? []);
        entries.sort((a, b) => (a['startMinutes'] as int? ?? 0).compareTo(b['startMinutes'] as int? ?? 0));
        if (isToday) {
          final nowMinutes = DateTime.now().hour * 60 + DateTime.now().minute;
          final upcoming = entries.where((e) => _endMinutes(e) >= nowMinutes).toList();
          final finished = entries.where((e) => _endMinutes(e) < nowMinutes).toList();
          entries = [...upcoming, ...finished];
        }
        if (entries.isEmpty) {
          return Text('No classes scheduled', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary));
        }
        return Column(children: entries.map((e) {
          final entryId = e['id'] as String? ?? '';
          final subject = e['subject'] as String? ?? '';
          final color = _lightColorFor(subject);
          final room = e['room'] as String? ?? '';
          final startTime = e['startTime'] as String? ?? '';
          final endTime = e['endTime'] as String? ?? '';
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: StreamBuilder<String>(
              stream: TimetableService.entryStatusStream(groupId, entryId, DateTime.now()),
              builder: (context, statusSnap) {
                final status = statusSnap.data ?? 'holding';
                final isCancelled = status == 'cancelled';
                return Material(
                  color: isCancelled ? AppColors.errorSurface : AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: isClassRep ? () => _showStatusSheet(context, groupId, entryId, status, subject, room, startTime) : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: isCancelled ? AppColors.error.withValues(alpha: 0.25) : AppColors.border),
                      ),
                      child: Row(children: [
                        Container(width: 9, height: 9, decoration: BoxDecoration(shape: BoxShape.circle, color: color['dot'])),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(children: [
                              Text(subject, style: GoogleFonts.dmSans(
                                fontSize: 13, fontWeight: FontWeight.w600,
                                color: isCancelled ? AppColors.error.withValues(alpha: 0.75) : AppColors.textPrimary,
                                decoration: isCancelled ? TextDecoration.lineThrough : null,
                                decorationColor: AppColors.error,
                              )),
                              if (status != 'holding') ...[
                                const SizedBox(width: 7),
                                _StatusBadge(status: status),
                              ],
                            ]),
                            const SizedBox(height: 1),
                            Text([startTime.isNotEmpty ? '$startTime – $endTime' : '', room].where((s) => s.isNotEmpty).join(' · '),
                              style: GoogleFonts.dmSans(fontSize: 11, color: isCancelled ? AppColors.error.withValues(alpha: 0.6) : AppColors.textTertiary)),
                          ]),
                        ),
                        if (isClassRep)
                          Icon(Icons.edit_outlined, size: 15, color: isCancelled ? AppColors.error.withValues(alpha: 0.6) : AppColors.textTertiary),
                      ]),
                    ),
                  ),
                );
              },
            ),
          );
        }).toList());
      },
    );
  }
}

void _showStatusSheet(BuildContext context, String groupId, String entryId, String current, String subject, String room, String startTime) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.card,
    builder: (sheetContext) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 8),
        for (final option in const [
          ('holding', 'Holding', Icons.check_circle_outline_rounded),
          ('delayed', 'Delayed', Icons.schedule_rounded),
          ('cancelled', 'Cancelled', Icons.cancel_outlined),
        ])
          ListTile(
            leading: Icon(option.$3, color: option.$1 == 'cancelled' ? AppColors.error : option.$1 == 'delayed' ? AppColors.warning : AppColors.success),
            title: Text(option.$2, style: GoogleFonts.dmSans(
              fontSize: 14, fontWeight: option.$1 == current ? FontWeight.w700 : FontWeight.w500,
              color: AppColors.textPrimary)),
            trailing: option.$1 == current ? Icon(Icons.check_rounded, color: AppColors.accent) : null,
            onTap: () async {
              try {
                final result = await TimetableService.setEntryStatus(
                  groupId: groupId, entryId: entryId, date: DateTime.now(), status: option.$1);
                if (sheetContext.mounted) Navigator.pop(sheetContext);
                if (result == TimetableEntryResult.success) {
                  // Fire-and-forget -- the rep shouldn't sit waiting on
                  // every group member's push to send one by one before
                  // the sheet closes. Best-effort by design (see the
                  // method's own doc comment).
                  TimetableService.notifyClassStatusChange(
                    groupId: groupId, subject: subject, status: option.$1, room: room, startTime: startTime);
                }
                if (result != TimetableEntryResult.success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      result == TimetableEntryResult.notAdmin
                          ? 'You\'re not recognized as this group\'s class rep'
                          : 'You need to be signed in to do that',
                      style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white)),
                    backgroundColor: AppColors.error,
                    behavior: SnackBarBehavior.floating,
                  ));
                }
              } catch (e) {
                if (sheetContext.mounted) Navigator.pop(sheetContext);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Couldn\'t update status: $e', style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white)),
                    backgroundColor: AppColors.error,
                    behavior: SnackBarBehavior.floating,
                  ));
                }
              }
            },
          ),
        const Divider(height: 1),
        ListTile(
          leading: Icon(Icons.delete_outline_rounded, color: AppColors.error),
          title: Text('Delete this class', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.error)),
          onTap: () async {
            Navigator.pop(sheetContext); // close the status sheet first
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (dialogContext) => AlertDialog(
                backgroundColor: AppColors.card,
                title: Text('Delete $subject?', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                content: Text('This removes it from the timetable for every week, not just today. This can\'t be undone.',
                  style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: Text('Cancel', style: GoogleFonts.dmSans(color: AppColors.textSecondary))),
                  TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: Text('Delete', style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, color: AppColors.error))),
                ],
              ),
            );
            if (confirmed != true) return;

            try {
              final result = await TimetableService.deleteEntry(groupId: groupId, entryId: entryId);
              if (result != TimetableEntryResult.success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    result == TimetableEntryResult.notAdmin
                        ? 'You\'re not recognized as this group\'s class rep'
                        : 'You need to be signed in to do that',
                    style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white)),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                ));
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Couldn\'t delete: $e', style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white)),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                ));
              }
            }
          },
        ),
        const SizedBox(height: 8),
      ]),
    ),
  );
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isCancelled = status == 'cancelled';
    final bg = isCancelled ? AppColors.errorSurface : AppColors.warningSurface;
    final text = isCancelled ? AppColors.error : AppColors.warning;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(status.toUpperCase(),
        style: GoogleFonts.dmSans(fontSize: 9, fontWeight: FontWeight.w700, color: text, letterSpacing: 0.3)),
    );
  }
}

class _AssignmentsList extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> assignmentsStream;
  const _AssignmentsList({required this.assignmentsStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: assignmentsStream,
      builder: (context, snap) {
        final assignments = snap.data ?? [];
        if (assignments.isEmpty) {
          return Text('No assignments posted yet', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary));
        }
        return Column(children: assignments.map((a) {
          final subject = a['subject'] as String? ?? '';
          final title = a['title'] as String? ?? '';
          final dueAt = (a['dueAt'] as dynamic)?.toDate() as DateTime?;
          if (dueAt == null) return const SizedBox.shrink();

          final remaining = dueAt.difference(DateTime.now());
          final overdue = remaining.isNegative;
          final isUrgent = !overdue && remaining.inHours <= 24;
          final dueLabel = overdue
              ? 'Overdue'
              : remaining.inDays == 0
                  ? 'Due today'
                  : remaining.inDays == 1
                      ? 'Due tomorrow'
                      : 'Due in ${remaining.inDays} days';

          final bg = (overdue || isUrgent) ? AppColors.errorSurface : AppColors.warningSurface;
          final textColor = (overdue || isUrgent) ? AppColors.error : AppColors.warning;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(subject, style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
                ]),
              ),
              Text(dueLabel, style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700, color: textColor)),
            ]),
          );
        }).toList());
      },
    );
  }
}

class _SubjectsLegend extends StatelessWidget {
  final String groupId;
  const _SubjectsLegend({required this.groupId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: TimetableService.allEntries(groupId),
      builder: (context, snap) {
        final subjects = (snap.data ?? []).map((e) => e['subject'] as String? ?? '').toSet().toList();
        if (subjects.isEmpty) return const SizedBox.shrink();
        return Wrap(spacing: 6, runSpacing: 6, children: subjects.map((s) {
          final color = _lightColorFor(s);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(color: color['bg'], borderRadius: BorderRadius.circular(999)),
            child: Text(s, style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600, color: color['text'])),
          );
        }).toList());
      },
    );
  }
}