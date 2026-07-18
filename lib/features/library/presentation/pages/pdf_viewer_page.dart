// lib/features/library/presentation/pages/pdf_viewer_page.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/study_time_service.dart';

class PdfViewerPage extends StatefulWidget {
  final String title;
  final String pdfUrl;
  final String courseTag;

  const PdfViewerPage({
    super.key,
    required this.title,
    required this.pdfUrl,
    required this.courseTag,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String? _localPath;
  bool _loading = true;
  String? _error;
  int _currentPage = 0;
  int _totalPages = 0;
  PDFViewController? _pdfController;

  @override
  void initState() {
    super.initState();
    StudyTimeService.startSession();
    _downloadPdf();
  }

  @override
  void dispose() {
    StudyTimeService.endSession();
    super.dispose();
  }

  Future<void> _downloadPdf() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download PDF');
      }
      final dir = await getTemporaryDirectory();
      final file = File(
        '${dir.path}/${widget.title.replaceAll(' ', '_')}.pdf');
      await file.writeAsBytes(response.bodyBytes);
      if (!mounted) return;
      setState(() {
        _localPath = file.path;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load PDF. Check your connection.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          bottom: false,
          child: Column(children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              color: AppColors.background,
              child: Row(children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: AppColors.textTertiary),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: GoogleFonts.dmSans(
                      fontSize: 14, fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                    if (widget.courseTag.isNotEmpty)
                      Text(widget.courseTag, style: GoogleFonts.dmSans(
                        fontSize: 11, color: AppColors.textTertiary)),
                  ],
                )),
                if (_totalPages > 0)
                  Text('${_currentPage + 1} / $_totalPages',
                    style: GoogleFonts.dmSans(
                      fontSize: 12, color: AppColors.textTertiary)),
              ]),
            ),

            // PDF content
            Expanded(child: _buildContent()),

            // Page navigation bar
            if (_totalPages > 1 && !_loading && _error == null)
              Container(
                color: AppColors.background,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 8,
                  top: 8, left: 16, right: 16,
                ),
                child: Row(children: [
                  IconButton(
                    onPressed: _currentPage > 0
                        ? () => _pdfController?.setPage(_currentPage - 1)
                        : null,
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: _currentPage > 0
                        ? AppColors.accent : AppColors.textDisabled,
                  ),
                  Expanded(child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6),
                      trackHeight: 3,
                    ),
                    child: Slider(
                      value: _currentPage.toDouble(),
                      min: 0,
                      max: (_totalPages - 1).toDouble(),
                      activeColor: AppColors.accent,
                      inactiveColor: AppColors.border,
                      onChanged: (v) =>
                          _pdfController?.setPage(v.round()),
                    ),
                  )),
                  IconButton(
                    onPressed: _currentPage < _totalPages - 1
                        ? () => _pdfController?.setPage(_currentPage + 1)
                        : null,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    color: _currentPage < _totalPages - 1
                        ? AppColors.accent : AppColors.textDisabled,
                  ),
                ]),
              ),
          ]),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_loading) {
      return Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.accent),
          const SizedBox(height: 16),
          Text('Loading PDF...', style: GoogleFonts.dmSans(
            fontSize: 13, color: AppColors.textTertiary)),
        ],
      ));
    }

    if (_error != null) {
      return Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off_rounded,
            color: AppColors.textTertiary, size: 40),
          const SizedBox(height: 12),
          Text(_error!, style: GoogleFonts.dmSans(
            color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              setState(() { _loading = true; _error = null; });
              _downloadPdf();
            },
            child: const Text('Retry'),
          ),
        ],
      ));
    }

    return PDFView(
      filePath: _localPath!,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: true,
      pageFling: true,
      backgroundColor: Colors.grey[900]!,
      onRender: (pages) {
        if (mounted) setState(() => _totalPages = pages ?? 0);
      },
      onViewCreated: (controller) {
        _pdfController = controller;
      },
      onPageChanged: (page, total) {
        if (mounted) {
          setState(() {
            _currentPage = page ?? 0;
            _totalPages = total ?? 0;
          });
        }
      },
      onError: (error) {
        if (mounted) setState(() => _error = 'Failed to render PDF.');
      },
    );
  }
}