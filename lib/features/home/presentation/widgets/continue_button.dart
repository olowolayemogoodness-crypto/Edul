// lib/features/home/presentation/widgets/continue_button.dart
//
// Was a flat "Continue today's lesson" label with zero context -- it
// already routed to /learning-map, but gave no reason to actually want
// to tap it. Rewritten to show the REAL next lesson (name, position,
// progress), sourced from the exact same data the Learning Map screen
// itself uses (subjectsData + the 'completed_lessons' /
// 'selected_subject' SharedPreferences keys) -- not decorative,
// genuinely the same underlying progress.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/data/course_catalog/subjects_data.dart';

class ContinueButton extends StatefulWidget {
  const ContinueButton({super.key});

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  String? _nextLessonName;
  String? _nextLessonIcon;
  int _position = 0;
  int _total = 0;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = (prefs.getStringList('completed_lessons') ?? []).toSet();
    final subjectKey = prefs.getString('selected_subject') ?? 'MTS 102';

    final subject = subjectsData[subjectKey];
    if (subject == null) {
      if (mounted) setState(() => _loaded = true);
      return;
    }
    final units = subject['units'] as List<Map<String, dynamic>>? ?? [];
    final allLessons = units.expand((u) => (u['lessons'] as List).cast<Map<String, dynamic>>()).toList();

    final nextIndex = allLessons.indexWhere((l) => !completed.contains(l['id']));
    if (mounted) {
      setState(() {
        _total = allLessons.length;
        if (nextIndex == -1) {
          // Every lesson in this subject is done -- nothing to preview,
          // falls back to the generic label below.
          _nextLessonName = null;
        } else {
          _position = nextIndex + 1;
          _nextLessonName = allLessons[nextIndex]['name'] as String?;
          _nextLessonIcon = allLessons[nextIndex]['icon'] as String?;
        }
        _loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPreview = _loaded && _nextLessonName != null && _total > 0;
    final progress = hasPreview ? (_position - 1) / _total : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: GestureDetector(
        onTap: () => context.go('/learning-map'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: hasPreview
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text(_nextLessonIcon ?? '📘', style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Lesson $_position of $_total', style: GoogleFonts.dmSans(
                          fontSize: 11, color: Colors.white70, fontWeight: FontWeight.w500)),
                        Text(_nextLessonName!, style: GoogleFonts.dmSans(
                          fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700)),
                      ]),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                      child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 18),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress, minHeight: 5,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ])
              : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text("Continue today's lesson", style: GoogleFonts.dmSans(
                    color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                ]),
        ),
      ),
    );
  }
}