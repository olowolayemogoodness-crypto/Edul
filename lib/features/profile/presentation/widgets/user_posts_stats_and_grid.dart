// lib/features/profile/presentation/widgets/user_posts_stats_and_grid.dart
//
// Replaces the old streak/study-activity sections on the Profile
// tab. Stats (post count, total likes) are computed client-side from
// the same fetched post list, rather than a separate aggregation
// query -- one user's own posts is a small, bounded list, so this is
// cheap and avoids maintaining a separate denormalized counter.
//
// REQUIRED Firestore index -- this query combines a where() and an
// orderBy() on different fields, which Firestore needs a composite
// index for. Without it this silently fails (shows the empty state,
// or errors to console via the print below). Open this screen once,
// check the terminal for a Firestore error with a direct console
// link, and create the index it points to.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../social/presentation/pages/social_feed_page.dart' show PostCard;

class UserPostsStatsAndGrid extends StatelessWidget {
  final String uid;
  const UserPostsStatsAndGrid({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('posts')
          .where('uid', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snap) {
        if (snap.hasError) {
          // ignore: avoid_print
          print('[UserPostsStatsAndGrid] posts query failed: ${snap.error}');
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Could not load posts', style: GoogleFonts.dmSans(color: AppColors.textTertiary)),
          );
        }
        if (!snap.hasData) {
          return const Padding(padding: EdgeInsets.all(20), child: Center(child: CircularProgressIndicator()));
        }
        final posts = snap.data!.docs.map((d) => {'id': d.id, ...d.data()}).toList();
        final postCount = posts.length;
        final totalLikes = posts.fold<int>(0, (sum, p) => sum + ((p['likeCount'] as num?)?.toInt() ?? 0));

        return Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(children: [
              Expanded(child: _stat('$postCount', 'Posts')),
              Container(width: 1, height: 32, color: AppColors.border),
              Expanded(child: _stat('$totalLikes', 'Likes')),
            ]),
          ),
          if (posts.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text('No posts yet', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
              itemCount: posts.length,
              itemBuilder: (context, i) {
                final post = posts[i];
                final imgs = (post['imageUrls'] as List<dynamic>?) ?? [];
                final thumb = imgs.isNotEmpty ? imgs.first as String : null;
                final content = post['content'] as String? ?? '';

                return GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                    builder: (_) => DraggableScrollableSheet(
                      initialChildSize: 0.85, expand: false,
                      builder: (context, controller) => Container(
                        decoration: BoxDecoration(color: AppColors.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
                        child: ListView(controller: controller, children: [PostCard(key: ValueKey(post['id']), post: post)]),
                      ),
                    ),
                  ),
                  child: thumb != null
                      ? Image.network(thumb, fit: BoxFit.cover)
                      : Container(
                          color: AppColors.card,
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.topLeft,
                          child: Text(content, maxLines: 5, overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textPrimary)),
                        ),
                );
              },
            ),
        ]);
      },
    );
  }

  Widget _stat(String value, String label) {
    return Column(children: [
      Text(value, style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      const SizedBox(height: 2),
      Text(label, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
    ]);
  }
}