// lib/features/learning/presentation/pages/learning_map_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/course_catalog/course_catalog.dart';

class LearningMapPage extends StatefulWidget {
  const LearningMapPage({super.key});

  @override
  State<LearningMapPage> createState() => _LearningMapPageState();
}

class _LearningMapPageState extends State<LearningMapPage> {
  String _toTitleCase(String text) {
    const lowerWords = {'and', 'of', 'in', 'the', 'to', 'for'};
    const romanNumerals = {'i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii', 'viii', 'ix', 'x'};

    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      final lower = word.toLowerCase();
      if (romanNumerals.contains(lower)) {
        return word.toUpperCase();
      }
      if (lowerWords.contains(lower)) {
        return lower;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
  String? _matchingSubjectsDataKey(String catalogCode) {
    final normalized = catalogCode.replaceAll(' ', '').toUpperCase();
    for (final key in subjectsData.keys) {
      if (key.replaceAll(' ', '').toUpperCase() == normalized) return key;
    }
    return null;
  }

  Map<String, bool> completedLessons = {};
  String selectedSubject = 'MTS 102'; // Default subject
  List<String> unlockedCatalogCodes = [];
  String? selectedCatalogOnlyCode; // Non-null when viewing a "coming soon" course // Default subject

  final Map<String, Map<String, dynamic>> subjectsData = {
    'MTS 102': {
      'fullName': 'INTRODUCTORY MATHEMATICS II',
      'color': Color(0xFF22C55E),
      'units': [
        {
          'unit': 1,
          'name': 'Functions of Real Variables',
          'color': Color(0xFF22C55E),
          'lessons': [
            {'id': 'mts102_u1_1', 'name': 'Function Basics', 'icon': '📐'},
            {'id': 'mts102_u1_2', 'name': 'Domain and Range', 'icon': '📊'},
            {'id': 'mts102_u1_3', 'name': 'Function Operations', 'icon': '⚙️'},
          ]
        },
        {
          'unit': 2,
          'name': 'Graphs of Functions',
          'color': Color(0xFFEAB308),
          'lessons': [
            {'id': 'mts102_u2_1', 'name': 'Graph Basics', 'icon': '📈'},
            {'id': 'mts102_u2_2', 'name': 'Transformations', 'icon': '🔄'},
            {'id': 'mts102_u2_3', 'name': 'Curve Analysis', 'icon': '🎯'},
          ]
        },
        {
          'unit': 3,
          'name': 'Limits and Continuity',
          'color': Color(0xFF3B82F6),
          'lessons': [
            {'id': 'mts102_u3_1', 'name': 'Limit Concept', 'icon': '🎯'},
            {'id': 'mts102_u3_2', 'name': 'Evaluating Limits', 'icon': '🔍'},
            {'id': 'mts102_u3_3', 'name': 'Continuity', 'icon': '🌊'},
          ]
        },
        {
          'unit': 4,
          'name': 'Techniques of Differentiation',
          'color': Color(0xFFEC4899),
          'lessons': [
            {'id': 'mts102_u4_1', 'name': 'Derivative Basics', 'icon': '📉'},
            {'id': 'mts102_u4_2', 'name': 'Differentiation Rules', 'icon': '⚙️'},
            {'id': 'mts102_u4_3', 'name': 'Advanced Techniques', 'icon': '🔗'},
          ]
        },
        {
          'unit': 5,
          'name': 'Extreme & Curve Sketching',
          'color': Color(0xFF8B5CF6),
          'lessons': [
            {'id': 'mts102_u5_1', 'name': 'Extrema', 'icon': '⬆️'},
            {'id': 'mts102_u5_2', 'name': 'Curve Sketching', 'icon': '🎨'},
            {'id': 'mts102_u5_3', 'name': 'Analysis', 'icon': '🔍'},
          ]
        },
        {
          'unit': 6,
          'name': 'Integration',
          'color': Color(0xFFF59E0B),
          'lessons': [
            {'id': 'mts102_u6_1', 'name': 'Antiderivatives', 'icon': '∫'},
            {'id': 'mts102_u6_2', 'name': 'Integration Methods', 'icon': '📦'},
            {'id': 'mts102_u6_3', 'name': 'Definite Integrals', 'icon': '📊'},
          ]
        },
        {
          'unit': 7,
          'name': 'Applications of Integration',
          'color': Color(0xFF06B6D4),
          'lessons': [
            {'id': 'mts102_u7_1', 'name': 'Area Problems', 'icon': '📐'},
            {'id': 'mts102_u7_2', 'name': 'Volume Problems', 'icon': '📦'},
            {'id': 'mts102_u7_3', 'name': 'Real-World Apps', 'icon': '🌍'},
          ]
        },
      ]
    },
    'GNS 106': {
      'fullName': 'PHILOSOPHY, LOGIC AND ISSUES IN SCIENCE AND TECHNOLOGY',
      'color': Color(0xFF10B981),
      'units': [
        {
          'unit': 1,
          'name': 'Philosophy and Logic - Part 1',
          'color': Color(0xFF10B981),
          'lessons': [
            {'id': 'gns106_u1_1', 'name': 'Intro to Philosophy', 'icon': '🧠'},
            {'id': 'gns106_u1_2', 'name': 'Rational Inquiry', 'icon': '💭'},
            {'id': 'gns106_u1_3', 'name': 'Branches of Philosophy', 'icon': '🌳'},
          ]
        },
        {
          'unit': 2,
          'name': 'Philosophy Methods & Schools',
          'color': Color(0xFF14B8A6),
          'lessons': [
            {'id': 'gns106_u2_1', 'name': 'Philosophical Methods', 'icon': '📖'},
            {'id': 'gns106_u2_2', 'name': 'Schools of Thought', 'icon': '🏫'},
            {'id': 'gns106_u2_3', 'name': 'African Philosophy', 'icon': '🌍'},
          ]
        },
        {
          'unit': 3,
          'name': 'Logic and Reasoning',
          'color': Color(0xFF0D9488),
          'lessons': [
            {'id': 'gns106_u3_1', 'name': 'Nature of Logic', 'icon': '🔗'},
            {'id': 'gns106_u3_2', 'name': 'Symbolic Logic', 'icon': '⚙️'},
            {'id': 'gns106_u3_3', 'name': 'Fallacies', 'icon': '❌'},
          ]
        },
        {
          'unit': 4,
          'name': 'Science, Technology & Culture',
          'color': Color(0xFF06B6D4),
          'lessons': [
            {'id': 'gns106_u4_1', 'name': 'Philosophy of Science', 'icon': '🔬'},
            {'id': 'gns106_u4_2', 'name': 'Science & Technology', 'icon': '⚡'},
            {'id': 'gns106_u4_3', 'name': 'Technology & Culture', 'icon': '🌐'},
          ]
        },
        {
          'unit': 5,
          'name': 'Ethics & Technology',
          'color': Color(0xFF0891B2),
          'lessons': [
            {'id': 'gns106_u5_1', 'name': 'Ethics Overview', 'icon': '⚖️'},
            {'id': 'gns106_u5_2', 'name': 'Science Ethics', 'icon': '🔬'},
            {'id': 'gns106_u5_3', 'name': 'Tech Ethics', 'icon': '💻'},
          ]
        },
      ]
    },
    'PHY 102': {
      'fullName': 'PHYSICS II',
      'color': Color(0xFFEF4444),
      'units': [
        {
          'unit': 1,
          'name': 'Electrostatics',
          'color': Color(0xFFEF4444),
          'lessons': [
            {'id': 'phy102_u1_1', 'name': 'Electric Fields', 'icon': '⚡'},
            {'id': 'phy102_u1_2', 'name': 'Electric Potential', 'icon': '💡'},
            {'id': 'phy102_u1_3', 'name': 'Applications', 'icon': '🔧'},
          ]
        },
        {
          'unit': 2,
          'name': 'Current Electricity',
          'color': Color(0xFFF87171),
          'lessons': [
            {'id': 'phy102_u2_1', 'name': 'Circuits', 'icon': '⚙️'},
            {'id': 'phy102_u2_2', 'name': 'Ohm\'s Law', 'icon': '📊'},
            {'id': 'phy102_u2_3', 'name': 'Power & Energy', 'icon': '⚡'},
          ]
        },
        {
          'unit': 3,
          'name': 'Magnetism',
          'color': Color(0xFFFCA5A5),
          'lessons': [
            {'id': 'phy102_u3_1', 'name': 'Magnetic Fields', 'icon': '🧲'},
            {'id': 'phy102_u3_2', 'name': 'Magnetic Induction', 'icon': '🔄'},
            {'id': 'phy102_u3_3', 'name': 'Applications', 'icon': '📡'},
          ]
        },
        {
          'unit': 4,
          'name': 'Electromagnetic Waves',
          'color': Color(0xFFFECACA),
          'lessons': [
            {'id': 'phy102_u4_1', 'name': 'Wave Properties', 'icon': '〰️'},
            {'id': 'phy102_u4_2', 'name': 'EM Radiation', 'icon': '☀️'},
            {'id': 'phy102_u4_3', 'name': 'Applications', 'icon': '📡'},
          ]
        },
      ]
    },
    'CHE 102': {
      'fullName': 'CHEMISTRY II (Organic)',
      'color': Color(0xFF8B5CF6),
      'units': [
        {
          'unit': 1,
          'name': 'Organic Chemistry Basics',
          'color': Color(0xFF8B5CF6),
          'lessons': [
            {'id': 'che102_u1_1', 'name': 'Historical Background', 'icon': '📚'},
            {'id': 'che102_u1_2', 'name': 'Purification', 'icon': '🧪'},
            {'id': 'che102_u1_3', 'name': 'Analysis', 'icon': '🔬'},
          ]
        },
        {
          'unit': 2,
          'name': 'Hydrocarbons',
          'color': Color(0xFFA78BFA),
          'lessons': [
            {'id': 'che102_u2_1', 'name': 'Aliphatic HC', 'icon': '⛓️'},
            {'id': 'che102_u2_2', 'name': 'Aromatic HC', 'icon': '⭕'},
            {'id': 'che102_u2_3', 'name': 'Structures', 'icon': '🧬'},
          ]
        },
        {
          'unit': 3,
          'name': 'Electronic Theory',
          'color': Color(0xFFC4B5FD),
          'lessons': [
            {'id': 'che102_u3_1', 'name': 'Bonding Theory', 'icon': '🔗'},
            {'id': 'che102_u3_2', 'name': 'Organic Reactions', 'icon': '⚗️'},
            {'id': 'che102_u3_3', 'name': 'Mechanisms', 'icon': '🎯'},
          ]
        },
        {
          'unit': 4,
          'name': 'Functional Groups',
          'color': Color(0xFFDDD6FE),
          'lessons': [
            {'id': 'che102_u4_1', 'name': 'Alcohols & Ethers', 'icon': '🧫'},
            {'id': 'che102_u4_2', 'name': 'Carbonyl Groups', 'icon': '⚙️'},
            {'id': 'che102_u4_3', 'name': 'Carboxylic Acids', 'icon': '⚛️'},
          ]
        },
      ]
    },
    'GNS 102': {
      'fullName': 'USE OF ENGLISH II',
      'color': Color(0xFF3B82F6),
      'units': [
        {
          'unit': 1,
          'name': 'Reading Skills',
          'color': Color(0xFF3B82F6),
          'lessons': [
            {'id': 'gns102_u1_1', 'name': 'Reading Comprehension', 'icon': '📖'},
            {'id': 'gns102_u1_2', 'name': 'Critical Reading', 'icon': '🔍'},
            {'id': 'gns102_u1_3', 'name': 'Reading Reviews', 'icon': '⭐'},
          ]
        },
        {
          'unit': 2,
          'name': 'Writing Process',
          'color': Color(0xFF60A5FA),
          'lessons': [
            {'id': 'gns102_u2_1', 'name': 'Writing Basics', 'icon': '✍️'},
            {'id': 'gns102_u2_2', 'name': 'Paragraph Development', 'icon': '📝'},
            {'id': 'gns102_u2_3', 'name': 'Drafting', 'icon': '📄'},
          ]
        },
        {
          'unit': 3,
          'name': 'Reports & Documentation',
          'color': Color(0xFF93C5FD),
          'lessons': [
            {'id': 'gns102_u3_1', 'name': 'Report Structure', 'icon': '📊'},
            {'id': 'gns102_u3_2', 'name': 'Editing', 'icon': '✏️'},
            {'id': 'gns102_u3_3', 'name': 'Documentation', 'icon': '📚'},
          ]
        },
      ]
    },
    'BIO 102': {
      'fullName': 'GENERAL BIOLOGY II',
      'color': Color(0xFF10B981),
      'units': [
        {
          'unit': 1,
          'name': 'Animal Kingdom Survey',
          'color': Color(0xFF10B981),
          'lessons': [
            {'id': 'bio102_u1_1', 'name': 'Kingdom Overview', 'icon': '🦁'},
            {'id': 'bio102_u1_2', 'name': 'Animal Features', 'icon': '👀'},
            {'id': 'bio102_u1_3', 'name': 'Ecological Adaptation', 'icon': '🌿'},
          ]
        },
        {
          'unit': 2,
          'name': 'Invertebrate Phyla',
          'color': Color(0xFF34D399),
          'lessons': [
            {'id': 'bio102_u2_1', 'name': 'Protozoans & Coelenterates', 'icon': '🦠'},
            {'id': 'bio102_u2_2', 'name': 'Worms & Nematodes', 'icon': '🪱'},
            {'id': 'bio102_u2_3', 'name': 'Arthropods & Molluscs', 'icon': '🦀'},
          ]
        },
        {
          'unit': 3,
          'name': 'Vertebrates & Ecology',
          'color': Color(0xFF6EE7B7),
          'lessons': [
            {'id': 'bio102_u3_1', 'name': 'Vertebrate Evolution', 'icon': '🦕'},
            {'id': 'bio102_u3_2', 'name': 'Chordates', 'icon': '🐟'},
            {'id': 'bio102_u3_3', 'name': 'Ecology Basics', 'icon': '🌍'},
          ]
        },
      ]
    },
    'CSC 102': {
      'fullName': 'INTRODUCTION TO COMPUTER SCIENCE',
      'color': Color(0xFF0EA5E9),
      'units': [
        {
          'unit': 1,
          'name': 'Computer Fundamentals',
          'color': Color(0xFF0EA5E9),
          'lessons': [
            {'id': 'csc102_u1_1', 'name': 'Computer Overview', 'icon': '💻'},
            {'id': 'csc102_u1_2', 'name': 'Hardware', 'icon': '⚙️'},
            {'id': 'csc102_u1_3', 'name': 'Software', 'icon': '📦'},
          ]
        },
        {
          'unit': 2,
          'name': 'Programming Languages',
          'color': Color(0xFF38BDF8),
          'lessons': [
            {'id': 'csc102_u2_1', 'name': 'Language Basics', 'icon': '🔤'},
            {'id': 'csc102_u2_2', 'name': 'BASIC Language', 'icon': '📝'},
            {'id': 'csc102_u2_3', 'name': 'Visual BASIC', 'icon': '🎨'},
          ]
        },
        {
          'unit': 3,
          'name': 'Programming Principles',
          'color': Color(0xFF7DD3FC),
          'lessons': [
            {'id': 'csc102_u3_1', 'name': 'Basic Principles', 'icon': '📚'},
            {'id': 'csc102_u3_2', 'name': 'Control Structures', 'icon': '🔄'},
            {'id': 'csc102_u3_3', 'name': 'Applications', 'icon': '🚀'},
          ]
        },
      ]
    },
    'MTS 104': {
      'fullName': 'INTRODUCTORY APPLIED MATHEMATICS',
      'color': Color(0xFFF59E0B),
      'units': [
        {
          'unit': 1,
          'name': 'Vectors',
          'color': Color(0xFFF59E0B),
          'lessons': [
            {'id': 'mts104_u1_1', 'name': 'Vector Basics', 'icon': '➡️'},
            {'id': 'mts104_u1_2', 'name': 'Vector Operations', 'icon': '⚙️'},
            {'id': 'mts104_u1_3', 'name': 'Applications', 'icon': '📊'},
          ]
        },
        {
          'unit': 2,
          'name': 'Geometry',
          'color': Color(0xFFFBBF24),
          'lessons': [
            {'id': 'mts104_u2_1', 'name': 'Circle Geometry', 'icon': '⭕'},
            {'id': 'mts104_u2_2', 'name': 'Conic Sections', 'icon': '📐'},
            {'id': 'mts104_u2_3', 'name': 'Properties', 'icon': '🎯'},
          ]
        },
        {
          'unit': 3,
          'name': 'Dynamics Part I',
          'color': Color(0xFFFCD34D),
          'lessons': [
            {'id': 'mts104_u3_1', 'name': 'Newton\'s Laws', 'icon': '⚡'},
            {'id': 'mts104_u3_2', 'name': 'Motion Analysis', 'icon': '🏃'},
            {'id': 'mts104_u3_3', 'name': 'Forces', 'icon': '💪'},
          ]
        },
        {
          'unit': 4,
          'name': 'Dynamics Part II',
          'color': Color(0xFFFDE68A),
          'lessons': [
            {'id': 'mts104_u4_1', 'name': 'Energy', 'icon': '⚡'},
            {'id': 'mts104_u4_2', 'name': 'Momentum', 'icon': '📈'},
            {'id': 'mts104_u4_3', 'name': 'Applications', 'icon': '🔧'},
          ]
        },
      ]
    },
  };

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList('completed_lessons') ?? [];
    final saved = prefs.getString('selected_subject') ?? 'MTS 102';
    final unlocked = prefs.getStringList('unlocked_courses') ?? [];
    setState(() {
      for (var lessonId in completed) {
        completedLessons[lessonId] = true;
      }
      selectedSubject = saved;
      unlockedCatalogCodes = unlocked;
    });
  }

  Future<void> _saveSubjectPreference(String subject) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_subject', subject);
  }

  Future<void> _loadCompletedLessons() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList('completed_lessons') ?? [];
    setState(() {
      completedLessons.clear();
      for (var lessonId in completed) {
        completedLessons[lessonId] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadCompletedLessons();

    if (selectedCatalogOnlyCode != null) {
      final entry = CourseCatalog.byCode(selectedCatalogOnlyCode!);
      final syntheticData = {
        'fullName': entry?.title ?? 'Course',
        'color': AppColors.textTertiary,
      };
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(syntheticData),
              Expanded(child: _buildComingSoon()),
            ],
          ),
        ),
      );
    }

    final subjectData = subjectsData[selectedSubject]!;
    final units = subjectData['units'] as List<Map<String, dynamic>>;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(subjectData),
                  const SizedBox(height: 30),
                  ...List.generate(units.length, (index) {
                    final unit = units[index];
                    return Column(
                      children: [
                        _buildUnit(
                          unitNumber: unit['unit'],
                          unitName: unit['name'],
                          color: unit['color'],
                          lessons: unit['lessons'],
                        ),
                        if (index < units.length - 1) const SizedBox(height: 50),
                      ],
                    );
                  }),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComingSoon() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🚧', style: TextStyle(fontSize: 56)),
            const SizedBox(height: 20),
            Text(
              'Coming Soon',
              style: GoogleFonts.dmSans(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lessons for this course are being prepared.',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> subjectData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.go('/home'),
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 20,
              color: AppColors.textTertiary,
            ),
          ),
          // Subject dropdown
          // Subject title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _toTitleCase(subjectData['fullName'] as String),
                
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          // Search icon
          GestureDetector(
            onTap: () => _showSubjectSearch(context),
            child: const Icon(
              Icons.search_rounded,
              size: 22,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
  void _showSubjectSearch(BuildContext context) {
    String query = '';
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final realResults = subjectsData.entries.map((entry) {
              return {
                'title': _toTitleCase(entry.value['fullName'] as String),
                'color': entry.value['color'] as Color,
                'isComingSoon': false,
                'subjectKey': entry.key,
                'catalogCode': null,
              };
            });

            final comingSoonResults = unlockedCatalogCodes
                .where((code) => _matchingSubjectsDataKey(code) == null)
                .map((code) {
              final entry = CourseCatalog.byCode(code);
              return {
                'title': entry != null ? _toTitleCase(entry.title) : code,
                'color': AppColors.textTertiary,
                'isComingSoon': true,
                'subjectKey': null,
                'catalogCode': code,
              };
            });

            final allResults = [...realResults, ...comingSoonResults];
            final matches = allResults.where((r) {
              return (r['title'] as String).toLowerCase().contains(query.toLowerCase());
            }).toList();

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: TextField(
                          autofocus: true,
                          onChanged: (value) {
                            setModalState(() => query = value);
                          },
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search subjects...',
                            hintStyle: GoogleFonts.dmSans(
                              fontSize: 14,
                              color: AppColors.textTertiary,
                            ),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: AppColors.textTertiary,
                              size: 20,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: matches.isEmpty
                          ? Center(
                              child: Text(
                                'No subjects found',
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: matches.length,
                              itemBuilder: (context, index) {
                                final result = matches[index];
                                final isComingSoon = result['isComingSoon'] as bool;
                                final title = result['title'] as String;
                                final color = result['color'] as Color;
                                final subjectKey = result['subjectKey'] as String?;
                                final catalogCode = result['catalogCode'] as String?;
                                final isSelected = !isComingSoon &&
                                    subjectKey == selectedSubject &&
                                    selectedCatalogOnlyCode == null;

                                return GestureDetector(
                                  onTap: () {
                                    if (isComingSoon) {
                                      setState(() {
                                        selectedCatalogOnlyCode = catalogCode;
                                      });
                                    } else {
                                      setState(() {
                                        selectedSubject = subjectKey!;
                                        selectedCatalogOnlyCode = null;
                                      });
                                      _saveSubjectPreference(subjectKey!);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? color.withOpacity(0.15)
                                          : AppColors.background,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected ? color : AppColors.border,
                                        width: isSelected ? 1.5 : 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            title,
                                            style: GoogleFonts.dmSans(
                                              fontSize: 14,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                        if (isComingSoon)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: AppColors.surfaceVariant,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              'Coming soon',
                                              style: GoogleFonts.dmSans(
                                                fontSize: 9,
                                                color: AppColors.textTertiary,
                                              ),
                                            ),
                                          )
                                        else if (isSelected)
                                          Icon(
                                            Icons.check_circle_rounded,
                                            size: 18,
                                            color: color,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildUnit({
    required int unitNumber,
    required String unitName,
    required Color color,
    required List<Map<String, dynamic>> lessons,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Unit header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UNIT $unitNumber',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: color,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      unitName,
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: color, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      '🏆',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Lessons in zigzag pattern
          ..._buildLessonZigzag(lessons, color),
        ],
      ),
    );
  }

  List<Widget> _buildLessonZigzag(
      List<Map<String, dynamic>> lessons, Color unitColor) {
    final widgets = <Widget>[];

    for (int i = 0; i < lessons.length; i++) {
      final lesson = lessons[i];
      final isLeft = i % 2 == 0;
      final isLocked = i > 0 && !completedLessons.containsKey(lessons[i - 1]['id']);

      // Draw diagonal line before next lesson
      if (i < lessons.length - 1) {
        widgets.add(
          CustomPaint(
            painter: DiagonalDashedLinePainter(
              color: unitColor.withOpacity(0.3),
              isLeft: isLeft,
            ),
            size: const Size(double.infinity, 60),
          ),
        );
      }

      // Lesson circle
      widgets.add(
        Align(
          alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
          child: GestureDetector(
            onTap: isLocked
                ? null
                : () {
                    context.push(
                      '/lesson-detail',
                      extra: {
                        'lessonId': lesson['id'],
                        'lessonName': lesson['name'],
                        'colorValue': unitColor.value,
                      },
                    );
                  },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isLocked ? Colors.grey[700] : unitColor,
                boxShadow: [
                  BoxShadow(
                    color: unitColor.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (completedLessons.containsKey(lesson['id']))
                      const Icon(Icons.check_circle, color: Colors.white, size: 28)
                    else if (isLocked)
                      const Icon(Icons.lock, color: Colors.white60, size: 28)
                    else
                      Text(
                        lesson['icon'] ?? '📚',
                        style: const TextStyle(fontSize: 36),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      widgets.add(const SizedBox(height: 12));
      widgets.add(
        Align(
          alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
          child: Padding(
            padding: isLeft
                ? const EdgeInsets.only(left: 20)
                : const EdgeInsets.only(right: 20),
            child: Text(
              lesson['name'],
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
      widgets.add(const SizedBox(height: 20));
    }

    return widgets;
  }
}

class DiagonalDashedLinePainter extends CustomPainter {
  final Color color;
  final bool isLeft;

  DiagonalDashedLinePainter({required this.color, required this.isLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const dashWidth = 8.0;
    const dashSpace = 8.0;
    const totalDash = dashWidth + dashSpace;

    if (isLeft) {
      var startX = 50.0;
      var startY = 0.0;
      var endX = size.width * 0.5;
      var endY = size.height;

      final dx = endX - startX;
      final dy = endY - startY;
      final distance = sqrt(dx * dx + dy * dy);

      for (var i = 0.0; i < distance; i += totalDash) {
        final t1 = i / distance;
        final t2 = (i + dashWidth) / distance;

        canvas.drawLine(
          Offset(startX + dx * t1, startY + dy * t1),
          Offset(startX + dx * t2, startY + dy * t2),
          paint,
        );
      }
    } else {
      var startX = size.width * 0.5;
      var startY = 0.0;
      var endX = size.width - 50;
      var endY = size.height;

      final dx = endX - startX;
      final dy = endY - startY;
      final distance = sqrt(dx * dx + dy * dy);

      for (var i = 0.0; i < distance; i += totalDash) {
        final t1 = i / distance;
        final t2 = (i + dashWidth) / distance;

        canvas.drawLine(
          Offset(startX + dx * t1, startY + dy * t1),
          Offset(startX + dx * t2, startY + dy * t2),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(DiagonalDashedLinePainter oldDelegate) => false;
}