// lib/features/library/presentation/pages/library_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/premium_service.dart';
import '../../../../core/utils/paywall_helper.dart';
import 'pdf_viewer_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  String _selectedCourse = 'All';
  List<Map<String, dynamic>> _allPdfs = [];
  List<Map<String, dynamic>> _filtered = [];
  List<String> _courses = ['All'];
  bool _loading = true;
  String? _error;
  int _monthlyOpened = 0;
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadPdfs();
    _loadMonthlyCount();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadMonthlyCount() async {
    final prefs = await SharedPreferences.getInstance();
    final month = DateTime.now().toIso8601String().substring(0, 7);
    setState(() => _monthlyOpened = prefs.getInt('pdf_opened_$month') ?? 0);
  }

  Future<void> _incrementMonthlyCount() async {
    final prefs = await SharedPreferences.getInstance();
    final month = DateTime.now().toIso8601String().substring(0, 7);
    final newCount = _monthlyOpened + 1;
    await prefs.setInt('pdf_opened_$month', newCount);
    setState(() => _monthlyOpened = newCount);
  }

  Future<void> _loadPdfs() async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('library')
          .orderBy('uploadedAt', descending: true)
          .get();

      final pdfs = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();

      final courseSet = <String>{'All'};
      for (final pdf in pdfs) {
        final tag = pdf['courseTag'] as String? ?? '';
        if (tag.isNotEmpty) courseSet.add(tag);
      }

      if (!mounted) return;
      setState(() {
        _allPdfs = pdfs;
        _courses = courseSet.toList();
        _loading = false;
        _applyFilters();
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load library: $e';
        _loading = false;
      });
    }
  }

  void _applyFilters() {
    _filtered = _allPdfs.where((p) {
      final matchesCourse = _selectedCourse == 'All' ||
          p['courseTag'] == _selectedCourse;
      final q = _searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty ||
          (p['title'] as String? ?? '').toLowerCase().contains(q) ||
          (p['topic'] as String? ?? '').toLowerCase().contains(q) ||
          (p['description'] as String? ?? '').toLowerCase().contains(q);
      return matchesCourse && matchesSearch;
    }).toList();
  }

  void _filterByCourse(String course) {
    setState(() {
      _selectedCourse = course;
      _applyFilters();
    });
  }

  Future<void> _openPdf(Map<String, dynamic> pdf) async {
    if (!PremiumService.isPro) {
      final limit = PremiumService.ebookAccessPerMonth;
      if (_monthlyOpened >= limit) {
        showPaywall(context,
          triggerReason:
            'You\'ve opened $limit PDFs this month. Upgrade to Pro for unlimited access.',
          initialTier: 2,
        );
        return;
      }
    }
    await _incrementMonthlyCount();
    if (!mounted) return;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => PdfViewerPage(
        title: pdf['title'] as String? ?? 'PDF',
        pdfUrl: pdf['pdfUrl'] as String? ?? '',
        courseTag: pdf['courseTag'] as String? ?? '',
      ),
    ));
  }

  String _formatSize(int? bytes) {
    if (bytes == null) return '';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final limit = PremiumService.ebookAccessPerMonth;
    final isLimited = !PremiumService.isPro;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
              child: Row(children: [
                Text('Library', style: GoogleFonts.dmSans(
                  fontSize: 22, fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
                const Spacer(),
                if (isLimited)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accentSurface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.accent.withOpacity(0.4)),
                    ),
                    child: Text('$_monthlyOpened/$limit this month',
                      style: GoogleFonts.dmSans(
                        fontSize: 11, color: AppColors.accentLight)),
                  ),
              ]),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (q) => setState(() {
                  _searchQuery = q;
                  _applyFilters();
                }),
                style: GoogleFonts.dmSans(
                  fontSize: 14, color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search PDFs...',
                  hintStyle: GoogleFonts.dmSans(
                    fontSize: 13, color: AppColors.textDisabled),
                  prefixIcon: Icon(Icons.search_rounded,
                    color: AppColors.textTertiary, size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? GestureDetector(
                          onTap: () => setState(() {
                            _searchCtrl.clear();
                            _searchQuery = '';
                            _applyFilters();
                          }),
                          child: Icon(Icons.close_rounded,
                            color: AppColors.textTertiary, size: 18),
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.accent),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                ),
              ),
            ),

            // Course filter pills
            if (_courses.length > 1)
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _courses.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final course = _courses[i];
                    final selected = _selectedCourse == course;
                    return GestureDetector(
                      onTap: () => _filterByCourse(course),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.accent : Colors.white12,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selected
                                ? AppColors.accent : Colors.white24),
                        ),
                        child: Text(course, style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: selected
                              ? FontWeight.w600 : FontWeight.w400,
                          color: Colors.white)),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 12),

            // Content
            Expanded(child: _buildContent()),
          ]),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.accent));
    }

    if (_error != null) {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.wifi_off_rounded,
            color: AppColors.textTertiary, size: 40),
          const SizedBox(height: 12),
          Text(_error!, style: GoogleFonts.dmSans(
            color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          TextButton(onPressed: _loadPdfs, child: const Text('Retry')),
        ]),
      );
    }

    if (_filtered.isEmpty) {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('📚', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty ? 'No results for "$_searchQuery"' : 'No PDFs yet',
            style: GoogleFonts.dmSans(
              fontSize: 16, fontWeight: FontWeight.w600,
              color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try a different search term'
                : 'Check back soon for study materials',
            style: GoogleFonts.dmSans(
              fontSize: 13, color: AppColors.textTertiary)),
        ]),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      itemCount: _filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final pdf = _filtered[i];
        final isLocked = !PremiumService.isPro &&
            _monthlyOpened >= PremiumService.ebookAccessPerMonth;

        return GestureDetector(
          onTap: () => _openPdf(pdf),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(children: [
              // PDF icon
              Container(
                width: 48, height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A1F0A),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF854F0B)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.picture_as_pdf_rounded,
                      color: Color(0xFFEF9F27), size: 22),
                    Text('PDF', style: GoogleFonts.dmSans(
                      fontSize: 8, fontWeight: FontWeight.w700,
                      color: const Color(0xFFEF9F27))),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pdf['title'] as String? ?? 'Untitled',
                    style: GoogleFonts.dmSans(
                      fontSize: 14, fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  if ((pdf['topic'] as String? ?? '').isNotEmpty)
                    Text(pdf['topic'] as String,
                      style: GoogleFonts.dmSans(
                        fontSize: 12, color: AppColors.textSecondary),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(children: [
                    if ((pdf['courseTag'] as String? ?? '').isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.accentSurface,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(pdf['courseTag'] as String,
                          style: GoogleFonts.dmSans(
                            fontSize: 10, color: AppColors.accentLight)),
                      ),
                      const SizedBox(width: 8),
                    ],
                    if ((pdf['fileSize'] as int?) != null)
                      Text(_formatSize(pdf['fileSize'] as int?),
                        style: GoogleFonts.dmSans(
                          fontSize: 11, color: AppColors.textTertiary)),
                  ]),
                  if ((pdf['description'] as String? ?? '').isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(pdf['description'] as String,
                      style: GoogleFonts.dmSans(
                        fontSize: 11, color: AppColors.textTertiary,
                        height: 1.4),
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ],
              )),

              const SizedBox(width: 8),
              Icon(
                isLocked ? Icons.lock_rounded : Icons.arrow_forward_ios_rounded,
                size: isLocked ? 18 : 14,
                color: isLocked
                    ? AppColors.textDisabled : AppColors.textTertiary,
              ),
            ]),
          ),
        );
      },
    );
  }
}