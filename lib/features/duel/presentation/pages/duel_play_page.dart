// lib/features/duel/presentation/pages/duel_play_page.dart
//
// The actual question-answering screen for a duel — used in TWO modes:
//
//   Creating (duelId == null): questions were just drawn fresh for
//     [courseKey]. On completion, DuelService.createDuel() is called,
//     which locks in the challenger's answers and creates the duel doc.
//
//   Responding (duelId != null): questions came from an EXISTING duel
//     doc (the challenger's exact question set, not re-drawn — both
//     players must answer literally the same questions). On completion,
//     DuelService.submitOpponentAnswers() scores the duel and notifies
//     both players.
//
// Each question has a 30-second timer, same allowance as the standard
// quiz. Running out of time on a question behaves like tapping Skip —
// it reveals the correct answer, marks that question unanswered, and
// the timer stops (reading the explanation isn't time-pressured, only
// deciding on an answer is).

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/duel_service.dart';
import '../../../quiz/domain/models/quiz_question.dart';

class DuelPlayPage extends StatefulWidget {
  final String courseKey;
  final List<QuizQuestion> questions;
  final String? duelId; // null when creating, set when responding
  final String? opponentUid; // required when creating
  final String? opponentName; // required when creating

  const DuelPlayPage({
    super.key,
    required this.courseKey,
    required this.questions,
    this.duelId,
    this.opponentUid,
    this.opponentName,
  });

  @override
  State<DuelPlayPage> createState() => _DuelPlayPageState();
}

class _DuelPlayPageState extends State<DuelPlayPage> {
  int _index = 0;
  int? _selected;
  bool _revealed = false;
  bool _submitting = false;
  final List<DuelAnswer> _answers = [];

  static const int _secondsPerQuestion = 30;
  Timer? _timer;
  int _secondsLeft = _secondsPerQuestion;

  QuizQuestion get _current => widget.questions[_index];
  bool get _isCreating => widget.duelId == null;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = _secondsPerQuestion;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_secondsLeft <= 1) {
        t.cancel();
        setState(() => _secondsLeft = 0);
        if (!_revealed) _skip(); // ran out of time without answering
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _selectOption(int i) {
    if (_revealed) return;
    _timer?.cancel();
    HapticFeedback.selectionClick();
    setState(() {
      _selected = i;
      _revealed = true;
    });
    _answers.add(DuelAnswer(
      selectedIndex: i,
      correct: i == _current.correctIndex,
    ));
  }

  void _skip() {
    if (_revealed) return;
    _timer?.cancel();
    _answers.add(const DuelAnswer(selectedIndex: null, correct: false));
    setState(() => _revealed = true);
  }

  Future<void> _next() async {
    if (_index == widget.questions.length - 1) {
      await _finish();
      return;
    }
    setState(() {
      _index++;
      _selected = null;
      _revealed = false;
    });
    _startTimer();
  }

  Future<void> _finish() async {
    setState(() => _submitting = true);
    try {
      if (_isCreating) {
        await DuelService.createDuel(
          opponentUid: widget.opponentUid!,
          opponentName: widget.opponentName!,
          courseKey: widget.courseKey,
          questions: widget.questions,
          challengerAnswers: _answers,
        );
      } else {
        await DuelService.submitOpponentAnswers(
          duelId: widget.duelId!,
          answers: _answers,
        );
      }
      if (!mounted) return;
      final correct = _answers.where((a) => a.correct).length;
      Navigator.of(context).pop({'correct': correct, 'total': _answers.length});
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Something went wrong: $e'),
        backgroundColor: AppColors.error,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.questions.length;
    final correctSoFar = _answers.where((a) => a.correct).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(_isCreating ? 'New Duel' : 'Answering Duel',
          style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600,
            color: AppColors.textPrimary)),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Progress
            Row(children: [
              Expanded(child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (_index + (_revealed ? 1 : 0)) / total,
                  minHeight: 6,
                  backgroundColor: AppColors.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation(AppColors.accent),
                ),
              )),
              const SizedBox(width: 12),
              Text('${_index + 1}/$total', style: GoogleFonts.dmSans(
                fontSize: 12, color: AppColors.textTertiary)),
            ]),
            const SizedBox(height: 6),
            Row(children: [
              Expanded(child: Text('⚔️ $correctSoFar correct so far', style: GoogleFonts.dmSans(
                fontSize: 11, color: AppColors.textTertiary))),
              if (!_revealed)
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.timer_outlined, size: 13,
                    color: _secondsLeft <= 10 ? AppColors.error : AppColors.textTertiary),
                  const SizedBox(width: 3),
                  Text('${_secondsLeft}s', style: GoogleFonts.dmSans(
                    fontSize: 12, fontWeight: FontWeight.w600,
                    color: _secondsLeft <= 10 ? AppColors.error : AppColors.textTertiary)),
                ]),
            ]),
            const SizedBox(height: 24),

            Expanded(child: SingleChildScrollView(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (_current.passage != null && _current.passage!.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(10)),
                  child: Text(_current.passage!, style: GoogleFonts.dmSans(
                    fontSize: 12, color: AppColors.textSecondary, height: 1.6)),
                ),
                const SizedBox(height: 12),
              ],
              Text(_current.question, style: GoogleFonts.dmSans(
                fontSize: 16, fontWeight: FontWeight.w500,
                color: AppColors.textPrimary, height: 1.5)),
              const SizedBox(height: 20),
              ..._current.options.asMap().entries.map((e) {
                final i = e.key;
                final isCorrect = i == _current.correctIndex;
                final isSelected = i == _selected;
                Color bg = AppColors.surface;
                Color border = AppColors.border;
                if (_revealed && isCorrect) {
                  bg = AppColors.successSurface;
                  border = AppColors.success;
                } else if (_revealed && isSelected && !isCorrect) {
                  bg = AppColors.errorSurface;
                  border = AppColors.error;
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () => _selectOption(i),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: bg,
                        border: Border.all(color: border),
                        borderRadius: BorderRadius.circular(12)),
                      child: Text(e.value, style: GoogleFonts.dmSans(
                        fontSize: 14, color: AppColors.textPrimary)),
                    ),
                  ),
                );
              }),
              if (_revealed && _current.explanation.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(10)),
                  child: Text(_current.explanation, style: GoogleFonts.dmSans(
                    fontSize: 12, color: AppColors.textSecondary, height: 1.5)),
                ),
              ],
            ]))),

            const SizedBox(height: 12),
            Row(children: [
              if (!_revealed)
                Expanded(child: TextButton(
                  onPressed: _skip,
                  child: Text('Skip', style: GoogleFonts.dmSans(color: AppColors.textTertiary)),
                )),
              if (_revealed)
                Expanded(child: ElevatedButton(
                  onPressed: _submitting ? null : _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _submitting
                      ? const SizedBox(width: 18, height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(_index == total - 1 ? 'Finish' : 'Next question',
                          style: GoogleFonts.dmSans(fontWeight: FontWeight.w600, color: Colors.white)),
                )),
            ]),
          ]),
        ),
      ),
    );
  }
}