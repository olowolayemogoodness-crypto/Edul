// lib/features/duel/presentation/pages/duel_setup_page.dart
//
// Step 1 of creating a duel: pick who to challenge and which course.
// Opponent search reuses the exact same bounded client-side-filter
// pattern already used for social search (Firestore has no native text
// search, so this fetches a batch and filters locally — fine at this
// scale, see social_feed_page.dart's _searchUsers for the precedent).

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/duel_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/data/course_catalog/subjects_data.dart';
import '../../../quiz/data/topic_question_source.dart';
import 'duel_play_page.dart';

const Map<String, String> _courseEmoji = {
  'MTS 102': '📐', 'MTS 104': '📊', 'PHY 102': '⚡', 'CHE 102': '⚗️',
  'BIO 102': '🧬', 'GNS 106': '📖', 'CSC 102': '💻', 'COS 102': '🖥️',
};

class DuelSetupPage extends StatefulWidget {
  const DuelSetupPage({super.key});

  @override
  State<DuelSetupPage> createState() => _DuelSetupPageState();
}

class _DuelSetupPageState extends State<DuelSetupPage> {
  final _searchCtrl = TextEditingController();
  List<Map<String, dynamic>> _results = [];
  Map<String, dynamic>? _selectedOpponent;
  String? _selectedCourse;
  bool _searching = false;

  late final List<String> _availableCourses = subjectsData.keys
      .where((k) => TopicQuestionSource.hasQuestionBank(k))
      .toList();

  Future<void> _search(String q) async {
    if (q.trim().isEmpty) {
      setState(() => _results = []);
      return;
    }
    setState(() => _searching = true);
    final myUid = UserService.uid;
    final snap = await FirebaseFirestore.instance.collection('users').limit(200).get();
    final matches = snap.docs
        .map((d) => {'uid': d.id, ...d.data()})
        .where((u) =>
            u['uid'] != myUid &&
            (u['displayName'] as String? ?? '').toLowerCase().contains(q.toLowerCase()))
        .take(15)
        .toList();
    if (!mounted) return;
    setState(() {
      _results = matches;
      _searching = false;
    });
  }

  Future<void> _startDuel() async {
    if (_selectedOpponent == null || _selectedCourse == null) return;
    final questions = DuelService.drawQuestions(_selectedCourse!);
    if (questions.isEmpty) return;

    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => DuelPlayPage(
        courseKey: _selectedCourse!,
        questions: questions,
        opponentUid: _selectedOpponent!['uid'] as String,
        opponentName: _selectedOpponent!['displayName'] as String? ?? 'Someone',
      ),
    ));

    if (result != null && mounted) {
      Navigator.of(context).pop(); // back to Compete tab, duel now pending
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('New Duel', style: GoogleFonts.dmSans(
          fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('1. Who are you challenging?', style: GoogleFonts.dmSans(
              fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 8),

            if (_selectedOpponent == null) ...[
              TextField(
                controller: _searchCtrl,
                onChanged: _search,
                style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search by name…',
                  hintStyle: GoogleFonts.dmSans(color: AppColors.textTertiary),
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true, fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 8),
              if (_searching) const Center(child: CircularProgressIndicator()),
              ..._results.map((u) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppColors.accentSurface,
                  child: Text(((u['displayName'] as String? ?? 'U').isNotEmpty
                      ? (u['displayName'] as String)[0].toUpperCase() : 'U'),
                    style: TextStyle(color: AppColors.accentLight, fontWeight: FontWeight.w700)),
                ),
                title: Text(u['displayName'] as String? ?? 'User',
                  style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary)),
                subtitle: (u['university'] as String?)?.isNotEmpty == true
                    ? Text(u['university'] as String, style: GoogleFonts.dmSans(
                        fontSize: 11, color: AppColors.textTertiary))
                    : null,
                onTap: () => setState(() => _selectedOpponent = u),
              )),
            ] else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.accentSurface,
                  border: Border.all(color: AppColors.accent),
                  borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  CircleAvatar(
                    backgroundColor: AppColors.accent,
                    child: Text(((_selectedOpponent!['displayName'] as String? ?? 'U').isNotEmpty
                        ? (_selectedOpponent!['displayName'] as String)[0].toUpperCase() : 'U'),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(_selectedOpponent!['displayName'] as String? ?? 'User',
                    style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary))),
                  GestureDetector(
                    onTap: () => setState(() => _selectedOpponent = null),
                    child: Icon(Icons.close_rounded, color: AppColors.textTertiary, size: 18)),
                ]),
              ),

            const SizedBox(height: 24),
            Text('2. Pick a course', style: GoogleFonts.dmSans(
              fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: _availableCourses.map((key) {
              final selected = _selectedCourse == key;
              return GestureDetector(
                onTap: () => setState(() => _selectedCourse = key),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.accent : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: selected ? AppColors.accent : AppColors.border)),
                  child: Text('${_courseEmoji[key] ?? '📚'} $key', style: GoogleFonts.dmSans(
                    fontSize: 12, fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : AppColors.textSecondary)),
                ),
              );
            }).toList()),

            const Spacer(),
            SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: (_selectedOpponent != null && _selectedCourse != null)
                  ? _startDuel : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('⚔️ Start Duel', style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w600, color: Colors.white)),
            )),
          ]),
        ),
      ),
    );
  }
}