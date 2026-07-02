import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'injection_container.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0D0D0F),
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  await _migrateCompulsoryCourses();
  runApp(const EduLinkApp());
}

/// One-time migration: ensures compulsory GST/core courses are unlocked
/// for users who registered before this feature existed. Runs once per
/// install (guarded by a SharedPreferences flag), then never again.
/// New registrations also get these via subject_picker_page.dart, so this
/// is purely a backfill for existing accounts.
Future<void> _migrateCompulsoryCourses() async {
  final prefs = await SharedPreferences.getInstance();
  final alreadyMigrated = prefs.getBool('compulsory_migration_v1_done') ?? false;
  if (alreadyMigrated) return;

  final unlocked = prefs.getStringList('unlocked_courses') ?? [];
  final merged = <String>{
    ...unlocked,
    ...AppConstants.compulsoryCourseCodes,
  }.toList();
  await prefs.setStringList('unlocked_courses', merged);
  await prefs.setBool('compulsory_migration_v1_done', true);
}

class EduLinkApp extends StatelessWidget {
  const EduLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()..add(const AuthStarted()),
        ),
      ],
      child: MaterialApp.router(
        title: 'EduLink',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        routerConfig: AppRouter.router,
      ),
    );
  }
}