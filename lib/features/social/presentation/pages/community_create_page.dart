// lib/features/social/presentation/pages/community_create_page.dart -- Cleared for rebuild.
// lib/features/social/presentation/pages/community_create_page.dart
//
// New: a hasRoom toggle -- not every community needs a private group
// chat behind its public Handle. The one-community cap applies
// uniformly to everyone right now, no premium gating yet.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/community_service.dart';
import 'community_page.dart';

const List<String> communityCategories = ['academic', 'clubs', 'interests', 'affinity'];
const List<String> communityColors = [
  '#7C3AED', '#C8102E', '#0E7490', '#16A34A',
  '#D97706', '#DB2777', '#4338CA', '#15803D',
];

class CommunityCreatePage extends StatefulWidget {
  const CommunityCreatePage({super.key});

  @override
  State<CommunityCreatePage> createState() => _CommunityCreatePageState();
}

class _CommunityCreatePageState extends State<CommunityCreatePage> {
  final _nameCtrl = TextEditingController();
  final _handleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _category = communityCategories.first;
  String _color = communityColors.first;
  bool _hasRoom = true;
  bool _creating = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _handleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    if (_nameCtrl.text.trim().isEmpty || _handleCtrl.text.trim().isEmpty) return;
    setState(() => _creating = true);
    try {
      final id = await CommunityService.createCommunity(
        name: _nameCtrl.text.trim(),
        handle: _handleCtrl.text.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ''),
        description: _descCtrl.text.trim(),
        color: _color,
        category: _category,
        hasRoom: _hasRoom,
      );
      if (!mounted) return;
      final navigator = Navigator.of(context);
      navigator.pop();
      navigator.push(MaterialPageRoute(builder: (_) => CommunityPage(communityId: id)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString().replaceFirst('Exception: ', ''), style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ));
      setState(() => _creating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('New community', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            Text('NAME', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameCtrl,
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'e.g. Gooners FUTA',
                filled: true, fillColor: AppColors.card,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.border)),
              ),
            ),
            const SizedBox(height: 18),
            Text('HANDLE', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
            const SizedBox(height: 8),
            TextField(
              controller: _handleCtrl,
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'goonersfuta',
                prefixText: '@',
                filled: true, fillColor: AppColors.card,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.border)),
              ),
            ),
            const SizedBox(height: 18),
            Text('DESCRIPTION', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
            const SizedBox(height: 8),
            TextField(
              controller: _descCtrl,
              maxLines: 3,
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'What is this community about?',
                filled: true, fillColor: AppColors.card,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.border)),
              ),
            ),
            const SizedBox(height: 18),
            Text('CATEGORY', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: communityCategories.map((cat) {
              final selected = cat == _category;
              return GestureDetector(
                onTap: () => setState(() => _category = cat),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.accent : AppColors.card,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: selected ? AppColors.accent : AppColors.border),
                  ),
                  child: Text(cat[0].toUpperCase() + cat.substring(1),
                    style: GoogleFonts.dmSans(fontSize: 12.5, fontWeight: FontWeight.w600, color: selected ? Colors.white : AppColors.textPrimary)),
                ),
              );
            }).toList()),
            const SizedBox(height: 18),
            Text('COLOR', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
            const SizedBox(height: 8),
            Wrap(spacing: 10, runSpacing: 10, children: communityColors.map((hex) {
              final selected = hex == _color;
              final color = Color(int.parse(hex.replaceFirst('#', '0xFF')));
              return GestureDetector(
                onTap: () => setState(() => _color = hex),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: color, shape: BoxShape.circle,
                    border: selected ? Border.all(color: AppColors.textPrimary, width: 2.5) : null,
                  ),
                  child: selected ? const Icon(Icons.check_rounded, color: Colors.white, size: 18) : null,
                ),
              );
            }).toList()),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Add a private room', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 2),
                    Text('A group chat for approved members, separate from the public page', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                  ]),
                ),
                Switch(value: _hasRoom, onChanged: (v) => setState(() => _hasRoom = v), activeColor: AppColors.accent),
              ]),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _creating ? null : _create,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent, foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: _creating
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text('Create community', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}