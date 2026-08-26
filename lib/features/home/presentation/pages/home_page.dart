import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../social/presentation/pages/social_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../albums/presentation/pages/albums_page.dart';
import '../../../timetable/presentation/pages/timetable_page.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/social_streak_service.dart';
import '../../../../core/services/default_screen_service.dart';

// NOTE: final confirmed nav structure -- Social, Albums, Timetable,
// Profile. No separate "Home" tab -- Social IS the default landing
// screen now, matching the app's core identity. The old _HomeContent
// (streak/XP/daily-goal display, tied to the archived gamified
// learning system) was removed entirely, not just hidden -- it had
// nothing left to show once that system was archived. Study Rooms is
// intentionally NOT in this nav -- its code stays fully intact,
// just unreachable via navigation for now (explicit call: revisit
// later, either give it a spot or archive it).

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _activeIndex = DefaultScreenService.index;
  int _unreadSocial = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _listenUnread();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_activeIndex == 0) SocialStreakService.pauseTracking();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Pause/resume social-streak time tracking around backgrounding, so
    // leaving the app open on the Social tab overnight doesn't falsely
    // accumulate hours of "time spent". Social is index 0 now.
    if (_activeIndex != 0) return;
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _activeIndex,
                  children: const [
                    SocialPage(),
                    AlbumsPage(),
                    TimetablePage(),
                    ProfilePage(),
                  ],
                ),
              ),
              _BottomNav(
                activeIndex: _activeIndex,
                unreadSocial: _unreadSocial,
                onTap: (i) {
                  final wasSocial = _activeIndex == 0;
                  setState(() {
                    _activeIndex = i;
                    if (i == 0) _unreadSocial = 0; // opened Social, clear badge
                  });
                  if (wasSocial && i != 0) {
                    SocialStreakService.pauseTracking();
                  } else if (!wasSocial && i == 0) {
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

class _BottomNav extends StatelessWidget {
  final int activeIndex;
  final int unreadSocial;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.activeIndex, required this.unreadSocial, required this.onTap});

  static const _icons = [
    Icons.dynamic_feed_rounded,
    Icons.photo_library_rounded,
    Icons.calendar_month_rounded,
    Icons.person_rounded,
  ];

  static const _labels = ['Social', 'Albums', 'Timetable', 'Profile'];

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
        children: List.generate(4, (i) {
          final active = i == activeIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Stack(clipBehavior: Clip.none, children: [
                Icon(_icons[i], size: 22,
                    color: active ? AppColors.accentLight : AppColors.textTertiary),
                if (i == 0 && unreadSocial > 0)
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
              Text(_labels[i], style: AppTextStyles.labelSmall.copyWith(
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