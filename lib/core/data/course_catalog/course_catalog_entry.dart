class CourseCatalogEntry {
  final String code;              // Internal ID, e.g. 'MTS101' — never shown to user
  final String title;             // Clean display title, e.g. 'Introductory Mathematics I (Algebra & Trigonometry)'
  final String semester;          // 'First' or 'Second'
  final List<String> topics;      // Topic/unit list for this course
  final List<String> subjectGroups; // Broad onboarding labels this course satisfies, e.g. ['Calculus']

  const CourseCatalogEntry({
    required this.code,
    required this.title,
    required this.semester,
    required this.topics,
    this.subjectGroups = const [],
  });
}