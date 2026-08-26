// lib/features/campaign/presentation/pages/campaign_application_page.dart
//
// One category, locked in at application time -- matches the fairness
// reasoning discussed: a voter judging "poetry" shouldn't also be
// seeing that same person competing in three other lanes. Rules
// agreement is the actual thing that turns "posting" into "applying"
// -- an explicit, on-record commitment, not just an assumption.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/campaign_service.dart';

class CampaignApplicationPage extends StatefulWidget {
  final String campaignId;
  final String campaignName;
  const CampaignApplicationPage({super.key, required this.campaignId, required this.campaignName});

  @override
  State<CampaignApplicationPage> createState() => _CampaignApplicationPageState();
}

class _CampaignApplicationPageState extends State<CampaignApplicationPage> {
  static const _categories = [
    ('poetry', 'Poetry & spoken word', Icons.menu_book_outlined),
    ('comedy', 'Comedy & skits', Icons.theater_comedy_outlined),
    ('storytelling', 'Storytelling', Icons.auto_stories_outlined),
    ('photography', 'Day-in-the-life & photography', Icons.camera_alt_outlined),
    ('study', 'Study creator', Icons.school_outlined),
  ];

  String? _selectedCategory;
  bool _agreedToRules = false;
  bool _submitting = false;

  Future<void> _submit() async {
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pick a category first')));
      return;
    }
    if (!_agreedToRules) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You need to agree to the rules to apply')));
      return;
    }
    setState(() => _submitting = true);
    try {
      final result = await CampaignService.apply(campaignId: widget.campaignId, category: _selectedCategory!);
      if (!mounted) return;
      switch (result) {
        case ApplyResult.success:
          HapticFeedback.lightImpact();
          break;
        case ApplyResult.alreadyApplied:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You\'ve already applied')));
          break;
        case ApplyResult.notSignedIn:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in to apply')));
          break;
      }
    } catch (e) {
      debugPrint('[CampaignApplication] Apply failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Could not submit your application'),
          action: SnackBarAction(label: 'Try again', onPressed: _submit),
        ));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        title: Text('Apply — ${widget.campaignName}', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ),
      body: StreamBuilder<Map<String, dynamic>?>(
        stream: CampaignService.myApplication(widget.campaignId),
        builder: (context, snap) {
          final existing = snap.data;
          if (existing != null) {
            return _AlreadyAppliedView(application: existing);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Pick your category', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 4),
              Text('One only — you can\'t switch or apply to more than one.',
                style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
              const SizedBox(height: 14),

              ..._categories.map((c) {
                final (id, label, icon) = c;
                final selected = _selectedCategory == id;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = id),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.accentSurface : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: selected ? AppColors.accent : AppColors.border, width: selected ? 1.5 : 1),
                    ),
                    child: Row(children: [
                      Icon(icon, color: selected ? AppColors.accent : AppColors.textSecondary, size: 22),
                      const SizedBox(width: 12),
                      Expanded(child: Text(label, style: GoogleFonts.dmSans(
                        fontSize: 14, fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                        color: selected ? AppColors.accent : AppColors.textPrimary))),
                      if (selected) Icon(Icons.check_circle_rounded, color: AppColors.accent, size: 20),
                    ]),
                  ),
                );
              }),

              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => setState(() => _agreedToRules = !_agreedToRules),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Checkbox(
                    value: _agreedToRules,
                    onChanged: (v) => setState(() => _agreedToRules = v ?? false),
                    activeColor: AppColors.accent,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        'I confirm this is my own original content, I\'m not competing in more than one category, and I understand I\'ll be pulled from the challenge if I don\'t post consistently through the full submission window.',
                        style: GoogleFonts.dmSans(fontSize: 12.5, color: AppColors.textSecondary, height: 1.4),
                      ),
                    ),
                  ),
                ]),
              ),

              const SizedBox(height: 20),
              SizedBox(width: double.infinity, child: ElevatedButton(
                onPressed: _submitting ? null : _submit,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: _submitting
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text('Submit application', style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
              )),
            ]),
          );
        },
      ),
    );
  }
}

class _AlreadyAppliedView extends StatelessWidget {
  final Map<String, dynamic> application;
  const _AlreadyAppliedView({required this.application});

  @override
  Widget build(BuildContext context) {
    final category = application['category'] as String? ?? '';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.check_circle_rounded, color: AppColors.success, size: 44),
          const SizedBox(height: 14),
          Text('You\'re in', style: GoogleFonts.dmSans(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text('Applied in: $category', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text('You\'ll be notified once submissions and voting open.',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
        ]),
      ),
    );
  }
}