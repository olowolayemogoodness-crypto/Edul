// lib/features/premium/presentation/pages/paywall_page.dart
//
// Full-screen paywall. Shows Free/Plus/Pro tiers, swipeable via a
// PageView. Pass a [triggerReason] to show a contextual banner
// explaining why the paywall appeared (e.g. "You've hit your daily
// question limit"). Leave null when opening from Profile.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/services/premium_service.dart';

class PaywallPage extends StatefulWidget {
  final String? triggerReason;
  final int initialTier; // 0=free, 1=plus, 2=pro

  const PaywallPage({
    super.key,
    this.triggerReason,
    this.initialTier = 1,
  });

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  late final PageController _pageCtrl;
  int _currentPage = 1;
  bool _loading = false;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialTier;
    _pageCtrl = PageController(initialPage: widget.initialTier);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  Future<void> _purchase(bool isPro) async {
    setState(() { _loading = true; _errorMsg = null; });
    try {
      final tier = isPro
          ? await PremiumService.purchasePro()
          : await PremiumService.purchasePlus();
      if (!mounted) return;
      if (tier != null && tier != PremiumTier.free) {
        Navigator.pop(context, tier);
      }
    } catch (e) {
      setState(() => _errorMsg = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _restore() async {
    setState(() { _loading = true; _errorMsg = null; });
    try {
      final tier = await PremiumService.restorePurchases();
      if (!mounted) return;
      if (tier != PremiumTier.free) {
        Navigator.pop(context, tier);
      } else {
        setState(() => _errorMsg = 'No previous purchases found.');
      }
    } catch (_) {
      setState(() => _errorMsg = 'Restore failed. Please try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0F),
      body: SafeArea(
        child: Column(children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close_rounded, color: Color(0xFF6B6B74), size: 22),
              ),
              const Spacer(),
              Text('Choose a plan', style: GoogleFonts.dmSans(
                fontSize: 15, fontWeight: FontWeight.w600,
                color: const Color(0xFFF5F5F7))),
              const Spacer(),
              const SizedBox(width: 22),
            ]),
          ),

          // Tab pills
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(children: [
              _TabPill(label: 'Free', index: 0, current: _currentPage,
                onTap: () => _goTo(0)),
              const SizedBox(width: 8),
              _TabPill(label: 'Plus', index: 1, current: _currentPage,
                onTap: () => _goTo(1)),
              const SizedBox(width: 8),
              _TabPill(label: 'Pro', index: 2, current: _currentPage,
                onTap: () => _goTo(2), isPro: true),
            ]),
          ),

          // Pages
          Expanded(
            child: PageView(
              controller: _pageCtrl,
              onPageChanged: (i) => setState(() => _currentPage = i),
              children: [
                _FreeTier(onUpgrade: () => _goTo(1)),
                _PlusTier(
                  triggerReason: widget.triggerReason,
                  loading: _loading,
                  onPurchase: () => _purchase(false),
                  onRestore: _restore,
                ),
                _ProTier(
                  loading: _loading,
                  onPurchase: () => _purchase(true),
                  onRestore: _restore,
                ),
              ],
            ),
          ),

          // Dot indicators
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ...List.generate(3, (i) => GestureDetector(
                onTap: () => _goTo(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _currentPage ? 16 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: i == _currentPage
                        ? (i == 2 ? const Color(0xFF4338CA) : const Color(0xFF7C3AED))
                        : const Color(0xFF2A2A32),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              )),
            ]),
          ),

          // Error
          if (_errorMsg != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(_errorMsg!, style: GoogleFonts.dmSans(
                fontSize: 12, color: const Color(0xFFEF4444))),
            ),
        ]),
      ),
    );
  }

  void _goTo(int i) {
    _pageCtrl.animateToPage(i,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab pill
// ─────────────────────────────────────────────────────────────────────────────
class _TabPill extends StatelessWidget {
  final String label;
  final int index, current;
  final VoidCallback onTap;
  final bool isPro;

  const _TabPill({
    required this.label, required this.index, required this.current,
    required this.onTap, this.isPro = false,
  });

  @override
  Widget build(BuildContext context) {
    final active = index == current;
    final activeColor = isPro ? const Color(0xFF4338CA) : const Color(0xFF7C3AED);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: active ? activeColor : Colors.transparent,
            border: Border.all(
              color: active ? activeColor : const Color(0xFF2A2A32)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(child: Text(label, style: GoogleFonts.dmSans(
            fontSize: 13, fontWeight: FontWeight.w500,
            color: active ? Colors.white : const Color(0xFF6B6B74)))),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Feature row
// ─────────────────────────────────────────────────────────────────────────────
class _Feat extends StatelessWidget {
  final String text;
  final bool included;

  const _Feat(this.text, {this.included = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 18, height: 18,
          margin: const EdgeInsets.only(top: 1),
          decoration: BoxDecoration(
            color: included ? const Color(0xFF0F2A1A) : const Color(0xFF1A1A1F),
            shape: BoxShape.circle,
          ),
          child: Icon(
            included ? Icons.check_rounded : Icons.close_rounded,
            size: 11,
            color: included ? const Color(0xFF22C55E) : const Color(0xFF444444),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: GoogleFonts.dmSans(
          fontSize: 13, height: 1.4,
          color: included ? const Color(0xFFAAAAAF) : const Color(0xFF444444)))),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CTA button
// ─────────────────────────────────────────────────────────────────────────────
class _CTAButton extends StatelessWidget {
  final String label;
  final Color color;
  final bool loading;
  final VoidCallback onTap;

  const _CTAButton({
    required this.label, required this.color,
    required this.loading, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: loading
              ? const SizedBox(width: 20, height: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Text(label, style: GoogleFonts.dmSans(
                  fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Free tier
// ─────────────────────────────────────────────────────────────────────────────
class _FreeTier extends StatelessWidget {
  final VoidCallback onUpgrade;
  const _FreeTier({required this.onUpgrade});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1F),
            border: Border.all(color: const Color(0xFF2A2A32)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('Current plan', style: GoogleFonts.dmSans(
            fontSize: 11, color: const Color(0xFF6B6B74))),
        ),
        const SizedBox(height: 12),
        Text('₦0', style: GoogleFonts.dmSans(
          fontSize: 40, fontWeight: FontWeight.w700,
          color: const Color(0xFFF5F5F7))),
        Text('Always free', style: GoogleFonts.dmSans(
          fontSize: 12, color: const Color(0xFF6B6B74))),
        const SizedBox(height: 20),
        const _Feat('20 quiz questions per day'),
        const _Feat('Unlimited Insights videos'),
        const _Feat('AI Tutor text — 20 min/day (limited access)'),
        const _Feat('5 auto-generated PDFs/month'),
        const _Feat('3 ebooks/month'),
        const _Feat('Focus Mode — 3 sessions total'),
        const _Feat('Learning map — ads before and after each lesson'),
        const _Feat('Text posts on social feed'),
        Container(height: 1, color: const Color(0xFF2A2A32), margin: const EdgeInsets.symmetric(vertical: 12)),
        const _Feat('No ads', included: false),
        const _Feat('Image or video posts', included: false),
        const _Feat('Unlimited AI Tutor', included: false),
        const _Feat('More PDFs and ebooks', included: false),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: onUpgrade,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1F),
              border: Border.all(color: const Color(0xFF2A2A32)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: Text('Your current plan',
              style: GoogleFonts.dmSans(fontSize: 15,
                fontWeight: FontWeight.w500, color: const Color(0xFF6B6B74)))),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Plus tier
// ─────────────────────────────────────────────────────────────────────────────
class _PlusTier extends StatelessWidget {
  final String? triggerReason;
  final bool loading;
  final VoidCallback onPurchase, onRestore;

  const _PlusTier({
    this.triggerReason, required this.loading,
    required this.onPurchase, required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF2D1B69),
              border: Border.all(color: const Color(0xFF7C3AED)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.bolt_rounded, size: 13, color: Color(0xFF9F67F5)),
              const SizedBox(width: 4),
              Text('Plus', style: GoogleFonts.dmSans(
                fontSize: 11, fontWeight: FontWeight.w500,
                color: const Color(0xFF9F67F5))),
            ]),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF7C3AED),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Most popular', style: GoogleFonts.dmSans(
              fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white)),
          ),
        ]),
        const SizedBox(height: 12),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('\$2', style: GoogleFonts.dmSans(
            fontSize: 40, fontWeight: FontWeight.w700,
            color: const Color(0xFFF5F5F7))),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text('/mo', style: GoogleFonts.dmSans(
              fontSize: 14, color: const Color(0xFF6B6B74))),
          ),
        ]),
        Text('Less than ₦100/day · cancel anytime', style: GoogleFonts.dmSans(
          fontSize: 12, color: const Color(0xFF6B6B74))),

        if (triggerReason != null) ...[
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2A1F0A),
              border: Border.all(color: const Color(0xFF854F0B)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              const Icon(Icons.warning_amber_rounded,
                size: 16, color: Color(0xFFEF9F27)),
              const SizedBox(width: 8),
              Expanded(child: Text(triggerReason!, style: GoogleFonts.dmSans(
                fontSize: 12, color: const Color(0xFFEF9F27), height: 1.4))),
            ]),
          ),
        ],

        const SizedBox(height: 18),
        const _Feat('200 quiz questions/month, then \$1 top-up'),
        const _Feat('No ads on learning map or anywhere'),
        const _Feat('Unlimited AI Tutor text — no time limit'),
        const _Feat('20 auto-generated PDFs/month'),
        const _Feat('3 ebooks/month'),
        const _Feat('Focus Mode — 5 sessions/month, cancel up to 5×/month'),
        const _Feat('Image posts: 3 images/post, 10 posts/month'),
        const _Feat('Text posts: unlimited'),
        const _Feat('Unlimited hearts'),
        const _Feat('Offline reel downloads'),
        Container(height: 1, color: const Color(0xFF2A2A32), margin: const EdgeInsets.symmetric(vertical: 12)),
        const _Feat('Video posts on social feed', included: false),
        const _Feat('Unlimited ebooks and PDFs', included: false),
        const _Feat('Priority AI Tutor model', included: false),
        const _Feat('Cancel focus anytime (up to 5×/week)', included: false),
        const SizedBox(height: 20),
        _CTAButton(
          label: 'Get Plus — \$2/mo',
          color: const Color(0xFF7C3AED),
          loading: loading,
          onTap: onPurchase,
        ),
        const SizedBox(height: 8),
        Center(child: GestureDetector(
          onTap: onRestore,
          child: Text('Restore purchases', style: GoogleFonts.dmSans(
            fontSize: 12, color: const Color(0xFF444444))),
        )),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pro tier
// ─────────────────────────────────────────────────────────────────────────────
class _ProTier extends StatelessWidget {
  final bool loading;
  final VoidCallback onPurchase, onRestore;

  const _ProTier({
    required this.loading,
    required this.onPurchase, required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF1e1b4b),
            border: Border.all(color: const Color(0xFF4338CA)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.rocket_launch_rounded,
              size: 13, color: Color(0xFFa5b4fc)),
            const SizedBox(width: 4),
            Text('Pro', style: GoogleFonts.dmSans(
              fontSize: 11, fontWeight: FontWeight.w500,
              color: const Color(0xFFa5b4fc))),
          ]),
        ),
        const SizedBox(height: 12),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('\$5', style: GoogleFonts.dmSans(
            fontSize: 40, fontWeight: FontWeight.w700,
            color: const Color(0xFFF5F5F7))),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text('/mo', style: GoogleFonts.dmSans(
              fontSize: 14, color: const Color(0xFF6B6B74))),
          ),
        ]),
        Text('Everything in Plus, and more', style: GoogleFonts.dmSans(
          fontSize: 12, color: const Color(0xFF6B6B74))),
        const SizedBox(height: 18),
        const _Feat('Unlimited quiz questions'),
        const _Feat('No ads on learning map or anywhere'),
        const _Feat('Unlimited AI Tutor — upgraded model (gpt-oss-120b)'),
        const _Feat('Unlimited auto-generated PDFs'),
        const _Feat('Unlimited ebooks and PDFs'),
        const _Feat('Focus Mode — unlimited sessions, cancel up to 5×/week'),
        const _Feat('Image posts: 5 images/post, 30 posts/month'),
        const _Feat('Video posts: 60s max, 20 videos/month'),
        const _Feat('Text posts: unlimited'),
        const _Feat('Unlimited hearts'),
        const _Feat('Offline reel downloads'),
        const _Feat('Priority support'),
        const SizedBox(height: 20),
        _CTAButton(
          label: 'Get Pro — \$5/mo',
          color: const Color(0xFF4338CA),
          loading: loading,
          onTap: onPurchase,
        ),
        const SizedBox(height: 8),
        Center(child: GestureDetector(
          onTap: onRestore,
          child: Text('Restore purchases', style: GoogleFonts.dmSans(
            fontSize: 12, color: const Color(0xFF444444))),
        )),
      ]),
    );
  }
}