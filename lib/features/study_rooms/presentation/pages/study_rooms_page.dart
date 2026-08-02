import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/feature_flags.dart';
import '../../../../core/services/user_service.dart';
import '../widgets/live_study_session_coming_soon_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/study_room_service.dart';

enum _StudyTab { hub, focusSetup, focusActive, focusDone, rooms, inRoom, createRoom }
class _Subject {
  final String id, emoji, name, sub;
  final Color iconBg;
  const _Subject({required this.id, required this.emoji, required this.name, required this.sub, required this.iconBg});
}

final _subjects = [
  _Subject(id: 'math', emoji: '📐', name: 'WAEC Mathematics', sub: 'Algebra · Trig · Geometry', iconBg: AppColors.accentSurface),
  _Subject(id: 'eng', emoji: '📝', name: 'WAEC English', sub: 'Comprehension · Essay', iconBg: AppColors.surface),
  _Subject(id: 'ielts', emoji: '🌍', name: 'IELTS Academic', sub: 'Reading · Writing · Speaking', iconBg: AppColors.successSurface),
];

// Course tags for Study Rooms -- deliberately separate from _subjects above,
// which belongs to Focus Mode and shouldn't be touched.
const _roomCourseTags = [
  ['📐', 'Maths'],
  ['⚡', 'Physics'],
  ['⚗️', 'Chemistry'],
  ['💻', 'Software Engineering'],
  ['🧬', 'Biology'],
  ['🎓', 'GNS'],
  ['📘', 'GST'],
  ['🖥️', 'Computer Science'],
];

class StudyRoomsPage extends StatefulWidget {
  const StudyRoomsPage({super.key});
  @override
  State<StudyRoomsPage> createState() => _StudyRoomsPageState();
}

class _StudyRoomsPageState extends State<StudyRoomsPage> with TickerProviderStateMixin {
  _StudyTab _tab = _StudyTab.hub;
  String _selectedSubject = 'math';
  int _focusMins = 25;
  bool _customTimer = false;
  bool _togBreath = true, _togBlock = true, _togSound = false;
  int _timerSecs = 25 * 60;
  bool _isPaused = false;
  int _elapsed = 0;
  Timer? _focusTimer;
  late AnimationController _breathCtrl;
  late Animation<double> _breathAnim;
  late AnimationController _ringCtrl;
  late Animation<double> _ringAnim;
  final TextEditingController _chatCtrl = TextEditingController();

  // ── Real study room state ──────────────────────────────────────────
  String? _currentRoomId;
  StudyRoom? _currentRoom;
  Timer? _roomExpiryWatch;
  bool _sendingAttachment = false;
  final TextEditingController _roomTitleCtrl = TextEditingController();
  String? _roomCourseTag;
  int _roomMaxParticipants = 4;
  int _roomDurationMinutes = 60;
  bool _creatingRoom = false;

  String get _myDisplayName =>
      FirebaseAuth.instance.currentUser?.displayName?.trim().isNotEmpty == true
          ? FirebaseAuth.instance.currentUser!.displayName!.trim()
          : 'Student';

  void _openRoom(String roomId, StudyRoom room) {
    setState(() {
      _currentRoomId = roomId;
      _currentRoom = room;
    });
    _roomExpiryWatch?.cancel();
    _roomExpiryWatch = Timer.periodic(const Duration(seconds: 5), (_) {
      final room = _currentRoom;
      if (room == null) return;
      if (room.isExpiredNow) {
        _roomExpiryWatch?.cancel();
        StudyRoomService.instance.markExpiredIfPast(room);
        if (mounted && _tab == _StudyTab.inRoom) {
          _leaveCurrentRoom(showExpiredMessage: true);
        }
      } else {
        setState(() {}); // tick the countdown label
      }
    });
    _go(_StudyTab.inRoom);
  }

  Future<void> _leaveCurrentRoom({bool showExpiredMessage = false}) async {
    final roomId = _currentRoomId;
    _roomExpiryWatch?.cancel();
    _roomExpiryWatch = null;
    if (roomId != null) {
      try {
        await StudyRoomService.instance.leaveRoom(roomId);
      } catch (_) {
        // Room may already be gone/expired -- leaving is best-effort.
      }
    }
    setState(() {
      _currentRoomId = null;
      _currentRoom = null;
    });
    if (mounted) {
      _go(_StudyTab.rooms);
      if (showExpiredMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This room has ended.')),
        );
      }
    }
  }

  Future<void> _handleJoinRoom(StudyRoom room) async {
    try {
      await StudyRoomService.instance.joinRoom(room.id, displayName: _myDisplayName);
      _openRoom(room.id, room);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  Future<void> _handleCreateRoom() async {
    final title = _roomTitleCtrl.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Give the room a name first.')),
      );
      return;
    }
    setState(() => _creatingRoom = true);
    try {
      final roomId = await StudyRoomService.instance.createRoom(
        title: title,
        courseTag: _roomCourseTag,
        maxParticipants: _roomMaxParticipants,
        durationMinutes: _roomDurationMinutes,
        hostDisplayName: _myDisplayName,
      );
      final snap = await StudyRoomService.instance.roomStream(roomId).first;
      _roomTitleCtrl.clear();
      if (mounted) _openRoom(roomId, snap);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _creatingRoom = false);
    }
  }

  Future<void> _handleSendText() async {
    final roomId = _currentRoomId;
    final text = _chatCtrl.text;
    if (roomId == null || text.trim().isEmpty) return;
    _chatCtrl.clear();
    try {
      await StudyRoomService.instance.sendTextMessage(roomId, text);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _handleSendImage() async {
    final roomId = _currentRoomId;
    if (roomId == null) return;
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) return;
    setState(() => _sendingAttachment = true);
    try {
      await StudyRoomService.instance.sendImageMessage(roomId, File(picked.path));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _sendingAttachment = false);
    }
  }

  Future<void> _handleReport(String reportedUserId, String reportedName) async {
    final reasonCtrl = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Report $reportedName', style: GoogleFonts.dmSans(color: AppColors.textPrimary, fontSize: 15)),
        content: TextField(
          controller: reasonCtrl,
          maxLines: 3,
          style: GoogleFonts.dmSans(color: AppColors.textPrimary, fontSize: 13),
          decoration: InputDecoration(
            hintText: 'What happened?',
            hintStyle: GoogleFonts.dmSans(color: AppColors.textTertiary, fontSize: 13),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Report')),
        ],
      ),
    );
    if (confirmed != true || _currentRoomId == null) return;
    try {
      await StudyRoomService.instance.reportParticipant(
        roomId: _currentRoomId!,
        reportedUserId: reportedUserId,
        reason: reasonCtrl.text.trim().isEmpty ? 'No reason given' : reasonCtrl.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Report sent. Thanks for flagging this.')));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  void initState() {
    super.initState();
    _breathCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
    _breathAnim = Tween(begin: 1.0, end: 1.08).animate(CurvedAnimation(parent: _breathCtrl, curve: Curves.easeInOut));
    _ringCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
    _ringAnim = Tween(begin: 1.0, end: 1.18).animate(CurvedAnimation(parent: _ringCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _focusTimer?.cancel();
    _roomExpiryWatch?.cancel();
    _breathCtrl.dispose();
    _ringCtrl.dispose();
    _chatCtrl.dispose();
    _roomTitleCtrl.dispose();
    super.dispose();
  }

  void _go(_StudyTab tab) {
    HapticFeedback.selectionClick();
    if (tab == _StudyTab.focusActive) {
      _timerSecs = _focusMins * 60;
      _elapsed = 0;
      _isPaused = false;
      _focusTimer?.cancel();
      _focusTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {
          if (_timerSecs > 0) { _timerSecs--; _elapsed++; }
          else { _focusTimer?.cancel(); _completeFocus(); }
        });
      });
    } else {
      _focusTimer?.cancel();
    }
    setState(() => _tab = tab);
  }

  void _completeFocus() {
    final hours = _focusMins / 60.0;
    final xp = (_focusMins ~/ 10) * 10;
    UserService.updateStreak();
    UserService.awardXP(xp, reason: 'focus_session');
    UserService.logStudyTime(hours);
    UserService.updateLeaderboard();
    setState(() => _tab = _StudyTab.focusDone);
  }

  String _fmt(int secs) {
    final m = secs ~/ 60;
    final s = secs % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  double get _ringProgress => _focusMins > 0 ? _timerSecs / (_focusMins * 60) : 0;

  void _togglePause() {
    HapticFeedback.selectionClick();
    setState(() => _isPaused = !_isPaused);
    if (_isPaused) {
      _focusTimer?.cancel();
    } else {
      _focusTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {
          if (_timerSecs > 0) { _timerSecs--; _elapsed++; }
          else { _focusTimer?.cancel(); _completeFocus(); }
        });
      });
    }
  }
  int get _xpEarned => (_elapsed ~/ 60) * 6;
  _Subject get _subject => _subjects.firstWhere((s) => s.id == _selectedSubject);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    switch (_tab) {
      case _StudyTab.hub:         return _hub();
      case _StudyTab.focusSetup:  return _focusSetup();
      case _StudyTab.focusActive: return _focusActive();
      case _StudyTab.focusDone:   return _focusDone();
      case _StudyTab.rooms:       return _roomsBrowse();
      case _StudyTab.inRoom:      return _inRoom();
      case _StudyTab.createRoom:  return _createRoom();
    }
  }

  // ══════════════════════════════════════════
  // HUB
  // ══════════════════════════════════════════
  Widget _hub() => Column(children: [
    Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Row(children: [
        
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Study', style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          Text('Choose how you want to study today', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
        ])),
      ]),
    ),
    Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(14), child: Column(children: [

      // Focus mode card
      GestureDetector(
        onTap: () => _go(_StudyTab.focusSetup),
        child: Container(
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.accentSurface,
            border: Border.all(color: const Color(0xFF3D2580), width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 52, height: 52, decoration: BoxDecoration(color: const Color(0xFF3D2580), borderRadius: BorderRadius.circular(16)), child: Icon(Icons.psychology_rounded, size: 26, color: AppColors.accentLight)),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Focus mode', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text('Study alone in deep focus. Set your subject and timer — no distractions, just you and the material.', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.accentLight, height: 1.6)),
                const SizedBox(height: 10),
                Wrap(spacing: 6, children: ['Breathing timer', 'Session streak', '+XP on complete'].map((t) =>
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFF3D2580), borderRadius: BorderRadius.circular(20)), child: Text(t, style: GoogleFonts.dmSans(fontSize: 9, color: AppColors.accentLight)))).toList()),
              ])),
            ]),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 16),
                const SizedBox(width: 6),
                Text('Start focus session', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
              ])),
            ),
          ]),
        ),
      ),

      // Study rooms card -- real entry point into the live rooms feature
      GestureDetector(
        onTap: () => _go(_StudyTab.rooms),
        child: Container(
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.successSurface,
            border: Border.all(color: AppColors.success, width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 52, height: 52, decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(16)), child: Icon(Icons.groups_rounded, size: 26, color: AppColors.success)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Study rooms', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 4),
              Text('Study together, live. Create a room or join one already open — chat, share images and notes, room closes automatically when time\'s up.', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.success, height: 1.6)),
            ])),
            Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.success),
          ]),
        ),
      ),
      // Live study session card
      if (FeatureFlags.showLiveStudySession) const LiveStudySessionComingSoon(),
      // Last session nudge
      Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Icon(Icons.history_rounded, size: 18, color: AppColors.textTertiary),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Last session: 45 min · WAEC Maths', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
            Text('Yesterday at 8:20 PM · +180 XP earned', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
          ])),
          Icon(Icons.chevron_right_rounded, size: 14, color: AppColors.textDisabled),
        ]),
      ),
    ]))),
  ]);

  // ══════════════════════════════════════════
  // FOCUS SETUP
  // ══════════════════════════════════════════
  Widget _focusSetup() => Column(children: [
    Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Row(children: [
        GestureDetector(onTap: () => _go(_StudyTab.hub), child: Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.textTertiary)),
        const SizedBox(width: 12),
        Text('Study Time', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: 0.5)),
          const SizedBox(height: 9),
        ]),
      ),

      // Duration picker
      Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('SESSION LENGTH', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: 0.5)),
          const SizedBox(height: 9),
          Row(children: [15, 25, 45, 60].map((m) {
            final on = !_customTimer && _focusMins == m;
            return Expanded(child: GestureDetector(
              onTap: () { HapticFeedback.selectionClick(); setState(() { _focusMins = m; _customTimer = false; }); },
              child: Container(
                margin: EdgeInsets.only(right: m == 60 ? 0 : 6),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: on ? AppColors.accentSurface : AppColors.surfaceVariant,
                  border: Border.all(color: on ? AppColors.accent : AppColors.border, width: on ? 1.5 : 0.5),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Column(children: [
                  Text('${m}m', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w500, color: on ? AppColors.accentLight : AppColors.textTertiary)),
                  Text(m == 15 ? 'Quick' : m == 25 ? 'Focus' : m == 45 ? 'Deep' : 'Full', style: GoogleFonts.dmSans(fontSize: 9, color: AppColors.textDisabled)),
                ]),
              ),
            ));
          }).toList()),
          const SizedBox(height: 8),

          // Custom timer row
          GestureDetector(
            onTap: () { HapticFeedback.selectionClick(); setState(() => _customTimer = true); },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
              decoration: BoxDecoration(
                color: _customTimer ? AppColors.accentSurface : AppColors.surfaceVariant,
                border: Border.all(color: _customTimer ? AppColors.accent : AppColors.border, width: _customTimer ? 1.5 : 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(children: [
                Icon(Icons.tune_rounded, size: 16, color: AppColors.textTertiary),
                const SizedBox(width: 8),
                Expanded(child: Text('Custom', style: GoogleFonts.dmSans(fontSize: 12, color: _customTimer ? AppColors.accentLight : AppColors.textSecondary))),
                if (_customTimer) ...[
                  GestureDetector(
                    onTap: () { HapticFeedback.selectionClick(); if (_focusMins > 5) setState(() => _focusMins -= 5); },
                    child: Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(9)), child: Icon(Icons.remove_rounded, size: 16, color: AppColors.textTertiary)),
                  ),
                  const SizedBox(width: 8),
                  Text('${_focusMins}m', style: GoogleFonts.dmSans(fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () { HapticFeedback.selectionClick(); if (_focusMins < 120) setState(() => _focusMins += 5); },
                    child: Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(9)), child: Icon(Icons.add_rounded, size: 16, color: AppColors.textTertiary)),
                  ),
                ],
              ]),
            ),
          ),
        ]),
      ),

      // Preferences
      Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(bottom: 14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('PREFERENCES', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: 0.5)),
          const SizedBox(height: 4),
          _prefRow('Breathing animation', 'Pulsing logo guides focus', _togBreath, () => setState(() => _togBreath = !_togBreath), border: true),
          _prefRow('Block notifications', 'No interruptions during session', _togBlock, () => setState(() => _togBlock = !_togBlock), border: true),
          _prefRow('Ambient sounds', 'Lo-fi / rain / white noise', _togSound, () => setState(() => _togSound = !_togSound)),
        ]),
      ),

      // Begin button
      GestureDetector(
        onTap: () => _go(_StudyTab.focusActive),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(14)),
          child: Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.psychology_rounded, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text('Begin focus session', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
          ])),
        ),
      ),
    ]);
  

  Widget _prefRow(String title, String sub, bool val, VoidCallback onTap, {bool border = false}) => GestureDetector(
    onTap: () { HapticFeedback.selectionClick(); onTap(); },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(border: Border(bottom: border ? BorderSide(color: AppColors.border, width: 0.5) : BorderSide.none)),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textPrimary)),
          Text(sub, style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
        ])),
        Container(
          width: 40, height: 22,
          decoration: BoxDecoration(color: val ? AppColors.accent : AppColors.surfaceVariant, borderRadius: BorderRadius.circular(11)),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            alignment: val ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(margin: const EdgeInsets.all(2), width: 18, height: 18, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
          ),
        ),
      ]),
    ),
  );

  // ══════════════════════════════════════════
  // FOCUS ACTIVE
  // ══════════════════════════════════════════
  Widget _focusActive() => Column(children: [
    Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
      child: Row(children: [
        GestureDetector(
          onTap: () => _go(_StudyTab.focusSetup),
          child: Container(width: 30, height: 30, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(9)), child: Icon(Icons.close_rounded, size: 15, color: AppColors.textTertiary)),
        ),
        Expanded(child: Center(child: Text('${_subject.name} · ${_focusMins}m', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textTertiary)))),
        Container(width: 30, height: 30, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(9)), child: Icon(Icons.more_horiz_rounded, size: 15, color: AppColors.textTertiary)),
      ]),
    ),
    Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // Breathing ring + timer
      SizedBox(
        width: 200, height: 200,
        child: Stack(alignment: Alignment.center, children: [
          // Pulse ring
          AnimatedBuilder(animation: _ringAnim, builder: (_, __) => Transform.scale(
            scale: _ringAnim.value,
            child: Container(width: 200, height: 200, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.accent.withValues(alpha: 0.15), width: 1.5))),
          )),
          // SVG countdown ring
          CustomPaint(size: const Size(200, 200), painter: _RingPainter(_ringProgress)),
          // Breathing logo
          AnimatedBuilder(animation: _breathAnim, builder: (_, __) => Transform.scale(
            scale: _breathAnim.value,
            child: Container(
              width: 160, height: 160,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.accentSurface, border: Border.all(color: const Color(0xFF3D2580), width: 1.5)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('E', style: GoogleFonts.dmSans(fontSize: 28, fontWeight: FontWeight.w500, color: AppColors.accentLight)),
                Text('EDULINK', style: GoogleFonts.dmSans(fontSize: 9, color: AppColors.accentLight, letterSpacing: 2)),
              ]),
            ),
          )),
        ]),
      ),
      const SizedBox(height: 24),
      Text(_fmt(_timerSecs), style: GoogleFonts.dmSans(fontSize: 48, fontWeight: FontWeight.w500, color: AppColors.textPrimary, letterSpacing: -2)),
      const SizedBox(height: 6),
      Text('Breathe in…', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
      const SizedBox(height: 4),
      Text('Stay focused · you\'re doing great', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textDisabled)),
      const SizedBox(height: 28),

      // Pause / End
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
          onTap: _togglePause,
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: _isPaused ? AppColors.accentSurface : AppColors.surface,
              border: Border.all(color: _isPaused ? AppColors.accent : AppColors.border),
              borderRadius: BorderRadius.circular(12)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(_isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded, size: 15,
                color: _isPaused ? AppColors.accentLight : AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(_isPaused ? 'Resume' : 'Pause', style: GoogleFonts.dmSans(fontSize: 12,
                color: _isPaused ? AppColors.accentLight : AppColors.textSecondary)),
            ])),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => _go(_StudyTab.focusDone),
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12)), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.stop_rounded, size: 15, color: AppColors.error), const SizedBox(width: 6), Text('End session', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.error))])),
        ),
      ]),
      const SizedBox(height: 24),

      // Mini stats
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(14)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          _statMini(_fmt(_elapsed), 'Elapsed', AppColors.accentLight),
          _divider(),
          _statMini('3', 'Streak', const Color(0xFFE8960F)),
          _divider(),
          _statMini('+$_xpEarned', 'XP so far', AppColors.success),
        ]),
      ),
    ])),
  ]);

  Widget _statMini(String val, String label, Color color) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Column(children: [
      Text(val, style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w500, color: color)),
      Text(label, style: GoogleFonts.dmSans(fontSize: 9, color: AppColors.textTertiary)),
    ]),
  );

  Widget _divider() => Container(width: 1, height: 28, color: AppColors.border);

  // ══════════════════════════════════════════
  // FOCUS DONE
  // ══════════════════════════════════════════
  Widget _focusDone() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(children: [
      const SizedBox(height: 20),
      Container(width: 72, height: 72, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.accentSurface, border: Border.all(color: AppColors.accent, width: 2)), child: Icon(Icons.psychology_rounded, size: 32, color: AppColors.accentLight)),
      const SizedBox(height: 14),
      Text('Session complete!', style: GoogleFonts.dmSans(fontSize: 21, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      const SizedBox(height: 3),
      Text('${_subject.name} · $_focusMins minutes', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
      const SizedBox(height: 18),

      // XP card
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF2D1E00), border: Border.all(color: const Color(0xFFC47D0E), width: 1.5), borderRadius: BorderRadius.circular(18)),
        child: Column(children: [
          Text('XP earned', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
          const SizedBox(height: 5),
          Text('+${_focusMins * 6}', style: GoogleFonts.dmSans(fontSize: 38, fontWeight: FontWeight.w500, color: const Color(0xFFE8960F))),
          Text('Base ${_focusMins * 5} · streak bonus +$_focusMins', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
        ]),
      ),
      const SizedBox(height: 12),

      // Stats grid
      Row(children: [
        Expanded(child: _doneStatCard('Duration', '${_focusMins}m', 'Full session', AppColors.textPrimary)),
        const SizedBox(width: 8),
        Expanded(child: _doneStatCard('Focus streak', '4', 'Personal best!', const Color(0xFFE8960F))),
        const SizedBox(width: 8),
        Expanded(child: _doneStatCard('Total today', '70m', 'Studied today', AppColors.accentLight)),
        const SizedBox(width: 8),
        Expanded(child: _doneStatCard('Day streak', '14', 'days in a row', AppColors.error)),
      ]),
      const SizedBox(height: 12),

      // Profile updated nudge
      Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(color: AppColors.accentSurface, border: Border.all(color: const Color(0xFF3D2580)), borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Icon(Icons.verified_user_rounded, size: 18, color: AppColors.accentLight),
          const SizedBox(width: 9),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Profile updated', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.accentLight)),
            Text('Activity rings, XP and streak updated on your profile', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
          ])),
        ]),
      ),
      const SizedBox(height: 12),

      GestureDetector(onTap: () => _go(_StudyTab.focusSetup), child: Container(padding: const EdgeInsets.symmetric(vertical: 13), decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(14)), child: Center(child: Text('Start another session', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white))))),
      const SizedBox(height: 8),
      GestureDetector(onTap: () => _go(_StudyTab.hub), child: Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(14)), child: Center(child: Text('Back to Study', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary))))),
    ]),
  );

  Widget _doneStatCard(String label, String val, String sub, Color valColor) => Container(
    padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
    decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12)),
    child: Column(children: [
      Text(label, style: GoogleFonts.dmSans(fontSize: 9, color: AppColors.textTertiary), textAlign: TextAlign.center),
      const SizedBox(height: 3),
      Text(val, style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w500, color: valColor)),
      Text(sub, style: GoogleFonts.dmSans(fontSize: 8, color: AppColors.textTertiary), textAlign: TextAlign.center),
    ]),
  );

  // ══════════════════════════════════════════
  // ROOMS BROWSE
  Widget _roomsBrowse() => Column(children: [
    Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Row(children: [
        GestureDetector(onTap: () => _go(_StudyTab.hub), child: Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.textTertiary)),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Study rooms', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          Text('Study together, live', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
        ])),
      ]),
    ),
    Expanded(child: StreamBuilder<List<StudyRoom>>(
      stream: StudyRoomService.instance.activeRoomsStream(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Could not load rooms.', style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
        }
        final rooms = (snap.data ?? []).where((r) => !r.isExpiredNow).toList();
        return SingleChildScrollView(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
            onTap: () => _go(_StudyTab.createRoom),
            child: Container(
              padding: const EdgeInsets.all(13),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(color: AppColors.accentSurface, border: Border.all(color: AppColors.accentDark), borderRadius: BorderRadius.circular(16)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.add_rounded, size: 17, color: AppColors.accentLight),
                const SizedBox(width: 8),
                Text('Create a new study room', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.accentLight)),
              ]),
            ),
          ),
          if (rooms.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(child: Text('No rooms open right now — start one!', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary))),
            )
          else ...[
            Text('OPEN NOW', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            ...rooms.map((r) => _roomCard(r)),
          ],
        ]));
      },
    )),
  ]);

  Widget _roomCard(StudyRoom r) {
    final full = r.isFull;
    final mins = r.remaining.inMinutes.clamp(0, 999);
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 38, height: 38, decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(11)), child: Center(child: Icon(Icons.groups_rounded, size: 18, color: AppColors.textTertiary))),
          const SizedBox(width: 9),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(r.title, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
            Text(r.courseTag ?? 'General study', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary)),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: AppColors.successSurface, border: Border.all(color: AppColors.success.withValues(alpha: 0.5)), borderRadius: BorderRadius.circular(20)),
            child: Text('$mins min left', style: GoogleFonts.dmSans(fontSize: 9, color: AppColors.success)),
          ),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Text('${r.participantCount}/${r.maxParticipants} students', style: GoogleFonts.dmSans(fontSize: 9, color: AppColors.textTertiary)),
          const Spacer(),
          GestureDetector(
            onTap: full ? null : () => _handleJoinRoom(r),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: full ? AppColors.surfaceVariant : AppColors.accentSurface, borderRadius: BorderRadius.circular(20)),
              child: Text(full ? 'Full' : 'Join →', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w500, color: full ? AppColors.textDisabled : AppColors.accentLight)),
            ),
          ),
        ]),
      ]),
    );
  }

  // ══════════════════════════════════════════
  // IN ROOM
  // ══════════════════════════════════════════
  Widget _inRoom() {
    final roomId = _currentRoomId;
    if (roomId == null) {
      return Center(child: Text('No room selected.', style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
    }
    return StreamBuilder<StudyRoom>(
      stream: StudyRoomService.instance.roomStream(roomId),
      builder: (context, roomSnap) {
        if (roomSnap.hasData) _currentRoom = roomSnap.data;
        final room = roomSnap.data;
        return Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
            child: Row(children: [
              GestureDetector(onTap: () => _leaveCurrentRoom(), child: Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.textTertiary)),
              const SizedBox(width: 8),
              Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(room?.title ?? '…', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary), overflow: TextOverflow.ellipsis),
                Text(
                  room == null ? 'live' : '${room.participantCount}/${room.maxParticipants} · ${room.remaining.inMinutes.clamp(0, 999)} min left',
                  style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary),
                ),
              ])),
              _iBtn(Icons.exit_to_app_rounded, () => _leaveCurrentRoom()),
            ]),
          ),
          Expanded(child: StreamBuilder<List<StudyRoomMessage>>(
            stream: StudyRoomService.instance.messagesStream(roomId),
            builder: (context, msgSnap) {
              final messages = msgSnap.data ?? [];
              if (msgSnap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(padding: const EdgeInsets.all(12), children: [
                if (messages.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Center(child: Text('No messages yet — say hi 👋', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary))),
                  ),
                ...messages.map((m) => _chatBubble(m)),
              ]);
            },
          )),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.border))),
            child: Row(children: [
              GestureDetector(
                onTap: _sendingAttachment ? null : _handleSendImage,
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), shape: BoxShape.circle),
                  child: _sendingAttachment
                      ? const Padding(padding: EdgeInsets.all(10), child: CircularProgressIndicator(strokeWidth: 2))
                      : Icon(Icons.image_outlined, size: 16, color: AppColors.textTertiary),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: TextField(
                controller: _chatCtrl,
                style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Message the room…',
                  hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary),
                  filled: true, fillColor: AppColors.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide(color: AppColors.border)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide(color: AppColors.border)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide(color: AppColors.accentDark)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
                onSubmitted: (_) => _handleSendText(),
              )),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () { HapticFeedback.lightImpact(); _handleSendText(); },
                child: Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle), child: const Icon(Icons.send_rounded, size: 16, color: Colors.white)),
              ),
            ]),
          ),
        ]);
      },
    );
  }

  Widget _chatBubble(StudyRoomMessage m) {
    final isMe = m.senderId == FirebaseAuth.instance.currentUser?.uid;
    Widget content;
    switch (m.type) {
      case StudyRoomMessageType.text:
        content = Text(m.content, style: GoogleFonts.dmSans(fontSize: 11, color: isMe ? AppColors.accentLight : AppColors.textSecondary, height: 1.55));
        break;
      case StudyRoomMessageType.image:
        content = ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(m.content, width: 180, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Text('Image failed to load', style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textTertiary))),
        );
        break;
      case StudyRoomMessageType.pdf:
        content = GestureDetector(
          onTap: () {}, // TODO: open in-app PDF viewer / launch URL once wired
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.picture_as_pdf_rounded, size: 16, color: AppColors.error),
            const SizedBox(width: 6),
            Flexible(child: Text(m.fileName ?? 'PDF file', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis)),
          ]),
        );
        break;
    }

    final initials = m.senderName.trim().isNotEmpty
        ? m.senderName.trim().split(RegExp(r'\s+')).map((w) => w[0]).take(2).join().toUpperCase()
        : '?';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: isMe ? [
          Container(constraints: const BoxConstraints(maxWidth: 220), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: AppColors.accentSurface, border: Border.all(color: AppColors.accentDark), borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14), bottomLeft: Radius.circular(14), bottomRight: Radius.circular(4))), child: content),
        ] : [
          GestureDetector(
            onLongPress: () => _handleReport(m.senderId, m.senderName),
            child: Container(width: 24, height: 24, decoration: BoxDecoration(color: AppColors.accentSurface, shape: BoxShape.circle), child: Center(child: Text(initials, style: GoogleFonts.dmSans(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.accentLight)))),
          ),
          const SizedBox(width: 7),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: const EdgeInsets.only(left: 2, bottom: 2), child: Text(m.senderName, style: GoogleFonts.dmSans(fontSize: 9, color: AppColors.textDisabled))),
            Container(constraints: const BoxConstraints(maxWidth: 220), padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8), decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14), bottomLeft: Radius.circular(4), bottomRight: Radius.circular(14))), child: content),
          ]),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════
  // CREATE ROOM
  // ══════════════════════════════════════════
  Widget _createRoom() {
    return StatefulBuilder(builder: (context, setS) => Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
        child: Row(children: [
          GestureDetector(onTap: () => _go(_StudyTab.rooms), child: Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.textTertiary)),
          const SizedBox(width: 12),
          Text('Create a study room', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        ]),
      ),
      Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(14), child: Column(children: [

        Container(
          padding: const EdgeInsets.all(13),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('ROOM NAME', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            TextField(
              controller: _roomTitleCtrl,
              style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'e.g. WAEC Maths revision group',
                hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary),
                filled: true, fillColor: AppColors.surfaceVariant,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.accentDark)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ]),
        ),

        Container(
          padding: const EdgeInsets.all(13),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('SUBJECT (optional)', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            Wrap(spacing: 7, runSpacing: 7, children: _roomCourseTags.map((c) {
              final emoji = c[0];
              final name = c[1];
              final on = _roomCourseTag == name;
              return GestureDetector(
                onTap: () { HapticFeedback.selectionClick(); setS(() => _roomCourseTag = on ? null : name); },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: on ? AppColors.accentSurface : AppColors.surfaceVariant, border: Border.all(color: on ? AppColors.accent : AppColors.border, width: on ? 1.5 : 0.5), borderRadius: BorderRadius.circular(20)),
                  child: Text('$emoji $name', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500, color: on ? AppColors.accentLight : AppColors.textTertiary)),
                ),
              );
            }).toList()),
          ]),
        ),

        Container(
          padding: const EdgeInsets.all(13),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('MAX PARTICIPANTS', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            Row(children: [2, 4, 6, 10].map((n) {
              final on = _roomMaxParticipants == n;
              return Expanded(child: GestureDetector(
                onTap: () { HapticFeedback.selectionClick(); setS(() => _roomMaxParticipants = n); },
                child: Container(
                  margin: EdgeInsets.only(right: n == 10 ? 0 : 6),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(color: on ? AppColors.accentSurface : AppColors.surfaceVariant, border: Border.all(color: on ? AppColors.accent : AppColors.border, width: on ? 1.5 : 0.5), borderRadius: BorderRadius.circular(11)),
                  child: Center(child: Text('$n', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w500, color: on ? AppColors.accentLight : AppColors.textTertiary))),
                ),
              ));
            }).toList()),
          ]),
        ),

        Container(
          padding: const EdgeInsets.all(13),
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('DURATION', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            Row(children: [30, 60, 90, 120].map((n) {
              final on = _roomDurationMinutes == n;
              return Expanded(child: GestureDetector(
                onTap: () { HapticFeedback.selectionClick(); setS(() => _roomDurationMinutes = n); },
                child: Container(
                  margin: EdgeInsets.only(right: n == 120 ? 0 : 6),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(color: on ? AppColors.accentSurface : AppColors.surfaceVariant, border: Border.all(color: on ? AppColors.accent : AppColors.border, width: on ? 1.5 : 0.5), borderRadius: BorderRadius.circular(11)),
                  child: Center(child: Text('${n}m', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500, color: on ? AppColors.accentLight : AppColors.textTertiary))),
                ),
              ));
            }).toList()),
          ]),
        ),

        GestureDetector(
          onTap: _creatingRoom ? null : _handleCreateRoom,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(14)),
            child: Center(child: _creatingRoom
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.meeting_room_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text('Create & join room', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                  ])),
          ),
        ),
        const SizedBox(height: 16),
      ]))),
    ]));
  }
  Widget _iBtn(IconData icon, VoidCallback fn) => GestureDetector(
    onTap: fn,
    child: Container(width: 30, height: 30, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(9)), child: Icon(icon, size: 15, color: AppColors.textTertiary)),
  );
}

// ── Ring painter ──
class _RingPainter extends CustomPainter {
  final double progress;
  _RingPainter(this.progress);
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2, cy = size.height / 2, r = size.width / 2 - 4;
    final bg = Paint()..color = const Color(0xFF1E1E24)..style = PaintingStyle.stroke..strokeWidth = 4;
    final fg = Paint()..color = const Color(0xFF7C3AED)..style = PaintingStyle.stroke..strokeWidth = 4..strokeCap = StrokeCap.round;
    canvas.drawCircle(Offset(cx, cy), r, bg);
    canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r), -1.5708, progress * 6.2832, false, fg);
  }
  @override bool shouldRepaint(_RingPainter old) => old.progress != progress;
}