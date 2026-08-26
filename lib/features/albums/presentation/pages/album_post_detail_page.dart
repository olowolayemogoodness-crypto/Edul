// lib/features/albums/presentation/pages/album_post_detail_page.dart
//
// The full post -- image or video -- plus a genuine "similar posts"
// section underneath. Reuses AlbumService.similarPosts(), which
// itself reuses HashtagService's existing querying pattern, matched
// on the post's first hashtag.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/album_service.dart';
import '../../../../core/services/post_interaction_service.dart';

class AlbumPostDetailPage extends StatefulWidget {
  final Map<String, dynamic> post;
  const AlbumPostDetailPage({super.key, required this.post});

  @override
  State<AlbumPostDetailPage> createState() => _AlbumPostDetailPageState();
}

class _AlbumPostDetailPageState extends State<AlbumPostDetailPage> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    final videoUrl = widget.post['videoUrl'] as String?;
    if (videoUrl != null) {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..initialize().then((_) {
          if (mounted) setState(() {});
          _videoController!.play();
          _videoController!.setLooping(true);
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final imageUrl = post['imageUrl'] as String?;
    final isVideo = post['type'] == 'video';
    final caption = post['caption'] as String? ?? '';
    final displayName = post['displayName'] as String? ?? 'User';
    final hashtags = (post['hashtags'] as List?)?.cast<String>() ?? [];
    final postId = post['id'] as String;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.background, elevation: 0),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (isVideo)
            (_videoController != null && _videoController!.value.isInitialized)
                ? AspectRatio(aspectRatio: _videoController!.value.aspectRatio, child: VideoPlayer(_videoController!))
                : Container(height: 240, color: AppColors.surfaceVariant, child: const Center(child: CircularProgressIndicator()))
          else if (imageUrl != null)
            Image.network(imageUrl, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(displayName, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 4),
              Text(caption, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: 10),
              Row(children: [
                StreamBuilder<bool>(
                  stream: PostInteractionService.isLikedByMe(postId, collectionPath: 'album_posts'),
                  builder: (context, likedSnap) {
                    final liked = likedSnap.data ?? false;
                    return GestureDetector(
                      onTap: () => PostInteractionService.toggleLike(
                        postId, post['uid'] as String, collectionPath: 'album_posts'),
                      child: Icon(liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        color: liked ? AppColors.error : AppColors.textSecondary, size: 22),
                    );
                  },
                ),
                const SizedBox(width: 6),
                StreamBuilder<int>(
                  stream: PostInteractionService.likeCount(postId, collectionPath: 'album_posts'),
                  builder: (context, s) => Text('${s.data ?? 0}',
                    style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                ),
              ]),
            ]),
          ),
          if (hashtags.isNotEmpty) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('More #${hashtags.first}', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: AlbumService.similarPosts(hashtags, excludePostId: postId),
              builder: (context, snapshot) {
                final similar = snapshot.data ?? [];
                if (similar.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('No other posts with this tag yet', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 4, crossAxisSpacing: 4),
                  itemCount: similar.length,
                  itemBuilder: (context, i) {
                    final s = similar[i];
                    final sIsVideo = s['type'] == 'video';
                    final sImageUrl = s['imageUrl'] as String?;
                    if (!sIsVideo && sImageUrl == null) return const SizedBox.shrink();
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => AlbumPostDetailPage(post: s))),
                      child: sIsVideo
                          ? Container(color: AppColors.surfaceVariant,
                              child: Center(child: Icon(Icons.play_circle_fill_rounded, color: AppColors.accent, size: 22)))
                          : Image.network(sImageUrl!, fit: BoxFit.cover),
                    );
                  },
                );
              },
            ),
          ],
        ]),
      ),
    );
  }
}