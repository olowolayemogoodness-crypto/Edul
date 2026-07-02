// lib/features/quiz/data/topic_question_source.dart
// Converts existing lesson question data into QuizQuestion objects,
// and exposes topic-level and course-level (pooled) question access
// for the quiz feature's two-level picker.
import 'dart:math';
import '../domain/models/quiz_question.dart';
import '../../learning/data/lessons/mts102_lessons.dart';
import '../../learning/data/lessons/mts104_lessons.dart';
import '../../learning/data/lessons/csc102_lessons.dart';
import '../../learning/data/lessons/bio102_lessons.dart';
import '../../learning/data/lessons/che102_lessons.dart';
import '../../learning/data/lessons/phy102_lessons.dart';
import '../../learning/data/lessons/gns106_lessons.dart';
import '../../../core/data/course_catalog/subjects_data.dart';

class TopicQuestionSource {
  // Maps a subjectsData course key (e.g. 'MTS 102') to the getter
  // function that returns that course's lesson data by lessonId.
  static Map<String, dynamic> Function(String lessonId)? _getterForCourse(
      String courseKey) {
    switch (courseKey) {
      case 'MTS 102':
        return getMTS102LessonData;
      case 'MTS 104':
        return getMTS104LessonData;
      case 'CSC 102':
        return getCSC102LessonData;
      case 'BIO 102':
        return getBIO102LessonData;
      case 'CHE 102':
        return getCHE102LessonData;
      case 'PHY 102':
        return getPHY102LessonData;
      case 'GNS 106':
        return getGNS106LessonData;
      default:
        return null; // No question bank available for this course yet
    }
  }

  /// Whether a course (by subjectsData key, e.g. 'MTS 102') has a
  /// real question bank available.
  static bool hasQuestionBank(String courseKey) {
    return _getterForCourse(courseKey) != null;
  }

  /// Converts one lesson's raw question maps into QuizQuestion objects.
  static List<QuizQuestion> _convertLessonQuestions(
      Map<String, dynamic> lessonData) {
    final rawQuestions = lessonData['questions'] as List<dynamic>? ?? [];
    return rawQuestions.map((q) {
      final map = q as Map<String, dynamic>;
      return QuizQuestion(
        question: map['question'] as String,
        options: List<String>.from(map['options'] as List),
        correctIndex: map['correct'] as int,
        // Lesson data has no explanation field; defaults to ''.
        explanation: (map['explanation'] as String?) ?? '',
      );
    }).toList();
  }

  /// Returns questions for one fine-grained topic (a single lesson),
  /// identified by its lessonId (e.g. 'mts102_u3_3').
  static List<QuizQuestion> questionsForTopic({
    required String courseKey,
    required String lessonId,
  }) {
    final getter = _getterForCourse(courseKey);
    if (getter == null) return [];
    final lessonData = getter(lessonId);
    return _convertLessonQuestions(lessonData);
  }

  /// Returns every lessonId + display name for a course, in unit order.
  /// Used to build the fine-grained topic list in the picker.
  static List<Map<String, String>> topicsForCourse(String courseKey) {
    final courseData = subjectsData[courseKey];
    if (courseData == null) return [];
    final units = courseData['units'] as List<Map<String, dynamic>>;
    final topics = <Map<String, String>>[];
    for (final unit in units) {
      final lessons = unit['lessons'] as List<Map<String, dynamic>>;
      for (final lesson in lessons) {
        topics.add({
          'id': lesson['id'] as String,
          'name': lesson['name'] as String,
        });
      }
    }
    return topics;
  }

  /// Returns questions pooled from ALL topics in a course, shuffled.
  /// Used when the user selects the whole course rather than specific
  /// fine-grained topics.
  static List<QuizQuestion> questionsForCourse(String courseKey) {
    final getter = _getterForCourse(courseKey);
    if (getter == null) return [];
    final topics = topicsForCourse(courseKey);
    final allQuestions = <QuizQuestion>[];
    for (final topic in topics) {
      final lessonData = getter(topic['id']!);
      allQuestions.addAll(_convertLessonQuestions(lessonData));
    }
    allQuestions.shuffle(Random());
    return allQuestions;
  }

  /// Returns questions pooled from a specific set of fine-grained
  /// topics (lessonIds) within a course, shuffled.
  /// Returns questions pooled from a specific set of fine-grained
  /// topics (lessonIds) within a course, shuffled.
  ///
  /// If [minCount] is provided and the selected topics don't have
  /// enough questions to meet it, additional questions are topped up
  /// from the course's other topics (in unit order) until minCount is
  /// reached or the whole course pool is exhausted.
  static List<QuizQuestion> questionsForSelectedTopics({
    required String courseKey,
    required List<String> lessonIds,
    int? minCount,
  }) {
    final getter = _getterForCourse(courseKey);
    if (getter == null) return [];

    final selectedQuestions = <QuizQuestion>[];
    for (final lessonId in lessonIds) {
      final lessonData = getter(lessonId);
      selectedQuestions.addAll(_convertLessonQuestions(lessonData));
    }

    if (minCount == null || selectedQuestions.length >= minCount) {
      selectedQuestions.shuffle(Random());
      return selectedQuestions;
    }

    // Top up from other topics in the same course.
    final shortfall = minCount - selectedQuestions.length;
    final topUpQuestions = <QuizQuestion>[];
    final allTopics = topicsForCourse(courseKey);
    for (final topic in allTopics) {
      if (lessonIds.contains(topic['id'])) continue; // already included
      final lessonData = getter(topic['id']!);
      topUpQuestions.addAll(_convertLessonQuestions(lessonData));
    }
    topUpQuestions.shuffle(Random());

    final combined = [
      ...selectedQuestions,
      ...topUpQuestions.take(shortfall),
    ];
    combined.shuffle(Random());
    return combined;
  }
  }