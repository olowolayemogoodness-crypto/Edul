// lib/core/services/course_service.dart
//
// Courses are shared across a whole admission cohort ("set"), not
// department-specific -- GNS/GST are general studies, PHY/MTH are
// shared foundational courses, MEE is the engineering cohort's own
// course. All five are the actual SET30 (100L) course load for this
// semester, matching group_service.dart's set-based scoping.
//
// No lecturer-managed creation flow yet -- courses are seeded here
// directly, the same way the 47 SET30 groups were bulk-created in
// Firestore before group_service.dart existed to read them. This
// file mainly defines the shape; real lecturer-driven course
// creation is a later phase.

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_colors.dart';
import 'user_service.dart';

class CurriculumTopic {
  final String title;
  final String description;
  const CurriculumTopic({required this.title, required this.description});
}

class Textbook {
  final String title;
  final String author;
  final String price; // display string, e.g. "₦4,500" -- no real payment yet
  const Textbook({required this.title, required this.author, required this.price});
}

class CourseModel {
  final String id;
  final String code;
  final String name;
  final String description;
  final int set;
  final Color accentColor;
  final List<CurriculumTopic> curriculum;
  final List<Textbook> textbooks;

  const CourseModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.set,
    required this.accentColor,
    required this.curriculum,
    required this.textbooks,
  });
}

class CourseService {
  CourseService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> _courses() => _db.collection('courses');

  /// Fetches courses for the signed-in user's own set (cohort). Returns
  /// an empty list rather than throwing if the profile has no set yet
  /// -- matches how the social feed's tabs handle a still-loading
  /// profile, rather than surfacing an error for something that
  /// resolves itself a moment later.
  ///
  /// Curriculum/textbooks are included in this same fetch rather than
  /// a separate "detail" call -- with only 5 courses per set, there's
  /// no real cost to fetching full detail up front, and it avoids a
  /// second round-trip when a card is tapped.
  static Future<List<CourseModel>> coursesForMySet() async {
    final profile = await UserService.getProfile();
    final set = profile?['set'] as int?;
    if (set == null) return [];

    final snap = await _courses().where('set', isEqualTo: set).get();
    if (snap.docs.isEmpty) return [];

    return snap.docs.map((doc) => _fromDoc(doc, set)).toList();
  }

  static CourseModel _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc, int fallbackSet) {
    final data = doc.data();
    final curriculumRaw = (data['curriculum'] as List<dynamic>?) ?? [];
    final textbooksRaw = (data['textbooks'] as List<dynamic>?) ?? [];

    return CourseModel(
      id: doc.id,
      code: data['code'] as String? ?? '',
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      set: data['set'] as int? ?? fallbackSet,
      accentColor: _colorForIndex(data['colorIndex'] as int? ?? 0),
      curriculum: curriculumRaw.map((t) => CurriculumTopic(
        title: (t as Map)['title'] as String? ?? '',
        description: t['description'] as String? ?? '',
      )).toList(),
      textbooks: textbooksRaw.map((t) => Textbook(
        title: (t as Map)['title'] as String? ?? '',
        author: t['author'] as String? ?? '',
        price: t['price'] as String? ?? '',
      )).toList(),
    );
  }

  static Color _colorForIndex(int i) {
    final palette = [
      AppColors.chart1, AppColors.chart2, AppColors.chart3,
      AppColors.chart4, AppColors.chart5,
    ];
    return palette[i % palette.length];
  }

  /// One-time seed for SET30's five confirmed courses, now including
  /// placeholder curriculum and textbook entries so the detail page
  /// has real content to show while testing. Not called automatically
  /// anywhere -- run manually until a real lecturer-creation flow
  /// exists. Safe to re-run: skips any code already present for this
  /// set, so re-running won't duplicate or overwrite what's there.
  static Future<void> seedSet30Courses() async {
    const set = 30;
    final seedCourses = [
      {
        'code': 'GNS', 'name': 'General Studies', 'colorIndex': 0,
        'description': 'Foundational general studies course covering citizenship, ethics, and civic responsibility.',
        'curriculum': [
          {'title': 'Introduction to Citizenship', 'description': 'What it means to be a responsible member of society.'},
          {'title': 'Ethics and Values', 'description': 'Core ethical principles and their application.'},
        ],
        'textbooks': [
          {'title': 'General Studies for Nigerian Universities', 'author': 'A. Okafor', 'price': '₦3,500'},
        ],
      },
      {
        'code': 'GST', 'name': 'General Studies (Use of English)', 'colorIndex': 1,
        'description': 'Communication skills, grammar, and academic writing for university-level work.',
        'curriculum': [
          {'title': 'Grammar Fundamentals', 'description': 'Sentence structure, tense, and agreement.'},
          {'title': 'Academic Writing', 'description': 'Essay structure, referencing, and clarity.'},
        ],
        'textbooks': [
          {'title': 'Use of English for Tertiary Institutions', 'author': 'F. Adeyemi', 'price': '₦2,800'},
        ],
      },
      {
        'code': 'PHY', 'name': 'Physics', 'colorIndex': 2,
        'description': 'Core physics principles for first-year engineering and science students.',
        'curriculum': [
          {'title': 'Mechanics', 'description': 'Motion, forces, and Newton\'s laws.'},
          {'title': 'Waves and Optics', 'description': 'Wave behavior and the physics of light.'},
        ],
        'textbooks': [
          {'title': 'University Physics', 'author': 'H. Young & R. Freedman', 'price': '₦6,200'},
        ],
      },
      {
        'code': 'MTH', 'name': 'Mathematics', 'colorIndex': 3,
        'description': 'Calculus and algebra foundations for engineering coursework.',
        'curriculum': [
          {'title': 'Differential Calculus', 'description': 'Limits, derivatives, and rates of change.'},
          {'title': 'Linear Algebra Basics', 'description': 'Vectors, matrices, and systems of equations.'},
        ],
        'textbooks': [
          {'title': 'Calculus: Early Transcendentals', 'author': 'J. Stewart', 'price': '₦7,000'},
        ],
      },
      {
        'code': 'MEE', 'name': 'Mechanical Engineering', 'colorIndex': 4,
        'description': 'Introduction to mechanical engineering principles and design thinking.',
        'curriculum': [
          {'title': 'Engineering Drawing', 'description': 'Technical drawing standards and orthographic projection.'},
          {'title': 'Materials Science Intro', 'description': 'Properties and selection of engineering materials.'},
        ],
        'textbooks': [
          {'title': 'Introduction to Mechanical Engineering', 'author': 'J. Wickert', 'price': '₦5,400'},
        ],
      },
    ];

    final existing = await _courses().where('set', isEqualTo: set).get();
    final existingCodes = existing.docs.map((d) => d.data()['code'] as String?).toSet();

    for (final course in seedCourses) {
      if (existingCodes.contains(course['code'])) continue; // already seeded, don't duplicate
      await _courses().add({...course, 'set': set, 'createdAt': FieldValue.serverTimestamp()});
    }
  }
}