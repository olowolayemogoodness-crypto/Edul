// lib/features/social/presentation/pages/post_composer_page.dart

import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/post_image_upload_service.dart';
import '../../../../core/services/post_video_upload_service.dart';
import '../../../../core/services/premium_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/notifications_service.dart';
import '../../../../core/services/hashtag_service.dart';
import '../../../../core/services/voice_note_service.dart';

class PostComposerPage extends StatefulWidget {
  final Map<String, dynamic>? quotedPost;
  final String? initialTarget;
  final String? groupId;
  final String? groupName;
  const PostComposerPage({super.key, this.quotedPost, this.initialTarget, this.groupId, this.groupName});

  @override
  State<PostComposerPage> createState() => _PostComposerPageState();
}

class _PostComposerPageState extends State<PostComposerPage> {
  final _textCtrl = TextEditingController();
  final _picker = ImagePicker();
  final List<File> _images = [];
  final PageController _imagePreviewController = PageController();
  int _imagePreviewIndex = 0;
  File? _video;
  VideoPlayerController? _videoPreviewController;
  String _uploadStatus = '';
  String _feedTarget = 'global';
  bool _posting = false;
  double _uploadProgress = 0.0;
  String _university = 'My Uni';

  RecordingResult? _voiceNote;
  bool _isRecording = false;
  int _recordingSeconds = 0;
  Timer? _recordTimer;

  static const int _maxChars = 500;
  int get _maxImages => PremiumService.isPro ? 5 : 3;
  bool get _canPost =>
      (_textCtrl.text.trim().isNotEmpty || _voiceNote != null ||
       _images.isNotEmpty || _video != null) && !_posting;

  @override
  void initState() {
    super.initState();
    if (widget.initialTarget != null) _feedTarget = widget.initialTarget!;
    _loadUniversity();
    _textCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _imagePreviewController.dispose();
    _videoPreviewController?.dispose();
    _recordTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadUniversity() async {
    final prefs = await SharedPreferences.getInstance();
    final uni = prefs.getString('user_university') ?? 'My Uni';
    if (mounted) setState(() => _university = uni);
  }

  Future<void> _pickImage() async {
    if (_images.length >= _maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Maximum $_maxImages images on your plan',
          style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating));
      return;
    }
    final picked = await _picker.pickImage(
      source: ImageSource.gallery, imageQuality: 80, maxWidth: 1080);
    if (picked != null && mounted) {
      setState(() {
        _images.add(File(picked.path));
        _clearVideo(); // a post is either photos or a video, not both
      });
    }
  }

  void _clearVideo() {
    _videoPreviewController?.dispose();
    _videoPreviewController = null;
    _video = null;
  }

  Future<void> _pickVideo() async {
    final picked = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: PostVideoUploadService.maxDurationSeconds),
    );
    if (picked == null || !mounted) return;

    final controller = VideoPlayerController.file(File(picked.path));
    try {
      await controller.initialize();
    } catch (e) {
      controller.dispose();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Could not read that video: $e',
            style: GoogleFonts.dmSans(fontSize: 13)),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating));
      }
      return;
    }

    setState(() {
      _images.clear(); // a post is either photos or a video, not both
      _video = File(picked.path);
      _videoPreviewController = controller..setLooping(true)..play();
    });
  }

  Future<void> _startRecording() async {
    try {
      await VoiceNoteService.startRecording();
      if (!mounted) return;
      setState(() {
        _isRecording = true;
        _recordingSeconds = 0;
      });
      _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() => _recordingSeconds++);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Could not start recording: $e',
          style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating));
    }
  }

  Future<void> _cancelRecording() async {
    _recordTimer?.cancel();
    await VoiceNoteService.cancelRecording();
    if (mounted) {
      setState(() {
        _isRecording = false;
        _recordingSeconds = 0;
      });
    }
  }

  Future<void> _attachRecording() async {
    _recordTimer?.cancel();
    setState(() => _isRecording = false);
    final result = await VoiceNoteService.stopRecording();
    if (result != null && mounted) {
      setState(() => _voiceNote = result);
    }
  }

  void _removeVoiceNote() => setState(() => _voiceNote = null);

  Future<void> _post() async {
    if (!_canPost) return;
    setState(() {
      _posting = true;
      _uploadProgress = 0.0;
    });
    HapticFeedback.lightImpact();
    try {
      final uid = UserService.uid;
      if (uid == null) throw Exception('Not logged in');

      List<String> imageUrls = [];
      if (_images.isNotEmpty) {
        imageUrls = await PostImageUploadService.uploadAll(
          _images,
          onProgress: (p) {
            if (mounted) setState(() => _uploadProgress = p);
          },
        );
      }

      String? videoUrl;
      if (_video != null) {
        videoUrl = await PostVideoUploadService.compressAndUpload(
          _video!,
          onStatus: (status) {
            if (mounted) setState(() => _uploadStatus = status);
          },
        );
      }

      String? audioUrl;
      if (_voiceNote != null) {
        audioUrl = await VoiceNoteService.uploadVoiceNote(_voiceNote!.file);
      }

      final profile = await UserService.getProfile();
      final displayName = profile?['displayName'] as String? ?? 'User';
      final usernameDisplay = profile?['usernameDisplay'] as String?;
      final uni = profile?['university'] as String? ?? _university;
      final course = profile?['course'] as String? ?? '';
      final studentType = profile?['studentType'] as String? ?? 'university';
      final postText = _textCtrl.text.trim();
      final hashtags = HashtagService.extractHashtags(postText);
      final isGroupPost = widget.groupId != null;
      final collectionRef = isGroupPost
          ? FirebaseFirestore.instance.collection('groups').doc(widget.groupId).collection('posts')
          : FirebaseFirestore.instance.collection('posts');
      final postRef = await collectionRef.add({
        'uid': uid,
        'displayName': displayName,
        'usernameDisplay': usernameDisplay,
        'university': uni,
        'course': course,
        'studentType': studentType,
        'content': postText,
        'hashtags': hashtags,
        'imageUrls': imageUrls,
        if (videoUrl != null) 'videoUrl': videoUrl,
        if (audioUrl != null) 'audioUrl': audioUrl,
        if (audioUrl != null) 'durationMs': _voiceNote!.durationMs,
        if (audioUrl != null) 'waveform': _voiceNote!.waveform,
        if (widget.quotedPost != null) 'quotedPostId': widget.quotedPost!['id'],
        // Group posts don't use feedTarget -- that field only makes
        // sense for the main feed's Global/Uni/News scoping.
        if (!isGroupPost) 'feedTarget': _feedTarget,
        'likeCount': 0, 'commentCount': 0, 'repostCount': 0, 'views': 0,
        'verified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (!isGroupPost) {
        _notifyFollowers(uid, displayName, postRef.id);
      } else {
        NotificationService.notifyGroupMembers(
          groupId: widget.groupId!,
          excludeUid: uid,
          title: '$displayName posted in ${widget.groupName ?? "your group"}',
          body: postText.isEmpty ? 'Shared something new' : postText,
          data: {'type': 'group_post', 'groupId': widget.groupId, 'postId': postRef.id},
        );
      }
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      debugPrint('[PostComposer] Post failed: $e');
      final message = _images.isNotEmpty || _video != null || _voiceNote != null
          ? 'Failed to upload media'
          : 'Failed to post';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message,
          style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 6),
        action: SnackBarAction(
          label: 'Try again',
          textColor: Colors.white,
          // Everything typed/selected is still sitting in state at this
          // point -- the failure happened during upload, not before it,
          // so a retry just re-runs the exact same submission rather
          // than needing the person to redo anything.
          onPressed: _post,
        ),
      ));
    } finally {
      if (mounted) setState(() {
        _posting = false;
        _uploadProgress = 0.0;
      });
    }
  }

  /// Notifies people who follow this user that a new post went up. Capped
  /// at 500 followers per post — a client-side fan-out beyond that starts
  /// to risk slow/expensive writes on a single post action. If Edulink's
  /// average follower count grows well past this, move this fan-out to a
  /// Cloud Function triggered on post creation instead.
  Future<void> _notifyFollowers(String posterUid, String posterName, String postId) async {
    await NotificationService.notifyFollowersOfNewContent(
      posterUid: posterUid,
      posterName: posterName,
      postId: postId,
      title: '$posterName shared a new post',
    );
  }

  @override
  Widget build(BuildContext context) {
    final charCount = _textCtrl.text.length;
    final charColor = charCount > _maxChars * 0.9
        ? AppColors.error : AppColors.accentLight.withOpacity(0.5);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Stack(fit: StackFit.expand, children: [
        // ── Galaxy background ─────────────────────────────────────────────
        const _GalaxyBackground(),

        // ── Content ───────────────────────────────────────────────────────
        SafeArea(
          child: Column(children: [
            // Top bar -- close + post button only. Pills used to live in
            // this same Row between two Spacers, which is exactly what
            // overflowed once a third pill (Aspirants) was added: fixed
            // elements plus growing content in one un-scrollable Row.
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: Row(children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24)),
                    child: const Icon(Icons.close_rounded,
                      color: Colors.white70, size: 18)),
                ),
                const Spacer(),
                // Post button
                GestureDetector(
                  onTap: _canPost ? _post : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: _canPost
                          ? AppColors.accent
                          : Colors.white12,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _canPost
                            ? AppColors.accent : Colors.white24),
                    ),
                    child: _posting
                        ? Row(mainAxisSize: MainAxisSize.min, children: [
                            const SizedBox(width: 14, height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white)),
                            if (_images.isNotEmpty && _uploadProgress < 1.0) ...[
                              const SizedBox(width: 6),
                              Text('${(_uploadProgress * 100).toInt()}%',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11, color: Colors.white70)),
                            ] else if (_video != null && _uploadStatus.isNotEmpty) ...[
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(_uploadStatus,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 11, color: Colors.white70)),
                              ),
                            ],
                          ])
                        : Text('Post', style: GoogleFonts.dmSans(
                            fontSize: 13, fontWeight: FontWeight.w600,
                            color: _canPost
                                ? Colors.white : Colors.white38)),
                  ),
                ),
              ]),
            ),

            const SizedBox(height: 8),

            // Feed target -- a fixed "Posting to" label, then the pills
            // scrolling beside it in the SAME row. Deliberately merged
            // into one row instead of two (a label row above a pills
            // row) -- that split was most of what pushed this screen
            // into overflow after Aspirants added a third pill.
            //
            // Group posts skip this entirely -- there's no feed target
            // to choose, you're already posting into one specific,
            // already-known group.
            if (widget.groupId != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(children: [
                  Text('Posting to', style: GoogleFonts.dmSans(
                    fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white54)),
                  const SizedBox(width: 6),
                  Text(widget.groupName ?? 'group', style: GoogleFonts.dmSans(
                    fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                ]),
              )
            else
              SizedBox(
                height: 34,
                child: Row(children: [
                  const SizedBox(width: 16),
                  Text('Posting to', style: GoogleFonts.dmSans(
                    fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white54)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(right: 16),
                      children: [
                        _TargetPill(
                          label: '🌍 Global',
                          selected: _feedTarget == 'global',
                          onTap: () => setState(() => _feedTarget = 'global')),
                        const SizedBox(width: 6),
                        _TargetPill(
                          label: '🏛 ${_university.length > 6 ? _university.substring(0, 6) : _university}',
                          selected: _feedTarget == 'uni',
                          onTap: () => setState(() => _feedTarget = 'uni')),
                        const SizedBox(width: 6),
                        _TargetPill(
                          label: '🎓 Aspirants',
                          selected: _feedTarget == 'aspirant',
                          onTap: () => setState(() => _feedTarget = 'aspirant')),
                      ],
                    ),
                  ),
                ]),
              ),

            const SizedBox(height: 8),

            // Quoted post preview, if this is a quote post
            if (widget.quotedPost != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.accentLight.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(12)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Quoting ${widget.quotedPost!['displayName'] ?? 'User'}',
                      style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600,
                        color: AppColors.accentLight)),
                    const SizedBox(height: 4),
                    Text((widget.quotedPost!['content'] as String?) ?? '',
                      maxLines: 3, overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary)),
                  ]),
                ),
              ),

            // Images area (top) -- single large swipeable preview, matching
            // the approved mockup, rather than a row of small thumbnails.
            if (_images.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: SizedBox(
                  height: 200,
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: PageView.builder(
                        controller: _imagePreviewController,
                        onPageChanged: (i) => setState(() => _imagePreviewIndex = i),
                        itemCount: _images.length,
                        itemBuilder: (_, i) => Image.file(_images[i],
                          width: double.infinity, height: 200, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(top: 8, right: 8,
                      child: GestureDetector(
                        onTap: () => setState(() {
                          _images.removeAt(_imagePreviewIndex);
                          if (_imagePreviewIndex >= _images.length && _imagePreviewIndex > 0) {
                            _imagePreviewIndex--;
                          }
                        }),
                        child: Container(
                          width: 26, height: 26,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.55),
                            shape: BoxShape.circle),
                          child: const Icon(Icons.close_rounded,
                            size: 14, color: Colors.white)))),
                    Positioned(bottom: 8, left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(12)),
                        child: Text('${_imagePreviewIndex + 1}/${_images.length}',
                          style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white)))),
                  ]),
                ),
              ),

            // Video preview -- mutually exclusive with images
            if (_video != null && _videoPreviewController != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: SizedBox(
                  height: 200,
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: double.infinity, height: 200,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _videoPreviewController!.value.size.width,
                            height: _videoPreviewController!.value.size.height,
                            child: VideoPlayer(_videoPreviewController!),
                          ),
                        ),
                      ),
                    ),
                    Positioned(top: 8, right: 8,
                      child: GestureDetector(
                        onTap: () => setState(_clearVideo),
                        child: Container(
                          width: 26, height: 26,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.55),
                            shape: BoxShape.circle),
                          child: const Icon(Icons.close_rounded,
                            size: 14, color: Colors.white)))),
                    Positioned(bottom: 8, left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          '${_videoPreviewController!.value.duration.inSeconds}s',
                          style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white)))),
                  ]),
                ),
              ),

            // Voice note preview (pre-post, not yet uploaded)
            if (_voiceNote != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.accentSurface.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.accentLight.withOpacity(0.3)),
                  ),
                  child: Row(children: [
                    Icon(Icons.graphic_eq_rounded,
                      color: AppColors.accentLight, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 24,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: _voiceNote!.waveform.map((amp) {
                            return Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                height: 4 + amp.clamp(0.08, 1.0) * 16,
                                decoration: BoxDecoration(
                                  color: AppColors.accentLight,
                                  borderRadius: BorderRadius.circular(2)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${_voiceNote!.durationMs ~/ 1000}s',
                      style: GoogleFonts.dmSans(
                        fontSize: 11, color: AppColors.accentLight)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _removeVoiceNote,
                      child: Icon(Icons.close_rounded,
                        size: 16, color: AppColors.accentLight.withOpacity(0.8)),
                    ),
                  ]),
                ),
              ),

            // Spacer pushes input to bottom
            const Spacer(),

            // Hint text -- only when the field is genuinely empty AND the
            // keyboard isn't up yet. Showing this decorative block while
            // the keyboard is open was eating exactly the vertical room
            // the two Spacers need to push the toolbar down to track the
            // keyboard -- hiding it here fixes both the toolbar-not-
            // tracking-the-keyboard bug and most of the residual overflow
            // in one change, not just another round of padding trims.
            if (bottomInset == 0 && _textCtrl.text.isEmpty && _images.isEmpty && _voiceNote == null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Text('Share what\'s on your mind',
                    style: GoogleFonts.dmSans(
                      fontSize: 20, fontWeight: FontWeight.w300,
                      color: Colors.white38),
                    textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text('Your post will reach students across Edulink',
                    style: GoogleFonts.dmSans(
                      fontSize: 13, color: Colors.white24),
                    textAlign: TextAlign.center),
                ]),
              ),

            const Spacer(),

            // Bottom composer bar -- no extra bottom padding here. The
            // Scaffold's resizeToAvoidBottomInset already shrinks the
            // whole body to sit right above the keyboard; adding
            // bottomInset again on top of that was double-compensating,
            // pushing this a full keyboard-height too far up.
            Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.accentLight.withOpacity(0.25)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.15),
                      blurRadius: 20, spreadRadius: 2),
                  ],
                ),
                child: _isRecording
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(children: [
                          Icon(Icons.fiber_manual_record_rounded,
                            color: AppColors.error, size: 14),
                          const SizedBox(width: 8),
                          Text('Recording ${_recordingSeconds ~/ 60}:${(_recordingSeconds % 60).toString().padLeft(2, '0')}',
                            style: GoogleFonts.dmSans(
                              fontSize: 14, color: AppColors.textPrimary)),
                          const Spacer(),
                          GestureDetector(
                            onTap: _cancelRecording,
                            child: Container(
                              width: 34, height: 34,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceVariant, shape: BoxShape.circle),
                              child: Icon(Icons.close_rounded,
                                color: AppColors.textSecondary, size: 16)),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: _attachRecording,
                            child: Container(
                              width: 34, height: 34,
                              decoration: BoxDecoration(
                                color: AppColors.accent, shape: BoxShape.circle),
                              child: const Icon(Icons.check_rounded,
                                color: Colors.white, size: 18)),
                          ),
                        ]),
                      )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  // Camera/image button
                  GestureDetector(
                    onTap: _pickImage,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 22,
                        color: AppColors.accentLight.withOpacity(0.85)),
                    ),
                  ),

                  // Video button
                  GestureDetector(
                    onTap: _pickVideo,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                      child: Icon(
                        Icons.videocam_outlined,
                        size: 22,
                        color: AppColors.accentLight.withOpacity(0.85)),
                    ),
                  ),

                  // Mic/voice note button
                  GestureDetector(
                    onTap: _voiceNote == null ? _startRecording : null,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                      child: Icon(
                        Icons.mic_none_rounded,
                        size: 22,
                        color: _voiceNote != null
                            ? AppColors.accentLight.withOpacity(0.2)
                            : AppColors.accentLight.withOpacity(0.85)),
                    ),
                  ),

                  // Text field
                  Expanded(
                    child: TextField(
                      controller: _textCtrl,
                      maxLines: 5,
                      minLines: 1,
                      maxLength: _maxChars,
                      style: GoogleFonts.dmSans(
                        fontSize: 15, color: AppColors.textPrimary, height: 1.4),
                      decoration: InputDecoration(
                        hintText: "What's happening?",
                        hintStyle: GoogleFonts.dmSans(
                          fontSize: 15, color: AppColors.accentLight.withOpacity(0.55)),
                        border: InputBorder.none,
                        counterText: '',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      ),
                    ),
                  ),

                  // Char count + image count
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 10, 12, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                      Text('$charCount/$_maxChars',
                        style: GoogleFonts.dmSans(
                          fontSize: 10, color: charColor)),
                      if (_images.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text('${_images.length}/$_maxImages 📷',
                          style: GoogleFonts.dmSans(
                            fontSize: 10, color: AppColors.accentLight.withOpacity(0.6))),
                      ],
                    ]),
                  ),
                ]),
              ),
          ]),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Galaxy background painter
// ─────────────────────────────────────────────────────────────────────────────
class _GalaxyBackground extends StatelessWidget {
  const _GalaxyBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GalaxyPainter(),
      child: Container(),
    );
  }
}

class _GalaxyPainter extends CustomPainter {
  static final List<_Star> _stars = _generateStars();

  static List<_Star> _generateStars() {
    final rng = math.Random(42); // fixed seed = consistent layout
    return List.generate(180, (_) => _Star(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      r: rng.nextDouble() * 1.8 + 0.2,
      opacity: rng.nextDouble() * 0.7 + 0.15,
    ));
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Deep space gradient
    final bg = Paint();
    final bgGrad = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF03001C),
        const Color(0xFF0A0620),
        const Color(0xFF100830),
        const Color(0xFF180B40),
        const Color(0xFF0D0520),
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );
    bg.shader = bgGrad.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    // Nebula glow — top right
    final nebula1 = Paint()
      ..color = const Color(0xFF7C3AED).withOpacity(0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.2),
        size.width * 0.6, nebula1);

    // Nebula glow — bottom left
    final nebula2 = Paint()
      ..color = const Color(0xFF0891B2).withOpacity(0.10)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.75),
        size.width * 0.5, nebula2);

    // Milky way band
    final mw = Paint()
      ..color = Colors.white.withOpacity(0.025)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    final mwPath = Path()
      ..moveTo(0, size.height * 0.3)
      ..quadraticBezierTo(
        size.width * 0.5, size.height * 0.5,
        size.width, size.height * 0.65)
      ..lineTo(size.width, size.height * 0.75)
      ..quadraticBezierTo(
        size.width * 0.5, size.height * 0.62,
        0, size.height * 0.42)
      ..close();
    canvas.drawPath(mwPath, mw);

    // Stars
    for (final star in _stars) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(star.opacity);
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.r, paint);
    }

    // Bright star clusters
    final bright = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);
    final rng = math.Random(99);
    for (int i = 0; i < 12; i++) {
      canvas.drawCircle(
        Offset(rng.nextDouble() * size.width, rng.nextDouble() * size.height),
        rng.nextDouble() * 1.2 + 0.8, bright);
    }
  }

  @override
  bool shouldRepaint(_GalaxyPainter old) => false;
}

class _Star {
  final double x, y, r, opacity;
  const _Star({required this.x, required this.y,
    required this.r, required this.opacity});
}

// ─────────────────────────────────────────────────────────────────────────────
// Feed target pill
// ─────────────────────────────────────────────────────────────────────────────
class _TargetPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TargetPill({
    required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.accent.withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.accent : Colors.white24)),
        child: Text(label, style: GoogleFonts.dmSans(
          fontSize: 11,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          color: selected ? Colors.white : Colors.white54)),
      ),
    );
  }
}