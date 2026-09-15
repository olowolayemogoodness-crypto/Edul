// lib/features/courses/presentation/pages/courses_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/course_service.dart';
import 'course_detail_page.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  // Genuinely loading, not just "empty" -- matches the fix already
  // proven in social_feed_page.dart, so the board doesn't flash a
  // misleading "no courses" state before the real data has arrived.
  bool _loading = true;
  List<CourseModel> _courses = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final courses = await CourseService.coursesForMySet();
    if (mounted) setState(() {
      _courses = courses;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
            child: Row(children: [
              Text('Courses', style: GoogleFonts.dmSans(
                fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ]),
          ),
          Expanded(
            child: _loading
                ? Center(child: CircularProgressIndicator(color: AppColors.accent))
                : _courses.isEmpty
                    ? _EmptyState()
                    : _CourseBoard(courses: _courses),
          ),
        ]),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.menu_book_outlined, size: 40, color: AppColors.textTertiary),
          const SizedBox(height: 12),
          Text('No courses yet', style: GoogleFonts.dmSans(
            fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text('Your courses will show up here once they\'re added for your set.',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
        ]),
      ),
    );
  }
}

class _CourseBoard extends StatelessWidget {
  final List<CourseModel> courses;
  const _CourseBoard({required this.courses});

  @override
  Widget build(BuildContext context) {
    // Two independent columns rather than a dedicated masonry package
    // (none exists in this project yet) -- a standard, dependency-free
    // way to get the staggered look. Alternating a taller/shorter card
    // height by index gives the visual variety, rather than every
    // card being identical.
    final left = <CourseModel>[];
    final right = <CourseModel>[];
    for (var i = 0; i < courses.length; i++) {
      (i % 2 == 0 ? left : right).add(courses[i]);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(children: [
          for (var i = 0; i < left.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CourseCard(course: left[i], tall: i.isEven),
            ),
        ])),
        const SizedBox(width: 12),
        Expanded(child: Column(children: [
          for (var i = 0; i < right.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CourseCard(course: right[i], tall: i.isOdd),
            ),
        ])),
      ]),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final CourseModel course;
  final bool tall;
  const _CourseCard({required this.course, required this.tall});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => CourseDetailPage(course: course))),
      child: Container(
        height: tall ? 160 : 120,
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [course.accentColor.withOpacity(0.22), AppColors.card],
          ),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(course.code, style: GoogleFonts.dmSans(
              fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 2),
            Text(course.name, style: GoogleFonts.dmSans(
              fontSize: 11, color: AppColors.textSecondary),
              maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}