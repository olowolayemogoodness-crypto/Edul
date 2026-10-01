// lib/features/social/presentation/pages/community_join_requests_page.dart
//
// Admin-only: see and act on pending Room join requests. Reached from
// the Handle page, visible only when the current user is an admin of
// this community (checked before navigating here, not re-checked on
// this screen itself -- the actual enforcement is the Firestore rule
// on approveJoinRequest/denyJoinRequest, which requires admin role
// server-side regardless of what this screen shows).

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/community_service.dart';
import '../../../../core/widgets/user_avatar.dart';

class CommunityJoinRequestsPage extends StatelessWidget {
  final String communityId;
  final String communityName;
  const CommunityJoinRequestsPage({super.key, required this.communityId, required this.communityName});

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Join requests', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: CommunityService.pendingJoinRequests(communityId),
          builder: (context, snap) {
            if (snap.hasError) {
              // ignore: avoid_print
              print('[CommunityJoinRequestsPage] pendingJoinRequests failed: ${snap.error}');
              return Center(child: Text('Could not load requests', style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
            }
            if (!snap.hasData) return const Center(child: CircularProgressIndicator());
            final requests = snap.data!;
            if (requests.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text('No pending requests', style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textTertiary)),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              itemCount: requests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final req = requests[i];
                final uid = req['uid'] as String;
                final displayName = req['displayName'] as String? ?? 'User';
                final requestedAt = req['requestedAt'] as Timestamp?;
                final requestedDt = requestedAt?.toDate();

                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16)),
                  child: Row(children: [
                    UserAvatar(uid: uid, displayName: displayName, size: 44),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(displayName, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        const SizedBox(height: 2),
                        Text(
                          requestedDt != null ? 'Requested ${_relativeTime(requestedDt)}' : 'Requested to join',
                          style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary),
                        ),
                      ]),
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await CommunityService.denyJoinRequest(communityId, uid);
                        } catch (e) {
                          // ignore: avoid_print
                          print('[CommunityJoinRequestsPage] denyJoinRequest failed: $e');
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not deny: $e')));
                          }
                        }
                      },
                      icon: const Icon(Icons.close_rounded),
                      color: AppColors.textTertiary,
                      tooltip: 'Deny',
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          await CommunityService.approveJoinRequest(communityId, uid);
                        } catch (e) {
                          // ignore: avoid_print
                          print('[CommunityJoinRequestsPage] approveJoinRequest failed: $e');
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not approve: $e')));
                          }
                        }
                      },
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                        child: const Icon(Icons.check_rounded, color: Colors.white, size: 18),
                      ),
                    ),
                  ]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}