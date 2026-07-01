import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/course_catalog/subjects_data.dart';
import '../../data/topic_question_source.dart';
import '../bloc/quiz_bloc.dart';
import '../../domain/models/quiz_question.dart';

class QuizSetupPage extends StatefulWidget {
  final String topic;
  const QuizSetupPage({super.key, this.topic = 'Data Structures'});

  @override
  State<QuizSetupPage> createState() => _QuizSetupPageState();
}

class _QuizSetupPageState extends State<QuizSetupPage> {
  // The course currently selected (subjectsData key, e.g. 'MTS 102'),
  // and the specific fine-grained topics (lessonIds) chosen within it.
  // If _selectedTopicIds is empty, the whole course is used (pooled).
  String? _selectedCourseKey;
  String _selectedCourseName = 'Select a course';
  List<String> _selectedTopicIds = [];
  List<String> _unlockedCourses = [];
  QuizDifficulty _difficulty = QuizDifficulty.easy;
  QuizMode _mode = QuizMode.timed;

  @override
  void initState() {
    super.initState();
    _loadUnlockedCourses();
  }

  Future<void> _loadUnlockedCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final unlocked = prefs.getStringList('unlocked_courses') ?? [];
    setState(() => _unlockedCourses = unlocked);
  }

  /// Resolves a catalog course code (e.g. 'MTS102') to a subjectsData
  /// key (e.g. 'MTS 102'), if a real question bank exists for it.
  String? _resolveToSubjectsDataKey(String catalogCode) {
    final normalized = catalogCode.replaceAll(' ', '').toUpperCase();
    for (final key in subjectsData.keys) {
      if (key.replaceAll(' ', '').toUpperCase() == normalized) {
        return TopicQuestionSource.hasQuestionBank(key) ? key : null;
      }
    }
    return null;
  }

  int get _questionCount {
    if (_selectedCourseKey == null) return 0;
    if (_selectedTopicIds.isEmpty) {
      return TopicQuestionSource.questionsForCourse(_selectedCourseKey!).length;
    }
    return TopicQuestionSource.questionsForSelectedTopics(
      courseKey: _selectedCourseKey!,
      lessonIds: _selectedTopicIds,
    ).length;
  }

  void _showTopicPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Track which course's topics are currently expanded, and the
        // in-progress topic selection for that course during this sheet.
        String? expandedCourseKey;
        List<String> workingTopicIds = List.from(_selectedTopicIds);
        String? workingCourseKey = _selectedCourseKey;

        return StatefulBuilder(
          builder: (context, setModalState) {
            // Build the list of courses to show: only unlocked ones,
            // each flagged whether it has a real question bank.
            final courseEntries = _unlockedCourses.map((code) {
              final key = _resolveToSubjectsDataKey(code);
              final rawKey = subjectsData.keys.firstWhere(
                (k) => k.replaceAll(' ', '').toUpperCase() ==
                    code.replaceAll(' ', '').toUpperCase(),
                orElse: () => code,
              );
              final courseData = subjectsData[rawKey];
              return {
                'catalogCode': code,
                'subjectsDataKey': key, // null if no question bank
                'displayKey': rawKey,
                'fullName': courseData?['fullName'] as String? ?? code,
                'available': key != null,
              };
            }).toList();

            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.75,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select a Topic',
                    style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pick a course, or expand to choose specific topics',
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: courseEntries.isEmpty
                        ? Center(
                            child: Text(
                              'No subjects unlocked yet.\nSelect subjects during registration.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: courseEntries.map((course) {
                                final available = course['available'] as bool;
                                final displayKey = course['displayKey'] as String;
                                final fullName = course['fullName'] as String;
                                final isExpanded = expandedCourseKey == displayKey;
                                final isCourseSelected =
                                    workingCourseKey == displayKey;
                                final topics = available
                                    ? TopicQuestionSource.topicsForCourse(displayKey)
                                    : <Map<String, String>>[];

                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: !available
                                          ? null
                                          : () {
                                              HapticFeedback.selectionClick();
                                              setModalState(() {
                                                if (isExpanded) {
                                                  expandedCourseKey = null;
                                                } else {
                                                  expandedCourseKey = displayKey;
                                                  workingCourseKey = displayKey;
                                                  workingTopicIds = [];
                                                }
                                              });
                                            },
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: !available
                                              ? AppColors.surfaceVariant
                                                  .withOpacity(0.4)
                                              : isCourseSelected
                                                  ? AppColors.accentSurface
                                                  : AppColors.surfaceVariant,
                                          border: Border.all(
                                            color: isCourseSelected && available
                                                ? AppColors.accent
                                                : AppColors.border,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    fullName,
                                                    style: GoogleFonts.dmSans(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500,
                                                      color: available
                                                          ? AppColors.textPrimary
                                                          : AppColors.textTertiary,
                                                    ),
                                                  ),
                                                  if (available)
                                                    Text(
                                                      '${topics.length} topics available',
                                                      style: GoogleFonts.dmSans(
                                                        fontSize: 11,
                                                        color:
                                                            AppColors.textTertiary,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            if (!available)
                                              Container(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 8, vertical: 3),
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.surfaceVariant,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  'Coming soon',
                                                  style: GoogleFonts.dmSans(
                                                    fontSize: 9,
                                                    color:
                                                        AppColors.textTertiary,
                                                  ),
                                                ),
                                              )
                                            else
                                              Icon(
                                                isExpanded
                                                    ? Icons
                                                        .keyboard_arrow_up_rounded
                                                    : Icons
                                                        .keyboard_arrow_down_rounded,
                                                color: AppColors.textTertiary,
                                                size: 20,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (isExpanded)
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppColors.background,
                                          border: Border.all(
                                              color: AppColors.border),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'FINE-GRAINED TOPICS (optional — leave unselected to use the whole course)',
                                              style: GoogleFonts.dmSans(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.textTertiary,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            ...topics.map((topic) {
                                              final id = topic['id']!;
                                              final name = topic['name']!;
                                              final checked =
                                                  workingTopicIds.contains(id);
                                              return GestureDetector(
                                                onTap: () {
                                                  HapticFeedback
                                                      .selectionClick();
                                                  setModalState(() {
                                                    if (checked) {
                                                      workingTopicIds
                                                          .remove(id);
                                                    } else {
                                                      workingTopicIds.add(id);
                                                    }
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 6),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        checked
                                                            ? Icons
                                                                .check_box_rounded
                                                            : Icons
                                                                .check_box_outline_blank_rounded,
                                                        size: 18,
                                                        color: checked
                                                            ? AppColors.accent
                                                            : AppColors
                                                                .textTertiary,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Text(
                                                          name,
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            fontSize: 12,
                                                            color: AppColors
                                                                .textSecondary,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: workingCourseKey == null
                        ? null
                        : () {
                            setState(() {
                              _selectedCourseKey = workingCourseKey;
                              _selectedCourseName = subjectsData[workingCourseKey]
                                      ?['fullName'] as String? ??
                                  workingCourseKey!;
                              _selectedTopicIds = workingTopicIds;
                            });
                            Navigator.pop(context);
                          },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        color: workingCourseKey == null
                            ? AppColors.border
                            : AppColors.accent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          workingTopicIds.isEmpty
                              ? 'Use whole course'
                              : 'Use ${workingTopicIds.length} selected topic${workingTopicIds.length == 1 ? "" : "s"}',
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(width: 12),
              Text('Quick quiz', style: GoogleFonts.dmSans(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const Spacer(),
              GestureDetector(
                onTap: _showTopicPicker,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.accentSurface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.accent),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.edit_rounded, size: 12, color: AppColors.accent),
                      const SizedBox(width: 4),
                      Text(
                        'Change',
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 8),
              _TopicCard(
                topic: _selectedTopicIds.isEmpty
                    ? _selectedCourseName
                    : '$_selectedCourseName (${_selectedTopicIds.length} topics)',
                emoji: '⚡',
                questions: _questionCount,
                time: '${(_questionCount * 0.5).ceil()}m',
              ),
              const SizedBox(height: 20),
              _label('Choose difficulty'),
              const SizedBox(height: 10),
              _DifficultySelector(selected: _difficulty, onChanged: (d) => setState(() => _difficulty = d)),
              const SizedBox(height: 20),
              _label('Quiz mode'),
              const SizedBox(height: 10),
              _ModeSelector(selected: _mode, onChanged: (m) => setState(() => _mode = m)),
              const SizedBox(height: 28),
              GestureDetector(
                onTap: _selectedCourseKey == null
                    ? null
                    : () => context.read<QuizBloc>().add(
                          QuizStarted(
                            topic: _selectedCourseKey!,
                            topicIds: _selectedTopicIds,
                            difficulty: _difficulty,
                            mode: _mode,
                          ),
                        ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(16)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text('Start quiz', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                  ]),
                ),
              ),
              const SizedBox(height: 24),
            ]),
          )),
        ]),
      ),
    );
  }

  Widget _label(String t) => Text(t.toUpperCase(),
    style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textTertiary, letterSpacing: 0.5));
}

class _TopicCard extends StatelessWidget {
  final String topic;
  final String emoji;
  final int questions;
  final String time;
  
  const _TopicCard({
    required this.topic,
    required this.emoji,
    required this.questions,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1240), border: Border.all(color: const Color(0xFF2D1B6B)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(children: [
        Text(emoji, style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 8),
        Text(topic, style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text('$questions questions · ~$time', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _chip('+50', 'XP reward', AppColors.accentLight),
          const SizedBox(width: 8),
          _chip('$questions', 'questions', const Color(0xFFE8960F)),
          const SizedBox(width: 8),
          _chip(time, 'time limit', const Color(0xFF0EA472)),
        ]),
      ]),
    );
  }

  Widget _chip(String val, String lbl, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: const Color(0xFF0D0D0F), borderRadius: BorderRadius.circular(10)),
    child: Column(children: [
      Text(val, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: color)),
      Text(lbl, style: GoogleFonts.dmSans(fontSize: 9, color: AppColors.textTertiary)),
    ]),
  );
}

class _DifficultySelector extends StatelessWidget {
  final QuizDifficulty selected;
  final ValueChanged<QuizDifficulty> onChanged;
  const _DifficultySelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _tile('🌱', 'Easy', 'Warm up · foundational concepts', QuizDifficulty.easy,
        const Color(0xFF052E1E), const Color(0xFF0EA472), const Color(0xFF0EA472)),
      const SizedBox(height: 8),
      _tile('🔥', 'Medium', 'Challenge mode · mixed topics', QuizDifficulty.medium,
        const Color(0xFF2D1E00), const Color(0xFFC47D0E), const Color(0xFFE8960F)),
      const SizedBox(height: 8),
      _tile('💀', 'Hard', 'Expert level · exam simulation', QuizDifficulty.hard,
        const Color(0xFF2D1200), const Color(0xFFEA580C), const Color(0xFFEA580C)),
    ]);
  }

  Widget _tile(String emoji, String label, String sub, QuizDifficulty diff,
      Color activeBg, Color activeBorder, Color activeText) {
    final active = selected == diff;
    return GestureDetector(
      onTap: () => onChanged(diff),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: active ? activeBg : const Color(0xFF141418),
          border: Border.all(color: active ? activeBorder : const Color(0xFF2A2A35), width: active ? 1.5 : 0.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(children: [
          Container(width: 36, height: 36,
            decoration: BoxDecoration(color: active ? activeBg : const Color(0xFF0D0D0F), borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 18)))),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w500,
              color: active ? activeText : const Color(0xFFA09CB8))),
            Text(sub, style: GoogleFonts.dmSans(fontSize: 10, color: const Color(0xFF5A5670))),
          ])),
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 18, height: 18,
            decoration: BoxDecoration(shape: BoxShape.circle, color: active ? activeBorder : const Color(0xFF2A2A35)),
            child: active ? const Icon(Icons.check_rounded, size: 10, color: Colors.white) : null,
          ),
        ]),
      ),
    );
  }
}

class _ModeSelector extends StatelessWidget {
  final QuizMode selected;
  final ValueChanged<QuizMode> onChanged;
  const _ModeSelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _tile('⏱', 'Timed', '30s per Q', QuizMode.timed),
      const SizedBox(width: 8),
      _tile('🧘', 'Free', 'No limit', QuizMode.free),
      const SizedBox(width: 8),
      _tile('⚔️', 'Battle', 'vs friend', QuizMode.battle),
    ]);
  }

  Widget _tile(String emoji, String label, String sub, QuizMode mode) {
    final active = selected == mode;
    return Expanded(child: GestureDetector(
      onTap: () => onChanged(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF1E1240) : const Color(0xFF141418),
          border: Border.all(color: active ? const Color(0xFF7C3AED) : const Color(0xFF2A2A35), width: active ? 1.5 : 0.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500,
            color: active ? const Color(0xFF9D6FEC) : const Color(0xFFA09CB8))),
          Text(sub, style: GoogleFonts.dmSans(fontSize: 9, color: const Color(0xFF5A5670))),
        ]),
      ),
    ));
  }
}