// lib/features/courses/presentation/pages/recap_edit_page.dart
//
// Class-rep-only recap creation. Access gated at the call site
// (course_overview_page.dart), same trust model as course_edit_page.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/course_service.dart';

class RecapEditPage extends StatefulWidget {
  final String courseId;
  const RecapEditPage({super.key, required this.courseId});

  @override
  State<RecapEditPage> createState() => _RecapEditPageState();
}

class _RecapEditPageState extends State<RecapEditPage> {
  final _lectureCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _notesUrlCtrl = TextEditingController();
  final _notesPagesCtrl = TextEditingController();
  final _audioUrlCtrl = TextEditingController();
  final _audioMinutesCtrl = TextEditingController();
  final List<(TextEditingController, TextEditingController)> _fileRows = [];
  bool _saving = false;

  void _addFileRow() {
    setState(() => _fileRows.add((TextEditingController(), TextEditingController())));
  }

  void _showSnack(String text, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white)),
      backgroundColor: isError ? AppColors.error : AppColors.success,
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<void> _save() async {
    final lectureNumber = int.tryParse(_lectureCtrl.text.trim());
    if (lectureNumber == null || _titleCtrl.text.trim().isEmpty) {
      _showSnack('Lecture number and title are required', isError: true);
      return;
    }

    setState(() => _saving = true);
    try {
      await CourseService.saveRecap(
        courseId: widget.courseId,
        lectureNumber: lectureNumber,
        dateLabel: _dateCtrl.text,
        title: _titleCtrl.text,
        description: _descCtrl.text,
        notesUrl: _notesUrlCtrl.text.trim().isEmpty ? null : _notesUrlCtrl.text,
        notesPages: int.tryParse(_notesPagesCtrl.text.trim()),
        audioUrl: _audioUrlCtrl.text.trim().isEmpty ? null : _audioUrlCtrl.text,
        audioMinutes: int.tryParse(_audioMinutesCtrl.text.trim()),
        files: [
          for (final row in _fileRows)
            if (row.$1.text.trim().isNotEmpty && row.$2.text.trim().isNotEmpty)
              MaterialFileRef(name: row.$1.text.trim(), url: row.$2.text.trim()),
        ],
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      _showSnack('Couldn\'t save: $e', isError: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        title: Text('New recap', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Row(children: [
              Expanded(child: _Field(label: 'Lecture #', hint: 'e.g. 12', controller: _lectureCtrl, isNumber: true)),
              const SizedBox(width: 12),
              Expanded(child: _Field(label: 'Date', hint: 'e.g. Nov 14', controller: _dateCtrl)),
            ]),
            _Field(label: 'Title', hint: 'e.g. Graph Traversals', controller: _titleCtrl),
            _Field(label: 'Description', hint: 'What this lecture covered', controller: _descCtrl, maxLines: 3),

            Text('Notes (optional)', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            _Field(label: 'Notes URL', hint: 'Link to notes PDF', controller: _notesUrlCtrl),
            _Field(label: 'Pages', hint: 'e.g. 4', controller: _notesPagesCtrl, isNumber: true),

            Text('Audio (optional)', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            _Field(label: 'Audio URL', hint: 'Link to recording', controller: _audioUrlCtrl),
            _Field(label: 'Minutes', hint: 'e.g. 42', controller: _audioMinutesCtrl, isNumber: true),

            Row(children: [
              Expanded(child: Text('Files (optional)', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
              TextButton(onPressed: _addFileRow, child: Text('+ Add file', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.accent))),
            ]),
            for (final row in _fileRows) ...[
              _Field(label: 'File name', hint: 'e.g. Problem Set 5.pdf', controller: row.$1),
              _Field(label: 'File URL', hint: 'Link to the file', controller: row.$2),
            ],

            const SizedBox(height: 12),
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
                    : Text('Save recap', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final bool isNumber;
  const _Field({required this.label, required this.hint, required this.controller, this.maxLines = 1, this.isNumber = false});

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
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
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