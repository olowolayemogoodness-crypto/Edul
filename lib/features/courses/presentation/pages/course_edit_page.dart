// lib/features/courses/presentation/pages/course_edit_page.dart
//
// Class-rep-only course creation/editing, in-app. Access is gated by
// GroupService.amIClassRepOfMyGroup() at the call site (courses_page
// and course_overview_page), not re-checked here -- this page assumes
// it was reached legitimately, same trust model as TimetableService's
// add-entry flow.
//
// Departments are picked from the REAL official groups for this set
// (GroupService.officialGroups), not typed freehand -- eliminates the
// exact-string-match typo class of bug entirely (this cost real
// debugging time earlier when department strings were hand-typed
// twice and didn't match byte-for-byte). "Visible to everyone"
// toggles between the ALL sentinel and the picked department list.
//
// curriculum/textbooks/recaps/materials aren't editable from this
// form -- textbooks still needs console entry for now, and
// recaps/materials get their own dedicated forms next.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/course_service.dart';
import '../../../../core/services/group_service.dart';

class CourseEditPage extends StatefulWidget {
  final CourseModel? existing; // null = creating a new course
  final int set;
  const CourseEditPage({super.key, this.existing, required this.set});

  @override
  State<CourseEditPage> createState() => _CourseEditPageState();
}

class _CourseEditPageState extends State<CourseEditPage> {
  final _codeCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  int _colorIndex = 0;
  bool _visibleToAll = true;
  Set<String> _selectedDepartments = {};
  List<Map<String, dynamic>> _groups = [];
  bool _loadingGroups = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final c = widget.existing;
    if (c != null) {
      _codeCtrl.text = c.code;
      _nameCtrl.text = c.name;
      _descCtrl.text = c.description;
      _subjectCtrl.text = c.subject;
      _colorIndex = 0; // colorIndex isn't stored back on CourseModel -- re-picking is fine, purely cosmetic
      _visibleToAll = c.departments.length == 1 && c.departments.first == 'ALL';
      _selectedDepartments = _visibleToAll ? {} : c.departments.toSet();
    }
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    final groups = await GroupService.officialGroups(set: widget.set);
    if (!mounted) return;
    setState(() { _groups = groups; _loadingGroups = false; });
  }

  Future<void> _save() async {
    if (_codeCtrl.text.trim().isEmpty || _nameCtrl.text.trim().isEmpty) {
      _showSnack('Code and name are required', isError: true);
      return;
    }
    if (!_visibleToAll && _selectedDepartments.isEmpty) {
      _showSnack('Pick at least one department, or turn on "Visible to everyone"', isError: true);
      return;
    }

    setState(() => _saving = true);
    try {
      await CourseService.saveCourse(
        courseId: widget.existing?.id,
        code: _codeCtrl.text, name: _nameCtrl.text, description: _descCtrl.text,
        set: widget.set, colorIndex: _colorIndex, subject: _subjectCtrl.text,
        departments: _visibleToAll ? ['ALL'] : _selectedDepartments.toList(),
      );
      if (!mounted) return;
      Navigator.pop(context, true); // true = saved, caller should refresh
    } catch (e) {
      if (!mounted) return;
      _showSnack('Couldn\'t save: $e', isError: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showSnack(String text, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white)),
      backgroundColor: isError ? AppColors.error : AppColors.success,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        title: Text(isEditing ? 'Edit course' : 'New course', style: GoogleFonts.dmSans(
          fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            _Field(label: 'Course code', hint: 'e.g. MTH101', controller: _codeCtrl),
            _Field(label: 'Course name', hint: 'e.g. Introduction to Mathematics', controller: _nameCtrl),
            _Field(label: 'Description', hint: 'What this course covers', controller: _descCtrl, maxLines: 3),
            _Field(label: 'Timetable subject', hint: 'e.g. Math (matches Timetable exactly)', controller: _subjectCtrl),

            const SizedBox(height: 8),
            Text('Accent color', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Row(children: [
              for (var i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () => setState(() => _colorIndex = i),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: _colorForIndex(i), shape: BoxShape.circle,
                        border: _colorIndex == i ? Border.all(color: AppColors.textPrimary, width: 2) : null,
                      ),
                    ),
                  ),
                ),
            ]),

            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: Text('Visible to everyone in this set', style: GoogleFonts.dmSans(
                fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
              Switch(value: _visibleToAll, onChanged: (v) => setState(() => _visibleToAll = v), activeColor: AppColors.accent),
            ]),
            if (!_visibleToAll) ...[
              const SizedBox(height: 8),
              Text('Pick departments', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: 10),
              if (_loadingGroups)
                Center(child: CircularProgressIndicator(color: AppColors.accent))
              else if (_groups.isEmpty)
                Text('No official groups found for this set.', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary))
              else
                Wrap(spacing: 8, runSpacing: 8, children: [
                  for (final g in _groups)
                    _DeptChip(
                      label: g['department'] as String? ?? '',
                      selected: _selectedDepartments.contains(g['department']),
                      onTap: () => setState(() {
                        final dept = g['department'] as String? ?? '';
                        if (_selectedDepartments.contains(dept)) {
                          _selectedDepartments.remove(dept);
                        } else {
                          _selectedDepartments.add(dept);
                        }
                      }),
                    ),
                ]),
            ],

            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent, foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _saving
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(isEditing ? 'Save changes' : 'Create course', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _colorForIndex(int i) {
    final palette = [AppColors.chart1, AppColors.chart2, AppColors.chart3, AppColors.chart4, AppColors.chart5];
    return palette[i % palette.length];
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  const _Field({required this.label, required this.hint, required this.controller, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary),
            filled: true, fillColor: AppColors.surfaceVariant,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ]),
    );
  }
}

class _DeptChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _DeptChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(label, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600,
          color: selected ? Colors.white : AppColors.textSecondary)),
      ),
    );
  }
}