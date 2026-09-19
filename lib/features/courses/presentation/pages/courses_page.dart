// lib/features/courses/presentation/pages/courses_page.dart
//
// Back on real data: courses now come from
// CourseService.coursesForMyProfile(), which matches on the signed-in
// user's set AND department (see course_service.dart for how). The
// mock-data detour is over -- this fetches real Firestore documents,
// which is why the empty state below now genuinely means "no course
// documents exist yet for your set+department", not "seeding hasn't
// run". That's expected until ambassadors add department-specific
// courses beyond the five universal SET30 ones.
//
// AppColors is already time/override-aware (see app_colors.dart), so
// this reads as "white theme" during the day / on manual override
// without anything special done here.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/course_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/group_service.dart';
import 'course_overview_page.dart';
import 'course_edit_page.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  bool _loading = true;
  String? _displayName;
  List<CourseModel> _courses = [];
  String _query = '';
  String? _loadError;
  // Debug-only: what we actually queried Firestore with, shown in the
  // empty state so this can be verified from the running app instead
  // of cross-checking Firestore console screenshots by hand. Remove
  // once the department-matching pipeline is confirmed reliable.
  String? _debugSet;
  String? _debugDepartment;
  bool _isClassRep = false;
  int? _mySet;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loadError = null; });
    try {
      final profile = await UserService.getProfile();
      _debugSet = profile?['set']?.toString() ?? '(missing)';
      _debugDepartment = (profile?['course'] as String?)?.isNotEmpty == true
          ? profile!['course'] as String
          : '(empty/missing)';
      _mySet = profile?['set'] as int?;

      final results = await Future.wait([
        CourseService.coursesForMyProfile(),
        GroupService.amIClassRepOfMyGroup(),
      ]);
      final courses = results[0] as List<CourseModel>;
      _isClassRep = results[1] as bool;
      if (!mounted) return;
      setState(() {
        _courses = courses;
        _displayName = (profile?['displayName'] as String?)?.split(' ').first;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadError = e.toString();
        _loading = false;
      });
    }
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  List<CourseModel> get _filtered {
    if (_query.trim().isEmpty) return _courses;
    final q = _query.trim().toLowerCase();
    return _courses.where((c) =>
      c.code.toLowerCase().contains(q) ||
      c.name.toLowerCase().contains(q)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: (!_loading && _isClassRep && _mySet != null)
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: Text('New course', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600)),
              onPressed: () async {
                final saved = await Navigator.of(context).push<bool>(
                  MaterialPageRoute(builder: (_) => CourseEditPage(set: _mySet!)),
                );
                if (saved == true) _load();
              },
            )
          : null,
      body: SafeArea(
        child: _loading
            ? Center(child: CircularProgressIndicator(color: AppColors.accent))
            : RefreshIndicator(
                color: AppColors.accent,
                onRefresh: _load,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(child: _Header(greeting: _greeting, name: _displayName)),
                    if (_loadError != null)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: _ErrorState(error: _loadError!, onRetry: _load),
                      )
                    else if (_courses.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: _EmptyState(debugSet: _debugSet, debugDepartment: _debugDepartment),
                      )
                    else ...[
                      SliverToBoxAdapter(
                        child: _SearchBar(onChanged: (v) => setState(() => _query = v)),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                        sliver: SliverToBoxAdapter(
                          child: Text('My Courses', style: GoogleFonts.dmSans(
                            fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        ),
                      ),
                      if (_filtered.isEmpty)
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                          sliver: SliverToBoxAdapter(
                            child: Center(
                              child: Text('No courses match "$_query"',
                                style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
                            ),
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, i) {
                                if (i.isOdd) return const SizedBox(height: 10);
                                return _CourseRow(course: _filtered[i ~/ 2]);
                              },
                              childCount: _filtered.isEmpty ? 0 : _filtered.length * 2 - 1,
                            ),
                          ),
                        ),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String? debugSet;
  final String? debugDepartment;
  const _EmptyState({this.debugSet, this.debugDepartment});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.menu_book_outlined, size: 40, color: AppColors.textTertiary),
          const SizedBox(height: 12),
          Text('No courses yet', style: GoogleFonts.dmSans(
            fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text('Your courses show up here once they\'re added for your department and level.',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
          if (debugSet != null) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                Text('DEBUG — remove before shipping', style: GoogleFonts.dmSans(
                  fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textTertiary)),
                const SizedBox(height: 6),
                Text('Queried with set: $debugSet', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary)),
                Text('Queried with department: "$debugDepartment"', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary)),
              ]),
            ),
          ],
        ]),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const _ErrorState({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.error_outline_rounded, size: 40, color: AppColors.error),
          const SizedBox(height: 12),
          Text('Couldn\'t load courses', style: GoogleFonts.dmSans(
            fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(10)),
            child: SelectableText(error, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary),
              textAlign: TextAlign.left),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white),
            child: Text('Retry', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ]),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String greeting;
  final String? name;
  const _Header({required this.greeting, required this.name});

  @override
  Widget build(BuildContext context) {
    final initial = (name != null && name!.isNotEmpty) ? name![0].toUpperCase() : 'U';
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
      child: Row(children: [
        Container(
          width: 44, height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.accentSurface, shape: BoxShape.circle),
          child: Text(initial, style: GoogleFonts.dmSans(
            fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.accent)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(greeting, style: GoogleFonts.dmSans(
              fontSize: 12, color: AppColors.textTertiary)),
            Text(name ?? 'there', style: GoogleFonts.dmSans(
              fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          ]),
        ),
      ]),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
      child: TextField(
        onChanged: onChanged,
        style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'Search your courses…',
          hintStyle: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textTertiary),
          prefixIcon: Icon(Icons.search_rounded, color: AppColors.textTertiary, size: 20),
          filled: true,
          fillColor: AppColors.surfaceVariant,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class _CourseRow extends StatelessWidget {
  final CourseModel course;
  const _CourseRow({required this.course});

  @override
  Widget build(BuildContext context) {
    final progress = course.progress;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => CourseOverviewPage(course: course))),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 44, height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: course.accentColor.withOpacity(0.16),
              borderRadius: BorderRadius.circular(12)),
            child: Text(course.code, style: GoogleFonts.dmSans(
              fontSize: 11, fontWeight: FontWeight.w700, color: course.accentColor)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(course.name, style: GoogleFonts.dmSans(
                fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(
                [course.code, if (course.instructor.isNotEmpty) course.instructor].join(' · '),
                style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary),
                maxLines: 1, overflow: TextOverflow.ellipsis),
              if (progress != null) ...[
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 5,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation(course.accentColor),
                  ),
                ),
                const SizedBox(height: 4),
                Text('${(progress.clamp(0.0, 1.0) * 100).round()}%', style: GoogleFonts.dmSans(
                  fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textTertiary)),
              ],
            ]),
          ),
          const SizedBox(width: 4),
          Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
        ]),
      ),
    );
  }
}