import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/profile_stats_row.dart';
import '../widgets/activity_rings_card.dart';
import '../widgets/this_week_grid.dart';
import '../widgets/streak_card_widget.dart';
import '../widgets/course_progress_widget.dart';
import '../widgets/strengths_widget.dart';
import '../widgets/learning_style_card.dart';
import '../widgets/success_prediction_card.dart';
import '../widgets/badges_scroll_widget.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/study_time_service.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  
 

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
    
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
 

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>?>(
      stream: UserService.profileStream(),
      builder: (context, snapshot) {
        final profile = snapshot.data;
        final isLoading = snapshot.connectionState == ConnectionState.waiting && profile == null || UserService.uid == null;
        final hasError = snapshot.hasError;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Profile', style: GoogleFonts.dmSans(
                              fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            IconButton(onPressed: () => context.push('/settings'),
                                icon: Icon(Icons.settings_outlined, color: AppColors.textTertiary, size: 22),
                                padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.fromLTRB(20, 12, 20, 0), child: ProfileHeaderWidget()),
                ),
                StreamBuilder<Map<String, dynamic>>(
  stream: StudyTimeService.todayStatsStream(),
  builder: (context, statsSnap) {
    final stats = statsSnap.data ?? {};
    return SliverToBoxAdapter(child: Column(children: [
      if (!isLoading && !hasError) ProfileStatsRow(
        streak: (profile?['streak'] as int?) ?? 0,
        friends: (profile?['friends'] as int?) ?? 0,
        tasksDone: (stats['tasksCompleted'] as int?) ?? 0,
      ),
      if (isLoading) Padding(
        padding: const EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator(color: AppColors.accent)),
      ),
      if (!isLoading && !hasError) _Section(
        title: 'Study activity',
        linkLabel: 'See history',
        onLink: () {},
        child: ActivityRingsCard(
          studyMinutes: (stats['studyMinutes'] as int?) ?? 0,
          tasksCompleted: (stats['tasksCompleted'] as int?) ?? 0,
          quizCorrect: (stats['quizCorrect'] as int?) ?? 0,
          quizTotal: (stats['quizTotal'] as int?) ?? 0,
          peakHour: (stats['peakHour'] as int?) ?? 0,
        ),
      ),
    ]));
  },
),
                if (!isLoading && !hasError) SliverToBoxAdapter(child: _Section(title: 'This week', child: _ComingSoonOverlay(child: ThisWeekGrid(
                  xp: (profile?['xp'] as int?) ?? 0,
                  rank: (profile?['rank'] as int?) ?? 0,
                )))),
                if (!isLoading && !hasError) SliverToBoxAdapter(child: _Section(title: 'Streak', child: StreakCardWidget(
                  currentStreak: (profile?['streak'] as int?) ?? 0,
                  longestStreak: (profile?['longestStreak'] as int?) ?? 0,
                ))),
                if (!isLoading && !hasError) SliverToBoxAdapter(child: _Section(title: 'Course progress', linkLabel: 'All courses', onLink: () {}, child: const _ComingSoonOverlay(child: CourseProgressWidget()))),
                if (!isLoading && !hasError) const SliverToBoxAdapter(child: _Section(title: 'Strengths & focus areas', child: _ComingSoonOverlay(child: StrengthsWidget()))),
                if (!isLoading && !hasError) const SliverToBoxAdapter(child: _Section(title: 'Your learning style', child: _ComingSoonOverlay(child: LearningStyleCard()))),
                if (!isLoading && !hasError) SliverToBoxAdapter(child: _Section(
                  title: 'Success prediction',
                  trailing: Text('AI-powered', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
                  child: const _ComingSoonOverlay(child: SuccessPredictionCard()),
                )),
                if (!isLoading && !hasError) SliverToBoxAdapter(child: _Section(title: 'Badges', linkLabel: 'See all', onLink: () {}, child: const _ComingSoonOverlay(child: BadgesScrollWidget()))),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
        ),
      ),
    );
      },
    );
  }
}
class _Section extends StatelessWidget {
  final String title;
  final String? linkLabel;
  final VoidCallback? onLink;
  final Widget? trailing;
  final Widget child;
  const _Section({required this.title, this.linkLabel, this.onLink, this.trailing, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title.toUpperCase(), style: GoogleFonts.dmSans(
              fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textTertiary, letterSpacing: 0.5)),
          if (linkLabel != null)
            GestureDetector(onTap: onLink,
                child: Text(linkLabel!, style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.accent))),
          if (trailing != null) trailing!,
        ]),
        const SizedBox(height: 10),
        child,
      ]),
    );
  }
}

class _ComingSoonOverlay extends StatelessWidget {
  final Widget child;
  const _ComingSoonOverlay({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(children: [
        IgnorePointer(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: child,
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.25)),
        ),
        Positioned.fill(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.accentLight.withOpacity(0.4)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Text('🔥', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text('Coming soon', style: GoogleFonts.dmSans(
                  fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}