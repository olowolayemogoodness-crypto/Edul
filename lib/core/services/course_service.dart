// lib/core/services/course_service.dart
//
// Courses are scoped by set (cohort/level) AND department -- GNS/GST
// are general studies, PHY/MTH are shared foundational courses tagged
// 'ALL' (every department in that set sees them), MEE is currently
// also 'ALL' but is the kind of course that would realistically be
// scoped to specific departments once ambassadors start adding
// department-specific courses (e.g. a PHY103 doc with
// departments: ['Mechanical Engineering', ...] alongside a PHY101 doc
// with departments: ['ALL']). See coursesForMyProfile() below for how
// that matching actually works.
//
// No lecturer-managed creation flow yet -- courses are seeded here
// directly, the same way the 47 SET30 groups were bulk-created in
// Firestore before group_service.dart existed to read them. This
// file mainly defines the shape; real lecturer-driven course
// creation is a later phase.

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_colors.dart';
import 'user_service.dart';

class CurriculumTopic {
  final String title;
  final String description;
  final int? week;
  final String? location;
  const CurriculumTopic({required this.title, required this.description, this.week, this.location});
}

class Textbook {
  final String title;
  final String author;
  final String price; // display string, e.g. "₦4,500" -- no real payment yet
  // Everything below is optional -- an ambassador can add as much or
  // as little detail as they have. Absent fields are hidden in the UI
  // rather than filled with a placeholder, except usedPrice, which
  // gets a documented ~65%-of-new fallback estimate when not supplied
  // (clearly a heuristic, not real data -- overridden the moment a
  // real used price is entered).
  final bool required; // required reading vs recommended
  final String? isbn;
  final double? rating;
  final int? ratingCount;
  final String? edition;
  final int? pages;
  final String? format;
  final String? usedPrice;
  final String? description;
  final bool inStock;

  const Textbook({
    required this.title,
    required this.author,
    required this.price,
    this.required = true,
    this.isbn,
    this.rating,
    this.ratingCount,
    this.edition,
    this.pages,
    this.format,
    this.usedPrice,
    this.description,
    this.inStock = true,
  });

  factory Textbook._fromMap(Map<dynamic, dynamic> t) {
    final price = t['price'] as String? ?? '';
    return Textbook(
      title: t['title'] as String? ?? '',
      author: t['author'] as String? ?? '',
      price: price,
      required: t['required'] as bool? ?? true,
      isbn: t['isbn'] as String?,
      rating: (t['rating'] as num?)?.toDouble(),
      ratingCount: t['ratingCount'] as int?,
      edition: t['edition'] as String?,
      pages: t['pages'] as int?,
      format: t['format'] as String?,
      usedPrice: t['usedPrice'] as String? ??
          (price.isNotEmpty ? _estimatedUsedPrice(price) : null),
      description: t['description'] as String?,
      inStock: t['inStock'] as bool? ?? true,
    );
  }

  /// A ~65%-of-new estimate, used only when no real usedPrice is
  /// entered. Naira-formatted to match the rest of the app's prices.
  /// This is a heuristic placeholder, not real inventory data --
  /// replace by adding a real `usedPrice` field on the textbook.
  static String _estimatedUsedPrice(String newPrice) {
    final digits = newPrice.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return '';
    final amount = (int.parse(digits) * 0.65).round();
    final s = amount.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return '₦$buf';
  }
}

class CourseModel {
  final String id;
  final String code;
  final String name;
  final String description;
  final int set;
  final Color accentColor;
  final List<CurriculumTopic> curriculum;
  final List<Textbook> textbooks;
  // Both optional and absent from the current seed data -- no lecturer
  // flow exists yet to set an instructor, and nothing computes real
  // progress yet (that needs the assessment/attendance layer). Left
  // nullable/empty on purpose rather than faked, so the UI can hide
  // these rather than show a made-up number.
  final String instructor;
  final double? progress; // 0.0-1.0, null = not yet tracked
  // Which departments (course of study) this course is visible to,
  // within its set/level. 'ALL' is a sentinel meaning every department
  // in that set sees it (e.g. GNS/GST/PHY101-style courses) -- not
  // every department's name, since that list isn't fixed and lives in
  // the `groups` collection, not here. A course with a real department
  // list (e.g. ['Mechanical Engineering', 'Electrical/Electronic
  // Engineering']) is only shown to students in those departments --
  // this is how "PHY103 for some departments, PHY101 for everyone"
  // gets modeled. Defaults to ['ALL'] if missing, so any course
  // document created before this field existed still shows up for
  // everyone rather than disappearing.
  final List<String> departments;
  // Links this course to how class reps name it in Timetable (see
  // timetable_service.dart's 'subject' field, e.g. "Physics",
  // "Mathematics"). Matched case-insensitively. Empty means no
  // schedule can be linked -- Overview then shows "no scheduled
  // classes linked yet" instead of a fabricated next-class banner.
  final String subject;

  const CourseModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.set,
    required this.accentColor,
    required this.curriculum,
    required this.textbooks,
    this.instructor = '',
    this.progress,
    this.departments = const ['ALL'],
    this.subject = '',
  });
}

class RecapEntry {
  final String id;
  final int lectureNumber;
  final String dateLabel; // display string, e.g. "Nov 14" -- ambassador-entered
  final String title;
  final String description;
  final String? notesUrl;
  final int? notesPages;
  final String? audioUrl;
  final int? audioMinutes;
  final List<MaterialFileRef> files;

  const RecapEntry({
    required this.id,
    required this.lectureNumber,
    required this.dateLabel,
    required this.title,
    required this.description,
    this.notesUrl,
    this.notesPages,
    this.audioUrl,
    this.audioMinutes,
    this.files = const [],
  });

  factory RecapEntry._fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final filesRaw = (data['files'] as List<dynamic>?) ?? [];
    return RecapEntry(
      id: doc.id,
      lectureNumber: data['lectureNumber'] as int? ?? 0,
      dateLabel: data['dateLabel'] as String? ?? '',
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      notesUrl: data['notesUrl'] as String?,
      notesPages: data['notesPages'] as int?,
      audioUrl: data['audioUrl'] as String?,
      audioMinutes: data['audioMinutes'] as int?,
      files: filesRaw.map((f) => MaterialFileRef(
        name: (f as Map)['name'] as String? ?? 'File',
        url: f['url'] as String? ?? '',
      )).toList(),
    );
  }
}

class MaterialFileRef {
  final String name;
  final String url;
  const MaterialFileRef({required this.name, required this.url});
}

class MaterialEntry {
  final String id;
  final String name;
  final String folder; // groups into "folders" client-side, no fixed enum
  final String fileType; // "PDF", "Link", etc -- free text, ambassador's choice
  final String url; // real link -- Firebase Storage, Drive, or any external URL
  final String? sizeLabel; // display only, e.g. "2.4 MB" -- optional
  final DateTime? uploadedAt;

  const MaterialEntry({
    required this.id,
    required this.name,
    required this.folder,
    required this.fileType,
    required this.url,
    this.sizeLabel,
    this.uploadedAt,
  });

  factory MaterialEntry._fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return MaterialEntry(
      id: doc.id,
      name: data['name'] as String? ?? 'Untitled file',
      folder: data['folder'] as String? ?? 'Other',
      fileType: data['fileType'] as String? ?? '',
      url: data['url'] as String? ?? '',
      sizeLabel: data['sizeLabel'] as String?,
      uploadedAt: (data['uploadedAt'] as Timestamp?)?.toDate(),
    );
  }
}

class CourseService {
  CourseService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> _courses() => _db.collection('courses');

  /// Fetches courses for the signed-in user's own set (cohort/level)
  /// AND their department -- a course is included if it either lists
  /// the student's exact department, or is tagged 'ALL' (visible to
  /// everyone in that set). This is what makes "PHY103 for some
  /// departments, PHY101 for everyone" possible: two Firestore
  /// documents with the same set but different `departments` arrays.
  ///
  /// The department comes from `profile['course']` -- confusingly
  /// named (it actually stores the department/course-of-study picked
  /// at registration, see register_page.dart's _DepartmentPickerSheet
  /// and user_service.dart's updateProfile), not renamed here to
  /// avoid a wider rename touching group_service.dart and the Social
  /// feed's department tab in the same change.
  ///
  /// Course documents are still added manually by ambassadors/admins
  /// directly in Firestore (no in-app authoring tool exists yet, same
  /// as before) -- this only changes what gets matched once a course
  /// document exists. A new course doc needs at minimum:
  ///   { code, name, set, departments: ['ALL'] or ['Some Dept', ...] }
  ///
  /// NOTE: this compound query (an equality filter + an
  /// arrayContainsAny filter together) needs a Firestore composite
  /// index. There's no firestore.indexes.json in this repo -- the
  /// first time this runs against a real project without that index,
  /// Firestore throws a FAILED_PRECONDITION error containing a direct
  /// link to auto-create it in the console. That error will now
  /// actually surface (see the try/catch this is called from) instead
  /// of failing silently.
  static Future<List<CourseModel>> coursesForMyProfile() async {
    final profile = await UserService.getProfile();
    final set = profile?['set'] as int?;
    if (set == null) return [];

    final department = profile?['course'] as String?;
    final wanted = (department != null && department.isNotEmpty) ? [department, 'ALL'] : ['ALL'];

    final snap = await _courses()
        .where('set', isEqualTo: set)
        .where('departments', arrayContainsAny: wanted)
        .get();
    if (snap.docs.isEmpty) return [];

    return snap.docs.map((doc) => _fromDoc(doc, set)).toList();
  }

  /// Creates a new recap under courses/{courseId}/recaps, or updates
  /// an existing one when [recapId] is passed. Class-rep permission
  /// is checked in the UI/form, same pattern as saveCourse.
  static Future<void> saveRecap({
    required String courseId,
    String? recapId,
    required int lectureNumber,
    required String dateLabel,
    required String title,
    required String description,
    String? notesUrl,
    int? notesPages,
    String? audioUrl,
    int? audioMinutes,
    List<MaterialFileRef> files = const [],
  }) async {
    final data = {
      'lectureNumber': lectureNumber,
      'dateLabel': dateLabel.trim(),
      'title': title.trim(),
      'description': description.trim(),
      'notesUrl': (notesUrl?.trim().isNotEmpty ?? false) ? notesUrl!.trim() : null,
      'notesPages': notesPages,
      'audioUrl': (audioUrl?.trim().isNotEmpty ?? false) ? audioUrl!.trim() : null,
      'audioMinutes': audioMinutes,
      'files': files.map((f) => {'name': f.name, 'url': f.url}).toList(),
    };
    final ref = _courses().doc(courseId).collection('recaps');
    if (recapId == null) {
      await ref.add({...data, 'createdAt': FieldValue.serverTimestamp()});
    } else {
      await ref.doc(recapId).update(data);
    }
  }

  /// Creates a new material under courses/{courseId}/materials, or
  /// updates an existing one when [materialId] is passed.
  static Future<void> saveMaterial({
    required String courseId,
    String? materialId,
    required String name,
    required String folder,
    required String fileType,
    required String url,
    String? sizeLabel,
  }) async {
    final data = {
      'name': name.trim(),
      'folder': folder.trim(),
      'fileType': fileType.trim(),
      'url': url.trim(),
      'sizeLabel': (sizeLabel?.trim().isNotEmpty ?? false) ? sizeLabel!.trim() : null,
      'uploadedAt': FieldValue.serverTimestamp(),
    };
    final ref = _courses().doc(courseId).collection('materials');
    if (materialId == null) {
      await ref.add(data);
    } else {
      await ref.doc(materialId).update(data);
    }
  }

    static Future<void> addCurriculumTopic({
    required String courseId,
    required String title,
    required String description,
    int? week,
    String? location,
  }) async {
    await _courses().doc(courseId).update({
      'curriculum': FieldValue.arrayUnion([
        {
          'title': title.trim(),
          'description': description.trim(),
          if (week != null) 'week': week,
          if (location != null && location.trim().isNotEmpty) 'location': location.trim(),
        },
      ]),
    });
  }

  static CourseModel _fromDoc(DocumentSnapshot<Map<String, dynamic>> doc, int fallbackSet) {
    final data = doc.data() ?? {};
    final curriculumRaw = (data['curriculum'] as List<dynamic>?) ?? [];
    final textbooksRaw = (data['textbooks'] as List<dynamic>?) ?? [];

    return CourseModel(
      id: doc.id,
      code: data['code'] as String? ?? '',
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      set: data['set'] as int? ?? fallbackSet,
      accentColor: _colorForIndex(data['colorIndex'] as int? ?? 0),
            curriculum: curriculumRaw.map((t) => CurriculumTopic(
        title: (t as Map)['title'] as String? ?? '',
        description: t['description'] as String? ?? '',
        week: t['week'] as int?,
        location: t['location'] as String?,
      )).toList(),
      textbooks: textbooksRaw.map((t) => Textbook._fromMap(t as Map)).toList(),
      instructor: data['instructor'] as String? ?? '',
      progress: (data['progress'] as num?)?.toDouble(),
      departments: (data['departments'] as List<dynamic>?)?.map((d) => d.toString()).toList() ?? const ['ALL'],
      subject: data['subject'] as String? ?? '',
    );
  }

  /// Refetches one course by id -- used after the in-app edit form
  /// saves, so the Overview page can update in place instead of
  /// forcing the user back to the list to see their own change.
  static Future<CourseModel?> getCourseById(String courseId) async {
    final doc = await _courses().doc(courseId).get();
    if (!doc.exists) return null;
    final set = doc.data()?['set'] as int? ?? 0;
    return _fromDoc(doc, set);
  }

  /// Creates a new course, or updates an existing one when [courseId]
  /// is passed. Used by the new in-app course editor (class-rep only
  /// -- the permission check happens in the UI/form, not here, same
  /// pattern as TimetableService.addEntry checking isClassRep before
  /// writing). curriculum/textbooks aren't editable from this form
  /// yet -- kept as whatever the document already has (or empty for
  /// a new course) so this doesn't wipe out console-added content.
  static Future<String> saveCourse({
    String? courseId,
    required String code,
    required String name,
    required String description,
    required int set,
    required int colorIndex,
    required List<String> departments,
    required String subject,
  }) async {
    final data = {
      'code': code.trim(),
      'name': name.trim(),
      'description': description.trim(),
      'set': set,
      'colorIndex': colorIndex,
      'departments': departments,
      'subject': subject.trim(),
    };
    if (courseId == null) {
      final doc = await _courses().add({...data, 'createdAt': FieldValue.serverTimestamp()});
      return doc.id;
    } else {
      await _courses().doc(courseId).update(data);
      return courseId;
    }
  }
  /// courses/{courseId}/recaps -- ambassador/lecturer-managed, same
  /// manual pattern as course documents themselves. Ordered newest
  /// lecture first. Empty list (not an error) if none exist yet.
  ///
  /// Deliberately sorts client-side rather than using Firestore's
  /// orderBy('lectureNumber') -- a server-side orderBy silently
  /// EXCLUDES any document missing that field entirely from the
  /// results (no error, it just vanishes), which is exactly the kind
  /// of silent-failure trap that cost real time earlier tonight with
  /// the departments field. Fetching everything and sorting here
  /// means a document with a missing/malformed lectureNumber still
  /// shows up (just at the end), instead of disappearing outright.
  static Future<List<RecapEntry>> recapsForCourse(String courseId) async {
    final snap = await _courses().doc(courseId).collection('recaps').get();
    final recaps = snap.docs.map((d) => RecapEntry._fromDoc(d)).toList();
    recaps.sort((a, b) => b.lectureNumber.compareTo(a.lectureNumber));
    return recaps;
  }

  /// Real uploaded materials for this course, from
  /// courses/{courseId}/materials. "Folders" in the UI are derived by
  /// grouping these by their `folder` string client-side -- there's
  /// no separate folders collection, so a folder simply exists once a
  /// material references it, and disappears once none do.
  ///
  /// Same client-side-sort reasoning as recapsForCourse above --
  /// avoids Firestore silently dropping any material missing
  /// uploadedAt. Materials without a timestamp just sort last rather
  /// than vanishing.
  static Future<List<MaterialEntry>> materialsForCourse(String courseId) async {
    final snap = await _courses().doc(courseId).collection('materials').get();
    final materials = snap.docs.map((d) => MaterialEntry._fromDoc(d)).toList();
    materials.sort((a, b) {
      if (a.uploadedAt == null && b.uploadedAt == null) return 0;
      if (a.uploadedAt == null) return 1;
      if (b.uploadedAt == null) return -1;
      return b.uploadedAt!.compareTo(a.uploadedAt!);
    });
    return materials;
  }

  static Color _colorForIndex(int i) {
    final palette = [
      AppColors.chart1, AppColors.chart2, AppColors.chart3,
      AppColors.chart4, AppColors.chart5,
    ];
    return palette[i % palette.length];
  }

  // ============================================================
  // Note: an earlier UI-building pass had a mockSet30Courses() helper
  // here for reviewing the Courses screens before real department
  // data existed. Removed now that courses_page.dart is back on
  // coursesForMyProfile() above.
  // ============================================================

  /// One-time seed for SET30's five confirmed courses, now including
  /// placeholder curriculum and textbook entries so the detail page
  /// has real content to show while testing. Not called automatically
  /// anywhere -- run manually until a real lecturer-creation flow
  /// exists. Safe to re-run: skips any code already present for this
  /// set, so re-running won't duplicate or overwrite what's there.
  ///
  /// Returns how many courses were actually added, so callers (the
  /// empty-state button) can show honest feedback instead of nothing
  /// happening after a tap. Any Firestore error (e.g. a missing
  /// `courses` rule) is left to propagate rather than swallowed, so
  /// the caller can surface it instead of it disappearing silently.
  static Future<int> seedSet30Courses() async {
    const set = 30;
    final seedCourses = [
      {
        'code': 'GNS', 'name': 'General Studies', 'colorIndex': 0, 'departments': const ['ALL'],
        'description': 'Foundational general studies course covering citizenship, ethics, and civic responsibility.',
        'subject': 'General Studies',
        'curriculum': [
          {'title': 'Introduction to Citizenship', 'description': 'What it means to be a responsible member of society.'},
          {'title': 'Ethics and Values', 'description': 'Core ethical principles and their application.'},
        ],
        'textbooks': [
          {'title': 'General Studies for Nigerian Universities', 'author': 'A. Okafor', 'price': '₦3,500'},
        ],
      },
      {
        'code': 'GST', 'name': 'General Studies (Use of English)', 'colorIndex': 1, 'departments': const ['ALL'],
        'description': 'Communication skills, grammar, and academic writing for university-level work.',
        'subject': 'English',
        'curriculum': [
          {'title': 'Grammar Fundamentals', 'description': 'Sentence structure, tense, and agreement.'},
          {'title': 'Academic Writing', 'description': 'Essay structure, referencing, and clarity.'},
        ],
        'textbooks': [
          {'title': 'Use of English for Tertiary Institutions', 'author': 'F. Adeyemi', 'price': '₦2,800'},
        ],
      },
      {
        'code': 'PHY', 'name': 'Physics', 'colorIndex': 2, 'departments': const ['ALL'],
        'description': 'Core physics principles for first-year engineering and science students.',
        'subject': 'Physics',
        'curriculum': [
          {'title': 'Mechanics', 'description': 'Motion, forces, and Newton\'s laws.'},
          {'title': 'Waves and Optics', 'description': 'Wave behavior and the physics of light.'},
        ],
        'textbooks': [
          {'title': 'University Physics', 'author': 'H. Young & R. Freedman', 'price': '₦6,200'},
        ],
      },
      {
        'code': 'MTH', 'name': 'Mathematics', 'colorIndex': 3, 'departments': const ['ALL'],
        'description': 'Calculus and algebra foundations for engineering coursework.',
        'subject': 'Math',
        'curriculum': [
          {'title': 'Differential Calculus', 'description': 'Limits, derivatives, and rates of change.'},
          {'title': 'Linear Algebra Basics', 'description': 'Vectors, matrices, and systems of equations.'},
        ],
        'textbooks': [
          {'title': 'Calculus: Early Transcendentals', 'author': 'J. Stewart', 'price': '₦7,000'},
        ],
      },
      {
        'code': 'MEE', 'name': 'Mechanical Engineering', 'colorIndex': 4, 'departments': const ['ALL'],
        'description': 'Introduction to mechanical engineering principles and design thinking.',
        'subject': 'Mechanical Engineering',
        'curriculum': [
          {'title': 'Engineering Drawing', 'description': 'Technical drawing standards and orthographic projection.'},
          {'title': 'Materials Science Intro', 'description': 'Properties and selection of engineering materials.'},
        ],
        'textbooks': [
          {'title': 'Introduction to Mechanical Engineering', 'author': 'J. Wickert', 'price': '₦5,400'},
        ],
      },
    ];

    final existing = await _courses().where('set', isEqualTo: set).get();
    final existingCodes = existing.docs.map((d) => d.data()['code'] as String?).toSet();

    var added = 0;
    for (final course in seedCourses) {
      if (existingCodes.contains(course['code'])) continue; // already seeded, don't duplicate
      await _courses().add({...course, 'set': set, 'createdAt': FieldValue.serverTimestamp()});
      added++;
    }
    return added;
  }
}