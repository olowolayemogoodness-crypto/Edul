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

class CourseModel {
  final String id;
  final String code;
  final String name;
  final int set;
  final Color accentColor;

  const CourseModel({
    required this.id,
    required this.code,
    required this.name,
    required this.set,
    required this.accentColor,
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
  static Future<List<CourseModel>> coursesForMySet() async {
    final profile = await UserService.getProfile();
    final set = profile?['set'] as int?;
    if (set == null) return [];

    final snap = await _courses().where('set', isEqualTo: set).get();
    if (snap.docs.isEmpty) return [];

    return snap.docs.map((doc) {
      final data = doc.data();
      return CourseModel(
        id: doc.id,
        code: data['code'] as String? ?? '',
        name: data['name'] as String? ?? '',
        set: data['set'] as int? ?? set,
        accentColor: _colorForIndex(data['colorIndex'] as int? ?? 0),
      );
    }).toList();
  }

  static Color _colorForIndex(int i) {
    final palette = [
      AppColors.chart1, AppColors.chart2, AppColors.chart3,
      AppColors.chart4, AppColors.chart5,
    ];
    return palette[i % palette.length];
  }

  /// One-time seed for SET30's five confirmed courses. Not called
  /// automatically anywhere -- run manually (e.g. from a debug button
  /// or the Firebase console script pattern already used for SET30
  /// groups) until a real lecturer-creation flow exists. Safe to
  /// re-run: skips any code that's already present for this set.
  static Future<void> seedSet30Courses() async {
    const set = 30;
    const seedCourses = [
      {'code': 'GNS', 'name': 'General Studies', 'colorIndex': 0},
      {'code': 'GST', 'name': 'General Studies (Use of English)', 'colorIndex': 1},
      {'code': 'PHY', 'name': 'Physics', 'colorIndex': 2},
      {'code': 'MTH', 'name': 'Mathematics', 'colorIndex': 3},
      {'code': 'MEE', 'name': 'Mechanical Engineering', 'colorIndex': 4},
    ];

    final existing = await _courses().where('set', isEqualTo: set).get();
    final existingCodes = existing.docs.map((d) => d.data()['code'] as String?).toSet();

    for (final course in seedCourses) {
      if (existingCodes.contains(course['code'])) continue; // already seeded, don't duplicate
      await _courses().add({...course, 'set': set, 'createdAt': FieldValue.serverTimestamp()});
    }
  }
}