// lib/core/data/subjects_data.dart
// Shared course/unit/lesson data — single source of truth used by
// both the Learning Map and the Quiz feature.
import 'package:flutter/material.dart';

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
          {'id': 'phy102_u1_1', 'name': 'Charge and Coulomb\'s Law', 'icon': '⚡'},
          {'id': 'phy102_u1_2', 'name': 'Electric Field and Potential', 'icon': '💡'},
        ]
      },
      {
        'unit': 2,
        'name': 'Current Electricity',
        'color': Color(0xFFF87171),
        'lessons': [
          {'id': 'phy102_u1_3', 'name': 'Current Electricity Basics', 'icon': '🔧'},
          {'id': 'phy102_u5_1', 'name': 'Electric Current', 'icon': '🔌'},
          {'id': 'phy102_u5_2', 'name': 'Resistance and Resistors', 'icon': '📊'},
          {'id': 'phy102_u5_3', 'name': 'Electrical Power', 'icon': '⚡'},
          {'id': 'phy102_u5_4', 'name': 'Resistors in Series and Parallel', 'icon': '🔗'},
          {'id': 'phy102_u5_5', 'name': 'Kirchhoff\'s Law', 'icon': '🧮'},
        ]
      },
      {
        'unit': 3,
        'name': 'Magnetism',
        'color': Color(0xFFFCA5A5),
        'lessons': [
          {'id': 'phy102_u2_1', 'name': 'Magnetic Fields and Forces', 'icon': '🧲'},
          {'id': 'phy102_u2_2', 'name': 'Self and Mutual Inductance', 'icon': '🔄'},
        ]
      },
      {
        'unit': 4,
        'name': 'Electromagnetic Waves',
        'color': Color(0xFFFECACA),
        'lessons': [
          {'id': 'phy102_u2_3', 'name': 'EM Wave Properties', 'icon': '〰️'},
          {'id': 'phy102_u3_1', 'name': 'EM Wave Applications', 'icon': '📡'},
        ]
      },
      {
        'unit': 5,
        'name': 'Applied Physics',
        'color': Color(0xFFFEE2E2),
        'lessons': [
          {'id': 'phy102_u3_2', 'name': 'Motors, Generators and Transformers', 'icon': '⚙️'},
          {'id': 'phy102_u3_3', 'name': 'Modern Physics Applications', 'icon': '🔬'},
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