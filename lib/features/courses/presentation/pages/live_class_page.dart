// lib/features/courses/presentation/pages/live_class_page.dart
//
// MOCK UI SCREEN -- there is no real video/WebRTC backend yet (no
// signaling, no media streams, no live captions). This renders the
// in-call layout from the target design so it can be reviewed and
// built around, with:
//   - Mic / camera / raise-hand as REAL local UI toggles (they only
//     affect what's shown on this screen, nothing is actually
//     transmitted anywhere -- there's nothing to transmit to yet).
//   - Screen share and the participant video tiles as static mock
//     content (a gradient placeholder instead of a real screen
//     share feed, initials instead of real camera feeds).
//   - The chat/caption text as a single static mock line.
//   - "Leave call" as the one real action: it actually navigates back.
//
// Deliberately dark regardless of the app's light/dark schedule --
// video-call UIs (Zoom, Meet, etc.) are conventionally dark so the
// video tiles read correctly, independent of the host app's theme.
// This screen does NOT use AppColors for that reason.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/course_service.dart';

class LiveClassPage extends StatefulWidget {
  final CourseModel course;
  final String sessionTitle;
  final String instructor;
  final int? enrolled;
  const LiveClassPage({
    super.key, required this.course, required this.sessionTitle,
    required this.instructor, this.enrolled,
  });

  @override
  State<LiveClassPage> createState() => _LiveClassPageState();
}

class _LiveClassPageState extends State<LiveClassPage> {
  bool _micOn = true;
  bool _cameraOn = false;
  bool _handRaised = false;

  static const _bg = Color(0xFF0D0D0F);
  static const _tileBg = Color(0xFF1E1E24);
  static const _border = Color(0xFF2A2A32);
  static const _textPrimary = Color(0xFFF5F5F7);
  static const _textSecondary = Color(0xFFAAAAAF);
  static const _live = Color(0xFFEF4444);

  void _notImplemented(String what) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(what, style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white)),
      backgroundColor: _tileBg,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final participants = _mockParticipants(course);

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(children: [
          // ── Top bar ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: _live, borderRadius: BorderRadius.circular(6)),
                child: Text('LIVE', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
              const SizedBox(width: 8),
              Icon(Icons.people_alt_rounded, size: 15, color: _textSecondary),
              const SizedBox(width: 4),
              Text(widget.enrolled != null ? '${widget.enrolled}' : '—', style: GoogleFonts.dmSans(fontSize: 13, color: _textSecondary)),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_down_rounded, color: _textPrimary),
                onPressed: () => Navigator.pop(context),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.sessionTitle, style: GoogleFonts.dmSans(
                fontSize: 17, fontWeight: FontWeight.w700, color: _textPrimary)),
              Text('${widget.instructor} · started 12 min ago', style: GoogleFonts.dmSans(
                fontSize: 12, color: _textSecondary)),
            ]),
          ),

          // ── Screen share (mock) ─────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                      colors: [course.accentColor.withValues(alpha: 0.55), _tileBg],
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.screen_share_outlined, size: 40, color: Colors.white.withValues(alpha: 0.5)),
                  ),
                ),
                Positioned(
                  right: 10, top: 10,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(20)),
                    child: Icon(Icons.mic_rounded, size: 14, color: Colors.white),
                  ),
                ),
                Positioned(
                  left: 10, bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                    child: Text('${widget.instructor} — screen share', style: GoogleFonts.dmSans(
                      fontSize: 11, color: Colors.white)),
                  ),
                ),
              ]),
            ),
          ),

          const SizedBox(height: 10),

          // ── Participant tiles (mock) ────────────────────────
          SizedBox(
            height: 56,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: participants.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final p = participants[i];
                return Container(
                  width: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: p.speaking ? course.accentColor.withValues(alpha: 0.35) : _tileBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: p.speaking ? course.accentColor : _border),
                  ),
                  child: Stack(alignment: Alignment.center, children: [
                    Text(p.initials, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: _textPrimary)),
                    if (p.muted)
                      Positioned(
                        right: 4, bottom: 4,
                        child: Icon(Icons.mic_off_rounded, size: 11, color: _live),
                      ),
                  ]),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // ── Live caption (mock) ─────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: _tileBg, borderRadius: BorderRadius.circular(12)),
              child: Text(
                '"${_mockCaption(course)}"',
                style: GoogleFonts.dmSans(fontSize: 13, color: _textSecondary, fontStyle: FontStyle.italic, height: 1.4),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ── Message input (mock) ────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () => _notImplemented('In-call chat isn\'t wired up yet'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(color: _tileBg, borderRadius: BorderRadius.circular(24)),
                child: Row(children: [
                  Icon(Icons.chat_bubble_outline_rounded, size: 16, color: _textSecondary),
                  const SizedBox(width: 10),
                  Text('Send a message…', style: GoogleFonts.dmSans(fontSize: 13, color: _textSecondary)),
                ]),
              ),
            ),
          ),

          const Spacer(),

          // ── Controls ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _ControlButton(
                icon: _micOn ? Icons.mic_rounded : Icons.mic_off_rounded,
                active: _micOn,
                onTap: () => setState(() => _micOn = !_micOn),
              ),
              _ControlButton(
                icon: _cameraOn ? Icons.videocam_rounded : Icons.videocam_off_rounded,
                active: _cameraOn,
                onTap: () => setState(() => _cameraOn = !_cameraOn),
              ),
              _ControlButton(
                icon: Icons.ios_share_rounded,
                active: false,
                onTap: () => _notImplemented('Screen sharing isn\'t wired up yet'),
              ),
              _ControlButton(
                icon: Icons.back_hand_rounded,
                active: _handRaised,
                onTap: () => setState(() => _handRaised = !_handRaised),
              ),
              _ControlButton(
                icon: Icons.call_end_rounded,
                active: true,
                activeColor: _live,
                onTap: () => Navigator.pop(context),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  String _mockCaption(CourseModel course) {
    if (course.curriculum.isNotEmpty) {
      return '…so that\'s how we get from ${course.curriculum.first.title.toLowerCase()} to the next part of the picture.';
    }
    return '…and that\'s the key idea behind today\'s lecture.';
  }

  List<_MockParticipant> _mockParticipants(CourseModel course) {
    const names = ['AV', 'JR', 'TM', 'KO', 'BF', 'SI'];
    return [
      for (var i = 0; i < names.length; i++)
        _MockParticipant(initials: names[i], muted: i != 2, speaking: i == 2),
    ];
  }
}

class _MockParticipant {
  final String initials;
  final bool muted;
  final bool speaking;
  const _MockParticipant({required this.initials, required this.muted, required this.speaking});
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final bool active;
  final Color? activeColor;
  final VoidCallback onTap;
  const _ControlButton({required this.icon, required this.active, required this.onTap, this.activeColor});

  @override
  Widget build(BuildContext context) {
    final bg = active ? (activeColor ?? const Color(0xFF7C3AED)) : const Color(0xFF1E1E24);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52, height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}