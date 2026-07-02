import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/user_service.dart';
import '../../../../models/courses_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Models ──
class SubjectOption {
  final String id, emoji, name;
  final Color color, bg, border;
  final List<ExamOption> exams;
  final List<String> catalogCodes; // Links to CourseCatalog codes, e.g. ['MTS102']
  const SubjectOption({
    required this.id, required this.emoji, required this.name,
    required this.color, required this.bg, required this.border,
    required this.exams,
    this.catalogCodes = const [],
  });
}

class ExamOption {
  final String id, label, tag;
  final Color tagBg, tagColor;
  const ExamOption({
    required this.id, required this.label, required this.tag,
    required this.tagBg, required this.tagColor,
  });
}

class SelectedSubject {
  final String subjectId;
  final String examId;
  const SelectedSubject({required this.subjectId, required this.examId});
}

// ── Subject Display Mapping ──
// Maps subject names (from CoursesData) to display properties
final _subjectDisplayMap = <String, SubjectOption>{
  // Block 1: Medical and Health Sciences
  'Gross Anatomy & Embryology': SubjectOption(
    id: 'anatomy', emoji: '🦴', name: 'Gross Anatomy & Embryology',
    color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
    exams: [
      ExamOption(id: 'anatomy_intro', label: 'Introduction', tag: 'Basic', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
      ExamOption(id: 'anatomy_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
    ],
  ),
  'Human Physiology': SubjectOption(
    id: 'physiology', emoji: '💚', name: 'Human Physiology',
    color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
    exams: [
      ExamOption(id: 'phys_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
      ExamOption(id: 'phys_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
    ],
  ),
  'Medical Biochemistry': SubjectOption(
    id: 'biochem', emoji: '⚗️', name: 'Medical Biochemistry',
    color: Color(0xFFEA580C), bg: Color(0xFF2D1200), border: Color(0xFFEA580C),
    exams: [
      ExamOption(id: 'biochem_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF2D1200), tagColor: Color(0xFFEA580C)),
      ExamOption(id: 'biochem_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF2D1200), tagColor: Color(0xFFEA580C)),
    ],
  ),
  'Histology & Cellular Biology': SubjectOption(
    id: 'histology', emoji: '🔬', name: 'Histology & Cellular Biology',
    color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
    exams: [
      ExamOption(id: 'hist_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
      ExamOption(id: 'hist_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
    ],
  ),
  'Medical Microbiology & Parasitology': SubjectOption(
    id: 'microbio', emoji: '🦠', name: 'Medical Microbiology & Parasitology',
    color: Color(0xFFEC4899), bg: Color(0xFF2D0A1E), border: Color(0xFFEC4899),
    exams: [
      ExamOption(id: 'micro_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF2D0A1E), tagColor: Color(0xFFEC4899)),
      ExamOption(id: 'micro_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF2D0A1E), tagColor: Color(0xFFEC4899)),
    ],
  ),
  'Pathology & Immunology': SubjectOption(
    id: 'pathology', emoji: '🛡️', name: 'Pathology & Immunology',
    color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
    exams: [
      ExamOption(id: 'path_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
      ExamOption(id: 'path_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
    ],
  ),
  'Pharmacology & Therapeutics': SubjectOption(
    id: 'pharma', emoji: '💊', name: 'Pharmacology & Therapeutics',
    color: Color(0xFFE8960F), bg: Color(0xFF2D1E00), border: Color(0xFFC47D0E),
    exams: [
      ExamOption(id: 'pharma_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF2D1E00), tagColor: Color(0xFFE8960F)),
      ExamOption(id: 'pharma_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF2D1E00), tagColor: Color(0xFFE8960F)),
    ],
  ),
  'Clinical Medicine & Surgery': SubjectOption(
    id: 'clinical', emoji: '🏥', name: 'Clinical Medicine & Surgery',
    color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
    exams: [
      ExamOption(id: 'clinical_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
      ExamOption(id: 'clinical_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
    ],
  ),

  // Block 2: Engineering and Technology
  'Foundational Engineering Mathematics': SubjectOption(
    id: 'eng_math', emoji: '📐', name: 'Foundational Engineering Mathematics',
    color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
    exams: [
      ExamOption(id: 'math_basic', label: 'Fundamentals', tag: 'Basic', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
      ExamOption(id: 'math_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
    ],
    catalogCodes: ['MTS101'],
  ),
  'Computer Programming & Software Architecture': SubjectOption(
    id: 'prog', emoji: '💻', name: 'Computer Programming & Software Architecture',
    color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
    exams: [
      ExamOption(id: 'prog_beg', label: 'Beginner', tag: 'Beginner', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
      ExamOption(id: 'prog_int', label: 'Intermediate', tag: 'Inter', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
      ExamOption(id: 'prog_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
    ],
    catalogCodes: ['CSC102'],
  ),
  'Data Structures & Algorithms': SubjectOption(
    id: 'dsa', emoji: '🔗', name: 'Data Structures & Algorithms',
    color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
    exams: [
      ExamOption(id: 'dsa_beg', label: 'Beginner', tag: 'Beginner', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
      ExamOption(id: 'dsa_int', label: 'Intermediate', tag: 'Inter', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
      ExamOption(id: 'dsa_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
    ],
  ),
  'Database Management Systems': SubjectOption(
    id: 'dbms', emoji: '🗄️', name: 'Database Management Systems',
    color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
    exams: [
      ExamOption(id: 'db_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
      ExamOption(id: 'db_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
    ],
  ),
  'Circuit Theory & Electronic Systems': SubjectOption(
    id: 'circuits', emoji: '⚡', name: 'Circuit Theory & Electronic Systems',
    color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
    exams: [
      ExamOption(id: 'circuit_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
      ExamOption(id: 'circuit_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
    ],
    catalogCodes: ['PHY102'],
  ),
  'Applied Physics & Mechanics': SubjectOption(
    id: 'physics', emoji: '🚀', name: 'Applied Physics & Mechanics',
    color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
    exams: [
      ExamOption(id: 'phys_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
      ExamOption(id: 'phys_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
    ],
  ),
  'Thermodynamics & Fluid Mechanics': SubjectOption(
    id: 'thermo', emoji: '🌡️', name: 'Thermodynamics & Fluid Mechanics',
    color: Color(0xFFEA580C), bg: Color(0xFF2D1200), border: Color(0xFFEA580C),
    exams: [
      ExamOption(id: 'thermo_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF2D1200), tagColor: Color(0xFFEA580C)),
      ExamOption(id: 'thermo_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF2D1200), tagColor: Color(0xFFEA580C)),
    ],
  ),
  'Structural Analysis & Design': SubjectOption(
    id: 'structures', emoji: '🏗️', name: 'Structural Analysis & Design',
    color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
    exams: [
      ExamOption(id: 'struct_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
      ExamOption(id: 'struct_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
    ],
  ),

  // Block 3: Management and Administration
  'Financial Accounting & Corporate Reporting': SubjectOption(
    id: 'accounting', emoji: '📊', name: 'Financial Accounting & Corporate Reporting',
    color: Color(0xFFE8960F), bg: Color(0xFF2D1E00), border: Color(0xFFC47D0E),
    exams: [
      ExamOption(id: 'acc_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF2D1E00), tagColor: Color(0xFFE8960F)),
      ExamOption(id: 'acc_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF2D1E00), tagColor: Color(0xFFE8960F)),
    ],
  ),
  'Principles of Management & Organizational Behaviour': SubjectOption(
    id: 'mgmt', emoji: '💼', name: 'Principles of Management & Organizational Behaviour',
    color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
    exams: [
      ExamOption(id: 'mgmt_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
      ExamOption(id: 'mgmt_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
    ],
  ),
  'Business Mathematics & Statistics': SubjectOption(
    id: 'bus_math', emoji: '📈', name: 'Business Mathematics & Statistics',
    color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
    exams: [
      ExamOption(id: 'bmath_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
      ExamOption(id: 'bmath_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
    ],
  ),
  'Corporate Finance & Investment Analysis': SubjectOption(
    id: 'finance', emoji: '💰', name: 'Corporate Finance & Investment Analysis',
    color: Color(0xFFE8960F), bg: Color(0xFF2D1E00), border: Color(0xFFC47D0E),
    exams: [
      ExamOption(id: 'fin_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF2D1E00), tagColor: Color(0xFFE8960F)),
      ExamOption(id: 'fin_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF2D1E00), tagColor: Color(0xFFE8960F)),
    ],
  ),
  'Microeconomic & Macroeconomic Theory': SubjectOption(
    id: 'econ', emoji: '📊', name: 'Microeconomic & Macroeconomic Theory',
    color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
    exams: [
      ExamOption(id: 'econ_micro', label: 'Microeconomics', tag: 'Micro', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
      ExamOption(id: 'econ_macro', label: 'Macroeconomics', tag: 'Macro', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
    ],
  ),
  'Human Resource Management & Industrial Relations': SubjectOption(
    id: 'hrm', emoji: '👥', name: 'Human Resource Management & Industrial Relations',
    color: Color(0xFFEC4899), bg: Color(0xFF2D0A1E), border: Color(0xFFEC4899),
    exams: [
      ExamOption(id: 'hr_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF2D0A1E), tagColor: Color(0xFFEC4899)),
      ExamOption(id: 'hr_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF2D0A1E), tagColor: Color(0xFFEC4899)),
    ],
  ),

  // Block 4: Law, Arts & Humanities
  'Legal Methods & Constitutional Law': SubjectOption(
    id: 'law', emoji: '⚖️', name: 'Legal Methods & Constitutional Law',
    color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
    exams: [
      ExamOption(id: 'law_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
      ExamOption(id: 'law_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
    ],
  ),
  'General & Developmental Psychology': SubjectOption(
    id: 'psych', emoji: '🧠', name: 'General & Developmental Psychology',
    color: Color(0xFFEC4899), bg: Color(0xFF2D0A1E), border: Color(0xFFEC4899),
    exams: [
      ExamOption(id: 'psych_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF2D0A1E), tagColor: Color(0xFFEC4899)),
      ExamOption(id: 'psych_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF2D0A1E), tagColor: Color(0xFFEC4899)),
    ],
  ),
  'Sociological Theories & Social Structures': SubjectOption(
    id: 'sociology', emoji: '👫', name: 'Sociological Theories & Social Structures',
    color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
    exams: [
      ExamOption(id: 'socio_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
      ExamOption(id: 'socio_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
    ],
  ),
  'Literary Studies & Creative Writing': SubjectOption(
    id: 'lit', emoji: '📚', name: 'Literary Studies & Creative Writing',
    color: Color(0xFFEC4899), bg: Color(0xFF2D0A1E), border: Color(0xFFEC4899),
    exams: [
      ExamOption(id: 'lit_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF2D0A1E), tagColor: Color(0xFFEC4899)),
      ExamOption(id: 'lit_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF2D0A1E), tagColor: Color(0xFFEC4899)),
    ],
  ),
  'Linguistics & Language Structures': SubjectOption(
    id: 'ling', emoji: '🗣️', name: 'Linguistics & Language Structures',
    color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
    exams: [
      ExamOption(id: 'ling_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
      ExamOption(id: 'ling_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
    ],
  ),
  'Philosophy & Critical Thinking': SubjectOption(
    id: 'philo', emoji: '💭', name: 'Philosophy & Critical Thinking',
    color: Color(0xFF9D6FEC), bg: Color(0xFF1E1240), border: Color(0xFF2D1B6B),
    exams: [
      ExamOption(id: 'philo_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
      ExamOption(id: 'philo_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF1E1240), tagColor: Color(0xFF9D6FEC)),
    ],
  ),

  // Block 5: Pure, Applied & Agricultural Sciences
  'Calculus': SubjectOption(
    id: 'calculus', emoji: '📐', name: 'Calculus',
    color: Color(0xFFE8960F), bg: Color(0xFF2D1E00), border: Color(0xFFC47D0E),
    exams: [
      ExamOption(id: 'calc_1', label: 'Calculus I', tag: 'Cal I', tagBg: Color(0xFF2D1E00), tagColor: Color(0xFFE8960F)),
      ExamOption(id: 'calc_2', label: 'Calculus II', tag: 'Cal II', tagBg: Color(0xFF2D1E00), tagColor: Color(0xFFE8960F)),
    ],
    catalogCodes: ['MTS102'],
  ),
  'Organic, Inorganic & Physical Chemistry': SubjectOption(
    id: 'chemistry', emoji: '⚗️', name: 'Organic, Inorganic & Physical Chemistry',
    color: Color(0xFFEA580C), bg: Color(0xFF2D1200), border: Color(0xFFEA580C),
    exams: [
      ExamOption(id: 'chem_org', label: 'Organic Chemistry', tag: 'Organic', tagBg: Color(0xFF2D1200), tagColor: Color(0xFFEA580C)),
      ExamOption(id: 'chem_inorg', label: 'Inorganic Chemistry', tag: 'Inorganic', tagBg: Color(0xFF2D1200), tagColor: Color(0xFFEA580C)),
    ],
    catalogCodes: ['CHM101', 'CHM102'],
  ),
  'Cell Biology & Genetics': SubjectOption(
    id: 'genetics', emoji: '🧬', name: 'Cell Biology & Genetics',
    color: Color(0xFF0EA472), bg: Color(0xFF052E1E), border: Color(0xFF0EA472),
    exams: [
      ExamOption(id: 'gen_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
      ExamOption(id: 'gen_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF052E1E), tagColor: Color(0xFF0EA472)),
    ],
  ),
  'Analytical Chemistry & Laboratory Instrumentation': SubjectOption(
    id: 'anal_chem', emoji: '🔬', name: 'Analytical Chemistry & Laboratory Instrumentation',
    color: Color(0xFF60A5FA), bg: Color(0xFF0C1A3D), border: Color(0xFF185FA5),
    exams: [
      ExamOption(id: 'anal_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
      ExamOption(id: 'anal_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF0C1A3D), tagColor: Color(0xFF60A5FA)),
    ],
  ),
  'Microbial Diversity & Physiology': SubjectOption(
    id: 'micro_adv', emoji: '🦠', name: 'Microbial Diversity & Physiology',
    color: Color(0xFFEC4899), bg: Color(0xFF2D0A1E), border: Color(0xFFEC4899),
    exams: [
      ExamOption(id: 'micro_div_intro', label: 'Introduction', tag: 'Intro', tagBg: Color(0xFF2D0A1E), tagColor: Color(0xFFEC4899)),
      ExamOption(id: 'micro_div_adv', label: 'Advanced', tag: 'Advanced', tagBg: Color(0xFF2D0A1E), tagColor: Color(0xFFEC4899)),
    ],
  ),
};

class SubjectPickerPage extends StatefulWidget {
  const SubjectPickerPage({super.key});
  @override
  State<SubjectPickerPage> createState() => _SubjectPickerPageState();
}

class _SubjectPickerPageState extends State<SubjectPickerPage> {
  final List<SelectedSubject> _selected = [];
  String? _expandedId;
  bool _reviewing = false;
  bool _saving = false;
  String? _userCourse;
  List<SubjectOption> _subjects = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStudentTypeAndCourse();
  }

  Future<void> _loadStudentTypeAndCourse() async {
    final prefs = await SharedPreferences.getInstance();
    final userCourse = prefs.getString('user_course'); // Saved during registration
    
    setState(() {
      _userCourse = userCourse;
    });

    // Load recommended subjects based on course
    _loadRecommendedSubjects(userCourse);
  }

  void _loadRecommendedSubjects(String? course) {
    if (course == null) {
      // Fallback: show empty or default message
      setState(() => _loading = false);
      return;
    }

    // Get recommended subjects from CoursesData
    final recommendedSubjectNames = CoursesData.getSubjectsForCourse(course);
    
    // Convert subject names to SubjectOption objects using the display map
    final subjects = recommendedSubjectNames
        .map((name) => _subjectDisplayMap[name])
        .whereType<SubjectOption>()
        .toList();

    setState(() {
      _subjects = subjects;
      _loading = false;
    });
  }

  SubjectOption? _getSubject(String id) =>
      _subjects.where((s) => s.id == id).firstOrNull;

  bool _isSelected(String subjectId) =>
      _selected.any((s) => s.subjectId == subjectId);

  SelectedSubject? _getEntry(String subjectId) =>
      _selected.where((s) => s.subjectId == subjectId).firstOrNull;

  void _toggleSubject(SubjectOption subject) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_isSelected(subject.id)) {
        _selected.removeWhere((s) => s.subjectId == subject.id);
        if (_expandedId == subject.id) _expandedId = null;
      } else {
        _selected.add(SelectedSubject(
          subjectId: subject.id,
          examId: subject.exams.first.id,
        ));
        _expandedId = subject.id;
      }
    });
  }

  void _selectExam(String subjectId, String examId) {
    HapticFeedback.selectionClick();
    setState(() {
      final idx = _selected.indexWhere((s) => s.subjectId == subjectId);
      if (idx != -1) {
        _selected[idx] = SelectedSubject(subjectId: subjectId, examId: examId);
      }
      _expandedId = null;
    });
  }

  void _toggleExpanded(String subjectId) {
    setState(() => _expandedId = _expandedId == subjectId ? null : subjectId);
  }

  Future<void> _saveAndContinue() async {
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select at least 1 subject',
            style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    setState(() => _saving = true);
    final subjectNames = _selected.map((s) {
      final sub = _getSubject(s.subjectId);
      final exam = sub?.exams.where((e) => e.id == s.examId).firstOrNull;
      return exam?.label ?? sub?.name ?? s.subjectId;
    }).toList();

    // Resolve selected subjects to catalog course codes so the
    // Learning Map knows which courses to unlock.
    final selectedCatalogCodes = _selected
        .expand((s) => _getSubject(s.subjectId)?.catalogCodes ?? const <String>[])
        .toSet();
    // Compulsory GST/core courses are unlocked for every student
    // regardless of elective picks (see AppConstants).
    final catalogCodes = <String>{
      ...selectedCatalogCodes,
      ...AppConstants.compulsoryCourseCodes,
    }.toList();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('unlocked_courses', catalogCodes);

    await UserService.updateProfile(course: subjectNames.join(', '));
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.accent,
          ),
        ),
      );
    }

    if (_subjects.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_rounded, size: 48, color: AppColors.textTertiary),
              const SizedBox(height: 16),
              Text('No subjects available',
                  style: GoogleFonts.dmSans(fontSize: 16,
                      fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Text('Please complete your registration first',
                  style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => context.go('/register'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('Go to Registration',
                      style: GoogleFonts.dmSans(fontSize: 13,
                          fontWeight: FontWeight.w500, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: _reviewing ? _reviewScreen() : _pickerScreen()),
    );
  }

  Widget _pickerScreen() {
    return Column(children: [
      // Step dots
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _dot(done: true), const SizedBox(width: 6),
          _dot(done: true), const SizedBox(width: 6),
          _dot(done: true), const SizedBox(width: 6),
          _dot(active: true),
        ]),
      ),
      // Header
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Recommended subjects',
              style: GoogleFonts.dmSans(fontSize: 18,
                  fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          const SizedBox(height: 3),
          Text('For ${_userCourse ?? "your course"}',
              style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
        ]),
      ),
      // Count badge
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          RichText(text: TextSpan(children: [
            TextSpan(text: '${_selected.length} subject${_selected.length != 1 ? "s" : ""}',
                style: GoogleFonts.dmSans(fontSize: 10,
                    fontWeight: FontWeight.w500, color: AppColors.accentLight)),
            TextSpan(text: ' selected · tap each to set level',
                style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
          ])),
        ]),
      ),
      // Subject list
      Expanded(child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemCount: _subjects.length,
        itemBuilder: (_, i) {
          final subject = _subjects[i];
          final selected = _isSelected(subject.id);
          final expanded = _expandedId == subject.id;
          final entry = _getEntry(subject.id);
          final selectedExam = entry != null
              ? subject.exams.where((e) => e.id == entry.examId).firstOrNull
              : null;

          return Column(children: [
            GestureDetector(
              onTap: () {
                if (selected) {
                  _toggleExpanded(subject.id);
                } else {
                  _toggleSubject(subject);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: expanded ? 0 : 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                decoration: BoxDecoration(
                  color: selected ? subject.bg : AppColors.surface,
                  border: Border.all(
                      color: selected ? subject.border : AppColors.border,
                      width: selected ? 1.5 : 0.5),
                  borderRadius: expanded
                      ? const BorderRadius.vertical(top: Radius.circular(14))
                      : BorderRadius.circular(14),
                ),
                child: Row(children: [
                  Text(subject.emoji, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(subject.name,
                        style: GoogleFonts.dmSans(fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: selected ? AppColors.textPrimary : AppColors.textSecondary)),
                    if (selected && selectedExam != null)
                      Text(selectedExam.label,
                          style: GoogleFonts.dmSans(fontSize: 10, color: subject.color)),
                  ])),
                  if (selected)
                    AnimatedRotation(
                      turns: expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: 22, height: 22,
                        decoration: BoxDecoration(
                            color: subject.bg,
                            borderRadius: BorderRadius.circular(7)),
                        child: Icon(Icons.keyboard_arrow_down_rounded,
                            size: 16, color: subject.color),
                      ),
                    )
                  else
                    Container(
                      width: 22, height: 22,
                      decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(7)),
                      child: const Icon(Icons.add_rounded,
                          size: 14, color: AppColors.textTertiary),
                    ),
                ]),
              ),
            ),
            // Exam dropdown
            if (expanded) AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: subject.border, width: 1.5),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(14)),
              ),
              child: Column(
                children: subject.exams.map((exam) {
                  final picked = entry?.examId == exam.id;
                  return GestureDetector(
                    onTap: () => _selectExam(subject.id, exam.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                      decoration: BoxDecoration(
                        color: picked ? subject.bg : Colors.transparent,
                        border: const Border(
                            bottom: BorderSide(color: AppColors.border, width: 0.5)),
                      ),
                      child: Row(children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: 18, height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: picked ? subject.color : Colors.transparent,
                            border: Border.all(
                                color: picked ? subject.color : AppColors.border,
                                width: 1.5),
                          ),
                          child: picked
                              ? const Icon(Icons.check_rounded,
                                  size: 10, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(exam.label,
                            style: GoogleFonts.dmSans(fontSize: 12,
                                fontWeight: picked ? FontWeight.w500 : FontWeight.normal,
                                color: picked ? AppColors.textPrimary : AppColors.textSecondary))),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                              color: exam.tagBg,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(exam.tag,
                              style: GoogleFonts.dmSans(
                                  fontSize: 9, color: exam.tagColor)),
                        ),
                      ]),
                    ),
                  );
                }).toList(),
              ),
            ),
          ]);
        },
      )),
      // CTA
      Container(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
        decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(top: BorderSide(color: AppColors.border))),
        child: GestureDetector(
          onTap: _selected.isNotEmpty
              ? () => setState(() => _reviewing = true)
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: _selected.isNotEmpty ? AppColors.accent : AppColors.border,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Continue',
                  style: GoogleFonts.dmSans(fontSize: 14,
                      fontWeight: FontWeight.w500, color: Colors.white)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
            ]),
          ),
        ),
      ),
    ]);
  }

  Widget _reviewScreen() {
    return Column(children: [
      // Step dots
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _dot(done: true), const SizedBox(width: 6),
          _dot(done: true), const SizedBox(width: 6),
          _dot(done: true), const SizedBox(width: 6),
          _dot(active: true),
        ]),
      ),
      // Header
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Your learning plan',
              style: GoogleFonts.dmSans(fontSize: 18,
                  fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          const SizedBox(height: 3),
          Text('Ready to start mastering these subjects?',
              style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
        ]),
      ),
      // Review list
      Expanded(child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemCount: _selected.length,
        itemBuilder: (_, i) {
          final entry = _selected[i];
          final subject = _getSubject(entry.subjectId)!;
          final exam = subject.exams
              .where((e) => e.id == entry.examId).firstOrNull;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: subject.bg,
              border: Border.all(color: subject.border, width: 1.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text(subject.emoji,
                    style: const TextStyle(fontSize: 22))),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(subject.name,
                    style: GoogleFonts.dmSans(fontSize: 14,
                        fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                if (exam != null) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: exam.tagBg,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(exam.label,
                        style: GoogleFonts.dmSans(
                            fontSize: 10, color: exam.tagColor)),
                  ),
                ],
              ])),
              GestureDetector(
                onTap: () => setState(() {
                  _selected.removeAt(i);
                  _reviewing = false;
                }),
                child: const Icon(Icons.close_rounded,
                    size: 16, color: AppColors.textTertiary),
              ),
            ]),
          );
        },
      )),
      // CTAs
      Container(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
        decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(top: BorderSide(color: AppColors.border))),
        child: Column(children: [
          GestureDetector(
            onTap: _saving ? null : _saveAndContinue,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(14)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (_saving)
                  const SizedBox(width: 18, height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                else ...[
                  const Icon(Icons.rocket_launch_rounded,
                      color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text('Start learning',
                      style: GoogleFonts.dmSans(fontSize: 14,
                          fontWeight: FontWeight.w500, color: Colors.white)),
                ],
              ]),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() => _reviewing = false),
            child: Text('← Edit subjects',
                style: GoogleFonts.dmSans(
                    fontSize: 12, color: AppColors.textTertiary)),
          ),
        ]),
      ),
    ]);
  }

  Widget _dot({bool done = false, bool active = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: active ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active
            ? AppColors.accent
            : done
                ? AppColors.accent.withValues(alpha: 0.4)
                : AppColors.border,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}