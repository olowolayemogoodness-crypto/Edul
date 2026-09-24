// lib/features/auth/presentation/pages/interest_picker_page.dart
//
// Reached right after registration succeeds, before landing on Social
// -- literally the same slot the old, irrelevant /subject-picker
// screen used to occupy. This is the actual data source for feed
// personalization, affinity-based community suggestions, and
// interest-targeted live banners (a movie discussion, a football
// fixture) -- nothing downstream of "For You" works without this.
//
// Minimum 3 picks required to enable Continue, but Skip is always
// available and never blocked -- forcing this would just produce junk
// data from people mashing random chips to get past a wall.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/affinity_service.dart';
import 'club_picker_page.dart';

const List<Map<String, String>> interestCategories = [
  {'id': 'gist', 'emoji': '💬', 'label': 'Gist & Entertainment'},
  {'id': 'football', 'emoji': '⚽', 'label': 'Football'},
  {'id': 'books', 'emoji': '📚', 'label': 'Books'},
  {'id': 'movies', 'emoji': '🎬', 'label': 'Movies & TV'},
  {'id': 'music', 'emoji': '🎵', 'label': 'Music'},
  {'id': 'tech', 'emoji': '💻', 'label': 'Tech & Startups'},
  {'id': 'comedy', 'emoji': '😂', 'label': 'Comedy & Memes'},
  {'id': 'fashion', 'emoji': '👗', 'label': 'Fashion'},
  {'id': 'fitness', 'emoji': '💪', 'label': 'Fitness'},
  {'id': 'career', 'emoji': '🚀', 'label': 'Career & Hustle'},
  {'id': 'anime', 'emoji': '🎌', 'label': 'Anime'},
  {'id': 'politics', 'emoji': '🗞️', 'label': 'Current Affairs'},
];

class InterestPickerPage extends StatefulWidget {
  const InterestPickerPage({super.key});

  @override
  State<InterestPickerPage> createState() => _InterestPickerPageState();
}

class _InterestPickerPageState extends State<InterestPickerPage> {
  final Set<String> _selected = {};
  List<String> _footballClubs = [];
  bool _saving = false;

  Future<void> _tapCategory(String id) async {
    if (id == 'football') {
      final result = await Navigator.of(context).push<List<String>>(
        MaterialPageRoute(builder: (_) => ClubPickerPage(initiallySelected: _footballClubs)),
      );
      if (result == null) return;
      setState(() {
        _footballClubs = result;
        if (result.isNotEmpty) {
          _selected.add('football');
        } else {
          _selected.remove('football');
        }
      });
      return;
    }

    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  Future<void> _continue() async {
    setState(() => _saving = true);
    try {
            await UserService.saveInterests(interests: _selected.toList(), footballClubs: _footballClubs);

      final labels = <String, String>{
        for (final cat in interestCategories) cat['id']!: cat['label']!,
        for (final club in footballClubs) club['id']!: club['label']!,
      };
      await AffinityService.recordInterestPicks([..._selected, ..._footballClubs], labels: labels);
    } catch (_) {
      // Best-effort -- don't block someone from entering the app over
      // a failed personalization write. They just get a less-tailored
      // feed for now, not a broken registration flow.
    }
    if (mounted) context.go('/home');
  }

  void _skip() => context.go('/home');

  @override
  Widget build(BuildContext context) {
    final canContinue = _selected.length >= 3;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
              children: [
                Text('STEP 3 OF 3', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: 0.3)),
                const SizedBox(height: 8),
                Text('What are you\ninto?', style: GoogleFonts.dmSans(fontSize: 26, fontWeight: FontWeight.w500, color: AppColors.textPrimary, height: 1.3)),
                const SizedBox(height: 8),
                Text('Pick a few things you like. We\'ll use this to shape your feed and suggest communities — you can always change this later.',
                  style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary, height: 1.6)),
                const SizedBox(height: 24),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.6,
                  children: [
                    for (final cat in interestCategories)
                      _InterestChip(
                        emoji: cat['emoji']!,
                        label: cat['label']!,
                        selected: _selected.contains(cat['id']),
                        badge: cat['id'] == 'football' && _footballClubs.isNotEmpty
                            ? '${_footballClubs.length} club${_footballClubs.length == 1 ? '' : 's'}'
                            : null,
                        onTap: () => _tapCategory(cat['id']!),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
            decoration: BoxDecoration(color: AppColors.background, border: Border(top: BorderSide(color: AppColors.border.withValues(alpha: 0.5)))),
            child: Column(children: [
              Text(
                canContinue ? '${_selected.length} selected' : '${_selected.length} selected — pick at least 3 to continue',
                style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (canContinue && !_saving) ? _continue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent, foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.4),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: _saving
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text('Continue', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700)),
                ),
              ),
              TextButton(
                onPressed: _saving ? null : _skip,
                child: Text('Skip for now', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textTertiary)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final String? badge;
  final VoidCallback onTap;
  const _InterestChip({required this.emoji, required this.label, required this.selected, required this.onTap, this.badge});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.accentSurface : AppColors.card,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: selected ? AppColors.accent : AppColors.border, width: selected ? 1.5 : 1),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 6),
              Text(label, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            ]),
          ),
          if (badge != null)
            Positioned(
              top: 10, right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(999)),
                child: Text(badge!, style: GoogleFonts.dmSans(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.accent)),
              ),
            ),
        ]),
      ),
    );
  }
}