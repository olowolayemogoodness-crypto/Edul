// lib/features/social/presentation/pages/my_communities_page.dart
//
// The "Communities" nav tab -- NOT a public directory anymore. Only
// shows Rooms the current user is an approved member of, chat-list
// style, plus a separate "Requested" section for pending Room
// requests still awaiting admin approval. Tapping a joined room goes
// straight into the Room, never a Handle page.
//
// Unread is a simple presence/absence dot for this first pass, not an
// exact count -- comparing the community's live lastMessage timestamp
// against this user's own lastReadAt (fan-out field). An exact count
// would need an aggregation query per room; deferred deliberately
// rather than fabricating a number.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/community_service.dart';
import 'community_room_page.dart';
import 'community_search_page.dart';
import 'community_create_page.dart';

class MyCommunitiesPage extends StatelessWidget {
  const MyCommunitiesPage({super.key});

  Color _colorFor(String? hex) {
    if (hex == null) return AppColors.accent;
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return AppColors.accent;
    }
  }

  String _initialsFor(String name) {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).take(2).toList();
    return parts.map((p) => p[0].toUpperCase()).join();
  }

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${dt.day}/${dt.month}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            child: Row(children: [
              Text('Communities', style: GoogleFonts.dmSans(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CommunitySearchPage())),
                child: Container(
                  width: 36, height: 36,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.search_rounded, color: AppColors.textPrimary, size: 20),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CommunityCreatePage())),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.add_rounded, color: AppColors.textPrimary, size: 18),
                ),
              ),
            ]),
          ),
          Expanded(
            child: ListView(
              children: [
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: CommunityService.myJoinedRooms(),
                  builder: (context, snap) {
                    if (snap.hasError) {
                      // ignore: avoid_print
                      print('[MyCommunitiesPage] myJoinedRooms failed: ${snap.error}');
                      return Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text('Could not load your communities', style: GoogleFonts.dmSans(color: AppColors.textTertiary)),
                      );
                    }
                    if (!snap.hasData) return const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator()));
                    final rooms = snap.data!;
                    if (rooms.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text('You haven\'t joined any community rooms yet. Follow a community from the feed, then request to join its room.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(fontSize: 13.5, color: AppColors.textTertiary, height: 1.5)),
                      );
                    }
                    return Column(children: rooms.map((room) {
                      final communityId = room['communityId'] as String;
                      final name = room['name'] as String? ?? '';
                      final color = _colorFor(room['color'] as String?);
                      final lastReadAt = (room['lastReadAt'] as Timestamp?)?.toDate();

                      return StreamBuilder<Map<String, dynamic>?>(
                        stream: CommunityService.communityStream(communityId),
                        builder: (context, communitySnap) {
                          final community = communitySnap.data;
                          final lastMessage = community?['lastMessage'] as Map<String, dynamic>?;
                          final lastMessageText = lastMessage?['text'] as String?;
                          final lastSenderName = lastMessage?['senderName'] as String?;
                          final lastMessageAt = (lastMessage?['createdAt'] as Timestamp?)?.toDate();
                          final unread = lastMessageAt != null && (lastReadAt == null || lastMessageAt.isAfter(lastReadAt));

                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                CommunityService.markRoomRead(communityId);
                                Navigator.push(context, MaterialPageRoute(builder: (_) => CommunityRoomPage(
                                  communityId: communityId, communityName: name,
                                )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                child: Row(children: [
                                  Container(
                                    width: 52, height: 52,
                                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
                                    child: Center(child: Text(_initialsFor(name), style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white))),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(name, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                                      const SizedBox(height: 3),
                                      Text(
                                        lastMessageText != null ? '${lastSenderName ?? 'Someone'}: $lastMessageText' : 'No messages yet',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.dmSans(fontSize: 13, fontWeight: unread ? FontWeight.w600 : FontWeight.w500,
                                          color: unread ? AppColors.textPrimary : AppColors.textTertiary),
                                      ),
                                    ]),
                                  ),
                                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                    if (lastMessageAt != null)
                                      Text(_relativeTime(lastMessageAt), style: GoogleFonts.dmSans(fontSize: 11.5, color: AppColors.textTertiary)),
                                    if (unread) ...[
                                      const SizedBox(height: 6),
                                      Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                                    ],
                                  ]),
                                ]),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList());
                  },
                ),

                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: CommunityService.myPendingRoomRequests(),
                  builder: (context, snap) {
                    final requests = snap.data ?? [];
                    if (requests.isEmpty) return const SizedBox.shrink();
                    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                        child: Text('REQUESTED', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: AppColors.textTertiary)),
                      ),
                      ...requests.map((req) {
                        final name = req['name'] as String? ?? '';
                        final color = _colorFor(req['color'] as String?);
                        return Opacity(
                          opacity: 0.6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(children: [
                              Container(
                                width: 52, height: 52,
                                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
                                child: Center(child: Text(_initialsFor(name), style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white))),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text(name, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                                  const SizedBox(height: 2),
                                  Text('Waiting for admin approval', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
                                ]),
                              ),
                              Icon(Icons.access_time_rounded, size: 16, color: AppColors.textTertiary),
                            ]),
                          ),
                        );
                      }),
                    ]);
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}