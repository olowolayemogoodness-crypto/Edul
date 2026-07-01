import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/user_service.dart';

// Subject display mapping - COPY FROM subject_picker_page.dart
final _subjectDisplayMap = <String, SubjectDisplay>{
  // Medical Sciences
  'Gross Anatomy & Embryology': SubjectDisplay(
    emoji: '🦴', color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
  ),
  'Human Physiology': SubjectDisplay(
    emoji: '💚', color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
  ),
  'Medical Biochemistry': SubjectDisplay(
    emoji: '⚗️', color: Color(0xFFEA580C), bg: Color(0xFF2D1200), border: Color(0xFFEA580C),
  ),
  'Histology & Cellular Biology': SubjectDisplay(
    emoji: '🔬', color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
  ),
  'Medical Microbiology & Parasitology': SubjectDisplay(
    emoji: '🦠', color: Color(0xFFEC4899), bg: Color(0xFF2D0A1E), border: Color(0xFFEC4899),
  ),
  'Pathology & Immunology': SubjectDisplay(
    emoji: '🛡️', color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
  ),
  'Pharmacology & Therapeutics': SubjectDisplay(
    emoji: '💊', color: Color(0xFFE8960F), bg: Color(0xFF2D1E00), border: Color(0xFFC47D0E),
  ),
  'Clinical Medicine & Surgery': SubjectDisplay(
    emoji: '🏥', color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
  ),
  // Engineering & Technology
  'Foundational Engineering Mathematics': SubjectDisplay(
    emoji: '📐', color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
  ),
  'Computer Programming & Software Architecture': SubjectDisplay(
    emoji: '💻', color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
  ),
  'Data Structures & Algorithms': SubjectDisplay(
    emoji: '🔗', color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
  ),
  'Database Management Systems': SubjectDisplay(
    emoji: '🗄️', color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
  ),
  'Circuit Theory & Electronic Systems': SubjectDisplay(
    emoji: '⚡', color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
  ),
  'Applied Physics & Mechanics': SubjectDisplay(
    emoji: '🚀', color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
  ),
  'Thermodynamics & Fluid Mechanics': SubjectDisplay(
    emoji: '🌡️', color: Color(0xFFEA580C), bg: Color(0xFF2D1200), border: Color(0xFFEA580C),
  ),
  'Structural Analysis & Design': SubjectDisplay(
    emoji: '🏗️', color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
  ),
  // Management & Business
  'Financial Accounting & Corporate Reporting': SubjectDisplay(
    emoji: '📊', color: Color(0xFFE8960F), bg: Color(0xFF2D1E00), border: Color(0xFFC47D0E),
  ),
  'Principles of Management & Organizational Behaviour': SubjectDisplay(
    emoji: '💼', color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
  ),
  'Business Mathematics & Statistics': SubjectDisplay(
    emoji: '📈', color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
  ),
  'Corporate Finance & Investment Analysis': SubjectDisplay(
    emoji: '💰', color: Color(0xFFE8960F), bg: Color(0xFF2D1E00), border: Color(0xFFC47D0E),
  ),
  'Microeconomic & Macroeconomic Theory': SubjectDisplay(
    emoji: '📊', color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
  ),
  'Human Resource Management & Industrial Relations': SubjectDisplay(
    emoji: '👥', color: Color(0xFFEC4899), bg: Color(0xFF2D0A1E), border: Color(0xFFEC4899),
  ),
  // Law, Arts & Humanities
  'Legal Methods & Constitutional Law': SubjectDisplay(
    emoji: '⚖️', color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
  ),
  'General & Developmental Psychology': SubjectDisplay(
    emoji: '🧠', color: Color(0xFFEC4899), bg: Color(0xFF2D0A1E), border: Color(0xFFEC4899),
  ),
  'Sociological Theories & Social Structures': SubjectDisplay(
    emoji: '👫', color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
  ),
  'Literary Studies & Creative Writing': SubjectDisplay(
    emoji: '📚', color: Color(0xFFEC4899), bg: Color(0xFF2D0A1E), border: Color(0xFFEC4899),
  ),
  'Linguistics & Language Structures': SubjectDisplay(
    emoji: '🗣️', color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
  ),
  'Philosophy & Critical Thinking': SubjectDisplay(
    emoji: '💭', color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
  ),
  // Pure & Applied Sciences
  'Calculus': SubjectDisplay(
    emoji: '📐', color: Color(0xFFE8960F), bg: Color(0xFF2D1E00), border: Color(0xFFC47D0E),
  ),
  'Organic, Inorganic & Physical Chemistry': SubjectDisplay(
    emoji: '⚗️', color: Color(0xFFEA580C), bg: Color(0xFF2D1200), border: Color(0xFFEA580C),
  ),
  'Cell Biology & Genetics': SubjectDisplay(
    emoji: '🧬', color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
  ),
  'Analytical Chemistry & Laboratory Instrumentation': SubjectDisplay(
    emoji: '🔬', color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
  ),
  'Microbial Diversity & Physiology': SubjectDisplay(
    emoji: '🦠', color: Color(0xFFEC4899), bg: Color(0xFF2D0A1E), border: Color(0xFFEC4899),
  ),
};

class SubjectDisplay {
  final String emoji;
  final Color color, bg, border;
  SubjectDisplay({
    required this.emoji,
    required this.color,
    required this.bg,
    required this.border,
  });
}

class LibrarySubjectSelectorPage extends StatefulWidget {
  const LibrarySubjectSelectorPage({super.key});
  @override
  State<LibrarySubjectSelectorPage> createState() => _LibrarySubjectSelectorPageState();
}

class _LibrarySubjectSelectorPageState extends State<LibrarySubjectSelectorPage> {
  List<String> _subjects = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
  try {
    final profile = await UserService.getProfile();
    print('🔍 DEBUG Profile: $profile');
    
    final course = profile?['course'] as String? ?? '';
    print('🔍 DEBUG Course: "$course"');
    print('🔍 DEBUG Course isEmpty: ${course.isEmpty}');
    
    final subjects = course.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    print('🔍 DEBUG Subjects parsed: $subjects');
    
    setState(() {
      _subjects = subjects;
      _loading = false;
    });
  } catch (e) {
    print('❌ ERROR: $e');
    setState(() => _loading = false);
  }
}

  SubjectDisplay? _getDisplay(String subject) {
    return _subjectDisplayMap[subject];
  }

  void _selectSubject(String subject) {
    context.push('/library', extra: {'subject': subject});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Subjects',
                          style: GoogleFonts.dmSans(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Select a subject to browse its library',
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Content
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _subjects.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('📚', style: TextStyle(fontSize: 48)),
                              const SizedBox(height: 12),
                              Text(
                                'No subjects yet',
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Select subjects to get started',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _subjects.length,
                          itemBuilder: (_, i) {
                            final subject = _subjects[i];
                            final display = _getDisplay(subject);

                            if (display == null) {
                              return const SizedBox.shrink();
                            }

                            return GestureDetector(
                              onTap: () => _selectSubject(subject),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: display.bg,
                                  border: Border.all(
                                    color: display.border,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: AppColors.background,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          display.emoji,
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            subject,
                                            style: GoogleFonts.dmSans(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.textPrimary,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Tap to browse resources',
                                            style: GoogleFonts.dmSans(
                                              fontSize: 10,
                                              color: AppColors.textTertiary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right_rounded,
                                      size: 20,
                                      color: AppColors.textTertiary,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}