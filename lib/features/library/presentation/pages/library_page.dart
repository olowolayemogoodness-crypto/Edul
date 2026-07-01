import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class LibraryPage extends StatefulWidget {
  final String? selectedSubject;

  const LibraryPage({super.key, this.selectedSubject});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int _selectedCategory = 0;
  final _categories = ['All', 'PDFs', 'Notes', 'Textbooks', 'Past questions'];
  List<Map<String, dynamic>> _resources = [];

  @override
  void initState() {
    super.initState();
    _loadResources();
  }

  void _loadResources() {
    final subject = widget.selectedSubject ?? 'Unknown';
    final resources = _getResourcesBySubject(subject);
    setState(() => _resources = resources);
  }

  List<Map<String, dynamic>> _getResourcesBySubject(String subject) {
    // Remove exam level suffix if present (e.g., "Introduction" from "Organic Chemistry Introduction")
    final baseSubject = subject.split(' - ').first.trim();

    if (baseSubject.contains('Medical Biochemistry')) {
      return _medicalBiochemistryResources;
    } else if (baseSubject.contains('Human Physiology')) {
      return _humanPhysiologyResources;
    } else if (baseSubject.contains('Gross Anatomy')) {
      return _anatomyResources;
    } else if (baseSubject.contains('Pharmacology')) {
      return _pharmacologyResources;
    } else if (baseSubject.contains('Microbiology')) {
      return _microbiologyResources;
    } else if (baseSubject.contains('Histology')) {
      return _histologyResources;
    } else if (baseSubject.contains('Pathology')) {
      return _pathologyResources;
    } else if (baseSubject.contains('Clinical')) {
      return _clinicalResources;
    } else if (baseSubject.contains('Foundational Engineering Mathematics')) {
      return _engMathResources;
    } else if (baseSubject.contains('Computer Programming')) {
      return _programmingResources;
    } else if (baseSubject.contains('Data Structures')) {
      return _dataStructuresResources;
    } else if (baseSubject.contains('Database')) {
      return _databaseResources;
    } else if (baseSubject.contains('Circuit Theory')) {
      return _circuitResources;
    } else if (baseSubject.contains('Applied Physics')) {
      return _physicsResources;
    } else if (baseSubject.contains('Thermodynamics')) {
      return _thermodynamicsResources;
    } else if (baseSubject.contains('Structural')) {
      return _structuralResources;
    } else if (baseSubject.contains('Calculus')) {
      return _calculusResources;
    } else if (baseSubject.contains('Chemistry')) {
      return _chemistryResources;
    } else if (baseSubject.contains('Genetics')) {
      return _geneticsResources;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedCategory == 0
        ? _resources
        : _resources.where((i) => i['type'] == _categories[_selectedCategory]).toList();

    final pdfCount = _resources.where((i) => i['type'] == 'PDFs').length;
    final pastQCount = _resources.where((i) => i['type'] == 'Past questions').length;

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
                    onTap: () => context.pop(),
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
                          'Study Library',
                          style: GoogleFonts.dmSans(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Books · PDFs · Notes',
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showUploadSheet(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      size: 18,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Search your library…',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Categories
            SizedBox(
              height: 36,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, index) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final selected = _selectedCategory == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.accent : AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected ? AppColors.accent : AppColors.border,
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        _categories[i],
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: selected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Stats row
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  _StatChip(
                    label: '${_resources.length} items',
                    color: AppColors.accentLight,
                  ),
                  const SizedBox(width: 8),
                  _StatChip(
                    label: '$pdfCount PDFs',
                    color: const Color(0xFF0EA472),
                  ),
                  const SizedBox(width: 8),
                  _StatChip(
                    label: '$pastQCount past Qs',
                    color: const Color(0xFFE8960F),
                  ),
                ],
              ),
            ),

            // List
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('📚', style: TextStyle(fontSize: 40)),
                          const SizedBox(height: 12),
                          Text(
                            'No items yet',
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tap + to upload a PDF or note',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filtered.length,
                      separatorBuilder: (_, index) => const SizedBox(height: 8),
                      itemBuilder: (_, i) => _LibraryCard(item: filtered[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Add to library',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            const _UploadOption(
              icon: Icons.picture_as_pdf_rounded,
              color: Color(0xFFEA580C),
              label: 'Upload PDF',
              sub: 'Past questions, textbooks, notes',
            ),
            const SizedBox(height: 10),
            const _UploadOption(
              icon: Icons.note_add_rounded,
              color: AppColors.accentLight,
              label: 'Create note',
              sub: 'Write or paste your study notes',
            ),
            const SizedBox(height: 10),
            const _UploadOption(
              icon: Icons.camera_alt_rounded,
              color: Color(0xFF0EA472),
              label: 'Scan document',
              sub: 'Take a photo of handwritten notes',
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ━━ RESOURCE DATA - One list per subject ━━

  static const List<Map<String, dynamic>> _medicalBiochemistryResources = [
    {
      'title': 'Medical Biochemistry Fundamentals',
      'type': 'Textbooks',
      'subject': 'Medical Biochemistry',
      'emoji': '⚗️',
      'pages': 240,
      'color': 0xFF2D1200,
      'border': 0xFFEA580C,
    },
    {
      'title': 'Metabolic Pathways & Enzymes',
      'type': 'Notes',
      'subject': 'Medical Biochemistry',
      'emoji': '📝',
      'pages': 96,
      'color': 0xFF2D1200,
      'border': 0xFFEA580C,
    },
    {
      'title': 'Clinical Biochemistry Past Questions',
      'type': 'Past questions',
      'subject': 'Medical Biochemistry',
      'emoji': '❓',
      'pages': 120,
      'color': 0xFF2D1200,
      'border': 0xFFEA580C,
    },
    {
      'title': 'Laboratory Techniques & Analysis',
      'type': 'Textbooks',
      'subject': 'Medical Biochemistry',
      'emoji': '🧪',
      'pages': 168,
      'color': 0xFF2D1200,
      'border': 0xFFEA580C,
    },
    {
      'title': 'Biochemistry Study Guide',
      'type': 'Notes',
      'subject': 'Medical Biochemistry',
      'emoji': '📋',
      'pages': 72,
      'color': 0xFF2D1200,
      'border': 0xFFEA580C,
    },
  ];

  static const List<Map<String, dynamic>> _humanPhysiologyResources = [
    {
      'title': 'Human Physiology Complete Textbook',
      'type': 'Textbooks',
      'subject': 'Human Physiology',
      'emoji': '💚',
      'pages': 420,
      'color': 0xFF052E1E,
      'border': 0xFF0EA472,
    },
    {
      'title': 'Organ Systems & Functions',
      'type': 'Notes',
      'subject': 'Human Physiology',
      'emoji': '📝',
      'pages': 160,
      'color': 0xFF052E1E,
      'border': 0xFF0EA472,
    },
    {
      'title': 'Physiology Past Papers 2022-2023',
      'type': 'Past questions',
      'subject': 'Human Physiology',
      'emoji': '❓',
      'pages': 144,
      'color': 0xFF052E1E,
      'border': 0xFF0EA472,
    },
    {
      'title': 'Cardiovascular System Deep Dive',
      'type': 'Notes',
      'subject': 'Human Physiology',
      'emoji': '❤️',
      'pages': 88,
      'color': 0xFF052E1E,
      'border': 0xFF0EA472,
    },
  ];

  static const List<Map<String, dynamic>> _anatomyResources = [
    {
      'title': 'Gross Anatomy Atlas & Guide',
      'type': 'Textbooks',
      'subject': 'Gross Anatomy & Embryology',
      'emoji': '🦴',
      'pages': 380,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
    {
      'title': 'Embryological Development Notes',
      'type': 'Notes',
      'subject': 'Gross Anatomy & Embryology',
      'emoji': '📝',
      'pages': 120,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
    {
      'title': 'Anatomy Exam Questions',
      'type': 'Past questions',
      'subject': 'Gross Anatomy & Embryology',
      'emoji': '❓',
      'pages': 136,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
  ];

  static const List<Map<String, dynamic>> _pharmacologyResources = [
    {
      'title': 'Pharmacology & Therapeutics Handbook',
      'type': 'Textbooks',
      'subject': 'Pharmacology & Therapeutics',
      'emoji': '💊',
      'pages': 320,
      'color': 0xFF2D1E00,
      'border': 0xFFC47D0E,
    },
    {
      'title': 'Drug Classification & Mechanisms',
      'type': 'Notes',
      'subject': 'Pharmacology & Therapeutics',
      'emoji': '📝',
      'pages': 144,
      'color': 0xFF2D1E00,
      'border': 0xFFC47D0E,
    },
    {
      'title': 'Clinical Pharmacology Questions',
      'type': 'Past questions',
      'subject': 'Pharmacology & Therapeutics',
      'emoji': '❓',
      'pages': 112,
      'color': 0xFF2D1E00,
      'border': 0xFFC47D0E,
    },
  ];

  static const List<Map<String, dynamic>> _microbiologyResources = [
    {
      'title': 'Medical Microbiology & Parasitology',
      'type': 'Textbooks',
      'subject': 'Medical Microbiology & Parasitology',
      'emoji': '🦠',
      'pages': 360,
      'color': 0xFF2D0A1E,
      'border': 0xFFEC4899,
    },
    {
      'title': 'Pathogenic Organisms & Diseases',
      'type': 'Notes',
      'subject': 'Medical Microbiology & Parasitology',
      'emoji': '📝',
      'pages': 168,
      'color': 0xFF2D0A1E,
      'border': 0xFFEC4899,
    },
    {
      'title': 'Microbiology Exam Papers',
      'type': 'Past questions',
      'subject': 'Medical Microbiology & Parasitology',
      'emoji': '❓',
      'pages': 128,
      'color': 0xFF2D0A1E,
      'border': 0xFFEC4899,
    },
  ];

  static const List<Map<String, dynamic>> _histologyResources = [
    {
      'title': 'Histology & Cellular Biology Guide',
      'type': 'Textbooks',
      'subject': 'Histology & Cellular Biology',
      'emoji': '🔬',
      'pages': 280,
      'color': 0xFF0C1A3D,
      'border': 0xFF185FA5,
    },
    {
      'title': 'Tissue Types & Microscopy Notes',
      'type': 'Notes',
      'subject': 'Histology & Cellular Biology',
      'emoji': '📝',
      'pages': 112,
      'color': 0xFF0C1A3D,
      'border': 0xFF185FA5,
    },
  ];

  static const List<Map<String, dynamic>> _pathologyResources = [
    {
      'title': 'Pathology & Immunology Textbook',
      'type': 'Textbooks',
      'subject': 'Pathology & Immunology',
      'emoji': '🛡️',
      'pages': 340,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
    {
      'title': 'Disease Mechanisms & Immunity',
      'type': 'Notes',
      'subject': 'Pathology & Immunology',
      'emoji': '📝',
      'pages': 144,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
  ];

  static const List<Map<String, dynamic>> _clinicalResources = [
    {
      'title': 'Clinical Medicine & Surgery Handbook',
      'type': 'Textbooks',
      'subject': 'Clinical Medicine & Surgery',
      'emoji': '🏥',
      'pages': 520,
      'color': 0xFF052E1E,
      'border': 0xFF0EA472,
    },
    {
      'title': 'Clinical Case Studies',
      'type': 'Notes',
      'subject': 'Clinical Medicine & Surgery',
      'emoji': '📝',
      'pages': 224,
      'color': 0xFF052E1E,
      'border': 0xFF0EA472,
    },
  ];

  static const List<Map<String, dynamic>> _engMathResources = [
    {
      'title': 'Engineering Mathematics Foundations',
      'type': 'Textbooks',
      'subject': 'Foundational Engineering Mathematics',
      'emoji': '📐',
      'pages': 360,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
    {
      'title': 'Calculus & Linear Algebra Notes',
      'type': 'Notes',
      'subject': 'Foundational Engineering Mathematics',
      'emoji': '📝',
      'pages': 144,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
    {
      'title': 'Engineering Math Past Questions',
      'type': 'Past questions',
      'subject': 'Foundational Engineering Mathematics',
      'emoji': '❓',
      'pages': 168,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
  ];

  static const List<Map<String, dynamic>> _programmingResources = [
    {
      'title': 'Programming Fundamentals Guide',
      'type': 'Textbooks',
      'subject': 'Computer Programming & Software Architecture',
      'emoji': '💻',
      'pages': 420,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
    {
      'title': 'Design Patterns & Architecture',
      'type': 'Notes',
      'subject': 'Computer Programming & Software Architecture',
      'emoji': '📝',
      'pages': 180,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
  ];

  static const List<Map<String, dynamic>> _dataStructuresResources = [
    {
      'title': 'Data Structures Complete Reference',
      'type': 'Textbooks',
      'subject': 'Data Structures & Algorithms',
      'emoji': '🔗',
      'pages': 380,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
    {
      'title': 'Algorithm Analysis & Complexity',
      'type': 'Notes',
      'subject': 'Data Structures & Algorithms',
      'emoji': '📝',
      'pages': 144,
      'color': 0xFF1E1240,
      'border': 0xFF2D1B6B,
    },
  ];

  static const List<Map<String, dynamic>> _databaseResources = [
    {
      'title': 'Database Management Systems Guide',
      'type': 'Textbooks',
      'subject': 'Database Management Systems',
      'emoji': '🗄️',
      'pages': 320,
      'color': 0xFF0C1A3D,
      'border': 0xFF185FA5,
    },
    {
      'title': 'SQL & Query Optimization',
      'type': 'Notes',
      'subject': 'Database Management Systems',
      'emoji': '📝',
      'pages': 128,
      'color': 0xFF0C1A3D,
      'border': 0xFF185FA5,
    },
  ];

  static const List<Map<String, dynamic>> _circuitResources = [
    {
      'title': 'Circuit Theory & Electronics',
      'type': 'Textbooks',
      'subject': 'Circuit Theory & Electronic Systems',
      'emoji': '⚡',
      'pages': 360,
      'color': 0xFF0C1A3D,
      'border': 0xFF185FA5,
    },
    {
      'title': 'Electronic Devices & Circuits',
      'type': 'Notes',
      'subject': 'Circuit Theory & Electronic Systems',
      'emoji': '📝',
      'pages': 152,
      'color': 0xFF0C1A3D,
      'border': 0xFF185FA5,
    },
  ];

  static const List<Map<String, dynamic>> _physicsResources = [
    {
      'title': 'Applied Physics & Mechanics',
      'type': 'Textbooks',
      'subject': 'Applied Physics & Mechanics',
      'emoji': '🚀',
      'pages': 380,
      'color': 0xFF0C1A3D,
      'border': 0xFF185FA5,
    },
    {
      'title': 'Mechanics & Motion Analysis',
      'type': 'Notes',
      'subject': 'Applied Physics & Mechanics',
      'emoji': '📝',
      'pages': 144,
      'color': 0xFF0C1A3D,
      'border': 0xFF185FA5,
    },
  ];

  static const List<Map<String, dynamic>> _thermodynamicsResources = [
    {
      'title': 'Thermodynamics & Heat Transfer',
      'type': 'Textbooks',
      'subject': 'Thermodynamics & Fluid Mechanics',
      'emoji': '🌡️',
      'pages': 360,
      'color': 0xFF2D1200,
      'border': 0xFFEA580C,
    },
    {
      'title': 'Fluid Mechanics Principles',
      'type': 'Notes',
      'subject': 'Thermodynamics & Fluid Mechanics',
      'emoji': '📝',
      'pages': 136,
      'color': 0xFF2D1200,
      'border': 0xFFEA580C,
    },
  ];

  static const List<Map<String, dynamic>> _structuralResources = [
    {
      'title': 'Structural Analysis Methods',
      'type': 'Textbooks',
      'subject': 'Structural Analysis & Design',
      'emoji': '🏗️',
      'pages': 400,
      'color': 0xFF052E1E,
      'border': 0xFF0EA472,
    },
    {
      'title': 'Design Codes & Standards',
      'type': 'Notes',
      'subject': 'Structural Analysis & Design',
      'emoji': '📝',
      'pages': 160,
      'color': 0xFF052E1E,
      'border': 0xFF0EA472,
    },
  ];

  static const List<Map<String, dynamic>> _calculusResources = [
    {
      'title': 'Calculus I & II Complete Guide',
      'type': 'Textbooks',
      'subject': 'Calculus',
      'emoji': '📐',
      'pages': 360,
      'color': 0xFF2D1E00,
      'border': 0xFFC47D0E,
    },
    {
      'title': 'Integration & Differentiation',
      'type': 'Notes',
      'subject': 'Calculus',
      'emoji': '📝',
      'pages': 144,
      'color': 0xFF2D1E00,
      'border': 0xFFC47D0E,
    },
    {
      'title': 'Calculus Practice Problems',
      'type': 'Past questions',
      'subject': 'Calculus',
      'emoji': '❓',
      'pages': 120,
      'color': 0xFF2D1E00,
      'border': 0xFFC47D0E,
    },
  ];

  static const List<Map<String, dynamic>> _chemistryResources = [
    {
      'title': 'Organic & Inorganic Chemistry',
      'type': 'Textbooks',
      'subject': 'Organic, Inorganic & Physical Chemistry',
      'emoji': '⚗️',
      'pages': 420,
      'color': 0xFF2D1200,
      'border': 0xFFEA580C,
    },
    {
      'title': 'Reaction Mechanisms & Synthesis',
      'type': 'Notes',
      'subject': 'Organic, Inorganic & Physical Chemistry',
      'emoji': '📝',
      'pages': 180,
      'color': 0xFF2D1200,
      'border': 0xFFEA580C,
    },
    {
      'title': 'Chemistry Exam Questions',
      'type': 'Past questions',
      'subject': 'Organic, Inorganic & Physical Chemistry',
      'emoji': '❓',
      'pages': 144,
      'color': 0xFF2D1200,
      'border': 0xFFEA580C,
    },
  ];

  static const List<Map<String, dynamic>> _geneticsResources = [
    {
      'title': 'Cell Biology & Genetics',
      'type': 'Textbooks',
      'subject': 'Cell Biology & Genetics',
      'emoji': '🧬',
      'pages': 340,
      'color': 0xFF052E1E,
      'border': 0xFF0EA472,
    },
    {
      'title': 'Inheritance Patterns & Mutations',
      'type': 'Notes',
      'subject': 'Cell Biology & Genetics',
      'emoji': '📝',
      'pages': 128,
      'color': 0xFF052E1E,
      'border': 0xFF0EA472,
    },
  ];
}

class _LibraryCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _LibraryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Color(item['color'] as int),
        border: Border.all(color: Color(item['border'] as int)),
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
                item['emoji'] as String,
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item['type'] as String,
                        style: GoogleFonts.dmSans(
                          fontSize: 9,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item['subject'] as String,
                      style: GoogleFonts.dmSans(
                        fontSize: 10,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${item['pages']} pages',
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
            size: 18,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class _UploadOption extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label, sub;

  const _UploadOption({
    required this.icon,
    required this.color,
    required this.label,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  sub,
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
            size: 16,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}