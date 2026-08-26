// lib/features/duel/presentation/pages/duel_invite_link_page.dart
//
// Landing screen for a shared duel-invite link
// (edulink001.app/duel-invite/{inviteId}). Anyone who opens it and is
// signed in can land here and accept -- unlike the friend-picker flow,
// this doesn't require already knowing the other person's uid ahead of
// time, so it works for sharing outside the app entirely (WhatsApp, a
// group chat, wherever).
//
// NOTE: this screen only handles the IN-APP side of deep linking (the
// route itself, and what to show once you're on it). Making the actual
// link open the app when tapped on a phone that doesn't have it open
// yet requires Android App Links / iOS Universal Links -- domain
// verification files (assetlinks.json / apple-app-site-association)
// hosted at the real domain, plus Play Console / App Store Connect
// configuration. That's not done yet; this screen is ready the moment
// it is.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/duel_service.dart';
import 'duel_play_page.dart';

class DuelInviteLinkPage extends StatefulWidget {
  final String inviteId;
  const DuelInviteLinkPage({super.key, required this.inviteId});

  @override
  State<DuelInviteLinkPage> createState() => _DuelInviteLinkPageState();
}

class _DuelInviteLinkPageState extends State<DuelInviteLinkPage> {
  Map<String, dynamic>? _invite;
  bool _loading = true;
  bool _accepting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final invite = await DuelService.peekInvite(widget.inviteId);
    if (!mounted) return;
    setState(() {
      _invite = invite;
      _loading = false;
      if (invite == null) _error = 'This invite link is invalid or has expired.';
      else if (invite['status'] != 'pending') _error = 'This invite has already been used.';
    });
  }

  Future<void> _accept() async {
    setState(() => _accepting = true);
    final duelId = await DuelService.acceptChallenge(widget.inviteId);
    if (!mounted) return;
    if (duelId == null) {
      setState(() {
        _accepting = false;
        _error = "This invite is no longer available -- it may have already been accepted, or it's your own link.";
      });
      return;
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => DuelPlayPage(duelId: duelId),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _loading
                ? const CircularProgressIndicator()
                : _error != null
                    ? _buildError()
                    : _buildInvite(),
          ),
        ),
      ),
    );
  }

  Widget _buildError() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('⚠️', style: TextStyle(fontSize: 40)),
      const SizedBox(height: 14),
      Text(_error!, textAlign: TextAlign.center, style: GoogleFonts.dmSans(
        fontSize: 14, color: AppColors.textSecondary)),
      const SizedBox(height: 20),
      TextButton(
        onPressed: () => Navigator.of(context).maybePop(),
        child: Text('Go back', style: GoogleFonts.dmSans(color: AppColors.accentLight)),
      ),
    ]);
  }

  Widget _buildInvite() {
    final fromName = _invite!['fromName'] as String? ?? 'Someone';
    final mode = _invite!['mode'] as String?;
    final courseKey = _invite!['courseKey'] as String?;
    final subtitle = mode == 'spelling' ? 'Spelling battle' : (courseKey ?? 'Quiz battle');

    return Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('⚔️', style: TextStyle(fontSize: 44)),
      const SizedBox(height: 16),
      Text('$fromName challenged you', textAlign: TextAlign.center, style: GoogleFonts.dmSans(
        fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      const SizedBox(height: 6),
      Text(subtitle, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
      const SizedBox(height: 8),
      Text('3 rounds · 3:00, 3:00, 2:00 each', style: GoogleFonts.dmSans(
        fontSize: 11, color: AppColors.textTertiary)),
      const SizedBox(height: 28),
      SizedBox(width: double.infinity, child: ElevatedButton(
        onPressed: _accepting ? null : _accept,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: _accepting
            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Text('Accept challenge', style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w600)),
      )),
      const SizedBox(height: 10),
      TextButton(
        onPressed: _accepting ? null : () => Navigator.of(context).maybePop(),
        child: Text('Not now', style: GoogleFonts.dmSans(color: AppColors.textTertiary)),
      ),
    ]);
  }
}