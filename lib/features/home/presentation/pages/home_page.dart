import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/daily_goal_card.dart';
import '../widgets/activity_grid.dart';
import 'package:google_fonts/google_fonts.dart';

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
import '../../../../core/services/notifications_service.dart';
import '../../../../core/services/push_notification_service.dart';
import '../../../leaderboard/presentation/pages/compete_coming_soon_page.dart';
import '../widgets/live_rooms_coming_soon_widget.dart';
import '../widgets/leaderboard_coming_soon_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activeIndex = 0;
  int _unreadSocial = 0;
  List<String> _unreadIds = [];

  @override
  void initState() {
    super.initState();
    _listenUnread();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  void _listenUnread() {
    PushNotificationService.initialize();
    final uid = UserService.uid;
    if (uid == null) return;
    FirebaseFirestore.instance
        .collection('notifications')
        .where('uid', isEqualTo: uid)
        .where('read', isEqualTo: false)
        .snapshots()
        .listen((snap) {
      if (mounted) {
        setState(() {
          _unreadSocial = snap.docs.length;
          _unreadIds = snap.docs.map((d) => d.id).toList();
        });
      }
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
                  children: [
                    const _HomeContent(),
                    const StudyRoomsPage(),
                    const CompeteComingSoonPage(),
                    InsightsFeedPage(isVisible: _activeIndex == 3),
                    const ProfilePage(),
                  ],
                ),
              ),
              _BottomNav(
                activeIndex: _activeIndex,
                onTap: (i) => setState(() => _activeIndex = i),
              ),
            ],
          ),
          // Floating social button — hidden on Profile tab
          if (_activeIndex != 4)
            Positioned(
              left: 20,
              bottom: 80,
              child: _SocialFAB(
                unread: _unreadSocial,
                onTap: () {
                  final idsToClear = _unreadIds;
                  setState(() {
                    _unreadSocial = 0;
                    _unreadIds = [];
                  });
                  if (idsToClear.isNotEmpty) {
                    NotificationService.markAllAsRead(idsToClear);
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SocialFeedPage()),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
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
            const SizedBox(height: AppSpacing.lg),
            const LeaderboardComingSoon(),
            
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
  final ValueChanged<int> onTap;
  const _BottomNav({required this.activeIndex, required this.onTap});

  static const _icons = [
    Icons.home_rounded,
    Icons.groups_rounded,
    Icons.emoji_events_rounded,
    Icons.explore_rounded,
    Icons.person_rounded,
  ];

  static const _labels = ['Home', 'Study', 'Compete', 'Insights', 'Profile'];

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
        children: List.generate(5, (i) {
          final active = i == activeIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(_icons[i], size: 22,
                  color: active ? AppColors.accentLight : AppColors.textTertiary),
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

// ─────────────────────────────────────────────────────────────────────────────
// Floating social button
// ─────────────────────────────────────────────────────────────────────────────
class _SocialFAB extends StatefulWidget {
  final int unread;
  final VoidCallback onTap;
  const _SocialFAB({required this.unread, required this.onTap});

  @override
  State<_SocialFAB> createState() => _SocialFABState();
}

class _SocialFABState extends State<_SocialFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(_SocialFAB old) {
    super.didUpdateWidget(old);
    if (widget.unread > 0 && old.unread == 0) {
      _pulse.repeat(reverse: true);
    } else if (widget.unread == 0) {
      _pulse.stop();
      _pulse.reset();
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = widget.unread > 0;
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: hasUnread
                    ? AppColors.accent
                    : AppColors.surfaceVariant,
                shape: BoxShape.circle,
                border: Border.all(
                  color: hasUnread
                      ? AppColors.accentLight.withOpacity(0.5)
                      : AppColors.border,
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 22,
                color: hasUnread
                    ? Colors.white
                    : AppColors.textTertiary,
              ),
            ),
            if (hasUnread)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE24B4A),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.background,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.unread > 9 ? '9+' : '${widget.unread}',
                      style: GoogleFonts.dmSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}