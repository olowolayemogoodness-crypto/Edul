import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/lives_badge.dart';
import '../../../../core/services/hint_service.dart';
import '../../../../core/services/rewarded_ad_service.dart';
import '../../../../core/services/premium_service.dart';
import '../../../../core/services/vision_service.dart';
import '../../../../core/services/ai_explain_service.dart';
import '../bloc/quiz_bloc.dart';
import '../../domain/models/quiz_question.dart';

class QuizQuestionPage extends StatefulWidget {
  const QuizQuestionPage({super.key});
  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _timerSecs = 30;
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  // Hint effects are per-question (reset when the question changes),
  // while the underlying hint BALANCE persists across the whole quiz —
  // see HintService.
  Set<int> _eliminatedIndices = {};
  bool _answerRevealed = false;
  int _lastQuestionIndex = -1;

  final GlobalKey _screenshotBoundaryKey = GlobalKey();
  bool _aiLoading = false;

  @override
  void initState() {
    super.initState();
    HintService.ensureLoaded().then((_) { if (mounted) setState(() {}); });
    AiExplainService.ensureLoaded();
    RewardedAdService.preload();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
    _startTimer();
  }

  Future<void> _handleAiExplainTap() async {
    if (_aiLoading) return;
    if (!AiExplainService.canUseNow) {
      _showAdPromptThenExplain();
      return;
    }
    AiExplainService.consumeUse();
    await _captureAndExplain();
  }

  void _showAdPromptThenExplain() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('✨', style: TextStyle(fontSize: 40)),
            const SizedBox(height: 14),
            Text("You've used your free explanations", style: GoogleFonts.dmSans(
              fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            Text('Watch a short ad to unlock ${AiExplainService.adBatchSize} more', textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: () {
                Navigator.pop(sheetContext);
                RewardedAdService.show(
                  onRewarded: () {
                    AiExplainService.grantAdBatch();
                    AiExplainService.consumeUse();
                    _captureAndExplain();
                  },
                  onNotReady: () {
                    if (mounted) ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ad not ready yet — try again in a moment')));
                  },
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: Text('Watch ad', style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w600)),
            )),
          ]),
        ),
      ),
    );
  }

  Future<void> _captureAndExplain() async {
    setState(() => _aiLoading = true);
    try {
      final boundary = _screenshotBoundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) throw Exception('Could not capture the screen');
      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/quiz_explain_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);

      final rawExplanation = await VisionService.analyzeImage(file);
      if (!mounted) return;
      _showExplanationSheet(_stripThinkingTrace(rawExplanation));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not get an explanation: $e')));
    } finally {
      if (mounted) setState(() => _aiLoading = false);
    }
  }

  // Qwen3.6 is a reasoning model -- it can emit its internal chain-of-
  // thought wrapped in <think>...</think> before the actual answer.
  // That's meant to stay internal, not be shown to the user as if it
  // were the explanation itself.
  String _stripThinkingTrace(String text) {
    return text.replaceAll(RegExp(r'<think>[\s\S]*?</think>', caseSensitive: false), '').trim();
  }

  void _showExplanationSheet(String explanation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6, minChildSize: 0.3, maxChildSize: 0.9, expand: false,
        builder: (_, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(Icons.auto_awesome_rounded, color: AppColors.accentLight, size: 18),
                const SizedBox(width: 8),
                Text('AI explanation', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              ]),
              const SizedBox(height: 14),
              GptMarkdown(explanation, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary, height: 1.6)),
            ]),
          ),
        ),
      ),
    );
  }

  void _startTimer([QuizMode? mode, QuizDifficulty? difficulty]) {
    _timer?.cancel();
    // Free mode has no time limit at all -- don't just hide the badge,
    // don't run the countdown or schedule the auto-timeout either.
    final effectiveMode = mode ?? _currentQuizMode();
    if (effectiveMode == QuizMode.free) return;
    final effectiveDifficulty = difficulty ?? _currentQuizDifficulty();
    setState(() => _timerSecs = _durationFor(effectiveDifficulty));
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() => _timerSecs--);
      if (_timerSecs <= 0) { t.cancel(); context.read<QuizBloc>().add(QuizTimedOut()); }
    });
  }

  // Easy gets the most thinking time, Hard the least -- same spirit as
  // Battle's round budgets, just per-question instead of per-round since
  // the solo quiz times each question individually, not a shared clock.
  int _durationFor(QuizDifficulty? d) => switch (d) {
    QuizDifficulty.easy => 45,
    QuizDifficulty.medium => 30,
    QuizDifficulty.hard => 15,
    null => 30,
  };

  QuizMode? _currentQuizMode() {
    final state = context.read<QuizBloc>().state;
    return state is QuizInProgress ? state.mode : null;
  }

  QuizDifficulty? _currentQuizDifficulty() {
    final state = context.read<QuizBloc>().state;
    return state is QuizInProgress ? state.difficulty : null;
  }

  void _stopTimer() => _timer?.cancel();

  @override
  void dispose() { _timer?.cancel(); _fadeCtrl.dispose(); super.dispose(); }

  void _onAnswer(int idx) {
    _stopTimer();
    final elapsed = 30 - _timerSecs;
    context.read<QuizBloc>().add(QuizAnswerSelected(selectedIndex: idx, secondsTaken: elapsed));
  }

  void _onNext(QuizInProgress s) {
    if (!s.isLastQuestion) { _fadeCtrl.reset(); _startTimer(s.mode, s.difficulty); _fadeCtrl.forward(); }
    context.read<QuizBloc>().add(QuizNextQuestion());
  }

  void _useRevealHint(QuizInProgress s) {
    if (s.answered || _answerRevealed) return;
    if (HintService.useReveal()) {
      setState(() => _answerRevealed = true);
      return;
    }
    if (HintService.isPremium) {
      HintService.grantRevealBatch();
      HintService.useReveal();
      setState(() => _answerRevealed = true);
      return;
    }
    RewardedAdService.show(
      onRewarded: () {
        HintService.grantRevealBatch();
        HintService.useReveal();
        if (mounted) setState(() => _answerRevealed = true);
      },
      onNotReady: () => _showHintMessage('Ad not ready yet — try again in a moment'),
      onFailed: () => _showHintMessage('Ad failed to show — try again in a moment'),
    );
  }

  void _useEliminateHint(QuizInProgress s) {
    if (s.answered) return;
    final wrongIndices = List.generate(s.currentQuestion.options.length, (i) => i)
        .where((i) => i != s.currentQuestion.correctIndex && !_eliminatedIndices.contains(i))
        .toList();
    if (wrongIndices.length < 2) return; // nothing left worth eliminating

    void applyElimination() {
      wrongIndices.shuffle();
      setState(() => _eliminatedIndices.addAll(wrongIndices.take(2)));
    }

    if (HintService.useEliminate()) {
      applyElimination();
      return;
    }
    if (HintService.isPremium) {
      HintService.grantEliminateBatch();
      HintService.useEliminate();
      applyElimination();
      return;
    }
    RewardedAdService.show(
      onRewarded: () {
        HintService.grantEliminateBatch();
        HintService.useEliminate();
        if (mounted) applyElimination();
      },
      onNotReady: () => _showHintMessage('Ad not ready yet — try again in a moment'),
      onFailed: () => _showHintMessage('Ad failed to show — try again in a moment'),
    );
  }

  void _showHintMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.dmSans(fontSize: 13)),
      backgroundColor: AppColors.surfaceVariant,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is! QuizInProgress) return const SizedBox();
        final s = state;
        final showTimer = s.mode == QuizMode.timed || s.mode == QuizMode.battle;
        if (s.currentIndex != _lastQuestionIndex) {
          _lastQuestionIndex = s.currentIndex;
          _eliminatedIndices = {};
          _answerRevealed = false;
        }
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(children: [
            RepaintBoundary(
              key: _screenshotBoundaryKey,
              child: SafeArea(child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
              child: Row(children: [
                GestureDetector(
                  onTap: () { _stopTimer(); context.read<QuizBloc>().add(QuizReset()); },
                  child: Icon(Icons.close_rounded, color: AppColors.textTertiary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Question ${s.currentIndex + 1} of ${s.questions.length}',
                      style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
                    Text('+${50 + s.bestStreak * 5} XP',
                      style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.accentLight)),
                  ]),
                  const SizedBox(height: 5),
                  ClipRRect(borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: s.progress, minHeight: 6,
                      backgroundColor: AppColors.border,
                      valueColor: AlwaysStoppedAnimation(AppColors.accent),
                    )),
                ])),
                if (showTimer) ...[const SizedBox(width: 10), _TimerBadge(secs: _timerSecs)],
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Row(children: [
                const LivesBadge(),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                  decoration: BoxDecoration(color: const Color(0xFF2D1E00), borderRadius: BorderRadius.circular(20)),
                  child: Text('🔥 ${s.streak}', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500, color: const Color(0xFFE8960F))),
                ),
              ]),
            ),
            if (s.lives <= 0) const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: _OutOfLivesBanner(),
            ),
            if (!s.answered) Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Row(children: [
                Expanded(child: _HintButton(
                  icon: Icons.remove_red_eye_rounded,
                  label: 'Reveal answer',
                  balance: HintService.revealBalance,
                  active: _answerRevealed,
                  onTap: () => _useRevealHint(s),
                )),
                const SizedBox(width: 10),
                Expanded(child: _HintButton(
                  icon: Icons.filter_alt_off_rounded,
                  label: 'Eliminate 2',
                  balance: HintService.eliminateBalance,
                  active: _eliminatedIndices.isNotEmpty,
                  onTap: () => _useEliminateHint(s),
                )),
              ]),
            ),
            Expanded(child: FadeTransition(
              opacity: _fadeAnim,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  _QuestionCard(question: s.currentQuestion, difficulty: s.difficulty, topicLabel: s.topicLabel),
                  const SizedBox(height: 14),
                  _OptionsWidget(
                    question: s.currentQuestion,
                    selectedIndex: s.selectedIndex,
                    answered: s.answered,
                    onAnswer: _onAnswer,
                    eliminatedIndices: _eliminatedIndices,
                    answerRevealed: _answerRevealed,
                  ),
                  if (s.answered) ...[
                    const SizedBox(height: 10),
                    _FeedbackPanel(
                      isCorrect: s.selectedIndex == s.currentQuestion.correctIndex,
                      timedOut: s.selectedIndex == -1,
                      explanation: s.currentQuestion.explanation,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _onNext(s),
                      child: Container(
                        width: double.infinity, padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: s.isLastQuestion ? const Color(0xFF059669) : AppColors.accent,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(s.isLastQuestion ? 'See results →' : 'Next question →',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                ]),
              ),
            )),
          ])),
            ),
            // Only appears after answering -- letting this fire before an
            // answer is submitted would just hand the answer to whoever
            // taps it, defeating the whole point of a quiz.
            if (s.answered)
            Positioned(
              right: 16,
              bottom: 24,
              child: GestureDetector(
                onTap: _handleAiExplainTap,
                child: Container(
                  width: 52, height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: AppColors.accent.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  child: _aiLoading
                      ? const Padding(padding: EdgeInsets.all(14), child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                      : const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 24),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}

class _HintButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int balance;
  final bool active;
  final VoidCallback onTap;
  const _HintButton({
    required this.icon, required this.label, required this.balance,
    required this.active, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final premium = !PremiumService.isRealFree;
    return GestureDetector(
      onTap: active ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: active ? AppColors.accentSurface : AppColors.surface,
          border: Border.all(color: active ? AppColors.accent : AppColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 15, color: active ? AppColors.accentLight : AppColors.textSecondary),
          const SizedBox(width: 6),
          Expanded(child: Text(label, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(
            fontSize: 11, color: active ? AppColors.accentLight : AppColors.textSecondary))),
          const SizedBox(width: 4),
          if (balance > 0)
            Text('$balance', style: GoogleFonts.dmSans(
              fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.accentLight))
          else if (premium)
            Icon(Icons.workspace_premium_rounded, size: 13, color: AppColors.accentLight)
          else
            Icon(Icons.play_circle_outline_rounded, size: 13, color: AppColors.textTertiary),
        ]),
      ),
    );
  }
}

class _TimerBadge extends StatelessWidget {
  final int secs;
  const _TimerBadge({required this.secs});
  @override
  Widget build(BuildContext context) {
    final urgent = secs <= 10;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: urgent ? const Color(0xFF2D1200) : const Color(0xFF1A0800),
        border: Border.all(color: urgent ? const Color(0xFFDC2626) : const Color(0xFFEA580C)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(children: [
        Icon(Icons.timer_outlined, size: 11, color: urgent ? const Color(0xFFDC2626) : const Color(0xFFEA580C)),
        const SizedBox(width: 4),
        Text('0:${secs.toString().padLeft(2, "0")}',
          style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600,
            color: urgent ? const Color(0xFFDC2626) : const Color(0xFFEA580C))),
      ]),
    );
  }
}

// Shown when a student hits 0 lives mid-quiz. Deliberately
// NON-BLOCKING for now -- the quiz stays playable underneath this
// banner, since no ad SDK is wired up yet and hard-blocking with a
// button that can't actually do anything would strand the student
// with no real way through. This does NOT touch LivesService at all
// (see LivesService.markQuizContinuedViaAd) -- watching an ad here is
// meant to unlock finishing THIS quiz only, never a permanent life.
class _OutOfLivesBanner extends StatelessWidget {
  const _OutOfLivesBanner();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A0F0F),
        border: Border.all(color: const Color(0xFFDC2626), width: 1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(children: [
        const Text('💔', style: TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Out of lives', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          Text('Watch an ad to finish this quiz', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
        ])),
        Opacity(
          opacity: 0.4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.play_circle_outline, size: 12, color: AppColors.textDisabled),
              const SizedBox(width: 3),
              Text('Watch ad', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textDisabled)),
            ]),
          ),
        ),
      ]),
    );
  }
}


class _QuestionCard extends StatelessWidget {
  final QuizQuestion question;
  final QuizDifficulty difficulty;
  final String topicLabel;
  const _QuestionCard({required this.question, required this.difficulty, required this.topicLabel});

  String get _diffLabel => switch (difficulty) {
    QuizDifficulty.easy => 'Easy',
    QuizDifficulty.medium => 'Medium',
    QuizDifficulty.hard => 'Hard',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface, border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle)),
          const SizedBox(width: 7),
          Text(topicLabel, style: GoogleFonts.dmSans(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.accentLight)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: const Color(0xFF1E1240), borderRadius: BorderRadius.circular(20)),
            child: Text(_diffLabel, style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.accentLight)),
          ),
        ]),
        const SizedBox(height: 10),
        if (question.passage != null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border(left: BorderSide(color: AppColors.accent, width: 3)),
            ),
            child: Text(
              question.passage!,
              style: GoogleFonts.dmSans(
                fontSize: 12.5,
                fontStyle: FontStyle.italic,
                color: AppColors.textSecondary,
                height: 1.55,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (question.imageUrl != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              question.imageUrl!,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(question.question, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary, height: 1.6)),
      ]),
    );
  }
}

class _OptionsWidget extends StatelessWidget {
  final QuizQuestion question;
  final int? selectedIndex;
  final bool answered;
  final ValueChanged<int> onAnswer;
  final Set<int> eliminatedIndices;
  final bool answerRevealed;
  const _OptionsWidget({
    required this.question, required this.selectedIndex, required this.answered,
    required this.onAnswer, required this.eliminatedIndices, required this.answerRevealed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...List.generate(question.options.length, (i) {
      final isSelected = selectedIndex == i;
      final isCorrect = i == question.correctIndex;
      final isEliminated = !answered && eliminatedIndices.contains(i);
      final isHintedCorrect = !answered && answerRevealed && isCorrect;
      Color bg = AppColors.surface;
      Color border = AppColors.border;
      Color textColor = AppColors.textSecondary;
      double opacity = 1.0;

      if (answered) {
        if (isCorrect) { bg = const Color(0xFF052E1E); border = const Color(0xFF059669); textColor = const Color(0xFF6EE7B7); }
        else if (isSelected) { bg = const Color(0xFF1F0A0A); border = const Color(0xFFDC2626); textColor = const Color(0xFFFCA5A5); }
        else { opacity = 0.3; }
      } else if (isHintedCorrect) {
        border = const Color(0xFFE8960F);
        bg = const Color(0xFF2D1E00);
      } else if (isEliminated) {
        opacity = 0.3;
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: (answered || isEliminated) ? null : () => onAnswer(i),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: opacity,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              decoration: BoxDecoration(color: bg, border: Border.all(color: border, width: 1.5), borderRadius: BorderRadius.circular(14)),
              child: Row(children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: answered && isCorrect ? const Color(0xFF059669) : answered && isSelected ? const Color(0xFFDC2626) : AppColors.border,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(child: Text(String.fromCharCode(65 + i),
                    style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500,
                      color: answered && (isCorrect || isSelected) ? Colors.white : AppColors.textSecondary))),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(question.options[i], style: GoogleFonts.dmSans(fontSize: 13, color: textColor))),
                if (answered && isCorrect) const Icon(Icons.check_circle_rounded, color: Color(0xFF059669), size: 16),
                if (answered && isSelected && !isCorrect) const Icon(Icons.cancel_rounded, color: Color(0xFFDC2626), size: 16),
                if (isHintedCorrect) const Icon(Icons.lightbulb_rounded, color: Color(0xFFE8960F), size: 16),
              ]),
            ),
          ),
        ),
      );
      }),
      // Short solution -- only shows once the question is answered AND
      // this specific question actually has explanation content. Most
      // question banks don't have this authored yet (checked directly:
      // zero explanation text across the PHY102/GNS106/etc banks), so
      // this stays invisible rather than showing an empty box for
      // virtually every question until that content exists.
      if (answered && question.explanation.trim().isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.info_outline_rounded, size: 15, color: AppColors.accentLight),
              const SizedBox(width: 8),
              Expanded(child: Text(question.explanation.trim(),
                style: GoogleFonts.dmSans(fontSize: 12.5, color: AppColors.textSecondary, height: 1.5))),
            ]),
          ),
        ),
    ]);
  }
}

class _FeedbackPanel extends StatelessWidget {
  final bool isCorrect, timedOut;
  final String explanation;
  const _FeedbackPanel({required this.isCorrect, required this.timedOut, required this.explanation});

  @override
  Widget build(BuildContext context) {
    final title = timedOut ? "⏱ Time's up!" : isCorrect ? '✓ Correct! +10 XP' : '✗ Not quite';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0xFF052E1E) : const Color(0xFF1F0A0A),
        border: Border.all(color: isCorrect ? const Color(0xFF059669) : const Color(0xFFDC2626), width: 0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600,
          color: isCorrect ? const Color(0xFF6EE7B7) : const Color(0xFFFCA5A5))),
        const SizedBox(height: 4),
        Text(explanation, style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textSecondary, height: 1.6)),
      ]),
    );
  }
}