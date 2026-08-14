// lib/features/study_rooms/presentation/pages/room_invite_link_page.dart
//
// Landing screen for a shared study-room invite link
// (edulink001.app/room-invite/{roomId}). Genuinely simpler than the
// duel invite link version: a study room isn't private or matched --
// anyone can already see room info and join, same as browsing the
// room list. So this is just a route + a nicer single-room preview,
// not a separate invites collection or claim transaction like duels
// needed.
//
// NOTE: same as the duel invite link -- this is the in-app half only.
// Making the link actually open the app when tapped cold (e.g. from a
// WhatsApp status) needs Android App Links / iOS Universal Links
// configured on the real domain. Ready the moment that's done.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/study_room_service.dart';
import '../../../../core/services/user_service.dart';

class RoomInviteLinkPage extends StatefulWidget {
  final String roomId;
  const RoomInviteLinkPage({super.key, required this.roomId});

  @override
  State<RoomInviteLinkPage> createState() => _RoomInviteLinkPageState();
}

class _RoomInviteLinkPageState extends State<RoomInviteLinkPage> {
  bool _joining = false;

  Future<void> _join(StudyRoom room) async {
    setState(() => _joining = true);
    try {
      final name = await UserService.getProfile().then((p) => p?['displayName'] as String? ?? 'Student');
      await StudyRoomService.instance.joinRoom(widget.roomId, displayName: name);
      if (!mounted) return;
      Navigator.of(context).pop(); // let the caller (usually the app's
      // own study rooms tab) pick this room up via its own room stream --
      // this landing page's only job is getting you INTO the room, not
      // rendering the chat itself.
    } catch (e) {
      if (!mounted) return;
      setState(() => _joining = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: StreamBuilder<StudyRoom>(
          stream: StudyRoomService.instance.roomStream(widget.roomId),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final room = snap.data;
            if (room == null || room.isExpiredNow || room.status != 'active') {
              return _buildError();
            }
            return _buildInvite(room);
          },
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('⏰', style: TextStyle(fontSize: 40)),
          const SizedBox(height: 14),
          Text('This room has ended or no longer exists.', textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: Text('Go back', style: GoogleFonts.dmSans(color: AppColors.accentLight)),
          ),
        ]),
      ),
    );
  }

  Widget _buildInvite(StudyRoom room) {
    final full = room.isFull;
    final mins = room.remaining.inMinutes.clamp(0, 999);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (room.coverImageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(room.coverImageUrl!, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: AppColors.surfaceVariant)),
              ),
            )
          else
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(color: AppColors.accentSurface, shape: BoxShape.circle),
              child: Icon(Icons.groups_rounded, color: AppColors.accentLight, size: 30),
            ),
          const SizedBox(height: 20),
          Text(room.title, textAlign: TextAlign.center, style: GoogleFonts.dmSans(
            fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text(room.courseTag ?? 'General study', style: GoogleFonts.dmSans(
            fontSize: 13, color: AppColors.textTertiary)),
          const SizedBox(height: 4),
          Text('${room.participantCount}/${room.maxParticipants} students · $mins min left',
            style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
          const SizedBox(height: 28),
          SizedBox(width: double.infinity, child: ElevatedButton(
            onPressed: (_joining || full) ? null : () => _join(room),
            style: ElevatedButton.styleFrom(
              backgroundColor: full ? AppColors.surfaceVariant : AppColors.accent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _joining
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : Text(full ? 'Room is full' : 'Join room', style: GoogleFonts.dmSans(
                    color: full ? AppColors.textDisabled : Colors.white, fontWeight: FontWeight.w600)),
          )),
        ]),
      ),
    );
  }
}