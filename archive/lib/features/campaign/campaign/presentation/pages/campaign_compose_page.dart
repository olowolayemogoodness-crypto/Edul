// lib/features/campaign/presentation/pages/campaign_compose_page.dart
//
// Deliberately a lightweight, dedicated composer rather than a third
// retrofit of PostComposerPage -- campaign posts are simpler (no voice
// notes, no feedTarget concept, no quoted-post support) and reusing
// the upload SERVICES directly here is less risk than extending an
// already-twice-extended shared composer again.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/campaign_service.dart';
import '../../../../core/services/post_image_upload_service.dart';
import '../../../../core/services/post_video_upload_service.dart';

class CampaignComposePage extends StatefulWidget {
  final String campaignId;
  const CampaignComposePage({super.key, required this.campaignId});

  @override
  State<CampaignComposePage> createState() => _CampaignComposePageState();
}

class _CampaignComposePageState extends State<CampaignComposePage> {
  final _textCtrl = TextEditingController();
  File? _image;
  File? _video;
  bool _posting = false;

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) setState(() { _image = File(picked.path); _video = null; });
  }

  Future<void> _pickVideo() async {
    final picked = await ImagePicker().pickVideo(source: ImageSource.gallery,
      maxDuration: const Duration(seconds: PostVideoUploadService.maxDurationSeconds));
    if (picked != null) setState(() { _video = File(picked.path); _image = null; });
  }

  Future<void> _post() async {
    final text = _textCtrl.text.trim();
    if (text.isEmpty && _image == null && _video == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add a caption or media first')));
      return;
    }
    setState(() => _posting = true);
    try {
      List<String>? imageUrls;
      String? videoUrl;
      if (_image != null) imageUrls = await PostImageUploadService.uploadAll([_image!]);
      if (_video != null) videoUrl = await PostVideoUploadService.compressAndUpload(_video!);

      final result = await CampaignService.postToCompetition(
        campaignId: widget.campaignId,
        content: text,
        imageUrls: imageUrls,
        videoUrl: videoUrl,
      );
      if (!mounted) return;
      switch (result) {
        case PostResult.success:
          HapticFeedback.lightImpact();
          Navigator.of(context).pop(true);
          break;
        case PostResult.notActiveContestant:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('You\'re not an active creator in this campaign right now')));
          break;
        case PostResult.notSignedIn:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in to post')));
          break;
      }
    } catch (e) {
      debugPrint('[CampaignCompose] Post failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_image != null || _video != null ? 'Failed to upload media' : 'Failed to post'),
          action: SnackBarAction(label: 'Try again', onPressed: _post),
        ));
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
        title: Text('New entry', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _textCtrl,
            maxLines: 5,
            style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Write your caption…',
              hintStyle: GoogleFonts.dmSans(color: AppColors.textTertiary),
              border: InputBorder.none,
            ),
          ),
          if (_image != null) ...[
            const SizedBox(height: 8),
            ClipRRect(borderRadius: BorderRadius.circular(12),
              child: Image.file(_image!, height: 200, width: double.infinity, fit: BoxFit.cover)),
          ],
          if (_video != null) ...[
            const SizedBox(height: 8),
            Container(height: 100, width: double.infinity,
              decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(12)),
              child: Center(child: Icon(Icons.videocam_rounded, color: AppColors.textTertiary, size: 28))),
          ],
          const Spacer(),
          Row(children: [
            IconButton(onPressed: _pickImage, icon: Icon(Icons.image_outlined, color: AppColors.textSecondary)),
            IconButton(onPressed: _pickVideo, icon: Icon(Icons.videocam_outlined, color: AppColors.textSecondary)),
          ]),
        ]),
      ),
    );
  }
}