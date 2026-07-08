import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/quiz_question.dart';
import '../../data/mock_questions.dart';
import '../../data/topic_question_source.dart';
import '../../../../core/services/quiz_sound_service.dart';
import '../../../../core/services/lives_service.dart';

// ── Events ──
abstract class QuizEvent {}
class QuizStarted extends QuizEvent {
  final String topic;
  final List<String> topicIds;
  final QuizDifficulty difficulty;
  final QuizMode mode;
  QuizStarted({required this.topic, this.topicIds = const [], required this.difficulty, required this.mode});
}
class QuizAnswerSelected extends QuizEvent {
  final int selectedIndex;
  final int secondsTaken;
  QuizAnswerSelected({required this.selectedIndex, required this.secondsTaken});
}
class QuizNextQuestion extends QuizEvent {}
class QuizTimedOut extends QuizEvent {}
class QuizReset extends QuizEvent {}

// ── States ──
abstract class QuizState {}
class QuizInitial extends QuizState {}

class QuizInProgress extends QuizState {
  final List<QuizQuestion> questions;
  final int currentIndex;
  final int lives;
  final int streak;
  final int bestStreak;
  final int correct;
  final int wrong;
  final int? selectedIndex;
  final bool answered;
  final QuizMode mode;
  final QuizDifficulty difficulty;
  final String topicLabel;

  QuizInProgress({
    required this.questions,
    required this.currentIndex,
    required this.lives,
    required this.streak,
    required this.bestStreak,
    required this.correct,
    required this.wrong,
    required this.mode,
    required this.difficulty,
    required this.topicLabel,
    this.selectedIndex,
    this.answered = false,
  });

  QuizQuestion get currentQuestion => questions[currentIndex];
  double get progress => (currentIndex + 1) / questions.length;
  bool get isLastQuestion => currentIndex >= questions.length - 1;

  QuizInProgress copyWith({
    int? currentIndex, int? lives, int? streak, int? bestStreak,
    int? correct, int? wrong, int? selectedIndex, bool? answered,
  }) {
    return QuizInProgress(
      questions: questions, mode: mode, difficulty: difficulty,
      topicLabel: topicLabel,
      currentIndex: currentIndex ?? this.currentIndex,
      lives: lives ?? this.lives,
      streak: streak ?? this.streak,
      bestStreak: bestStreak ?? this.bestStreak,
      correct: correct ?? this.correct,
      wrong: wrong ?? this.wrong,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      answered: answered ?? this.answered,
    );
  }
}

class QuizFinished extends QuizState {
  final QuizResult result;
  QuizFinished({required this.result});
}

// ── BLoC ──
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final List<QuizAnswerRecord> _answers = [];
  final List<int> _times = [];

  QuizBloc() : super(QuizInitial()) {
    on<QuizStarted>(_onStarted);
    on<QuizAnswerSelected>(_onAnswerSelected);
    on<QuizNextQuestion>(_onNextQuestion);
    on<QuizTimedOut>(_onTimedOut);
    on<QuizReset>(_onReset);
  }

  int _questionCountForDifficulty(QuizDifficulty difficulty) {
    switch (difficulty) {
      case QuizDifficulty.easy:
        return 10;
      case QuizDifficulty.medium:
        return 20;
      case QuizDifficulty.hard:
        return 30;
    }
  }

  /// Builds the real "course · topic" label shown on the question card
  /// and results screen, replacing what used to be a hardcoded
  /// "Gemini · Data Structures" placeholder. If exactly one fine-grained
  /// topic was selected, shows its real display name (e.g.
  /// "GNS 106 · Schools of Thought"); otherwise (whole course, or
  /// multiple topics selected) falls back to just the course key
  /// (e.g. "GNS 106").
  String _topicLabelFor(QuizStarted event) {
    if (event.topicIds.length == 1) {
      final topics = TopicQuestionSource.topicsForCourse(event.topic);
      final match = topics.firstWhere(
        (t) => t['id'] == event.topicIds.first,
        orElse: () => {'name': event.topic},
      );
      return '${event.topic} · ${match['name']}';
    }
    return event.topic;
  }

  Future<void> _onStarted(QuizStarted event, Emitter<QuizState> emit) async {
    _answers.clear(); _times.clear();

    final requestedCount = _questionCountForDifficulty(event.difficulty);
    List<QuizQuestion> questions;
    if (TopicQuestionSource.hasQuestionBank(event.topic)) {
      // event.topic is a subjectsData course key (e.g. 'MTS 102')
      questions = event.topicIds.isEmpty
          ? TopicQuestionSource.questionsForCourse(event.topic)
          : TopicQuestionSource.questionsForSelectedTopics(
              courseKey: event.topic,
              lessonIds: event.topicIds,
              minCount: requestedCount,
            );
    } else {
      // Fallback to legacy mock questions (old flow / topics not in the catalog)
      questions = MockQuestions.getQuestions(
        topic: event.topic, difficulty: event.difficulty,
      );
    }

    // Trim to the difficulty's question count. If the pool has fewer
    // questions than requested, use everything available instead of
    // throwing a range error.
    if (questions.length > requestedCount) {
      questions = questions.take(requestedCount).toList();
    }

    // Lives are now GLOBAL/persistent (see LivesService) -- a quiz no
    // longer starts with a fresh 3 every time; it reflects whatever
    // the student's real current life count is, including regen that
    // happened since they last played.
    final currentLives = await LivesService.getCurrentLives();

    emit(QuizInProgress(
      questions: questions, currentIndex: 0, lives: currentLives,
      streak: 0, bestStreak: 0, correct: 0, wrong: 0,
      mode: event.mode, difficulty: event.difficulty,
      topicLabel: _topicLabelFor(event),
    ));
  }

  Future<void> _onAnswerSelected(QuizAnswerSelected event, Emitter<QuizState> emit) async {
    final s = state as QuizInProgress;
    if (s.answered) return;
    final isCorrect = event.selectedIndex == s.currentQuestion.correctIndex;
    final newStreak = isCorrect ? s.streak + 1 : 0;
    final newBest = newStreak > s.bestStreak ? newStreak : s.bestStreak;
    if (isCorrect) {
      QuizSoundService.playCorrect(newStreak);
    } else {
      QuizSoundService.playWrong();
    }

    // Lives are global/persistent now (see LivesService) -- every 5th
    // wrong answer, tracked across quiz sessions (not reset per
    // quiz), costs exactly 1 life. A correct answer never touches this.
    var newLives = s.lives;
    if (!isCorrect) {
      await LivesService.recordWrongAnswer();
      newLives = await LivesService.getCurrentLives();
    }

    _answers.add(QuizAnswerRecord(
      question: s.currentQuestion.question,
      correct: isCorrect,
      secondsTaken: event.secondsTaken,
    ));
    _times.add(event.secondsTaken);
    emit(s.copyWith(
      selectedIndex: event.selectedIndex,
      answered: true,
      correct: isCorrect ? s.correct + 1 : s.correct,
      wrong: isCorrect ? s.wrong : s.wrong + 1,
      streak: newStreak,
      bestStreak: newBest,
      lives: newLives,
    ));
  }

  void _onNextQuestion(QuizNextQuestion event, Emitter<QuizState> emit) {
    final s = state as QuizInProgress;
    if (s.isLastQuestion) {
      _finish(s, emit);
    } else {
      emit(s.copyWith(currentIndex: s.currentIndex + 1, selectedIndex: -1, answered: false));
    }
  }

  Future<void> _onTimedOut(QuizTimedOut event, Emitter<QuizState> emit) async {
    final s = state as QuizInProgress;
    if (s.answered) return;
    QuizSoundService.playWrong();
    await LivesService.recordWrongAnswer();
    final newLives = await LivesService.getCurrentLives();
    _answers.add(QuizAnswerRecord(question: s.currentQuestion.question, correct: false, secondsTaken: 30));
    _times.add(30);
    emit(s.copyWith(
      answered: true, selectedIndex: -1, wrong: s.wrong + 1, streak: 0,
      lives: newLives,
    ));
  }

  void _onReset(QuizReset event, Emitter<QuizState> emit) {
    _answers.clear(); _times.clear();
    emit(QuizInitial());
  }

  void _finish(QuizInProgress s, Emitter<QuizState> emit) {
    final avg = _times.isNotEmpty ? _times.reduce((a, b) => a + b) / _times.length : 0.0;
    emit(QuizFinished(result: QuizResult(
      correct: s.correct, wrong: s.wrong, bestStreak: s.bestStreak,
      avgTimeSeconds: avg, answers: List.from(_answers),
      xpEarned: 50 + s.bestStreak * 5,
      topicLabel: s.topicLabel,
    )));
  }
}