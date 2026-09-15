import 'package:firebase_core/firebase_core.dart';
import 'core/services/premium_service.dart';
import 'core/services/theme_override_service.dart';
import 'core/services/study_reminder_service.dart';
import 'core/services/rewarded_ad_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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

  // TEMPORARY DIAGNOSTIC — shows the real error in red text instead of
  // Flutter's default silent gray box (which release builds normally show
  // to hide internals from real users). Remove this override once the
  // social-feed crash is found and fixed.
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        details.exceptionAsString(),
        style: const TextStyle(color: Colors.white, fontSize: 11),
        textAlign: TextAlign.left,
      ),
    );
  };

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
  // Best-effort: never let a notification setup failure block app startup.
  try {
    await StudyReminderService.init();
    await StudyReminderService.scheduleAll();
  } catch (_) {}
  // Native ads and in-app purchases are unavailable on the web runtime.
  // Guarding them here avoids the MissingPluginException / Platform.isIOS
  // crashes that happen when the Chrome target boots without the native
  // plugin implementations.
  if (!kIsWeb) {
    MobileAds.instance.initialize();
    try {
      await RewardedAdService.configureTestDevices();
    } catch (_) {}
    await PremiumService.initialize();
  }
  await ThemeOverrideService.init();
  await initDependencies();
  await _migrateCompulsoryCourses();
  await _migrateCOS102();
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

Future<void> _migrateCOS102() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('compulsory_migration_v2_done') ?? false) return;
  final unlocked = prefs.getStringList('unlocked_courses') ?? [];
  if (!unlocked.contains('COS102')) {
    unlocked.add('COS102');
    await prefs.setStringList('unlocked_courses', unlocked);
  }
  await prefs.setBool('compulsory_migration_v2_done', true);
}
class EduLinkApp extends StatefulWidget {
  const EduLinkApp({super.key});

  @override
  State<EduLinkApp> createState() => _EduLinkAppState();
}

class _EduLinkAppState extends State<EduLinkApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: ThemeOverrideService.changeSignal,
      builder: (context, epoch, _) {
        // The key changing forces Flutter to fully discard and rebuild
        // this entire subtree — needed because none of the individual
        // screens are otherwise reactive to a color change mid-session
        // (colors are read as plain static getters, not via Theme.of).
        return MultiBlocProvider(
          key: ValueKey('theme-epoch-$epoch'),
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
      },
    );
  }
}