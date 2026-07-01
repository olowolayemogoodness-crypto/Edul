import 'course_catalog_entry.dart';
import 'first_semester_courses.dart';
import 'second_semester_courses.dart';

class CourseCatalog {
  static List<CourseCatalogEntry> get all => [
        ...firstSemesterCourses,
        ...secondSemesterCourses,
      ];

  /// Look up a single course by its code, e.g. 'MTS102'.
  static CourseCatalogEntry? byCode(String code) {
    try {
      return all.firstWhere((c) => c.code == code);
    } catch (_) {
      return null;
    }
  }

  /// Search courses by title (case-insensitive, partial match).
  static List<CourseCatalogEntry> searchByTitle(String query) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return all;
    return all.where((c) => c.title.toLowerCase().contains(q)).toList();
  }

  /// Get all courses linked to a broad onboarding subject label,
  /// e.g. subjectsFor('Calculus') -> [MTS102].
  static List<CourseCatalogEntry> subjectsFor(String subjectGroup) {
    return all.where((c) => c.subjectGroups.contains(subjectGroup)).toList();
  }
}