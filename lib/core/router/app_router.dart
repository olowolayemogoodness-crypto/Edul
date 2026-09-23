import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_routes.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/tutor/presentation/pages/tutor_page.dart';
import '../../features/quiz/presentation/pages/quiz_page.dart';
import '../../features/exam_prep/presentation/pages/exam_prep_page.dart';
import '../../features/library/presentation/pages/library_page.dart';
import '../../features/auth/presentation/pages/subject_picker_page.dart';
import '../../features/flashcards/presentation/pages/flashcards_page.dart';
import '../../features/auth/presentation/pages/interest_picker_page.dart';
import '../../features/study_rooms/presentation/pages/study_rooms_page.dart';
import '../../features/scholarship/presentation/pages/scholarship_page.dart';
import '../../features/masterclass/presentation/pages/masterclass_page.dart';
import '../../features/camera_scan/presentation/pages/camera_scan_page.dart';
import '../../features/practice_test/presentation/pages/practice_test_page.dart';
import '../../features/profile/presentation/pages/profile_settings_page.dart';
import '../../features/auth/presentation/pages/student_type_page.dart';
import '../../features/learning/presentation/pages/learning_map_page.dart';
import '../../features/learning/presentation/pages/lesson_detail_page.dart';
import '../../features/insights/presentation/pages/insights_feed_page.dart';
import '../../features/streak/presentation/pages/streak_celebration_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: AppRoutes.splash,      name: 'splash',      builder: (c, s) => const SplashPage()),
      GoRoute(path: AppRoutes.onboarding,  name: 'onboarding',  builder: (c, s) => const OnboardingPage()),
      GoRoute(path: AppRoutes.login,       name: 'login',       builder: (c, s) => const LoginPage()),
      GoRoute(path: AppRoutes.register,    name: 'register',    builder: (c, s) => const RegisterPage()),
      GoRoute(path: AppRoutes.home,        name: 'home',        builder: (c, s) => const HomePage()),
      GoRoute(path: AppRoutes.profile,     name: 'profile',     builder: (c, s) => const ProfilePage()),
      GoRoute(path: AppRoutes.tutor,       name: 'tutor',       builder: (c, s) => const TutorPage()),
      GoRoute(path: AppRoutes.quiz,        name: 'quiz',        builder: (c, s) => const QuizPage()),
      GoRoute(path: AppRoutes.examPrep,    name: 'examPrep',    builder: (c, s) => const ExamPrepPage()),
      GoRoute(path: AppRoutes.library,       name: 'library',       builder: (c, s) => const LibraryPage()),
      GoRoute(path: AppRoutes.subjectPicker, name: 'subjectPicker', builder: (c, s) => const SubjectPickerPage()),
      GoRoute(path: AppRoutes.flashcards,  name: 'flashcards',  builder: (c, s) => const FlashcardsPage()),
      GoRoute(path: '/interests', name: 'interests', builder: (c, s) => const InterestPickerPage()),
      GoRoute(path: AppRoutes.studyRoom,   name: 'studyRoom',   builder: (c, s) => const StudyRoomsPage()),
      GoRoute(
  path: '/discover',
  name: 'discover',
  builder: (context, state) => const InsightsFeedPage(),
),
      GoRoute(path: AppRoutes.scholarship, name: 'scholarship', builder: (c, s) => const ScholarshipPage()),
      GoRoute(path: '/masterclass', name: 'masterclass', builder: (c, s) => const MasterclassPage()),
      GoRoute(path: AppRoutes.cameraScan,  name: 'cameraScan',  builder: (c, s) => const CameraScanPage()),
      GoRoute(path: AppRoutes.practiceTest, name: 'practiceTest', builder: (c, s) => const PracticeTestPage()),
      GoRoute(path: '/settings', name: 'settings', builder: (c, s) => const ProfileSettingsPage()),
      GoRoute(path: '/student-type', name: 'studentType', builder: (c, s) => const StudentTypePage()),
      GoRoute(path: '/learning-map',builder: (context, state) => const LearningMapPage(),),
     // NEW
GoRoute(
  path: '/library-subjects',
  name: 'library-subjects',
  builder: (context, state) => const LibraryPage(),
),


      GoRoute(path: '/lesson-detail',builder: (context, state) {final extra = state.extra as Map<String, dynamic>;return LessonDetailPage(lessonId: extra['lessonId'],lessonName: extra['lessonName'],color: extra['colorValue'].toString(),);
      
  },
),
      GoRoute(
        path: AppRoutes.streakCelebration,
        name: 'streakCelebration',
        builder: (context, state) {
          final count = (state.extra as Map<String, dynamic>?)?['streakCount'] as int? ?? 1;
          return StreakCelebrationPage(streakCount: count);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.error}',
          style: Theme.of(context).textTheme.bodyMedium)),
    ),
  );
}