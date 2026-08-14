// lib/features/duel/presentation/pages/duel_setup_page.dart
//
// Step 1 of a live duel: pick a mode (Spelling, or a subject to face),
// then either find a random opponent via the matchmaking queue, or
// challenge a specific friend (mutual follow) directly. Friend
// challenges are necessarily async-to-start -- the friend has to
// actually open the app and accept before the live duel (with its
// shared clock) can begin, since there's no live state to sync until
// both people are actually present. Random matchmaking, by contrast,
// only ever matches two people who are both actively searching right
// now, so it can start instantly.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/duel_service.dart';
import '../../../../core/services/user_follow_service.dart';
import '../../../../core/data/course_catalog/subjects_data.dart';
import '../../../quiz/data/topic_question_source.dart';
import 'duel_play_page.dart';

const Map<String, String> _courseEmoji = {
  'MTS 102': '📐', 'MTS 104': '📊', 'PHY 102': '⚡', 'CHE 102': '⚗️',
  'BIO 102': '🧬', 'GNS 106': '📖', 'CSC 102': '💻', 'COS 102': '🖥️',
};

enum _View { setup, friendPicker, waitingForFriend, searchingQueue, linkShared }

class DuelSetupPage extends StatefulWidget {
  const DuelSetupPage({super.key});

  @override
  State<DuelSetupPage> createState() => _DuelSetupPageState();
}

class _DuelSetupPageState extends State<DuelSetupPage> {
  DuelMode? _mode;
  String? _selectedCourse;
  _View _view = _View.setup;
  StreamSubscription<String?>? _queueSub;
  StreamSubscription<Map<String, dynamic>?>? _inviteSub;
  String? _shareLink;

  late final List<String> _availableCourses = subjectsData.keys
      .where((k) => TopicQuestionSource.hasQuestionBank(k))
      .toList();

  bool get _canSearch =>
      _mode == DuelMode.spelling || (_mode == DuelMode.subject && _selectedCourse != null);

  @override
  void dispose() {
    _queueSub?.cancel();
    _inviteSub?.cancel();
    // Don't leave an orphaned queue entry if the user backs out mid-search.
    if (_view == _View.searchingQueue) DuelService.cancelQueue();
    super.dispose();
  }

  // ── Random matchmaking ────────────────────────────────────────────────

  Future<void> _findOpponent() async {
    if (!_canSearch) return;
    setState(() => _view = _View.searchingQueue);

    final duelId = await DuelService.queueForMatch(
      mode: _mode!,
      courseKey: _mode == DuelMode.subject ? _selectedCourse : null,
    );
    if (!mounted) return;

    if (duelId != null) {
      _enterDuel(duelId);
      return;
    }
    _queueSub = DuelService.myQueueEntryStream().listen((matchedDuelId) {
      if (matchedDuelId != null && mounted) _enterDuel(matchedDuelId);
    });
  }

  void _cancelSearch() {
    _queueSub?.cancel();
    DuelService.cancelQueue();
    setState(() => _view = _View.setup);
  }

  // ── Friend challenge ─────────────────────────────────────────────────

  Future<void> _challengeFriend(Map<String, dynamic> friend) async {
    final inviteId = await DuelService.sendChallenge(
      toUid: friend['uid'] as String,
      toName: friend['displayName'] as String? ?? 'Friend',
      mode: _mode!,
      courseKey: _mode == DuelMode.subject ? _selectedCourse : null,
    );
    if (inviteId == null || !mounted) return;

    setState(() => _view = _View.waitingForFriend);

    _inviteSub = DuelService.inviteStream(inviteId).listen((invite) {
      final resultDuelId = invite?['resultDuelId'] as String?;
      if (resultDuelId != null && mounted) _enterDuel(resultDuelId);
      if (invite?['status'] == 'declined' && mounted) {
        setState(() => _view = _View.setup);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Challenge declined')));
      }
    });
  }

  void _cancelFriendChallenge() {
    _inviteSub?.cancel();
    setState(() => _view = _View.setup);
  }

  // ── Link invite ──────────────────────────────────────────────────────

  Future<void> _shareViaLink() async {
    if (!_canSearch) return;
    final inviteId = await DuelService.createLinkChallenge(
      mode: _mode!,
      courseKey: _mode == DuelMode.subject ? _selectedCourse : null,
    );
    if (inviteId == null || !mounted) return;

    // NOTE: this domain needs to actually be owned by you and configured
    // with Android App Links / iOS Universal Links (domain verification
    // files hosted at the real site) before tapping this link on a
    // phone will open the app directly instead of a browser. The in-app
    // route (/duel-invite/:inviteId) is ready the moment that's done --
    // swap this placeholder for your real verified domain then.
    final link = 'https://edulink001.app/duel-invite/$inviteId';

    setState(() {
      _shareLink = link;
      _view = _View.linkShared;
    });

    SharePlus.instance.share(ShareParams(
      text: "I challenged you to a battle on Edulink — accept here: $link",
      sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
    ));

    _inviteSub = DuelService.inviteStream(inviteId).listen((invite) {
      final resultDuelId = invite?['resultDuelId'] as String?;
      if (resultDuelId != null && mounted) _enterDuel(resultDuelId);
    });
  }

  void _cancelLinkShare() {
    _inviteSub?.cancel();
    setState(() => _view = _View.setup);
  }

  Future<void> _acceptIncoming(String inviteId) async {
    final duelId = await DuelService.acceptChallenge(inviteId);
    if (duelId != null && mounted) _enterDuel(duelId);
  }

  void _enterDuel(String duelId) {
    _queueSub?.cancel();
    _inviteSub?.cancel();
    setState(() => _view = _View.setup);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => DuelPlayPage(duelId: duelId),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Battle', style: GoogleFonts.dmSans(
          fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    switch (_view) {
      case _View.searchingQueue:
        return _WaitingScreen(
          title: 'Finding an opponent…',
          subtitle: _mode == DuelMode.spelling ? 'Spelling battle' : (_selectedCourse ?? ''),
          onCancel: _cancelSearch,
        );
      case _View.waitingForFriend:
        return _WaitingScreen(
          title: 'Waiting for them to accept…',
          subtitle: _mode == DuelMode.spelling ? 'Spelling battle' : (_selectedCourse ?? ''),
          onCancel: _cancelFriendChallenge,
        );
      case _View.linkShared:
        return _LinkSharedScreen(link: _shareLink ?? '', onCancel: _cancelLinkShare);
      case _View.friendPicker:
        return _FriendPicker(
          onBack: () => setState(() => _view = _View.setup),
          onPick: _challengeFriend,
        );
      case _View.setup:
        return _buildSetup();
    }
  }

  Widget _buildSetup() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _IncomingInvites(onAccept: _acceptIncoming),

        Text('1. Choose a mode', style: GoogleFonts.dmSans(
          fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: _ModeCard(
            emoji: '🔤', label: 'Spelling',
            selected: _mode == DuelMode.spelling,
            onTap: () => setState(() { _mode = DuelMode.spelling; _selectedCourse = null; }),
          )),
          const SizedBox(width: 10),
          Expanded(child: _ModeCard(
            emoji: '⚔️', label: 'Subject',
            selected: _mode == DuelMode.subject,
            onTap: () => setState(() => _mode = DuelMode.subject),
          )),
        ]),

        if (_mode == DuelMode.subject) ...[
          const SizedBox(height: 24),
          Text('2. Pick a subject', style: GoogleFonts.dmSans(
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
        ],

        const SizedBox(height: 28),
        Text('3 rounds · 3:00, 3:00, 2:00 each', style: GoogleFonts.dmSans(
          fontSize: 11, color: AppColors.textTertiary)),
        const SizedBox(height: 10),

        SizedBox(width: double.infinity, child: ElevatedButton(
          onPressed: _canSearch ? _findOpponent : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text('⚔️ Find opponent', style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w600, color: Colors.white)),
        )),
        const SizedBox(height: 10),
        SizedBox(width: double.infinity, child: OutlinedButton(
          onPressed: _canSearch ? () => setState(() => _view = _View.friendPicker) : null,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.border),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text('👥 Challenge a friend', style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        )),
        const SizedBox(height: 10),
        SizedBox(width: double.infinity, child: TextButton(
          onPressed: _canSearch ? _shareViaLink : null,
          child: Text('🔗 Invite via link', style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w600, color: AppColors.accentLight)),
        )),
      ]),
    );
  }
}

class _WaitingScreen extends StatelessWidget {
  final String title, subtitle;
  final VoidCallback onCancel;
  const _WaitingScreen({required this.title, required this.subtitle, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        Text(title, style: GoogleFonts.dmSans(
          fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        Text(subtitle, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
        const SizedBox(height: 28),
        TextButton(
          onPressed: onCancel,
          child: Text('Cancel', style: GoogleFonts.dmSans(color: AppColors.error)),
        ),
      ]),
    );
  }
}

class _IncomingInvites extends StatelessWidget {
  final void Function(String inviteId) onAccept;
  const _IncomingInvites({required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: DuelService.myIncomingInvites(),
      builder: (context, snap) {
        final invites = snap.data ?? [];
        if (invites.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('CHALLENGES', style: GoogleFonts.dmSans(
              fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            ...invites.map((inv) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accentSurface,
                border: Border.all(color: AppColors.accent),
                borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${inv['fromName']} challenged you', style: GoogleFonts.dmSans(
                    fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  Text(inv['mode'] == 'spelling' ? 'Spelling battle' : (inv['courseKey'] as String? ?? 'Battle'),
                    style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
                ])),
                GestureDetector(
                  onTap: () => onAccept(inv['id'] as String),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(20)),
                    child: Text('Accept', style: GoogleFonts.dmSans(
                      fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => DuelService.declineChallenge(inv['id'] as String),
                  child: Icon(Icons.close_rounded, color: AppColors.textTertiary, size: 20),
                ),
              ]),
            )),
          ]),
        );
      },
    );
  }
}

class _FriendPicker extends StatefulWidget {
  final VoidCallback onBack;
  final void Function(Map<String, dynamic> friend) onPick;
  const _FriendPicker({required this.onBack, required this.onPick});

  @override
  State<_FriendPicker> createState() => _FriendPickerState();
}

class _FriendPickerState extends State<_FriendPicker> {
  List<Map<String, dynamic>>? _friends;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final uids = (await UserFollowService.myFriendUids()).toList();
    if (uids.isEmpty) {
      if (mounted) setState(() => _friends = []);
      return;
    }
    // Firestore whereIn caps at 30 -- chunk defensively even though a
    // student's friend list realistically won't hit that.
    const chunkSize = 30;
    final results = <Map<String, dynamic>>[];
    for (var i = 0; i < uids.length; i += chunkSize) {
      final chunk = uids.sublist(i, i + chunkSize > uids.length ? uids.length : i + chunkSize);
      final snap = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();
      results.addAll(snap.docs.map((d) => {'uid': d.id, ...d.data()}));
    }
    if (mounted) setState(() => _friends = results);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          GestureDetector(onTap: widget.onBack, child: Icon(Icons.arrow_back_rounded, color: AppColors.textTertiary)),
          const SizedBox(width: 10),
          Text('Challenge a friend', style: GoogleFonts.dmSans(
            fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        ]),
      ),
      if (_friends == null)
        const Expanded(child: Center(child: CircularProgressIndicator()))
      else if (_friends!.isEmpty)
        Expanded(child: Center(child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text('Follow each other with someone to challenge them here.',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
        )))
      else
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _friends!.length,
          itemBuilder: (context, i) {
            final f = _friends![i];
            final name = f['displayName'] as String? ?? 'Friend';
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: AppColors.accentSurface,
                child: Text(name.isNotEmpty ? name[0].toUpperCase() : 'U',
                  style: TextStyle(color: AppColors.accentLight, fontWeight: FontWeight.w700)),
              ),
              title: Text(name, style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary)),
              trailing: Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
              onTap: () => widget.onPick(f),
            );
          },
        )),
    ]);
  }
}

class _LinkSharedScreen extends StatelessWidget {
  final String link;
  final VoidCallback onCancel;
  const _LinkSharedScreen({required this.link, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text('Waiting for someone to accept…', style: GoogleFonts.dmSans(
            fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface, border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Expanded(child: Text(link, style: GoogleFonts.dmSans(
                fontSize: 11, color: AppColors.textTertiary), overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: link));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Link copied')));
                },
                child: Icon(Icons.copy_rounded, size: 16, color: AppColors.accentLight),
              ),
            ]),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: onCancel,
            child: Text('Cancel', style: GoogleFonts.dmSans(color: AppColors.error)),
          ),
        ]),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String emoji, label;
  final bool selected;
  final VoidCallback onTap;
  const _ModeCard({required this.emoji, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentSurface : AppColors.surface,
          border: Border.all(color: selected ? AppColors.accent : AppColors.border, width: selected ? 1.5 : 0.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(children: [
          Text(emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(height: 6),
          Text(label, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600,
            color: selected ? AppColors.accentLight : AppColors.textSecondary)),
        ]),
      ),
    );
  }
}