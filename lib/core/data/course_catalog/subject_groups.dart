/// Maps broad onboarding subject labels (from courses_model.dart's
/// courseToSubjects) to whether real catalog content exists yet.
/// Use this to grey out / hide subjects in the UI that don't have
/// course data yet, instead of showing an empty search result.
const Set<String> mappedSubjectGroups = {
  'Foundational Engineering Mathematics',
  'Calculus',
  'Applied Physics & Mechanics',
  'Organic & Inorganic Chemistry',
  'Risk Management & Actuarial Mathematics',
  'Circuit Theory & Electronic Systems',
  'Computer Programming & Software Architecture',
};

// TODO: The following onboarding subject labels currently have NO
// matching catalog courses (no curriculum data provided yet):
// - Gross Anatomy & Embryology
// - Histology & Cellular Biology
// - Human Physiology
// - Medical Biochemistry
// - Medical Microbiology & Parasitology
// - Pathology & Immunology
// - Pharmacology & Therapeutics
// - Clinical Medicine & Surgery
// - Community Health & Epidemiology
// - Pharmaceutical Chemistry
// - Data Structures & Algorithms
// - Database Management Systems
// - Web Development & Frameworks
// ...and others from courseToSubjects in courses_model.dart