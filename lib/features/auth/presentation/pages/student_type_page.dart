import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';

class StudentTypePage extends StatefulWidget {
  const StudentTypePage({super.key});
  @override
  State<StudentTypePage> createState() => _StudentTypePageState();
}

class _StudentTypePageState extends State<StudentTypePage> {
  final _pageCtrl = PageController();
  final _uniCtrl = TextEditingController();
  int _step = 0; // 0 = university, 1 = level
  String? _selectedLevel;

  static const List<Map<String, String>> _levels = [
    {'value': '100', 'label': '100 Level', 'emoji': '🌱', 'sub': 'First year undergraduate'},
    {'value': '200', 'label': '200 Level', 'emoji': '📘', 'sub': 'Second year undergraduate'},
    {'value': '300', 'label': '300 Level', 'emoji': '📗', 'sub': 'Third year undergraduate'},
    {'value': '400', 'label': '400 Level', 'emoji': '📙', 'sub': 'Fourth year undergraduate'},
    {'value': '500', 'label': '500 Level', 'emoji': '📕', 'sub': 'Fifth year undergraduate'},
    {'value': 'postgrad', 'label': 'Postgraduate', 'emoji': '🎓', 'sub': "Master's, PhD, professional"},
  ];

  @override
  void dispose() {
    _pageCtrl.dispose();
    _uniCtrl.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_step == 0) {
      if (_uniCtrl.text.trim().isEmpty) return;
      HapticFeedback.selectionClick();
      setState(() => _step = 1);
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _backStep() {
    setState(() => _step = 0);
    _pageCtrl.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finish() async {
    if (_selectedLevel == null) return;
    HapticFeedback.lightImpact();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('student_type', 'university');
    await prefs.setString('user_university', _uniCtrl.text.trim());
    await prefs.setString('user_level', _selectedLevel!);
    if (mounted) context.go('/register');
  }

  bool get _canContinue =>
      _step == 0 ? _uniCtrl.text.trim().isNotEmpty : _selectedLevel != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(children: [
              if (_step > 0)
                GestureDetector(
                  onTap: _backStep,
                  child: const Icon(Icons.arrow_back_rounded, size: 22,
                    color: AppColors.textTertiary),
                )
              else
                Container(width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.accentSurface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.accent, width: 1.5),
                  ),
                  child: const Icon(Icons.bolt_rounded,
                    color: AppColors.accentLight, size: 24)),
              const Spacer(),
              // Step indicator
              Row(children: List.generate(2, (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(left: 4),
                width: i == _step ? 16 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i == _step ? AppColors.accent : AppColors.border,
                  borderRadius: BorderRadius.circular(3),
                ),
              ))),
            ]),
          ),

          // Page content
          Expanded(
            child: PageView(
              controller: _pageCtrl,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _UniversityStep(ctrl: _uniCtrl, onChange: () => setState(() {})),
                _LevelStep(
                  levels: _levels,
                  selected: _selectedLevel,
                  onSelect: (v) => setState(() => _selectedLevel = v),
                ),
              ],
            ),
          ),

          // CTA
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: Column(children: [
              GestureDetector(
                onTap: _canContinue ? _nextStep : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: _canContinue ? AppColors.accent : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      _step == 0 ? 'Continue' : 'Get started',
                      style: GoogleFonts.dmSans(
                        fontSize: 15, fontWeight: FontWeight.w500,
                        color: _canContinue ? Colors.white : AppColors.textDisabled,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => context.go('/register'),
                child: Text('Skip for now',
                  style: GoogleFonts.dmSans(
                    fontSize: 13, color: AppColors.textDisabled)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

// ── Step 1: University ────────────────────────────────────────────────────────
class _UniversityStep extends StatelessWidget {
  final TextEditingController ctrl;
  final VoidCallback onChange;
  const _UniversityStep({required this.ctrl, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Which university\ndo you attend?',
          style: GoogleFonts.dmSans(
            fontSize: 26, fontWeight: FontWeight.w500,
            color: AppColors.textPrimary, height: 1.3)),
        const SizedBox(height: 8),
        Text('Start typing — any university worldwide',
          style: GoogleFonts.dmSans(
            fontSize: 13, color: AppColors.textTertiary, height: 1.6)),
        const SizedBox(height: 32),
        TextField(
          controller: ctrl,
          onChanged: (_) => onChange(),
          autofocus: true,
          style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: 'e.g. University of Ibadan, Harvard, UCL',
            hintStyle: GoogleFonts.dmSans(
              fontSize: 13, color: AppColors.textDisabled),
            prefixIcon: const Icon(Icons.school_rounded,
              color: AppColors.textTertiary, size: 20),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.accent, width: 2)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14),
          ),
        ),
      ]),
    );
  }
}

// ── Step 2: Academic level ────────────────────────────────────────────────────
class _LevelStep extends StatelessWidget {
  final List<Map<String, String>> levels;
  final String? selected;
  final ValueChanged<String> onSelect;

  const _LevelStep({
    required this.levels,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('What\'s your\nacademic level?',
          style: GoogleFonts.dmSans(
            fontSize: 26, fontWeight: FontWeight.w500,
            color: AppColors.textPrimary, height: 1.3)),
        const SizedBox(height: 8),
        Text('We\'ll tailor your courses and content accordingly',
          style: GoogleFonts.dmSans(
            fontSize: 13, color: AppColors.textTertiary, height: 1.6)),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.separated(
            itemCount: levels.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final level = levels[i];
              final isSelected = selected == level['value'];
              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  onSelect(level['value']!);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accentSurface : AppColors.surface,
                    border: Border.all(
                      color: isSelected ? AppColors.accent : AppColors.border,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(children: [
                    Text(level['emoji']!,
                      style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 14),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(level['label']!,
                          style: GoogleFonts.dmSans(
                            fontSize: 14, fontWeight: FontWeight.w500,
                            color: isSelected
                                ? AppColors.accentLight
                                : AppColors.textPrimary)),
                        Text(level['sub']!,
                          style: GoogleFonts.dmSans(
                            fontSize: 11, color: AppColors.textTertiary)),
                      ],
                    )),
                    Container(
                      width: 22, height: 22,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accent : AppColors.surfaceVariant,
                        shape: BoxShape.circle,
                      ),
                      child: isSelected
                          ? const Icon(Icons.check_rounded,
                              size: 13, color: Colors.white)
                          : null,
                    ),
                  ]),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}