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
import 'question_banks/mts102_question_bank.dart';
import 'question_banks/phy102_question_bank.dart';
import 'question_banks/gns106_question_bank.dart';
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

  // Maps a subjectsData course key to an EXTRA question-bank getter,
  // if a richer bank exists for that course. Questions returned here
  // are ADDED ON TOP OF the base lesson questions (append, not
  // replace) -- see _questionsForLessonId below.
  //
  // NOTE: PHY102's extra bank also covers brand-new lessonIds
  // (phy102_u5_1 .. phy102_u5_5) that have NO entry in
  // phy102_lessons.dart at all. _questionsForLessonId handles this
  // gracefully -- base lookups simply return an empty question list
  // for those ids, so the extra bank's questions are all there is.
  static List<Map<String, dynamic>> Function(String lessonId)?
      _extraGetterForCourse(String courseKey) {
    switch (courseKey) {
      case 'MTS 102':
        return getMTS102ExtraQuestions;
      case 'PHY 102':
        return getPHY102ExtraQuestions;
      case 'GNS 106':
        return getGNS106ExtraQuestions;
      default:
        return null; // No extra bank for this course yet
    }
  }

  /// Whether a course (by subjectsData key, e.g. 'MTS 102') has a
  /// real question bank available.
  static bool hasQuestionBank(String courseKey) {
    return _getterForCourse(courseKey) != null;
  }

  /// Converts one lesson's raw question maps into QuizQuestion objects.
  static List<QuizQuestion> _convertQuestions(
      List<dynamic> rawQuestions) {
    return rawQuestions.map((q) {
      final map = q as Map<String, dynamic>;
      return QuizQuestion(
        question: map['question'] as String,
        options: List<String>.from(map['options'] as List),
        correctIndex: map['correct'] as int,
        // Lesson/bank data has no explanation field; defaults to ''.
        explanation: (map['explanation'] as String?) ?? '',
        // Reading-passage questions (GNS106) carry the source passage
        // text to display above the question; null for questions with
        // no associated passage.
        passage: map['passage'] as String?,
      );
    }).toList();
  }

  /// Courses whose base lesson questions (in their *_lessons.dart file)
  /// should be EXCLUDED from the quiz pool -- the extra bank is the sole
  /// source instead. Used for GNS106: 39 of its 45 base questions were
  /// found to be miskeyed (correct answer wrongly marked as option B),
  /// so they're skipped here for quiz purposes. NOTE: this only affects
  /// the standalone Quiz tab pool -- gns106_lessons.dart itself is left
  /// untouched, so the Learning Map's 5-question-per-lesson mini quiz is
  /// unaffected by this exclusion.
  static const Set<String> _baseQuestionsExcludedForCourses = {'GNS 106'};

  /// Returns all questions for one fine-grained topic (lessonId),
  /// combining the base lesson questions with any extra question-bank
  /// questions for that course (appended, not replacing) -- unless the
  /// course is in _baseQuestionsExcludedForCourses, in which case only
  /// the extra bank is used.
  ///
  /// If a lessonId has no base lesson data at all (e.g. a brand-new
  /// topic added only via the extra bank), the base lookup safely
  /// returns an empty list and the extra bank supplies everything.
  static List<QuizQuestion> _questionsForLessonId(
      String courseKey, String lessonId) {
    final getter = _getterForCourse(courseKey);
    if (getter == null) return [];

    final combined = <QuizQuestion>[];
    if (!_baseQuestionsExcludedForCourses.contains(courseKey)) {
      final baseData = getter(lessonId);
      final baseRaw = baseData['questions'] as List<dynamic>? ?? [];
      combined.addAll(_convertQuestions(baseRaw));
    }

    final extraGetter = _extraGetterForCourse(courseKey);
    if (extraGetter != null) {
      final extraRaw = extraGetter(lessonId);
      combined.addAll(_convertQuestions(extraRaw));
    }

    return combined;
  }

  /// Returns questions for one fine-grained topic (a single lesson),
  /// identified by its lessonId (e.g. 'mts102_u3_3').
  static List<QuizQuestion> questionsForTopic({
    required String courseKey,
    required String lessonId,
  }) {
    return _questionsForLessonId(courseKey, lessonId);
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
      allQuestions.addAll(_questionsForLessonId(courseKey, topic['id']!));
    }
    allQuestions.shuffle(Random());
    return allQuestions;
  }

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
      selectedQuestions.addAll(_questionsForLessonId(courseKey, lessonId));
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
      topUpQuestions.addAll(_questionsForLessonId(courseKey, topic['id']!));
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