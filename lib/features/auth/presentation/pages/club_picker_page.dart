// lib/features/auth/presentation/pages/club_picker_page.dart
//
// Nested sub-picker reached only from tapping "Football" on the main
// interest grid. This granularity is the whole point of the feature:
// "likes football" alone can't target a specific fixture banner
// (Arsenal vs Man U), but "supports Arsenal" can. No other interest
// category needs this kind of sub-picker -- football is the special
// case, not the template for every category.
//
// Pops with whatever's currently selected, even via the back arrow
// without hitting Done -- partial progress isn't lost just because
// someone didn't tap the final button.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

const List<Map<String, String>> footballClubs = [
  {'id': 'arsenal', 'label': 'Arsenal'},
  {'id': 'man_utd', 'label': 'Manchester United'},
  {'id': 'man_city', 'label': 'Manchester City'},
  {'id': 'liverpool', 'label': 'Liverpool'},
  {'id': 'chelsea', 'label': 'Chelsea'},
  {'id': 'real_madrid', 'label': 'Real Madrid'},
  {'id': 'barcelona', 'label': 'Barcelona'},
];

class ClubPickerPage extends StatefulWidget {
  final List<String> initiallySelected;
  const ClubPickerPage({super.key, this.initiallySelected = const []});

  @override
  State<ClubPickerPage> createState() => _ClubPickerPageState();
}

class _ClubPickerPageState extends State<ClubPickerPage> {
  late final Set<String> _selected = widget.initiallySelected.toSet();

  void _toggle(String clubId) {
    setState(() {
      if (_selected.contains(clubId)) {
        _selected.remove(clubId);
      } else {
        _selected.add(clubId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) Navigator.pop(context, _selected.toList());
          },
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
              child: Row(children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textPrimary),
                  onPressed: () => Navigator.pop(context, _selected.toList()),
                ),
                const SizedBox(width: 4),
                Text('⚽ Football', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              ]),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                children: [
                  Text('Which clubs do\nyou support?', style: GoogleFonts.dmSans(
                    fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.textPrimary, height: 1.3)),
                  const SizedBox(height: 6),
                  Text('This is what makes a live "Arsenal vs Man U" banner show up only for people who\'d actually care.',
                    style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary, height: 1.5)),
                  const SizedBox(height: 20),
                  for (final club in footballClubs)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _ClubTile(
                        label: club['label']!,
                        selected: _selected.contains(club['id']),
                        onTap: () => _toggle(club['id']!),
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
              decoration: BoxDecoration(color: AppColors.background, border: Border(top: BorderSide(color: AppColors.border))),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _selected.toList()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent, foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Done · ${_selected.length} selected', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _ClubTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _ClubTile({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.accentSurface : AppColors.card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: selected ? AppColors.accent : AppColors.border, width: selected ? 1.5 : 1),
          ),
          child: Row(children: [
            Expanded(child: Text(label, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
            if (selected) Icon(Icons.check_circle_rounded, color: AppColors.accent, size: 20)
            else Icon(Icons.radio_button_off_rounded, color: AppColors.textTertiary, size: 20),
          ]),
        ),
      ),
    );
  }
}