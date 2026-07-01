// lib/models/courses_model.dart - ENHANCED VERSION

class CoursesData {
  // Original Faculty/Course structure
  static const Map<String, List<String>> facultyCourses = {
    'Medical and Health Sciences': [
      'Medicine and Surgery',
      'Nursing Science',
      'Pharmacy',
      'Medical Laboratory Science',
      'Dentistry and Dental Surgery',
      'Physiotherapy (Medical Rehabilitation)',
      'Public Health',
      'Optometry',
      'Radiography',
      'Anatomy',
      'Physiology',
    ],
    'Engineering and Technology': [
      'Computer Science',
      'Software Engineering',
      'Information Technology',
      'Electrical/Electronic Engineering',
      'Civil Engineering',
      'Mechanical Engineering',
      'Chemical Engineering',
      'Petroleum and Gas Engineering',
      'Telecommunication Engineering',
      'Mechatronics Engineering',
      'Agricultural and Bioresources Engineering',
      'Materials and Metallurgical Engineering',
    ],
    'Administration and Management': [
      'Accounting',
      'Business Administration',
      'Economics',
      'Banking and Finance',
      'Marketing',
      'Public Administration',
      'Mass Communication',
      'Human Resource Management',
      'Insurance',
      'Actuarial Science',
      'Entrepreneurship',
      'Cooperative and Rural Development',
    ],
    'Art, Laws & Humanities': [
      'Law',
      'International Relations',
      'Political Science',
      'Mass Communication',
      'Theatre Arts / Creative Arts',
      'English Language',
      'History and Strategic Studies',
      'Linguistics and Nigerian Languages',
      'Philosophy',
      'Sociology',
      'Psychology',
    ],
    'Sciences and Agriculture': [
      'Biochemistry',
      'Microbiology',
      'Geology',
      'Industrial Chemistry',
      'Physics with Electronics',
      'Mathematics & Statistics',
      'Agricultural Science / Agriculture',
      'Botany & Zoology',
      'Food Science and Technology',
    ],
    'Environmental Sciences': [
      'Architecture',
      'Estate Management',
      'Urban and Regional Planning',
      'Quantity Surveying',
      'Building Technology',
      'Surveying and Geoinformatics',
    ],
    'Education': [
      'Education and English / Mathematics / Economics',
      'Educational Management',
      'Guidance and Counseling',
      'Primary Education Studies',
      'Adult and Non-Formal Education',
      'Health Education',
      'Physical and Health Education',
    ],
  };

  // ============================================================
  // NEW: Faculty to Block Mapping
  // ============================================================
  static const Map<String, String> facultyToBlock = {
    'Medical and Health Sciences': 'Block 1: Medical, Clinical & Health Sciences',
    'Engineering and Technology': 'Block 2: Computing & Engineering Disciplines',
    'Administration and Management': 'Block 3: Management, Administration & Commercial Sciences',
    'Art, Laws & Humanities': 'Block 4: Law, Arts, Humanities & Social Sciences',
    'Sciences and Agriculture': 'Block 5: Pure, Applied & Agricultural Sciences',
    'Environmental Sciences': 'Block 6: Environmental Sciences & Built Environment',
    'Education': 'Block 7: Education & Pedagogical Disciplines',
  };

  // ============================================================
  // NEW: Course to Recommended Subjects Mapping
  // Based on Block structure
  // ============================================================
  static const Map<String, List<String>> courseToSubjects = {
    // Block 1: Medical and Health Sciences
    'Medicine and Surgery': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Gross Anatomy & Embryology',
      'Histology & Cellular Biology',
      'Human Physiology',
      'Medical Biochemistry',
      'Medical Microbiology & Parasitology',
      'Pathology & Immunology',
      'Pharmacology & Therapeutics',
      'Clinical Medicine & Surgery',
    ],
    'Nursing Science': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Human Physiology',
      'Medical Biochemistry',
      'Medical Microbiology & Parasitology',
      'Pharmacology & Therapeutics',
      'Community Health & Epidemiology',
    ],
    'Pharmacy': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Medical Biochemistry',
      'Medical Microbiology',
      'Pharmacology & Therapeutics',
      'Pharmaceutical Chemistry',
      'Pathology & Immunology',
    ],
    'Anatomy': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Gross Anatomy & Embryology',
      'Histology & Cellular Biology',
      'Neuroanatomy',
    ],
    'Physiology': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Human Physiology',
      'Cellular Physiology',
      'Systems Physiology',
    ],

    // Block 2: Engineering and Technology
    'Computer Science': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Computer Programming & Software Architecture',
      'Data Structures & Algorithms',
      'Database Management Systems',
      'Web Development & Frameworks',
    ],
    'Software Engineering': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Computer Programming & Software Architecture',
      'Data Structures & Algorithms',
      'Software Design Patterns',
      'Systems Engineering & Control Systems',
    ],
    'Mathematics & Statistics': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Linear Algebra',
      'Differential Equations',
      'Probability & Statistics',
    ],
    'Electrical/Electronic Engineering': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Circuit Theory & Electronic Systems',
      'Applied Physics & Mechanics',
      'Systems Engineering & Control Systems',
    ],
    'Civil Engineering': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Applied Physics & Mechanics',
      'Structural Analysis & Design',
      'Environmental Engineering & Geotechnics',
    ],
    'Mechanical Engineering': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Applied Physics & Mechanics',
      'Thermodynamics & Fluid Mechanics',
      'Systems Engineering & Control Systems',
    ],

    // Block 3: Management and Administration
    'Accounting': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Financial Accounting & Corporate Reporting',
      'Business Mathematics & Statistics',
      'Auditing & Taxation Systems',
      'Corporate Finance & Investment Analysis',
    ],
    'Business Administration': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Principles of Management & Organizational Behaviour',
      'Business Mathematics & Statistics',
      'Strategic Management & Entrepreneurship',
      'Corporate Finance & Investment Analysis',
    ],
    'Economics': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Microeconomic & Macroeconomic Theory',
      'Business Mathematics & Statistics',
      'Corporate Finance & Investment Analysis',
      'Risk Management & Actuarial Mathematics',
    ],
    'Banking and Finance': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Corporate Finance & Investment Analysis',
      'Financial Accounting & Corporate Reporting',
      'Risk Management & Actuarial Mathematics',
      'Business Mathematics & Statistics',
    ],

    // Block 4: Law, Arts & Humanities
    'Law': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Legal Methods & Constitutional Law',
      'Criminal Justice & Jurisprudence',
      'International Law & Treaties',
      'Business Law & Corporate Governance',
    ],
    'Psychology': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'General & Developmental Psychology',
      'Sociological Theories & Social Structures',
      'Research Methodologies in Social Sciences',
      'Philosophy & Critical Thinking',
    ],
    'Sociology': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Sociological Theories & Social Structures',
      'General & Developmental Psychology',
      'Research Methodologies in Social Sciences',
      'Philosophy & Logic',
    ],
    'English Language': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Literary Studies & Creative Writing',
      'Linguistics & Language Structures',
      'Media Studies & Communication Theories',
      'Philosophy & Critical Thinking',
    ],

    // Block 5: Pure, Applied & Agricultural Sciences
    'Biochemistry': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Organic & Inorganic Chemistry',
      'Cell Biology & Genetics',
      'Enzymology & Intermediary Metabolism',
      'Analytical Chemistry & Laboratory Instrumentation',
    ],
    'Microbiology': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Microbial Diversity & Physiology',
      'Cell Biology & Genetics',
      'Analytical Chemistry & Laboratory Instrumentation',
      'Virology & Immunology',
    ],
    'Physics with Electronics': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Classical, Quantum & Solid-State Physics',
      'Mathematical Methods & Statistical Computing',
      'Circuit Theory & Electronic Systems',
    ],
    'Industrial Chemistry': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Organic, Inorganic & Physical Chemistry',
      'Analytical Chemistry & Laboratory Instrumentation',
      'Materials Science & Metallurgy',
    ],

    // Block 6: Environmental Sciences
    'Architecture': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Architectural Design & Visual Communication',
      'Building Materials & Component Technology',
      'Environmental Science & Climatology',
      'Structural Analysis & Design',
    ],
    'Urban and Regional Planning': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'Urban Planning Theories & Housing Design',
      'Environmental Science & Climatology',
      'Land Economics & Estate Management',
      'Environmental Law & Land Law',
    ],

    // Block 7: Education
    'Education and English / Mathematics / Economics': [
      'Foundational Engineering Mathematics',
      'Calculus',
      'History & Philosophy of Education',
      'Educational Psychology & Learning Theories',
      'Curriculum Development & Planning',
      'Teaching Methodologies & Pedagogy',
    ],
  };

  // ============================================================
  // NEW: Subject to Topics Mapping (Learning Map Structure)
  // Example: Calculus topics for learning map
  // ============================================================
  static const Map<String, List<LearningTopic>> subjectTopics = {
    'Calculus': [
      LearningTopic(
        id: '1',
        name: 'Functions and Graphs',
        description: 'Introduction to functions and their graphical representations',
        icon: '📈',
        subtopics: [
          'Definition of functions',
          'Domain and codomain',
          'Function notation',
          'Graphing functions',
        ],
      ),
      LearningTopic(
        id: '2',
        name: 'Domain and Range',
        description: 'Understanding domain and range of functions',
        icon: '📊',
        subtopics: [
          'Finding domain',
          'Finding range',
          'Restrictions on domain',
          'Real-world applications',
        ],
      ),
      LearningTopic(
        id: '3',
        name: 'Types of Functions',
        description: 'Polynomial, Trigonometric, Exponential, Logarithmic',
        icon: '⚡',
        subtopics: [
          'Polynomial functions',
          'Trigonometric functions',
          'Exponential functions',
          'Logarithmic functions',
        ],
      ),
      LearningTopic(
        id: '4',
        name: 'Limits',
        description: 'Intuitive concept and evaluation of limits',
        icon: '🎯',
        subtopics: [
          'Intuitive concept of limits',
          'One-sided limits',
          'Two-sided limits',
          'Limits at infinity',
          'Infinite limits',
        ],
      ),
      LearningTopic(
        id: '5',
        name: 'Continuity',
        description: 'Understanding continuity and discontinuity',
        icon: '🌊',
        subtopics: [
          'Definition of continuity',
          'Points of discontinuity',
          'Continuity on intervals',
          'Intermediate Value Theorem',
        ],
      ),
      LearningTopic(
        id: '6',
        name: 'Derivatives',
        description: 'Rate of change and derivative rules',
        icon: '📐',
        subtopics: [
          'Definition of derivative',
          'Power rule',
          'Product rule',
          'Quotient rule',
          'Chain rule',
        ],
      ),
      LearningTopic(
        id: '7',
        name: 'Applications of Derivatives',
        description: 'Optimization and real-world applications',
        icon: '🚀',
        subtopics: [
          'Optimization problems',
          'Related rates',
          'Curve sketching',
          'Motion problems',
        ],
      ),
      LearningTopic(
        id: '8',
        name: 'Integrals',
        description: 'Antiderivatives and definite integrals',
        icon: '∫',
        subtopics: [
          'Antiderivatives',
          'Indefinite integrals',
          'Definite integrals',
          'Fundamental Theorem of Calculus',
        ],
      ),
    ],
    'Data Structures & Algorithms': [
      LearningTopic(
        id: '1',
        name: 'Big O Notation',
        description: 'Time and space complexity analysis',
        icon: '⏱️',
        subtopics: [
          'Time complexity',
          'Space complexity',
          'Best, average, worst cases',
          'Big O rules',
        ],
      ),
      LearningTopic(
        id: '2',
        name: 'Arrays and Strings',
        description: 'Fundamental data structures',
        icon: '📦',
        subtopics: [
          'Array operations',
          'String manipulation',
          'Two-pointer technique',
          'Sliding window',
        ],
      ),
      LearningTopic(
        id: '3',
        name: 'Linked Lists',
        description: 'Node-based linear data structure',
        icon: '⛓️',
        subtopics: [
          'Singly linked lists',
          'Doubly linked lists',
          'Circular linked lists',
          'Operations and traversal',
        ],
      ),
      LearningTopic(
        id: '4',
        name: 'Stacks and Queues',
        description: 'LIFO and FIFO data structures',
        icon: '📚',
        subtopics: [
          'Stack operations',
          'Queue operations',
          'Priority queues',
          'Applications',
        ],
      ),
      LearningTopic(
        id: '5',
        name: 'Trees',
        description: 'Hierarchical data structures',
        icon: '🌳',
        subtopics: [
          'Binary trees',
          'Binary search trees',
          'Balanced trees (AVL, Red-Black)',
          'Tree traversals',
        ],
      ),
      LearningTopic(
        id: '6',
        name: 'Graphs',
        description: 'Network structures and algorithms',
        icon: '🕸️',
        subtopics: [
          'Graph representations',
          'DFS and BFS',
          'Shortest path (Dijkstra)',
          'Minimum spanning tree',
        ],
      ),
      LearningTopic(
        id: '7',
        name: 'Sorting Algorithms',
        description: 'Ordering data efficiently',
        icon: '🔄',
        subtopics: [
          'Bubble sort',
          'Quick sort',
          'Merge sort',
          'Heap sort',
        ],
      ),
      LearningTopic(
        id: '8',
        name: 'Dynamic Programming',
        description: 'Optimization through memoization',
        icon: '💾',
        subtopics: [
          'Overlapping subproblems',
          'Optimal substructure',
          'Memoization',
          'Tabulation',
        ],
      ),
    ],
  };

  // ============================================================
  // METHODS
  // ============================================================

  static List<String> getFaculties() => facultyCourses.keys.toList();

  static List<String> getCourses(String faculty) =>
      facultyCourses[faculty] ?? [];

  /// Get the block name for a faculty
  static String? getBlockForFaculty(String faculty) =>
      facultyToBlock[faculty];

  /// Get recommended subjects for a course
  static List<String> getSubjectsForCourse(String course) =>
      courseToSubjects[course] ?? [];

  /// Get topics for a subject (for learning map)
  static List<LearningTopic> getTopicsForSubject(String subject) =>
      subjectTopics[subject] ?? [];
}

// ============================================================
// DATA MODEL: Learning Topic
// ============================================================
class LearningTopic {
  final String id;
  final String name;
  final String description;
  final String icon;
  final List<String> subtopics;

  const LearningTopic({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.subtopics,
  });
}