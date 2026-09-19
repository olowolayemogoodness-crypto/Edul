// lib/features/courses/presentation/pages/material_edit_page.dart
//
// Class-rep-only material creation. existingFolders is passed in from
// the Materials tab (derived from already-loaded materials) so the
// rep can tap a suggested folder name instead of retyping it and
// accidentally creating a near-duplicate folder ("Lecture Slides" vs
// "lecture slides") -- the same typo-avoidance reasoning as the
// department picker in course_edit_page.dart.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/course_service.dart';

class MaterialEditPage extends StatefulWidget {
  final String courseId;
  final List<String> existingFolders;
  const MaterialEditPage({super.key, required this.courseId, required this.existingFolders});

  @override
  State<MaterialEditPage> createState() => _MaterialEditPageState();
}

class _MaterialEditPageState extends State<MaterialEditPage> {
  final _nameCtrl = TextEditingController();
  final _folderCtrl = TextEditingController();
  final _fileTypeCtrl = TextEditingController(text: 'PDF');
  final _urlCtrl = TextEditingController();
  final _sizeCtrl = TextEditingController();
  bool _saving = false;

  void _showSnack(String text, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white)),
      backgroundColor: isError ? AppColors.error : AppColors.success,
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<void> _save() async {
    if (_nameCtrl.text.trim().isEmpty || _folderCtrl.text.trim().isEmpty || _urlCtrl.text.trim().isEmpty) {
      _showSnack('Name, folder, and URL are required', isError: true);
      return;
    }

    setState(() => _saving = true);
    try {
      await CourseService.saveMaterial(
        courseId: widget.courseId,
        name: _nameCtrl.text, folder: _folderCtrl.text,
        fileType: _fileTypeCtrl.text, url: _urlCtrl.text,
        sizeLabel: _sizeCtrl.text.trim().isEmpty ? null : _sizeCtrl.text,
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
        title: Text('New material', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            _Field(label: 'File name', hint: 'e.g. Lecture 12 Slides.pdf', controller: _nameCtrl),

            Text('Folder', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            _Field(label: '', hint: 'e.g. Lecture Slides', controller: _folderCtrl),
            if (widget.existingFolders.isNotEmpty) ...[
              Text('Existing folders — tap to reuse', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
              const SizedBox(height: 8),
              Wrap(spacing: 8, runSpacing: 8, children: [
                for (final f in widget.existingFolders)
                  GestureDetector(
                    onTap: () => setState(() => _folderCtrl.text = f),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(999)),
                      child: Text(f, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                    ),
                  ),
              ]),
              const SizedBox(height: 16),
            ],

            _Field(label: 'File type', hint: 'e.g. PDF, Link', controller: _fileTypeCtrl),
            _Field(label: 'URL', hint: 'Real link the download button opens', controller: _urlCtrl),
            _Field(label: 'Size (optional)', hint: 'e.g. 2.4 MB', controller: _sizeCtrl),

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
                    : Text('Save material', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700)),
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
  const _Field({required this.label, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (label.isNotEmpty) ...[
          Text(label, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
        ],
        TextField(
          controller: controller,
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