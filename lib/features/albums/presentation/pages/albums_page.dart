// lib/features/albums/presentation/pages/albums_page.dart
//
// A genuine Pinterest-style masonry feed -- each tile's height is
// driven by its own image's natural aspect ratio, not forced uniform,
// which is what actually creates the staggered look. No more
// "create an album" concept -- posts flow directly, grouped only by
// hashtag. Tapping a post opens it with similar-hashtag posts
// underneath.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/album_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/post_interaction_service.dart';
import 'album_post_detail_page.dart';
import 'create_album_post_page.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        title: Text('Albums', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.accent,
          unselectedLabelColor: AppColors.textTertiary,
          indicatorColor: AppColors.accent,
          labelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500),
          tabs: const [Tab(text: 'Featured'), Tab(text: 'Archive')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MasonryFeed(stream: AlbumService.featuredPosts(), emptyLabel: 'No posts featured this week yet'),
          _MasonryFeed(stream: AlbumService.archivedPosts(), emptyLabel: 'Nothing in the archive yet'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.add_a_photo_outlined, color: Colors.white),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateAlbumPostPage())),
      ),
    );
  }
}

class _MasonryFeed extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> stream;
  final String emptyLabel;
  const _MasonryFeed({required this.stream, required this.emptyLabel});

  Future<void> _confirmDelete(BuildContext context, String postId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete this post?', style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)),
        content: Text('This can\'t be undone.', style: GoogleFonts.dmSans(fontSize: 13)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true),
            child: Text('Delete', style: TextStyle(color: AppColors.error))),
        ],
      ),
    );
    if (confirmed != true) return;
    final result = await AlbumService.deletePost(postId);
    if (result == DeleteAlbumPostResult.success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post deleted')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        final posts = snapshot.data ?? [];
        if (posts.isEmpty) {
          return Center(child: Text(emptyLabel, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)));
        }

        return MasonryGridView.count(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 90),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: posts.length,
          itemBuilder: (context, i) {
            final p = posts[i];
            final postId = p['id'] as String;
            final isOwner = p['uid'] == UserService.uid;

            return _AlbumTile(
              post: p,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AlbumPostDetailPage(post: p))),
              onLongPress: isOwner ? () => _confirmDelete(context, postId) : null,
            );
          },
        );
      },
    );
  }
}

class _AlbumTile extends StatefulWidget {
  final Map<String, dynamic> post;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  const _AlbumTile({required this.post, required this.onTap, this.onLongPress});

  @override
  State<_AlbumTile> createState() => _AlbumTileState();
}

class _AlbumTileState extends State<_AlbumTile> with SingleTickerProviderStateMixin {
  late final AnimationController _heartController = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 500));
  late final Animation<double> _heartScale = TweenSequence([
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.3).chain(CurveTween(curve: Curves.easeOut)), weight: 40),
    TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), weight: 20),
  ]).animate(_heartController);

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    final postId = widget.post['id'] as String;
    final ownerUid = widget.post['uid'] as String;
    PostInteractionService.toggleLike(postId, ownerUid, collectionPath: 'album_posts');
    _heartController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final isVideo = widget.post['type'] == 'video';
    final imageUrl = widget.post['imageUrl'] as String?;
    if (!isVideo && imageUrl == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onDoubleTap: _handleDoubleTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(alignment: Alignment.center, children: [
          isVideo
              // No thumbnail-generation service exists yet, so this is
              // a genuine, honest placeholder -- a fixed-height tile
              // with a play icon, not a real preview frame from the
              // video itself.
              ? Container(
                  height: 180, color: AppColors.surfaceVariant,
                  child: Center(child: Icon(Icons.play_circle_fill_rounded, color: AppColors.accent, size: 40)),
                )
              : Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  // Deliberately no fixed height -- letting the image
                  // render at its own natural aspect ratio within the
                  // MasonryGridView is exactly what produces the
                  // staggered, Pinterest look instead of a uniform grid.
                  errorBuilder: (_, __, ___) => Container(
                    height: 140, color: AppColors.surfaceVariant,
                    child: Icon(Icons.broken_image_outlined, color: AppColors.textTertiary)),
                ),
          ScaleTransition(
            scale: _heartScale,
            child: Icon(Icons.favorite_rounded, color: Colors.white, size: 64,
              shadows: const [Shadow(color: Colors.black38, blurRadius: 12)]),
          ),
          Positioned(
            right: 8, bottom: 8,
            child: StreamBuilder<int>(
              stream: PostInteractionService.likeCount(widget.post['id'] as String, collectionPath: 'album_posts'),
              builder: (context, snap) {
                final count = snap.data ?? 0;
                if (count == 0) return const SizedBox.shrink(); // don't clutter a fresh, unliked post
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.55), borderRadius: BorderRadius.circular(12)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.favorite_rounded, color: Colors.white, size: 12),
                    const SizedBox(width: 4),
                    Text('$count', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
                  ]),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}