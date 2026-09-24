// lib/features/courses/presentation/pages/course_detail_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/course_service.dart';

class CourseDetailPage extends StatelessWidget {
  final CourseModel course;
  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(children: [
              IconButton(
                icon: Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                onPressed: () => Navigator.pop(context),
              ),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                      colors: [course.accentColor.withValues(alpha: 0.25), AppColors.card],
                    ),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(course.code, style: GoogleFonts.dmSans(
                      fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text(course.name, style: GoogleFonts.dmSans(
                      fontSize: 15, color: AppColors.textSecondary)),
                    if (course.description.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(course.description, style: GoogleFonts.dmSans(
                        fontSize: 13, height: 1.5, color: AppColors.textSecondary)),
                    ],
                  ]),
                ),

                const SizedBox(height: 24),

                // Curriculum
                Text('Curriculum', style: GoogleFonts.dmSans(
                  fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                if (course.curriculum.isEmpty)
                  Text('Curriculum for this course hasn\'t been added yet.',
                    style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary))
                else
                  for (var i = 0; i < course.curriculum.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                          width: 26, height: 26,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: course.accentColor.withValues(alpha: 0.2),
                            shape: BoxShape.circle),
                          child: Text('${i + 1}', style: GoogleFonts.dmSans(
                            fontSize: 12, fontWeight: FontWeight.w700, color: course.accentColor)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(course.curriculum[i].title, style: GoogleFonts.dmSans(
                              fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                            const SizedBox(height: 2),
                            Text(course.curriculum[i].description, style: GoogleFonts.dmSans(
                              fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
                          ]),
                        ),
                      ]),
                    ),

                const SizedBox(height: 24),

                // Textbooks -- purchase is a placeholder for now, real
                // payment integration is a separate, later step.
                Text('Textbooks', style: GoogleFonts.dmSans(
                  fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                if (course.textbooks.isEmpty)
                  Text('No textbooks listed for this course yet.',
                    style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary))
                else
                  for (final book in course.textbooks)
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(children: [
                        Container(
                          width: 40, height: 52,
                          decoration: BoxDecoration(
                            color: course.accentColor.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(6)),
                          child: Icon(Icons.menu_book_rounded, size: 18, color: course.accentColor),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(book.title, style: GoogleFonts.dmSans(
                              fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 2),
                            Text(book.author, style: GoogleFonts.dmSans(
                              fontSize: 11, color: AppColors.textTertiary)),
                            if (book.price.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(book.price, style: GoogleFonts.dmSans(
                                fontSize: 12, fontWeight: FontWeight.w600, color: course.accentColor)),
                            ],
                          ]),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            // Placeholder only -- no real payment yet.
                            // Purchasing is deliberately deferred to a
                            // separate step once payment integration
                            // is actually wired up.
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Textbook purchasing is coming soon',
                                style: GoogleFonts.dmSans(fontSize: 13)),
                              backgroundColor: AppColors.surfaceVariant,
                              behavior: SnackBarBehavior.floating));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(20)),
                            child: Text('Buy', style: GoogleFonts.dmSans(
                              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ),
                      ]),
                    ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}