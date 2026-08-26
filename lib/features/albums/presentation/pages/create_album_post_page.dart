// lib/features/albums/presentation/pages/create_album_post_page.dart
//
// Deliberately low-friction: one merged "Add media" picker for both
// photos and videos (using ImagePicker.pickMedia(), not two separate
// buttons), plus a caption with a hashtag typed naturally into it,
// same pattern as regular posts. Note: pickMedia() doesn't support a
// maxDuration limit the way pickVideo() did, so the previous 60-second
// pick-time cap no longer applies here -- a real, honest tradeoff of
// merging the two flows, not an oversight.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/album_service.dart';

class CreateAlbumPostPage extends StatefulWidget {
  const CreateAlbumPostPage({super.key});

  @override
  State<CreateAlbumPostPage> createState() => _CreateAlbumPostPageState();
}

class _CreateAlbumPostPageState extends State<CreateAlbumPostPage> {
  static const _suggestedTags = ['orientationweek', 'campuslife', 'classdinner', 'sportsday', 'memes', 'graduation'];
  static const _videoExtensions = ['.mp4', '.mov', '.avi', '.mkv', '.webm', '.3gp'];

  final _captionCtrl = TextEditingController();
  File? _image;
  File? _video;
  bool _posting = false;

  @override
  void dispose() {
    _captionCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickMedia() async {
    final picked = await ImagePicker().pickMedia();
    if (picked == null) return;
    final path = picked.path.toLowerCase();
    final isVideo = _videoExtensions.any((ext) => path.endsWith(ext));
    setState(() {
      if (isVideo) {
        _video = File(picked.path);
        _image = null;
      } else {
        _image = File(picked.path);
        _video = null;
      }
    });
  }

  void _insertTag(String tag) {
    final current = _captionCtrl.text;
    _captionCtrl.text = current.isEmpty ? '#$tag ' : '$current #$tag ';
    _captionCtrl.selection = TextSelection.fromPosition(TextPosition(offset: _captionCtrl.text.length));
  }

  Future<void> _post() async {
    if (_image == null && _video == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add a photo or video first')));
      return;
    }
    setState(() => _posting = true);
    try {
      final result = await AlbumService.post(image: _image, video: _video, caption: _captionCtrl.text);
      if (!mounted) return;
      switch (result) {
        case PostToAlbumsResult.success:
          HapticFeedback.lightImpact();
          Navigator.of(context).pop(true);
          break;
        case PostToAlbumsResult.needsHashtag:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Add at least one #hashtag so people can find this')));
          break;
        case PostToAlbumsResult.notSignedIn:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in to post')));
          break;
        case PostToAlbumsResult.uploadFailed:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Upload failed'),
            action: SnackBarAction(label: 'Try again', onPressed: _post),
          ));
          break;
      }
    } finally {
      if (mounted) setState(() => _posting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        title: Text('New post', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: _posting ? null : _post,
              child: _posting
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text('Post', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.accent)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
            onTap: _pickMedia,
            child: Container(
              height: 220, width: double.infinity,
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
              clipBehavior: Clip.antiAlias,
              child: _image != null
                  ? Image.file(_image!, fit: BoxFit.cover, width: double.infinity)
                  : _video != null
                      ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.videocam_rounded, color: AppColors.accent, size: 32),
                          const SizedBox(height: 8),
                          Text('Video selected', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
                        ]))
                      : Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.add_photo_alternate_outlined, color: AppColors.textTertiary, size: 32),
                          const SizedBox(height: 8),
                          Text('Tap to add a photo or video', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
                        ])),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _captionCtrl,
            maxLines: 3,
            style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Write a caption with a #hashtag…',
              hintStyle: GoogleFonts.dmSans(color: AppColors.textTertiary),
              filled: true, fillColor: AppColors.surface,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.border)),
            ),
          ),
          const SizedBox(height: 14),
          Text('Suggested tags', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: _suggestedTags.map((tag) {
            return GestureDetector(
              onTap: () => _insertTag(tag),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(16)),
                child: Text('#$tag', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
              ),
            );
          }).toList()),
        ]),
      ),
    );
  }
}