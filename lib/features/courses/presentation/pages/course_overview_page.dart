// lib/features/courses/presentation/pages/course_overview_page.dart
//
// REAL DATA: schedule comes from CourseScheduleService (bridging to
// real Timetable entries via course.subject), recaps and materials
// come from courses/{id}/recaps and courses/{id}/materials
// subcollections, and books come straight off course.textbooks.
// None of these have an in-app authoring tool yet -- ambassadors add
// recap/material documents directly in Firestore, same manual
// pattern as courses and departments themselves.
//
// The one thing that stays mock: the actual Live Class video screen
// (live_class_page.dart) has no real video/streaming backend behind
// it. Join live class only becomes reachable when a real timetable
// session says a class is happening right now -- the SCHEDULING is
// real, the VIDEO CALL is still the UI-only mock built earlier.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/course_service.dart';
import '../../../../core/services/course_schedule_service.dart';
import '../../../../core/services/group_service.dart';
import 'live_class_page.dart';
import 'course_edit_page.dart';
import 'recap_edit_page.dart';
import 'material_edit_page.dart';

class CourseOverviewPage extends StatefulWidget {
  final CourseModel course;
  const CourseOverviewPage({super.key, required this.course});

  @override
  State<CourseOverviewPage> createState() => _CourseOverviewPageState();
}

class _CourseOverviewPageState extends State<CourseOverviewPage> with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 4, vsync: this);
  late CourseModel _course = widget.course; // mutable copy -- updated in place after an edit, so the caller's list doesn't need to reload
  bool _isClassRep = false;
  bool _saved = false;
  bool _loading = true;
  String? _loadError;
  List<ClassSession> _sessions = [];
  List<RecapEntry> _recaps = [];
  List<MaterialEntry> _materials = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _loadError = null; });
    try {
      final results = await Future.wait([
        CourseScheduleService.sessionsForSubject(_course.subject),
        CourseService.recapsForCourse(_course.id),
        CourseService.materialsForCourse(_course.id),
        GroupService.amIClassRepOfMyGroup(),
      ]);
      if (!mounted) return;
      setState(() {
        _sessions = results[0] as List<ClassSession>;
        _recaps = results[1] as List<RecapEntry>;
        _materials = results[2] as List<MaterialEntry>;
        _isClassRep = results[3] as bool;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() { _loadError = e.toString(); _loading = false; });
    }
  }

  Future<void> _refreshCourseAndData() async {
    final refreshed = await CourseService.getCourseById(_course.id);
    if (!mounted || refreshed == null) return;
    setState(() => _course = refreshed);
    _load();
  }

  Future<void> _editCourse() async {
    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => CourseEditPage(existing: _course, set: _course.set)),
    );
    if (saved == true) _refreshCourseAndData();
  }

  void _notImplemented(String what) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(what, style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white)),
      backgroundColor: AppColors.surfaceVariant,
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<void> _openUrl(String url) async {
    if (url.isEmpty) {
      _notImplemented('No file linked yet');
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null || !await canLaunchUrl(uri)) {
      _notImplemented('Couldn\'t open that link');
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final course = _course;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
            child: Row(children: [
              IconButton(
                icon: Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(course.name, style: GoogleFonts.dmSans(
                    fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(course.instructor.isNotEmpty ? '${course.code} · Prof. ${course.instructor}' : course.code,
                    style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                ]),
              ),
              if (_isClassRep)
                IconButton(
                  icon: Icon(Icons.edit_outlined, color: AppColors.textPrimary),
                  onPressed: _editCourse,
                ),
              IconButton(
                icon: Icon(_saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                  color: _saved ? AppColors.accent : AppColors.textPrimary),
                onPressed: () => setState(() => _saved = !_saved),
              ),
            ]),
          ),
          TabBar(
            controller: _tabs,
            isScrollable: false,
            labelColor: AppColors.accent,
            unselectedLabelColor: AppColors.textTertiary,
            indicatorColor: AppColors.accent,
            labelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600),
            unselectedLabelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500),
            tabs: const [
              Tab(text: 'Overview'), Tab(text: 'Recaps'), Tab(text: 'Materials'), Tab(text: 'Books'),
            ],
          ),
          Expanded(
            child: _loading
                ? Center(child: CircularProgressIndicator(color: AppColors.accent))
                : _loadError != null
                    ? _ErrorState(error: _loadError!, onRetry: _load)
                    : TabBarView(controller: _tabs, children: [
                        _OverviewTab(courseId: course.id, course: course, sessions: _sessions, recaps: _recaps, isClassRep: _isClassRep, onChanged: _refreshCourseAndData, onNotImplemented: _notImplemented),
                        _RecapsTab(courseId: course.id, recaps: _recaps, accent: course.accentColor, isClassRep: _isClassRep, onChanged: _load, onOpenUrl: _openUrl),
                        _MaterialsTab(courseId: course.id, materials: _materials, accent: course.accentColor, isClassRep: _isClassRep, onChanged: _load, onOpenUrl: _openUrl),
                        _BooksTab(course: course, onNotImplemented: _notImplemented),
                      ]),
          ),
        ]),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const _ErrorState({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.error_outline_rounded, size: 40, color: AppColors.error),
          const SizedBox(height: 12),
          Text('Couldn\'t load this course', style: GoogleFonts.dmSans(
            fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(10)),
            child: SelectableText(error, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary)),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white),
            child: Text('Retry', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ]),
      ),
    );
  }
}

// ============================================================
// OVERVIEW TAB
// ============================================================
class _OverviewTab extends StatelessWidget {
  final String courseId;
  final CourseModel course;
  final List<ClassSession> sessions;
  final List<RecapEntry> recaps;
  final bool isClassRep;
  final VoidCallback onChanged;
  final void Function(String) onNotImplemented;
  const _OverviewTab({
    required this.courseId, required this.course, required this.sessions, required this.recaps,
    required this.isClassRep, required this.onChanged, required this.onNotImplemented,
  });

  String _dayTimeLabel(ClassSession s) {
    final now = DateTime.now();
    final isToday = s.start.year == now.year && s.start.month == now.month && s.start.day == now.day;
    final isTomorrow = s.start.difference(DateTime(now.year, now.month, now.day)).inDays == 1;
    final dayLabel = isToday ? 'Today' : (isTomorrow ? 'Tomorrow' : s.day);
    return '$dayLabel · ${s.startTime} - ${s.endTime}${s.room.isNotEmpty ? ' · ${s.room}' : ''}';
  }

  @override
  Widget build(BuildContext context) {
    final next = sessions.isNotEmpty ? sessions.first : null;
    final upcoming = sessions.length > 1 ? sessions.sublist(1, sessions.length.clamp(0, 4)) : <ClassSession>[];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        if (next == null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(18)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('No scheduled classes linked yet', style: GoogleFonts.dmSans(
                fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 4),
              Text(
                course.subject.isEmpty
                    ? 'This course isn\'t linked to a Timetable subject yet.'
                    : 'No Timetable entries found for "${course.subject}" in your class yet.',
                style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary),
              ),
            ]),
          )
        else
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [course.accentColor, course.accentColor.withOpacity(0.75)],
              ),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text('NEXT CLASS', style: GoogleFonts.dmSans(
                  fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.85), letterSpacing: 0.5)),
                const Spacer(),
                if (next.isHappeningNow)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(999)),
                    child: Text('● LIVE NOW', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                  ),
              ]),
              const SizedBox(height: 10),
              Text(next.subject, style: GoogleFonts.dmSans(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 4),
              Text(_dayTimeLabel(next), style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white.withOpacity(0.9))),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: next.isHappeningNow
                        ? () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => LiveClassPage(
                              course: course, sessionTitle: next.subject,
                              instructor: course.instructor.isNotEmpty ? 'Prof. ${course.instructor}' : 'Staff',
                            ),
                          ))
                        : () => onNotImplemented('This class isn\'t live right now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, foregroundColor: course.accentColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(next.isHappeningNow ? 'Join live class' : 'Not live yet', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => onNotImplemented('Reminders aren\'t wired up yet'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white, side: const BorderSide(color: Colors.white54),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Remind me', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700)),
                  ),
                ),
              ]),
            ]),
          ),

        if (upcoming.isNotEmpty) ...[
          const SizedBox(height: 24),
          Text('Upcoming classes', style: GoogleFonts.dmSans(
            fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          for (final s in upcoming)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.card, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border)),
              child: Row(children: [
                Container(
                  width: 40, height: 40, alignment: Alignment.center,
                  decoration: BoxDecoration(color: course.accentColor.withOpacity(0.14), borderRadius: BorderRadius.circular(10)),
                  child: Text(s.day.length >= 3 ? s.day.substring(0, 3) : s.day, style: GoogleFonts.dmSans(
                    fontSize: 12, fontWeight: FontWeight.w700, color: course.accentColor)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(s.subject, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    Text(_dayTimeLabel(s), style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                  ]),
                ),
              ]),
            ),
        ],

        if (isClassRep || course.curriculum.isNotEmpty) ...[
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: Text('Syllabus', style: GoogleFonts.dmSans(
              fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
            if (isClassRep)
              TextButton(
                onPressed: () => _showAddTopicDialog(context),
                child: Text('+ Add topic', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.accent)),
              ),
          ]),
          const SizedBox(height: 12),
          for (final topic in course.curriculum)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.card, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (topic.week != null || (topic.location != null && topic.location!.isNotEmpty))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(children: [
                      if (topic.week != null)
                        Text('WEEK ${topic.week}', style: GoogleFonts.dmSans(
                          fontSize: 10, fontWeight: FontWeight.w700, color: course.accentColor, letterSpacing: 0.5)),
                      if (topic.week != null && topic.location != null && topic.location!.isNotEmpty)
                        Text('  ·  ', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
                      if (topic.location != null && topic.location!.isNotEmpty)
                        Text(topic.location!, style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
                    ]),
                  ),
                Text(topic.title, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                if (topic.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(topic.description, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ]),
            ),
        ],

        if (recaps.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text('Latest recap', style: GoogleFonts.dmSans(
            fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          _RecapCard(recap: recaps.first, accent: course.accentColor, onOpenUrl: null),
        ],
      ],
    );
  }

  void _showAddTopicDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final weekCtrl = TextEditingController();
    final locationCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text('Add syllabus topic', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            Expanded(
              child: TextField(
                controller: weekCtrl,
                keyboardType: TextInputType.number,
                style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
                decoration: InputDecoration(hintText: 'Week #', hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: locationCtrl,
                style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
                decoration: InputDecoration(hintText: 'Location (e.g. Hall B204)', hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
              ),
            ),
          ]),
          TextField(
            controller: titleCtrl,
            style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
            decoration: InputDecoration(hintText: 'Topic title', hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
          ),
          TextField(
            controller: descCtrl,
            maxLines: 2,
            style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
            decoration: InputDecoration(hintText: 'Short description', hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
          ),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: Text('Cancel', style: GoogleFonts.dmSans(color: AppColors.textSecondary))),
          TextButton(
            onPressed: () async {
              if (titleCtrl.text.trim().isEmpty) return;
              await CourseService.addCurriculumTopic(
                courseId: courseId, title: titleCtrl.text, description: descCtrl.text,
                week: int.tryParse(weekCtrl.text.trim()), location: locationCtrl.text,
              );
              if (dialogContext.mounted) Navigator.pop(dialogContext);
              onChanged();
            },
            child: Text('Add', style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, color: AppColors.accent)),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// RECAPS TAB
// ============================================================
class _RecapsTab extends StatefulWidget {
  final String courseId;
  final List<RecapEntry> recaps;
  final Color accent;
  final bool isClassRep;
  final VoidCallback onChanged;
  final Future<void> Function(String) onOpenUrl;
  const _RecapsTab({
    required this.courseId, required this.recaps, required this.accent,
    required this.isClassRep, required this.onChanged, required this.onOpenUrl,
  });

  @override
  State<_RecapsTab> createState() => _RecapsTabState();
}

class _RecapsTabState extends State<_RecapsTab> {
  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final recaps = widget.recaps.where((r) {
      switch (_filter) {
        case 'Notes': return r.notesUrl != null && r.notesUrl!.isNotEmpty;
        case 'Audio': return r.audioUrl != null && r.audioUrl!.isNotEmpty;
        case 'Files': return r.files.isNotEmpty;
        default: return true;
      }
    }).toList();

    Widget content;
    if (widget.recaps.isEmpty) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.event_note_outlined, size: 40, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text('No recaps yet', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            Text('Lecture recaps show up here once they\'re added for this course.',
              textAlign: TextAlign.center, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
          ]),
        ),
      );
    } else {
      content = Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
        child: Row(children: [
          for (final f in ['All', 'Notes', 'Audio', 'Files'])
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(f, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600,
                  color: _filter == f ? Colors.white : AppColors.textSecondary)),
                selected: _filter == f,
                onSelected: (_) => setState(() => _filter = f),
                selectedColor: AppColors.accent,
                backgroundColor: AppColors.surfaceVariant,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                side: BorderSide.none,
              ),
            ),
        ]),
      ),
      Expanded(
        child: recaps.isEmpty
            ? Center(child: Text('No recaps in this filter yet',
                style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)))
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                children: [for (final r in recaps) _RecapCard(recap: r, accent: widget.accent, onOpenUrl: widget.onOpenUrl)],
              ),
      ),
    ]);
    }

    return Stack(children: [
      content,
      if (widget.isClassRep)
        Positioned(
          right: 16, bottom: 16,
          child: FloatingActionButton(
            heroTag: 'add_recap',
            backgroundColor: AppColors.accent,
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final saved = await Navigator.of(context).push<bool>(
                MaterialPageRoute(builder: (_) => RecapEditPage(courseId: widget.courseId)));
              if (saved == true) widget.onChanged();
            },
          ),
        ),
    ]);
  }
}

class _RecapCard extends StatelessWidget {
  final RecapEntry recap;
  final Color accent;
  final Future<void> Function(String)? onOpenUrl;
  const _RecapCard({required this.recap, required this.accent, required this.onOpenUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(recap.dateLabel.isNotEmpty ? '${recap.dateLabel} · Lecture ${recap.lectureNumber}' : 'Lecture ${recap.lectureNumber}',
          style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600, color: accent)),
        const SizedBox(height: 4),
        Text(recap.title, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        if (recap.description.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(recap.description, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
        ],
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: [
          if (recap.notesUrl != null && recap.notesUrl!.isNotEmpty)
            _Tag(icon: Icons.description_outlined,
              label: recap.notesPages != null ? 'Notes · ${recap.notesPages} pages' : 'Notes',
              onTap: onOpenUrl == null ? null : () => onOpenUrl!(recap.notesUrl!)),
          if (recap.audioUrl != null && recap.audioUrl!.isNotEmpty)
            _Tag(icon: Icons.headphones_outlined,
              label: recap.audioMinutes != null ? '${recap.audioMinutes} min' : 'Audio',
              onTap: onOpenUrl == null ? null : () => onOpenUrl!(recap.audioUrl!)),
          if (recap.files.isNotEmpty)
            _Tag(icon: Icons.folder_outlined, label: '${recap.files.length} files',
              onTap: onOpenUrl == null ? null : () => onOpenUrl!(recap.files.first.url)),
        ]),
      ]),
    );
  }
}

class _Tag extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _Tag({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(8)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 13, color: AppColors.textTertiary),
          const SizedBox(width: 4),
          Text(label, style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
        ]),
      ),
    );
  }
}

// ============================================================
// MATERIALS TAB
// ============================================================
class _MaterialsTab extends StatelessWidget {
  final String courseId;
  final List<MaterialEntry> materials;
  final Color accent;
  final bool isClassRep;
  final VoidCallback onChanged;
  final Future<void> Function(String) onOpenUrl;
  const _MaterialsTab({
    required this.courseId, required this.materials, required this.accent,
    required this.isClassRep, required this.onChanged, required this.onOpenUrl,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (materials.isEmpty) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.folder_open_outlined, size: 40, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text('No materials yet', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            Text('Slides, problem sets, and readings show up here once they\'re added.',
              textAlign: TextAlign.center, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
          ]),
        ),
      );
    } else {

    final byFolder = <String, List<MaterialEntry>>{};
    for (final m in materials) {
      byFolder.putIfAbsent(m.folder, () => []).add(m);
    }

    content = ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        Text('Folders', style: GoogleFonts.dmSans(
          fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        for (final entry in byFolder.entries)
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.background,
              isScrollControlled: true,
              builder: (_) => _FolderSheet(name: entry.key, files: entry.value, accent: accent, onOpenUrl: onOpenUrl),
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.card, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border)),
              child: Row(children: [
                Container(
                  width: 40, height: 40, alignment: Alignment.center,
                  decoration: BoxDecoration(color: accent.withOpacity(0.14), borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.folder_rounded, color: accent, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(entry.key, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    Text('${entry.value.length} file${entry.value.length == 1 ? '' : 's'}', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                  ]),
                ),
                Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
              ]),
            ),
          ),

        const SizedBox(height: 12),
        Text('Recent files', style: GoogleFonts.dmSans(
          fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        for (final file in materials.take(10))
          _FileRow(file: file, onOpenUrl: onOpenUrl),
      ],
    );
    }

    return Stack(children: [
      content,
      if (isClassRep)
        Positioned(
          right: 16, bottom: 16,
          child: FloatingActionButton(
            heroTag: 'add_material',
            backgroundColor: AppColors.accent,
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final saved = await Navigator.of(context).push<bool>(
                MaterialPageRoute(builder: (_) => MaterialEditPage(
                  courseId: courseId,
                  existingFolders: materials.map((m) => m.folder).toSet().toList(),
                )),
              );
              if (saved == true) onChanged();
            },
          ),
        ),
    ]);
  }
}

class _FolderSheet extends StatelessWidget {
  final String name;
  final List<MaterialEntry> files;
  final Color accent;
  final Future<void> Function(String) onOpenUrl;
  const _FolderSheet({required this.name, required this.files, required this.accent, required this.onOpenUrl});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(name, style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
            child: ListView(
              shrinkWrap: true,
              children: [for (final f in files) _FileRow(file: f, onOpenUrl: onOpenUrl)],
            ),
          ),
        ]),
      ),
    );
  }
}

class _FileRow extends StatelessWidget {
  final MaterialEntry file;
  final Future<void> Function(String) onOpenUrl;
  const _FileRow({required this.file, required this.onOpenUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border)),
      child: Row(children: [
        Icon(Icons.insert_drive_file_outlined, color: AppColors.textSecondary, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(file.name, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              maxLines: 1, overflow: TextOverflow.ellipsis),
            Text([file.fileType, if (file.sizeLabel != null) file.sizeLabel!].where((s) => s.isNotEmpty).join(' · '),
              style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
          ]),
        ),
        IconButton(
          icon: Icon(Icons.download_rounded, color: AppColors.textSecondary, size: 20),
          onPressed: () => onOpenUrl(file.url),
        ),
      ]),
    );
  }
}

// ============================================================
// BOOKS TAB
// ============================================================
class _BooksTab extends StatefulWidget {
  final CourseModel course;
  final void Function(String) onNotImplemented;
  const _BooksTab({required this.course, required this.onNotImplemented});

  @override
  State<_BooksTab> createState() => _BooksTabState();
}

class _BooksTabState extends State<_BooksTab> {
  bool _showRequired = true;

  @override
  Widget build(BuildContext context) {
    final required = widget.course.textbooks.where((b) => b.required).toList();
    final recommended = widget.course.textbooks.where((b) => !b.required).toList();
    final books = _showRequired ? required : recommended;

    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
        child: Row(children: [
          Expanded(child: _BookToggle(label: 'Required', selected: _showRequired, onTap: () => setState(() => _showRequired = true))),
          const SizedBox(width: 8),
          Expanded(child: _BookToggle(label: 'Recommended', selected: !_showRequired, onTap: () => setState(() => _showRequired = false))),
        ]),
      ),
      Expanded(
        child: books.isEmpty
            ? Center(child: Text('No ${_showRequired ? 'required' : 'recommended'} books listed yet',
                style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)))
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                children: [
                  for (final b in books)
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => BookDetailPage(book: b, accentColor: widget.course.accentColor, courseCode: widget.course.code),
                      )),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.card, borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.border)),
                        child: Row(children: [
                          Container(
                            width: 44, height: 58,
                            decoration: BoxDecoration(color: widget.course.accentColor.withOpacity(0.18), borderRadius: BorderRadius.circular(6)),
                            child: Icon(Icons.menu_book_rounded, size: 20, color: widget.course.accentColor),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(b.title, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                              Text(b.author, style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
                              if (b.price.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(b.price, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: widget.course.accentColor)),
                              ],
                            ]),
                          ),
                          GestureDetector(
                            onTap: () => widget.onNotImplemented('Textbook purchasing is coming soon'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(20)),
                              child: Text('Buy', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                            ),
                          ),
                        ]),
                      ),
                    ),
                ],
              ),
      ),
    ]);
  }
}

class _BookToggle extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _BookToggle({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(10)),
        child: Text(label, style: GoogleFonts.dmSans(
          fontSize: 13, fontWeight: FontWeight.w600, color: selected ? Colors.white : AppColors.textSecondary)),
      ),
    );
  }
}

String _withCommas(int n) {
  final s = n.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return buf.toString();
}

// ============================================================
// BOOK DETAIL PAGE
// ============================================================
class BookDetailPage extends StatefulWidget {
  final Textbook book;
  final Color accentColor;
  final String courseCode;
  const BookDetailPage({super.key, required this.book, required this.accentColor, required this.courseCode});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool _selectedNew = true;
  bool _favorited = false;

  void _notImplemented(String what) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(what, style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white)),
      backgroundColor: AppColors.surfaceVariant,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final hasUsed = book.usedPrice != null && book.usedPrice!.isNotEmpty;
    final selectedPrice = (_selectedNew || !hasUsed) ? book.price : book.usedPrice!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
            child: Row(children: [
              IconButton(
                icon: Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Column(children: [
                  Text('Book details', style: GoogleFonts.dmSans(
                    fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  Text('${widget.courseCode} · ${book.required ? 'required' : 'recommended'} reading', style: GoogleFonts.dmSans(
                    fontSize: 11, color: AppColors.textTertiary)),
                ]),
              ),
              IconButton(
                icon: Icon(Icons.ios_share_rounded, color: AppColors.textPrimary),
                onPressed: () => _notImplemented('Sharing isn\'t wired up yet'),
              ),
              IconButton(
                icon: Icon(_favorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: _favorited ? AppColors.error : AppColors.textPrimary),
                onPressed: () => setState(() => _favorited = !_favorited),
              ),
            ]),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    width: 90, height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                        colors: [widget.accentColor, widget.accentColor.withOpacity(0.6)],
                      ),
                    ),
                    child: Icon(Icons.menu_book_rounded, color: Colors.white.withOpacity(0.8), size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(book.title, style: GoogleFonts.dmSans(
                        fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      const SizedBox(height: 2),
                      Text(book.author, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
                      if (book.rating != null) ...[
                        const SizedBox(height: 8),
                        Row(children: [
                          Icon(Icons.star_rounded, size: 16, color: AppColors.gold),
                          const SizedBox(width: 4),
                          Text(book.rating.toString(), style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          if (book.ratingCount != null) ...[
                            const SizedBox(width: 4),
                            Text('(${_withCommas(book.ratingCount!)} ratings)', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                          ],
                        ]),
                      ],
                      if (book.edition != null || book.pages != null || book.format != null) ...[
                        const SizedBox(height: 8),
                        if (book.edition != null)
                          Text(book.edition!, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                        if (book.pages != null || book.format != null)
                          Text([if (book.pages != null) '${book.pages} pages', if (book.format != null) book.format!].join(' · '),
                            style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                      ],
                      if (book.isbn != null) ...[
                        const SizedBox(height: 2),
                        Text('ISBN ${book.isbn}', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                      ],
                    ]),
                  ),
                ]),

                const SizedBox(height: 20),
                Row(children: [
                  Expanded(
                    child: _PriceOption(
                      label: 'New', price: book.price, note: 'Ships in 2-4 days',
                      selected: _selectedNew, accentColor: widget.accentColor,
                      onTap: () => setState(() => _selectedNew = true),
                    ),
                  ),
                  if (hasUsed) ...[
                    const SizedBox(width: 10),
                    Expanded(
                      child: _PriceOption(
                        label: 'Used · Good', price: book.usedPrice!, note: 'Campus pickup',
                        selected: !_selectedNew, accentColor: widget.accentColor,
                        onTap: () => setState(() => _selectedNew = false),
                      ),
                    ),
                  ],
                ]),

                const SizedBox(height: 14),
                if (book.inStock)
                  Row(children: [
                    Icon(Icons.check_circle_rounded, size: 16, color: AppColors.success),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        _selectedNew ? 'In stock — ships from the campus bookstore' : 'In stock at Campus Store — reserve for pickup today',
                        style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.success)),
                    ),
                  ])
                else
                  Row(children: [
                    Icon(Icons.error_outline_rounded, size: 16, color: AppColors.warning),
                    const SizedBox(width: 6),
                    Text('Currently out of stock', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.warning)),
                  ]),

                if (book.description != null && book.description!.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(book.description!, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                ],
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            decoration: BoxDecoration(color: AppColors.surface, border: Border(top: BorderSide(color: AppColors.border))),
            child: Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _notImplemented('Textbook purchasing is coming soon'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary, side: BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Add to cart', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _notImplemented('Textbook purchasing is coming soon'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.accentColor, foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(selectedPrice.isNotEmpty ? 'Buy now · $selectedPrice' : 'Buy now', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700)),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _PriceOption extends StatelessWidget {
  final String label;
  final String price;
  final String note;
  final bool selected;
  final Color accentColor;
  final VoidCallback onTap;
  const _PriceOption({
    required this.label, required this.price, required this.note,
    required this.selected, required this.accentColor, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.card,
          border: Border.all(color: selected ? accentColor : AppColors.border, width: selected ? 1.5 : 1),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(selected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              size: 16, color: selected ? accentColor : AppColors.textTertiary),
            const SizedBox(width: 6),
            Expanded(child: Text(label, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
          ]),
          const SizedBox(height: 6),
          Text(price.isNotEmpty ? price : '—', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          Text(note, style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
        ]),
      ),
    );
  }
}