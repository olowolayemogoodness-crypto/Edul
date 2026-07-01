import 'course_catalog_entry.dart';

final List<CourseCatalogEntry> firstSemesterCourses = [
  const CourseCatalogEntry(
    code: 'MTS101',
    title: 'Introductory Mathematics I (Algebra & Trigonometry)',
    semester: 'First',
    subjectGroups: ['Foundational Engineering Mathematics'],
    topics: [
      'Elementary set theory',
      'The real number system',
      'Sequences and series (A.P. and G.P.)',
      'Equations and theory of polynomials',
      'Binomial expansion',
      'Complex numbers',
      'Trigonometry',
    ],
  ),
  const CourseCatalogEntry(
    code: 'PHY101',
    title: 'General Physics I (Mechanics & Thermal Physics)',
    semester: 'First',
    subjectGroups: ['Applied Physics & Mechanics'],
    topics: [
      'Space, time, and vectors',
      'Kinematics',
      'Dynamics and friction',
      'Work, energy, and power',
      'Rotational dynamics',
      'Thermal properties',
    ],
  ),
  const CourseCatalogEntry(
    code: 'PHY103',
    title: 'General Physics III (Properties of Matter)',
    semester: 'First',
    subjectGroups: ['Applied Physics & Mechanics'],
    topics: [
      'Molecular theory of matter',
      'Elasticity',
      'Hydrostatics',
      'Hydrodynamics',
      'Surface phenomena',
    ],
  ),
  const CourseCatalogEntry(
    code: 'CHM101',
    title: 'General Chemistry I (Inorganic & Physical Chemistry)',
    semester: 'First',
    subjectGroups: ['Organic & Inorganic Chemistry'],
    topics: [
      'Atomic structure and quantum states',
      'Chemical bonding',
      'Gas and liquid laws',
      'Stoichiometry and energy systems',
      'Equilibrium and rates',
    ],
  ),
  const CourseCatalogEntry(
    code: 'CHM103',
    title: 'Experimental Chemistry I',
    semester: 'First',
    subjectGroups: [],
    topics: [
      'Laboratory safety and protocols',
      'Quantitative volumetric assays',
      'Qualitative analytic methods',
    ],
  ),
  const CourseCatalogEntry(
    code: 'MEE101',
    title: 'Engineering Drawing I',
    semester: 'First',
    subjectGroups: [],
    topics: [
      'Instrument applications',
      'Geometric shapes',
      'Loci and curves',
    ],
  ),
  const CourseCatalogEntry(
    code: 'GNS101',
    title: 'Use of English I',
    semester: 'First',
    subjectGroups: [],
    topics: [
      'Grammar systems',
      'Concord configurations',
      'Reading strategies',
    ],
  ),
  const CourseCatalogEntry(
    code: 'GNS103',
    title: 'Information Literacy & Retrieval',
    semester: 'First',
    subjectGroups: [],
    topics: [
      'Information systems',
      'Digital research frameworks',
      'Intellectual property compliance',
    ],
  ),
];