// lib/features/learning/presentation/pages/lesson_detail_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/services/streak_service.dart';
import '../../data/lessons/mts102_lessons.dart';
import '../../data/lessons/csc102_lessons.dart';
import '../../data/lessons/calculus_lessons.dart';
import '../../data/lessons/bio102_lessons.dart';
import '../../data/lessons/che102_lessons.dart';
import '../../data/lessons/phy102_lessons.dart';
import '../../data/lessons/gns106_lessons.dart';
import '../../data/lessons/mts104_lessons.dart';
import '../../data/lessons/cos102_lessons.dart';

class LessonDetailPage extends StatefulWidget {
  final String lessonId;
  final String lessonName;
  final String color;

  const LessonDetailPage({
    super.key,
    required this.lessonId,
    required this.lessonName,
    required this.color,
  });

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool showResult = false;
  bool showQuiz = false;
  int correctAnswers = 0;
  bool quizComplete = false;

  late List<Map<String, dynamic>> questions;
  late String teachingContent;

  @override
  void initState() {
    super.initState();
    _loadLessonContent();
  }

  void _loadLessonContent() {
    final lessonData = _getLessonData(widget.lessonId);
    teachingContent = lessonData['content'];
    questions = List<Map<String, dynamic>>.from(lessonData['questions']);
  }

  Map<String, dynamic> _getLessonData(String lessonId) {
    // MTS 102 lessons
    if (lessonId.startsWith('mts102_')) {
      return getMTS102LessonData(lessonId);
    }
    
    // CSC 102 lessons
    if (lessonId.startsWith('csc102_')) {
      return getCSC102LessonData(lessonId);
    }
    if (lessonId.startsWith('bio102_')) {
  return getBIO102LessonData(lessonId);
}
if (lessonId.startsWith('che102_')) {
  return getCHE102LessonData(lessonId);
}
if (lessonId.startsWith('phy102_')) {
  return getPHY102LessonData(lessonId);
}
if (lessonId.startsWith('gns106_')) return getGNS106LessonData(lessonId);
if (lessonId.startsWith('cos102_')) return getCOS102LessonData(lessonId);
if (lessonId.startsWith('mts104_')) {
  return getMTS104LessonData(lessonId);
}
    
    // Original Calculus lessons (dr_, tf_, lim_, cont_, der_, int_)
    return _getCalculusLessonData(lessonId);
  }
  

  // Calculus lessons (dr_, tf_, lim_, cont_, der_, int_)
  Map<String, dynamic> _getCalculusLessonData(String lessonId) {
  return getCalculusLessonData(lessonId);
}
  void _selectAnswer(int index) {
    setState(() {
      selectedAnswerIndex = index;
      showResult = true;
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      if (selectedAnswerIndex == questions[currentQuestionIndex]['correct']) {
        correctAnswers++;
      }
      
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        showResult = false;
      });
    } else {
      if (selectedAnswerIndex == questions[currentQuestionIndex]['correct']) {
        correctAnswers++;
      }
      
      setState(() {
        quizComplete = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Text('Loading lesson...', style: GoogleFonts.dmSans()),
        ),
      );
    }

    if (!showQuiz) {
      return _buildTeachingPage(context);
    }

    if (quizComplete) {
      return _buildResultsPage(context);
    }

    return _buildQuizPage(context);
  }

  Widget _buildTeachingPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_rounded, size: 20),
                    ),
                    Text(
                      widget.lessonName,
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),

              // Teaching content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._parseTeachingContent(teachingContent),
                    const SizedBox(height: 40),

                    // Start Quiz button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => showQuiz = true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Start Quiz (${questions.length} Questions)',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _parseTeachingContent(String content) {
    final lines = content.split('\n');
    final widgets = <Widget>[];

    for (final line in lines) {
      if (line.startsWith('# ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 12),
            child: Text(
              line.replaceFirst('# ', ''),
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        );
      } else if (line.startsWith('## ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              line.replaceFirst('## ', ''),
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        );
      } else if (line.startsWith('• ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 12),
            child: Text(
              line.replaceFirst('• ', ''),
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        );
      } else if (line.startsWith('💡 ')) {
        widgets.add(
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              border: Border.all(color: AppColors.accent.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              line,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: AppColors.textPrimary,
                height: 1.5,
              ),
            ),
          ),
        );
      } else if (line.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              line,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }

  Widget _buildQuizPage(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final isCorrect = selectedAnswerIndex == currentQuestion['correct'];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_rounded, size: 20),
                    ),
                    Text(
                      widget.lessonName,
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),

              // Progress indicator
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (currentQuestionIndex + 1) / questions.length,
                          minHeight: 6,
                          backgroundColor: AppColors.border,
                          valueColor: const AlwaysStoppedAnimation(AppColors.accent),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${currentQuestionIndex + 1}/${questions.length}',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),

              // Question card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentQuestion['question'],
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Answer options
                      ...List.generate(
                        currentQuestion['options'].length,
                        (index) {
                          final option = currentQuestion['options'][index];
                          final isSelected = selectedAnswerIndex == index;
                          final isCorrectOption = index == currentQuestion['correct'];

                          Color borderColor = AppColors.border;
                          Color bgColor = AppColors.background;

                          if (showResult && isCorrectOption) {
                            borderColor = AppColors.success;
                            bgColor = AppColors.success.withOpacity(0.1);
                          } else if (showResult && isSelected && !isCorrect) {
                            borderColor = const Color(0xFFEF4444);
                            bgColor = const Color(0xFFEF4444).withOpacity(0.1);
                          } else if (isSelected) {
                            borderColor = AppColors.accent;
                            bgColor = AppColors.accent.withOpacity(0.1);
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: showResult ? null : () => _selectAnswer(index),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  border: Border.all(color: borderColor, width: 1.5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: borderColor, width: 2),
                                        color: isSelected ? borderColor : Colors.transparent,
                                      ),
                                      child: isSelected
                                          ? const Center(
                                              child: Icon(Icons.check,
                                                  size: 14, color: Colors.white),
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    if (showResult && isCorrectOption)
                                      const Icon(Icons.check_circle,
                                          color: AppColors.success, size: 20)
                                    else if (showResult && isSelected && !isCorrect)
                                      const Icon(Icons.cancel,
                                          color: Color(0xFFEF4444), size: 20),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // Result message
                      if (showResult)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            isCorrect ? '✅ Correct!' : '❌ Not quite right',
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isCorrect ? AppColors.success : const Color(0xFFEF4444),
                            ),
                          ),
                        ),

                      // Next button
                      if (showResult)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _nextQuestion,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accent,
                              ),
                              child: Text(
                                currentQuestionIndex == questions.length - 1
                                    ? 'Finish'
                                    : 'Next Question',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsPage(BuildContext context) {
    final percentage = ((correctAnswers / questions.length) * 100).toInt();
    final passed = percentage >= 80;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      'Quiz Results',
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),

              // Results content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Status icon
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: passed ? AppColors.success : const Color(0xFFEF4444),
                        boxShadow: [
                          BoxShadow(
                            color: (passed ? AppColors.success : const Color(0xFFEF4444))
                                .withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          passed ? '✅' : '❌',
                          style: const TextStyle(fontSize: 50),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Status text
                    Text(
                      passed ? 'Great Job! 🎉' : 'Keep Trying',
                      style: GoogleFonts.dmSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      passed
                          ? 'You passed the quiz! Move on to the next lesson.'
                          : 'You need 80% to pass. Try again!',
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppColors.textTertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Score card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Score',
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                              Text(
                                '$percentage%',
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: percentage / 100,
                              minHeight: 8,
                              backgroundColor: AppColors.border,
                              valueColor: AlwaysStoppedAnimation(
                                passed ? AppColors.success : const Color(0xFFEF4444),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Correct Answers',
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                              Text(
                                '$correctAnswers/${questions.length}',
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Buttons
                    if (!passed)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentQuestionIndex = 0;
                              selectedAnswerIndex = null;
                              showResult = false;
                              quizComplete = false;
                              correctAnswers = 0;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            'Try Again',
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            final completedLessons = 
                              prefs.getStringList('completed_lessons') ?? [];
                            if (!completedLessons.contains(widget.lessonId)) {
                              completedLessons.add(widget.lessonId);
                              await prefs.setStringList(
                                'completed_lessons',
                                completedLessons,
                              );
                            }
                            // Try to award a streak for completing this lesson.
                            // If one is awarded (first qualifying activity today),
                            // navigate to the celebration screen before popping.
                            // If already awarded today or Firestore unreachable,
                            // tryAwardStreak() returns null and we just pop as
                            // before -- no change to normal lesson flow.
                            final newStreak = await StreakService.recordLessonPassed();
                            if (!mounted) return;
                            if (newStreak != null) {
                              context.push(
                                AppRoutes.streakCelebration,
                                extra: {'streakCount': newStreak},
                              );
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            'Next Lesson 🚀',
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}