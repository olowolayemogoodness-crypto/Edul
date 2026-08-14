// lib/features/notifications/presentation/pages/notifications_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/notifications_service.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  IconData _iconFor(String type) {
    switch (type) {
      case 'like':
        return Icons.favorite_rounded;
      case 'like_milestone':
        return Icons.celebration_rounded;
      case 'comment':
        return Icons.chat_bubble_rounded;
      case 'reply':
        return Icons.reply_rounded;
      case 'follow':
        return Icons.person_add_rounded;
      case 'repost':
        return Icons.repeat_rounded;
      case 'duel_challenge':
        return Icons.sports_martial_arts_rounded;
      case 'duel_result':
        return Icons.emoji_events_rounded;
      case 'badge_eligible':
        return Icons.workspace_premium_rounded;
      case 'system':
      case 'welcome':
        return Icons.school_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  String _timeAgo(DateTime? dt) {
    if (dt == null) return '';
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
        leading: GestureDetector(
          onTap: () => context.canPop() ? context.pop() : null,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.arrow_back_rounded,
                color: AppColors.textPrimary, size: 24),
          ),
        ),
        title: Text('Notifications',
            style: GoogleFonts.dmSans(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary)),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: NotificationService.stream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            );
          }

          if (snapshot.hasError) {
            return _ErrorState(error: snapshot.error.toString());
          }

          final notifications = snapshot.data ?? [];

          if (notifications.isEmpty) {
            return const _EmptyState();
          }

          final unreadIds = notifications
              .where((n) => n['read'] != true)
              .map((n) => n['id'] as String)
              .toList();

          return Column(
            children: [
              if (unreadIds.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            NotificationService.markAllAsRead(unreadIds),
                        child: Text('Mark all as read',
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.accentLight,
                            )),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final n = notifications[i];
                    final isUnread = n['read'] != true;
                    final createdAt =
                        (n['createdAt'] as Timestamp?)?.toDate();

                    return GestureDetector(
                      onTap: () {
                        if (isUnread) {
                          NotificationService.markAsRead(n['id'] as String);
                        }
                        final type = n['type'] as String?;
                        final postId = n['postId'] as String?;
                        // These are exactly the types that carry a real
                        // postId -- comment/reply/like/repost/new_post
                        // all point at a specific piece of content, so
                        // "take me to the post" is the only sensible
                        // destination. Other types (follow, welcome,
                        // duel_challenge, etc.) don't have a post to go
                        // to, so they're deliberately left as just
                        // marking read for now.
                        if (postId != null &&
                            ['comment', 'reply', 'like_milestone', 'repost', 'new_post'].contains(type)) {
                          context.push('/post/$postId');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isUnread
                              ? AppColors.accentSurface.withOpacity(0.35)
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isUnread
                                ? AppColors.accent.withOpacity(0.4)
                                : AppColors.border,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColors.accentSurface,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _iconFor(n['type'] as String? ?? ''),
                                color: AppColors.accentLight,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          n['title'] as String? ?? '',
                                          style: GoogleFonts.dmSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                      if (isUnread)
                                        Container(
                                          width: 8,
                                          height: 8,
                                          margin:
                                              const EdgeInsets.only(left: 6),
                                          decoration: BoxDecoration(
                                            color: AppColors.accent,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    n['body'] as String? ?? '',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _timeAgo(createdAt),
                                    style: GoogleFonts.dmSans(
                                      fontSize: 11,
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  const _ErrorState({required this.error});

  @override
  Widget build(BuildContext context) {
    // Most likely cause: Firestore needs a composite index for this query
    // (it filters on `uid` AND orders by a different field, `createdAt`) —
    // that combination isn't covered by Firestore's automatic single-field
    // indexes. If that's it, the real Firestore error (visible below, and
    // in your device logs) contains a direct link to auto-create the
    // missing index in the Firebase Console.
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, color: AppColors.error, size: 32),
            const SizedBox(height: 16),
            Text('Couldn\'t load notifications',
                style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            Text(error,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                    fontSize: 12, color: AppColors.textTertiary)),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.notifications_none_rounded,
                color: AppColors.textTertiary, size: 32),
          ),
          const SizedBox(height: 16),
          Text('No notifications yet',
              style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text("We'll let you know when something happens",
              style: GoogleFonts.dmSans(
                  fontSize: 13, color: AppColors.textTertiary)),
        ],
      ),
    );
  }
}