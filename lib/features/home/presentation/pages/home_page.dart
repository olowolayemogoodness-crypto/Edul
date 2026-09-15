import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../social/presentation/pages/social_feed_page.dart';
import '../../../courses/presentation/pages/courses_page.dart';
import '../../../timetable/presentation/pages/timetable_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/social_streak_service.dart';
import '../../../../core/services/push_notification_service.dart';

// Final, confirmed nav: Social, Classes, Timetable, Profile. Home and
// Study (quiz/AI-tutor/flashcards/library, and the study rooms page)
// are removed entirely, not just hidden -- Classes replaces Home's
// old slot with the subjects board, matching how the original app
// laid out its four tabs. Discover (InsightsFeedPage) is also fully
// removed, not folded in anywhere.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _activeIndex = 0;
  int _unreadSocial = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _listenUnread();
    // Requests permission and saves this device's FCM token to the
    // user's profile -- without this call, no user ever has a token
    // saved to send a push to at all, regardless of how correctly the
    // sending side (NotificationService._sendPush) is written. Genuine
    // gap found and fixed before the first Shorebird release went to
    // testers.
    PushNotificationService.initialize();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  List<_TabDef> get _tabs => [
    _TabDef(icon: Icons.dynamic_feed_rounded, label: 'Social', builder: () => const SocialFeedPage(), isSocial: true),
    _TabDef(icon: Icons.grid_view_rounded, label: 'Classes', builder: () => const CoursesPage()),
    _TabDef(icon: Icons.calendar_month_rounded, label: 'Timetable', builder: () => const TimetablePage()),
    _TabDef(icon: Icons.person_rounded, label: 'Profile', builder: () => const ProfilePage()),
  ];

  int get _socialIndex => _tabs.indexWhere((t) => t.isSocial);

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_activeIndex == _socialIndex) SocialStreakService.pauseTracking();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Pause/resume social-streak time tracking around backgrounding, so
    // leaving the app open on the Social tab overnight doesn't falsely
    // accumulate hours of "time spent".
    if (_activeIndex != _socialIndex) return;
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      SocialStreakService.pauseTracking();
    } else if (state == AppLifecycleState.resumed) {
      SocialStreakService.startTracking();
    }
  }

  void _listenUnread() {
    final uid = UserService.uid;
    if (uid == null) return;
    FirebaseFirestore.instance
        .collection('notifications')
        .where('uid', isEqualTo: uid)
        .where('read', isEqualTo: false)
        .snapshots()
        .listen((snap) {
      if (mounted) setState(() => _unreadSocial = snap.docs.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = _tabs;
    final socialIndex = _socialIndex;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _activeIndex,
                  children: tabs.map((t) => t.builder()).toList(),
                ),
              ),
              _BottomNav(
                activeIndex: _activeIndex,
                unreadSocial: _unreadSocial,
                socialIndex: socialIndex,
                icons: tabs.map((t) => t.icon).toList(),
                labels: tabs.map((t) => t.label).toList(),
                onTap: (i) {
                  final wasSocial = _activeIndex == socialIndex;
                  setState(() {
                    _activeIndex = i;
                    if (i == socialIndex) _unreadSocial = 0; // opened Social, clear badge
                  });
                  if (wasSocial && i != socialIndex) {
                    SocialStreakService.pauseTracking();
                  } else if (!wasSocial && i == socialIndex) {
                    SocialStreakService.startTracking();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabDef {
  final IconData icon;
  final String label;
  final Widget Function() builder;
  final bool isSocial;
  _TabDef({required this.icon, required this.label, required this.builder, this.isSocial = false});
}

class _BottomNav extends StatelessWidget {
  final int activeIndex;
  final int unreadSocial;
  final int socialIndex;
  final List<IconData> icons;
  final List<String> labels;
  final ValueChanged<int> onTap;
  const _BottomNav({
    required this.activeIndex,
    required this.unreadSocial,
    required this.socialIndex,
    required this.icons,
    required this.labels,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      padding: EdgeInsets.only(top: 10, bottom: MediaQuery.of(context).padding.bottom + 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (i) {
          final active = i == activeIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Stack(clipBehavior: Clip.none, children: [
                Icon(icons[i], size: 22,
                    color: active ? AppColors.accentLight : AppColors.textTertiary),
                if (i == socialIndex && unreadSocial > 0)
                  Positioned(
                    right: -6, top: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDC2626),
                        borderRadius: BorderRadius.circular(8)),
                      child: Text(unreadSocial > 9 ? '9+' : '$unreadSocial',
                        style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                  ),
              ]),
              const SizedBox(height: 3),
              Text(labels[i], style: AppTextStyles.labelSmall.copyWith(
                  color: active ? AppColors.accentLight : AppColors.textTertiary)),
              if (active)
                Container(margin: const EdgeInsets.only(top: 2),
                    width: 4, height: 4,
                    decoration: BoxDecoration(
                        color: AppColors.accentLight, shape: BoxShape.circle)),
            ]),
          );
        }),
      ),
    );
  }
}