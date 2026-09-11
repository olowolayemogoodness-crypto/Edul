import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/daily_goal_card.dart';
import '../widgets/activity_grid.dart';

import '../widgets/continue_button.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../insights/presentation/pages/insights_feed_page.dart';
import '../../../social/presentation/pages/social_feed_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../../../leaderboard/presentation/pages/leaderboard_page.dart';
import '../../../study_rooms/presentation/pages/study_rooms_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/social_streak_service.dart';
import '../../../../core/services/home_study_feature_service.dart';
import '../../../../core/services/push_notification_service.dart';
import '../widgets/live_rooms_coming_soon_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _activeIndex = 0;
  int _unreadSocial = 0;
  bool _homeStudyEnabled = false; // fail-closed default, matches the service

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _listenUnread();
    _loadHomeStudyFlag();
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

  Future<void> _loadHomeStudyFlag() async {
    final enabled = await HomeStudyFeatureService.isEnabled();
    if (mounted) setState(() {
      _homeStudyEnabled = enabled;
      // If Home/Study were hidden and _activeIndex was still pointing
      // at one of their old positions (0 or 1) from before this async
      // check resolved, land on the new first tab instead of an
      // index that no longer means what it used to.
      if (!enabled && _activeIndex < 2) _activeIndex = 0;
    });
  }

  // Full, unfiltered tab definitions -- Home and Study only get
  // included when the backend flag is on. Their widgets and all
  // their code stay fully intact regardless; this only controls
  // whether they're reachable from navigation.
  List<_TabDef> get _tabs => [
    if (_homeStudyEnabled) _TabDef(icon: Icons.home_rounded, label: 'Home', builder: () => const _HomeContent()),
    if (_homeStudyEnabled) _TabDef(icon: Icons.groups_rounded, label: 'Study', builder: () => const StudyRoomsPage()),
    _TabDef(icon: Icons.dynamic_feed_rounded, label: 'Social', builder: () => const SocialFeedPage(), isSocial: true),
    _TabDef(icon: Icons.explore_rounded, label: 'Discover', builder: () => InsightsFeedPage(isVisible: _activeIndex == _discoverIndex), isDiscover: true),
    _TabDef(icon: Icons.person_rounded, label: 'Profile', builder: () => const ProfilePage()),
  ];

  int get _socialIndex => _tabs.indexWhere((t) => t.isSocial);
  int get _discoverIndex => _tabs.indexWhere((t) => t.isDiscover);

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
  final bool isDiscover;
  _TabDef({required this.icon, required this.label, required this.builder, this.isSocial = false, this.isDiscover = false});
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>?>(
      stream: UserService.profileStream(),
      builder: (context, snapshot) {
        final profile = snapshot.data;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTopBar(streakCount: (profile?['streak'] as int?) ?? 0, xpCount: (profile?['xp'] as int?) ?? 0),
            _GreetingBlock(name: context.read<AuthBloc>().state is AuthAuthenticated
             ? ((context.read<AuthBloc>().state as AuthAuthenticated).user.displayName).split(' ').first
              : 'there'),
            DailyGoalCard(
              percent: ((profile?['xpToday'] as int?) ?? 0) / 180.0 > 1.0 ? 1.0 : ((profile?['xpToday'] as int?) ?? 0) / 180.0,
              xpToday: (profile?['xpToday'] as int?) ?? 0,
              xpTotal: (profile?['xp'] as int?) ?? 0,
              rank: (profile?['rank'] as int?) ?? 0,
            ),
            const SizedBox(height: AppSpacing.xxl),
            const ContinueButton(),
            const SizedBox(height: AppSpacing.lg),
            const SizedBox(height: AppSpacing.lg),
            _SectionHeader(title: 'Continue learning', linkText: 'See all', onTap: () {}),
            const SizedBox(height: AppSpacing.md),
            const ActivityGrid(),
            const SizedBox(height: AppSpacing.lg),
          const LiveRoomsComingSoon(),
            
          ],
        ),
      ),
    );
  },
  );
  }
}



class _GreetingBlock extends StatelessWidget {
  final String name;
  const _GreetingBlock({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 2, AppSpacing.lg, AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Good morning,',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary)),
          Text(name, style: AppTextStyles.headlineLarge),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title, linkText;
  final VoidCallback onTap;
  const _SectionHeader({required this.title, required this.linkText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.titleLarge),
          GestureDetector(onTap: onTap,
              child: Text(linkText,
                  style: AppTextStyles.labelMedium.copyWith(color: AppColors.accentLight))),
        ],
      ),
    );
  }
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