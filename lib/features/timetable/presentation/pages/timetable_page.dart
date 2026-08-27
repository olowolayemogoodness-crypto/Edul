// lib/features/timetable/presentation/pages/timetable_page.dart
//
// Class-wide, class-rep-driven schedule -- scoped to the user's own
// official SET30 group, not personal. Deliberately uses its own
// vibrant, per-subject color palette rather than the app's usual
// restrained AppColors system, matching the confirmed reference
// design specifically for this screen.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/timetable_service.dart';
import '../../../../core/services/user_service.dart';
import 'add_timetable_entry_page.dart';

const _bg = Color(0xFF150F2E);
const _cardBg = Color(0xFF1F1840);
const _textPrimary = Color(0xFFF4F2FF);
const _textSecondary = Color(0xFF8E84BE);
const _textTertiary = Color(0xFFA99FDB);
const _amber = Color(0xFFEF9F27);
const _teal = Color(0xFF5DCAA5);
const _urgentBg = Color(0xFF791F1F), _urgentText = Color(0xFFF7C1C1);
const _soonBg = Color(0xFF633806), _soonText = Color(0xFFFAC775);

const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
const _fullDayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

IconData _iconForSubject(String subject) {
  switch (subject.trim().toLowerCase()) {
    case 'english': return Icons.menu_book_rounded;
    case 'physics': return Icons.science_outlined;
    case 'math': return Icons.memory_rounded;
    case 'history': return Icons.public_rounded;
    case 'music': return Icons.music_note_rounded;
    case 'art': return Icons.star_border_rounded;
    default: return Icons.school_outlined;
  }
}

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  String? _groupId;
  bool _isClassRep = false;
  Stream<List<Map<String, dynamic>>>? _entriesStream;
  Stream<List<Map<String, dynamic>>>? _assignmentsStream;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final groupId = await TimetableService.myOfficialGroupId();
    if (groupId == null) { if (mounted) setState(() {}); return; }
    setState(() {
      _groupId = groupId;
      // Created exactly once here, not inside any widget's build() --
      // that was the actual bug: each rebuild was creating a brand new
      // Firestore stream, which resets StreamBuilder to its empty
      // "waiting" state until the new stream's first result arrives,
      // producing the appears-and-disappears flicker.
      _entriesStream = TimetableService.entriesForDay(groupId, _todayLabel);
      _assignmentsStream = TimetableService.assignments(groupId);
    });
    final isRep = await TimetableService.isClassRep(groupId);
    if (mounted) setState(() => _isClassRep = isRep);
  }

  String get _todayLabel => _days[(DateTime.now().weekday - 1).clamp(0, 4)];

  @override
  Widget build(BuildContext context) {
    if (_groupId == null || _entriesStream == null || _assignmentsStream == null) {
      return Scaffold(backgroundColor: _bg, body: Center(
        child: Text('Join your official class group to see its timetable',
          style: GoogleFonts.dmSans(fontSize: 13, color: _textSecondary))));
    }
    final groupId = _groupId!;
    final entriesStream = _entriesStream!;
    final assignmentsStream = _assignmentsStream!;

    return Scaffold(
      backgroundColor: _bg,
      floatingActionButton: _isClassRep ? FloatingActionButton(
        backgroundColor: _amber,
        child: const Icon(Icons.add_rounded, color: Colors.black),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AddTimetableEntryPage(groupId: groupId))),
      ) : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _Header(),
            const SizedBox(height: 16),
            _StatsRow(entriesStream: entriesStream, assignmentsStream: assignmentsStream),
            const SizedBox(height: 16),
            _StreakBanner(),
            const SizedBox(height: 18),
            _SectionLabel('NEXT UP'),
            const SizedBox(height: 8),
            _NextUpCard(entriesStream: entriesStream),
            const SizedBox(height: 18),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _SectionLabel('URGENT DEADLINES'),
              Text('scroll →', style: GoogleFonts.dmSans(fontSize: 11, color: const Color(0xFFAFA9EC))),
            ]),
            const SizedBox(height: 8),
            _AssignmentsRow(assignmentsStream: assignmentsStream),
            const SizedBox(height: 18),
            _SectionLabel('TODAY · ${_fullDayNames[_days.indexOf(_todayLabel).clamp(0, 4)].toUpperCase()}'),
            const SizedBox(height: 8),
            _TodayList(entriesStream: entriesStream),
            const SizedBox(height: 18),
            _SectionLabel('SUBJECTS'),
            const SizedBox(height: 8),
            _SubjectsLegend(groupId: groupId),
            const SizedBox(height: 90),
          ]),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    final greeting = hour < 12 ? 'Good morning' : hour < 17 ? 'Good afternoon' : 'Good evening';
    return FutureBuilder<Map<String, dynamic>?>(
      future: UserService.getProfile(),
      builder: (context, snap) {
        final displayName = snap.data?['displayName'] as String? ?? 'there';
        final name = displayName.split(' ').first;

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // No comma between weekday and date -- matches the confirmed reference exactly.
          Text('${_weekday(now.weekday)} ${now.day} ${_month(now.month)}',
            style: GoogleFonts.dmSans(fontSize: 12, color: _textTertiary)),
          const SizedBox(height: 2),
          RichText(text: TextSpan(children: [
            TextSpan(text: '$greeting, ', style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w700, color: _textPrimary)),
            TextSpan(text: name, style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w700, color: const Color(0xFFED93B1))),
            const TextSpan(text: ' ✦', style: TextStyle(fontSize: 20, color: _textPrimary)),
          ])),
        ]);
      },
    );
  }

  static String _weekday(int d) => const ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'][d - 1];
  static String _month(int m) => const ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m - 1];
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
    style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 0.8, color: _textSecondary));
}

class _StatsRow extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> entriesStream;
  final Stream<List<Map<String, dynamic>>> assignmentsStream;
  const _StatsRow({required this.entriesStream, required this.assignmentsStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: assignmentsStream,
      builder: (context, aSnap) {
        final assignments = aSnap.data ?? [];
        final dueSoon = assignments.where((a) {
          final due = (a['dueAt'] as dynamic)?.toDate() as DateTime?;
          return due != null && due.difference(DateTime.now()).inDays <= 3;
        }).length;

        return StreamBuilder<List<Map<String, dynamic>>>(
          stream: entriesStream,
          builder: (context, eSnap) {
            final classesToday = (eSnap.data ?? []).length;
            return Row(children: [
              Expanded(child: _StatCard(value: '${assignments.length}', label: 'Assignments', color: const Color(0xFFCEC9F6))),
              const SizedBox(width: 8),
              Expanded(child: _StatCard(value: '$dueSoon', label: 'Due soon', color: const Color(0xFFE24B4A))),
              const SizedBox(width: 8),
              Expanded(child: _StatCard(value: '$classesToday', label: 'Classes', color: _teal)),
            ]);
          },
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value, label;
  final Color color;
  const _StatCard({required this.value, required this.label, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    decoration: BoxDecoration(color: _cardBg, borderRadius: BorderRadius.circular(12)),
    child: Column(children: [
      Text(value, style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w700, color: color)),
      Text(label, style: GoogleFonts.dmSans(fontSize: 10, color: _textSecondary)),
    ]),
  );
}

class _StreakBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(color: const Color(0xFF241A38), borderRadius: BorderRadius.circular(14), border: Border.all(color: _amber)),
    child: Row(children: [
      Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFF3A2E14), shape: BoxShape.circle),
        child: Icon(Icons.bolt_rounded, color: _amber, size: 20)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('7 day streak!', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: _textPrimary)),
        Text('keep it going — check off today\'s tasks', style: GoogleFonts.dmSans(fontSize: 11, color: _textSecondary)),
      ])),
    ]),
  );
}

class _NextUpCard extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> entriesStream;
  const _NextUpCard({required this.entriesStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: entriesStream,
      builder: (context, snap) {
        final entries = snap.data ?? [];
        final nowMinutes = DateTime.now().hour * 60 + DateTime.now().minute;
        final next = entries.where((e) => (e['startMinutes'] as int? ?? 0) >= nowMinutes).toList();

        if (next.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: _cardBg, borderRadius: BorderRadius.circular(14)),
            child: Text('No more classes today', style: GoogleFonts.dmSans(fontSize: 13, color: _textSecondary)),
          );
        }
        final entry = next.first;
        final subject = entry['subject'] as String? ?? '';
        final color = TimetableService.colorFor(subject);

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color(int.parse(color['bg']!.substring(1), radix: 16) + 0xFF000000),
            border: Border(left: BorderSide(color: Color(int.parse(color['border']!.substring(1), radix: 16) + 0xFF000000), width: 3)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Container(width: 40, height: 40,
                decoration: BoxDecoration(shape: BoxShape.circle,
                  color: Color(int.parse(color['badgeBg']!.substring(1), radix: 16) + 0xFF000000)),
                child: Icon(_iconForSubject(subject), size: 18,
                  color: Color(int.parse(color['text']!.substring(1), radix: 16) + 0xFF000000))),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(subject, style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700,
                  color: Color(int.parse(color['text']!.substring(1), radix: 16) + 0xFF000000))),
                Text('${entry['startTime']}–${entry['endTime']} · ${entry['room']}',
                  style: GoogleFonts.dmSans(fontSize: 12, color: _textTertiary)),
              ]),
            ]),
            Icon(Icons.chevron_right_rounded, color: _textSecondary),
          ]),
        );
      },
    );
  }
}

class _AssignmentsRow extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> assignmentsStream;
  const _AssignmentsRow({required this.assignmentsStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: assignmentsStream,
      builder: (context, snap) {
        final assignments = snap.data ?? [];
        if (assignments.isEmpty) {
          return Text('No assignments posted yet', style: GoogleFonts.dmSans(fontSize: 12, color: _textSecondary));
        }
        return SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: assignments.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) {
              final a = assignments[i];
              final subject = a['subject'] as String? ?? '';
              final title = a['title'] as String? ?? '';
              final dueAt = (a['dueAt'] as dynamic)?.toDate() as DateTime?;
              final color = TimetableService.colorFor(subject);
              if (dueAt == null) return const SizedBox.shrink();

              final remaining = dueAt.difference(DateTime.now());
              final isUrgent = remaining.inHours <= 24;
              final overdue = remaining.isNegative;

              return Container(
                width: 150,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(int.parse(color['bg']!.substring(1), radix: 16) + 0xFF000000),
                  border: Border.all(color: Color(int.parse(color['border']!.substring(1), radix: 16) + 0xFF000000)),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Icon(_iconForSubject(subject), size: 13,
                      color: Color(int.parse(color['text']!.substring(1), radix: 16) + 0xFF000000)),
                    const SizedBox(width: 4),
                    Text(subject.toUpperCase(), style: GoogleFonts.dmSans(fontSize: 10,
                      color: Color(int.parse(color['text']!.substring(1), radix: 16) + 0xFF000000))),
                  ]),
                  const SizedBox(height: 4),
                  Text(title, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: _textPrimary),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  overdue
                      ? Text('Overdue', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700,
                          color: Color(int.parse(color['text']!.substring(1), radix: 16) + 0xFF000000)))
                      : _CountdownBlocks(dueAt: dueAt,
                          color: Color(int.parse(color['text']!.substring(1), radix: 16) + 0xFF000000)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: isUrgent ? _urgentBg : _soonBg, borderRadius: BorderRadius.circular(8)),
                    child: Text(isUrgent ? 'urgent' : 'soon',
                      style: GoogleFonts.dmSans(fontSize: 9, color: isUrgent ? _urgentText : _soonText)),
                  ),
                ]),
              );
            },
          ),
        );
      },
    );
  }
}

class _CountdownBlocks extends StatefulWidget {
  final DateTime dueAt;
  final Color color;
  const _CountdownBlocks({required this.dueAt, required this.color});

  @override
  State<_CountdownBlocks> createState() => _CountdownBlocksState();
}

class _CountdownBlocksState extends State<_CountdownBlocks> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Isolated to just this small widget -- ticking here rebuilds
    // only these four numbers, not the whole screen (that was the
    // earlier bug: a page-wide timer was flickering the header/avatar
    // every second along with the countdown).
    _timer = Timer.periodic(const Duration(seconds: 1), (_) { if (mounted) setState(() {}); });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.dueAt.difference(DateTime.now());
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    Widget block(int value, String label) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(value.toString().padLeft(2, '0'), style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700, color: widget.color)),
      Text(label, style: GoogleFonts.dmSans(fontSize: 9, color: _textSecondary)),
    ]);

    return Row(children: [
      block(days, 'D'), const SizedBox(width: 6),
      block(hours, 'H'), const SizedBox(width: 6),
      block(minutes, 'M'), const SizedBox(width: 6),
      block(seconds, 'S'),
    ]);
  }
}

class _TodayList extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> entriesStream;
  const _TodayList({required this.entriesStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: entriesStream,
      builder: (context, snap) {
        final entries = snap.data ?? [];
        if (entries.isEmpty) {
          return Text('No classes scheduled today', style: GoogleFonts.dmSans(fontSize: 12, color: _textSecondary));
        }
        return Column(children: entries.map((e) {
          final subject = e['subject'] as String? ?? '';
          final color = TimetableService.colorFor(subject);
          final startTime = e['startTime'] as String? ?? '';
          final endTime = e['endTime'] as String? ?? '';
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: Color(int.parse(color['bg']!.substring(1), radix: 16) + 0xFF000000),
                borderRadius: BorderRadius.circular(30)), // fully rounded, pill shape
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle,
                    color: Color(int.parse(color['text']!.substring(1), radix: 16) + 0xFF000000))),
                  const SizedBox(width: 10),
                  Text(subject, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700,
                    color: Color(int.parse(color['text']!.substring(1), radix: 16) + 0xFF000000))),
                ]),
                // Explicit ask: show the full start-end range here, not
                // just the start time -- deliberately different from
                // the plain reference image on this one specific detail.
                Text('$startTime–$endTime', style: GoogleFonts.dmSans(fontSize: 12, color: _textSecondary)),
              ]),
            ),
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
          final color = TimetableService.colorFor(s);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Color(int.parse(color['badgeBg']!.substring(1), radix: 16) + 0xFF000000),
              borderRadius: BorderRadius.circular(12)),
            child: Text(s, style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700,
              color: Color(int.parse(color['badgeText']!.substring(1), radix: 16) + 0xFF000000))),
          );
        }).toList());
      },
    );
  }
}