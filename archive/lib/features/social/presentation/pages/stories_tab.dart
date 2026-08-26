// lib/features/social/presentation/pages/stories_tab.dart
//
// Real data now (StoryService.activeStoriesByUser()), matching the
// approved mockup: 4 avatars per row, gradient ring = unwatched, gray
// ring = watched, watched entries sink toward the end of the list.
//
// The "Add Story" entry point lives here as a public method
// (showAddStorySheet) so SocialPage's shared FAB can call it directly,
// rather than duplicating the bottom-sheet logic in two places.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/story_service.dart';
import '../../../../core/services/post_image_upload_service.dart';
import '../../../../core/services/post_video_upload_service.dart';
import '../../../../core/widgets/voice_note_bubble.dart';
import 'story_caption_compose_page.dart';
import 'story_viewer_page.dart';

class StoriesTab extends StatelessWidget {
  const StoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: StoryService.activeStoriesByUser(),
      builder: (context, snapshot) {
        final stories = snapshot.data ?? [];

        if (stories.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('📖', style: const TextStyle(fontSize: 40)),
                const SizedBox(height: 12),
                Text('No stories yet', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text('Tap the + button to share your first one',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
              ]),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: 16, crossAxisSpacing: 8, childAspectRatio: 0.75),
          itemCount: stories.length,
          itemBuilder: (context, i) {
            final s = stories[i];
            final watched = s['watched'] as bool? ?? false;
            final uid = s['uid'] as String;
            final name = (s['usernameDisplay'] as String?)?.isNotEmpty == true
                ? '@${s['usernameDisplay']}' : (s['displayName'] as String? ?? 'User');
            final photoUrl = s['photoUrl'] as String?;
            final ringColor = voiceNoteColor(uid); // same per-user color law as voice notes
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => StoryViewerPage(uid: uid))),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: watched ? null : LinearGradient(colors: [ringColor, ringColor.withOpacity(0.6)]),
                    border: watched ? Border.all(color: AppColors.border, width: 2) : null,
                  ),
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.accentSurface,
                    backgroundImage: (photoUrl != null && photoUrl.isNotEmpty) ? NetworkImage(photoUrl) : null,
                    child: (photoUrl == null || photoUrl.isEmpty)
                        ? Text(name.replaceAll('@', '').isNotEmpty ? name.replaceAll('@', '')[0].toUpperCase() : 'U',
                            style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.accent))
                        : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(name, style: GoogleFonts.dmSans(fontSize: 10.5, color: watched ? AppColors.textTertiary : AppColors.textSecondary),
                  overflow: TextOverflow.ellipsis, maxLines: 1),
              ]),
            );
          },
        );
      },
    );
  }
}

/// Called from SocialPage's shared FAB, only visible on the Stories tab.
Future<void> showAddStorySheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Add to your story', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 18),
          _StoryOptionTile(
            icon: Icons.photo_camera_outlined, label: 'Photo',
            onTap: () { Navigator.pop(sheetContext); _postMedia(context, isVideo: false); },
          ),
          _StoryOptionTile(
            icon: Icons.videocam_outlined, label: 'Video',
            onTap: () { Navigator.pop(sheetContext); _postMedia(context, isVideo: true); },
          ),
          _StoryOptionTile(
            icon: Icons.edit_note_rounded, label: 'Caption only',
            onTap: () async {
              Navigator.pop(sheetContext);
              await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StoryCaptionComposePage()));
            },
          ),
        ]),
      ),
    ),
  );
}

Future<void> _postMedia(BuildContext context, {required bool isVideo}) async {
  final picker = ImagePicker();
  final picked = isVideo
      ? await picker.pickVideo(source: ImageSource.gallery, maxDuration: const Duration(seconds: PostVideoUploadService.maxDurationSeconds))
      : await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
  if (picked == null || !context.mounted) return;

  final captionCtrl = TextEditingController();
  final confirmed = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (sheetContext) => Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Add a caption? (optional)', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        TextField(
          controller: captionCtrl,
          style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: 'Say something about this…',
            hintStyle: GoogleFonts.dmSans(color: AppColors.textTertiary),
            filled: true, fillColor: AppColors.surfaceVariant,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: ElevatedButton(
          onPressed: () => Navigator.pop(sheetContext, true),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          child: Text('Post to story', style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w600)),
        )),
      ]),
    ),
  );
  if (confirmed != true || !context.mounted) return;

  showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator()));
  try {
    final file = File(picked.path);
    final mediaUrl = isVideo
        ? await PostVideoUploadService.compressAndUpload(file)
        : (await PostImageUploadService.uploadAll([file])).first;
    await StoryService.postStory(
      type: isVideo ? StoryType.video : StoryType.image,
      mediaUrl: mediaUrl,
      textContent: captionCtrl.text.trim().isEmpty ? null : captionCtrl.text.trim(),
    );
    if (context.mounted) Navigator.pop(context); // close loading dialog
    HapticFeedback.lightImpact();
  } catch (e) {
    if (context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not post story: $e')));
    }
  }
}

class _StoryOptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _StoryOptionTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(width: 40, height: 40,
        decoration: BoxDecoration(color: AppColors.accentSurface, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: AppColors.accent, size: 20)),
      title: Text(label, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
    );
  }
}