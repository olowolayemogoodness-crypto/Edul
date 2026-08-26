import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_routes.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/study_rooms/presentation/pages/study_rooms_page.dart';
import '../../features/profile/presentation/pages/profile_settings_page.dart';
import '../../features/auth/presentation/pages/student_type_page.dart';
import '../../features/study_rooms/presentation/pages/room_invite_link_page.dart';
import '../../features/social/presentation/pages/post_detail_page.dart';

// NOTE: routes for tutor, quiz, exam prep, library, flashcards, study
// materials/discover, scholarship, masterclass, camera scan, practice
// test, learning map, lesson detail, and streak celebration were
// removed here -- their entire feature folders were archived out of
// lib/ (moved to /archive, not deleted) as part of the deliberate
// "one product face" decision: Social/info-centralization only, no
// competing Edu identity.

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
      GoRoute(path: AppRoutes.studyRoom,   name: 'studyRoom',   builder: (c, s) => const StudyRoomsPage()),
      GoRoute(
        path: '${AppRoutes.roomInvite}/:roomId',
        name: 'roomInvite',
        builder: (c, s) => RoomInviteLinkPage(roomId: s.pathParameters['roomId']!),
      ),
      GoRoute(
        path: '${AppRoutes.postDetail}/:postId',
        name: 'postDetail',
        builder: (c, s) => PostDetailPage(postId: s.pathParameters['postId']!),
      ),
      GoRoute(path: '/settings', name: 'settings', builder: (c, s) => const ProfileSettingsPage()),
      GoRoute(path: '/student-type', name: 'studentType', builder: (c, s) => const StudentTypePage()),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.error}',
          style: Theme.of(context).textTheme.bodyMedium)),
    ),
  );
}