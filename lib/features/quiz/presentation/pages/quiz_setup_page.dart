import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../bloc/quiz_bloc.dart';
import '../../domain/models/quiz_question.dart';

class QuizSetupPage extends StatefulWidget {
  final String topic;
  const QuizSetupPage({super.key, this.topic = 'Data Structures'});

  @override
  State<QuizSetupPage> createState() => _QuizSetupPageState();
}

class _QuizSetupPageState extends State<QuizSetupPage> {
  late String _selectedTopic;
  QuizDifficulty _difficulty = QuizDifficulty.easy;
  QuizMode _mode = QuizMode.timed;

  // Topic data
  final Map<String, Map<String, dynamic>> _topics = {
    'Data Structures': {'emoji': '⚡', 'questions': 10, 'time': '5m'},
    'Algorithms': {'emoji': '🔄', 'questions': 12, 'time': '6m'},
    'Database Design': {'emoji': '🗄️', 'questions': 10, 'time': '5m'},
    'Web Development': {'emoji': '🌐', 'questions': 15, 'time': '8m'},
    'Calculus': {'emoji': '∫', 'questions': 10, 'time': '5m'},
    'Linear Algebra': {'emoji': '📐', 'questions': 10, 'time': '5m'},
    'Probability': {'emoji': '🎲', 'questions': 12, 'time': '6m'},
  };

  @override
  void initState() {
    super.initState();
    _selectedTopic = widget.topic;
  }

  void _showTopicPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
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
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _topics.entries.map((entry) => GestureDetector(
                    onTap: () {
                      setState(() => _selectedTopic = entry.key);
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _selectedTopic == entry.key
                            ? AppColors.accentSurface
                            : AppColors.surfaceVariant,
                        border: Border.all(
                          color: _selectedTopic == entry.key
                              ? AppColors.accent
                              : AppColors.border,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(entry.value['emoji'], style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.key,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  '${entry.value['questions']} questions · ${entry.value['time']}',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 11,
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_selectedTopic == entry.key)
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.accent,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
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
                topic: _selectedTopic,
                emoji: _topics[_selectedTopic]?['emoji'] ?? '⚡',
                questions: _topics[_selectedTopic]?['questions'] ?? 10,
                time: _topics[_selectedTopic]?['time'] ?? '5m',
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
                onTap: () => context.read<QuizBloc>().add(
                  QuizStarted(topic: _selectedTopic, difficulty: _difficulty, mode: _mode)),
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