// lib/features/social/presentation/pages/post_composer_page.dart
//
// Full-screen composer with a unified, mixed media system -- photos
// and videos live in one ordered list and can be swiped through
// together in one carousel, matching Instagram's actual behavior
// (not just "multiple photos, separately from one video"). Picked
// via image_picker's pickMultipleMedia(), which supports selecting
// both types in a single gallery session.

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/services/notifications_service.dart';
import '../../../../core/services/post_image_upload_service.dart';
import '../../../../core/services/post_video_upload_service.dart';
import '../../../../core/services/premium_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/voice_note_service.dart';
import '../../../../core/utils/paywall_helper.dart';

class _MediaItem {
  final File file;
  final bool isVideo;
  VideoPlayerController? controller; // lazily initialized for video items only
  _MediaItem({required this.file, required this.isVideo});
}

const _videoExtensions = {'.mp4', '.mov', '.avi', '.mkv', '.webm', '.m4v'};
bool _looksLikeVideo(String path) =>
    _videoExtensions.any((ext) => path.toLowerCase().endsWith(ext));

class PostComposerPage extends StatefulWidget {
  final Map<String, dynamic>? quotedPost;
  const PostComposerPage({super.key, this.quotedPost});

  @override
  State<PostComposerPage> createState() => _PostComposerPageState();
}

class _PostComposerPageState extends State<PostComposerPage> {
  final _textCtrl = TextEditingController();
  final _picker = ImagePicker();
  final List<_MediaItem> _mediaItems = [];
  final PageController _mediaPreviewController = PageController();
  int _mediaPreviewIndex = 0;
  String _uploadStatus = '';
  String _feedTarget = 'global';
  bool _posting = false;
  double _uploadProgress = 0.0;
  String _university = 'My Uni';

  RecordingResult? _voiceNote;
  bool _isRecording = false;
  int _recordingSeconds = 0;
  Timer? _recordTimer;

  bool _showPollBuilder = false;
  final List<TextEditingController> _pollOptionCtrls = [];
  static const int _maxPollOptions = 4;

  static const int _maxChars = 500;
  // Combined limit -- photos and videos together, not separately, since
  // they now share one carousel rather than being mutually exclusive.
  int get _maxMedia => PremiumService.isPro ? 5 : 3;
  bool get _canPost =>
      (_textCtrl.text.trim().isNotEmpty || _voiceNote != null || _mediaItems.isNotEmpty) && !_posting;

  List<String> get _validPollOptions =>
      _pollOptionCtrls.map((c) => c.text.trim()).where((t) => t.isNotEmpty).toList();

  static const _iconColor = Colors.white70;
  static const _iconColorDisabled = Colors.white24;

  void _togglePollBuilder() {
    setState(() {
      _showPollBuilder = !_showPollBuilder;
      if (_showPollBuilder && _pollOptionCtrls.isEmpty) {
        _pollOptionCtrls.addAll([TextEditingController(), TextEditingController()]);
      }
    });
  }

  void _addPollOption() {
    if (_pollOptionCtrls.length >= _maxPollOptions) return;
    setState(() => _pollOptionCtrls.add(TextEditingController()));
  }

  void _removePollOption(int index) {
    setState(() {
      _pollOptionCtrls[index].dispose();
      _pollOptionCtrls.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUniversity();
    _loadGroupContext();
    _textCtrl.addListener(() => setState(() {}));
  }

  String? _myGroupId;
  bool _isClassRep = false;
  bool _isAlert = false;

  Future<void> _loadGroupContext() async {
    final groupId = await GroupService.myOfficialGroupId();
    if (groupId == null || !mounted) return;
    final isRep = await GroupService.isClassRep(groupId);
    if (mounted) setState(() {
      _myGroupId = groupId;
      _isClassRep = isRep;
    });
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _mediaPreviewController.dispose();
    for (final item in _mediaItems) { item.controller?.dispose(); }
    _recordTimer?.cancel();
    for (final c in _pollOptionCtrls) { c.dispose(); }
    super.dispose();
  }

  Future<void> _loadUniversity() async {
    final prefs = await SharedPreferences.getInstance();
    final uni = prefs.getString('user_university') ?? 'My Uni';
    if (mounted) setState(() => _university = uni);
  }

  Future<void> _addMedia() async {
    if (PremiumService.isFree) {
      showPaywall(context,
        triggerReason: 'Photo and video posts are available on Plus and Pro.',
        initialTier: 1);
      return;
    }
    final remaining = _maxMedia - _mediaItems.length;
    if (remaining <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Maximum $_maxMedia photos/videos on your plan',
          style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating));
      return;
    }

    final picked = await _picker.pickMultipleMedia(imageQuality: 80);
    if (picked.isEmpty || !mounted) return;

    // Respect the remaining quota even if the user picked more than
    // that from the gallery -- take the first N, not all of them.
    final toAdd = picked.take(remaining).toList();
    if (picked.length > remaining) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Only added $remaining — that\'s your plan\'s limit',
          style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating));
    }

    for (final xfile in toAdd) {
      final file = File(xfile.path);
      final isVideo = _looksLikeVideo(xfile.path);
      final item = _MediaItem(file: file, isVideo: isVideo);
      if (isVideo) {
        final controller = VideoPlayerController.file(file);
        try {
          await controller.initialize();
          item.controller = controller..setLooping(true)..play();
        } catch (_) {
          controller.dispose();
          continue; // skip files that fail to initialize as video, rather than add a broken preview
        }
      }
      _mediaItems.add(item);
    }
    if (mounted) setState(() {});
  }

  void _removeMediaAt(int index) {
    setState(() {
      _mediaItems[index].controller?.dispose();
      _mediaItems.removeAt(index);
      if (_mediaPreviewIndex >= _mediaItems.length && _mediaPreviewIndex > 0) {
        _mediaPreviewIndex--;
      }
    });
  }

  Future<void> _startRecording() async {
    if (PremiumService.isFree) {
      showPaywall(context,
        triggerReason: 'Voice note posts are available on Plus and Pro.',
        initialTier: 1);
      return;
    }
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

      // Upload in original pick order, tagging each result with its
      // type -- this is what lets the feed reconstruct the exact same
      // mixed-order carousel the poster arranged, not photos-then-videos
      // regardless of how they were actually interleaved.
      final orderedMedia = <Map<String, String>>[];
      final imageFiles = _mediaItems.where((m) => !m.isVideo).map((m) => m.file).toList();
      List<String> uploadedImageUrls = [];
      if (imageFiles.isNotEmpty) {
        uploadedImageUrls = await PostImageUploadService.uploadAll(
          imageFiles,
          onProgress: (p) {
            if (mounted) setState(() => _uploadProgress = p);
          },
        );
      }

      int imageIdx = 0;
      for (final item in _mediaItems) {
        if (item.isVideo) {
          if (mounted) setState(() => _uploadStatus = 'Uploading video…');
          final url = await PostVideoUploadService.compressAndUpload(
            item.file,
            onStatus: (status) {
              if (mounted) setState(() => _uploadStatus = status);
            },
          );
          orderedMedia.add({'type': 'video', 'url': url});
        } else {
          orderedMedia.add({'type': 'image', 'url': uploadedImageUrls[imageIdx]});
          imageIdx++;
        }
      }

      String? audioUrl;
      if (_voiceNote != null) {
        audioUrl = await VoiceNoteService.uploadVoiceNote(_voiceNote!.file);
      }

      final profile = await UserService.getProfile();
      final displayName = profile?['displayName'] as String? ?? 'User';
      final uni = profile?['university'] as String? ?? _university;
      final course = profile?['course'] as String? ?? '';
      final set = profile?['set'] as int?;
      final studentType = profile?['studentType'] as String? ?? 'university';
      final postRef = await FirebaseFirestore.instance.collection('posts').add({
        'uid': uid,
        'displayName': displayName,
        'university': uni,
        'course': course,
        if (set != null) 'set': set,
        'studentType': studentType,
        'content': _textCtrl.text.trim(),
        // New, unified field -- ordered, mixed photos/videos, the
        // source of truth for the swipeable carousel display.
        'mediaItems': orderedMedia,
        // Old fields kept alongside for backward compatibility with
        // anything still reading them -- imageUrls/videoUrls now just
        // mirror the matching entries from mediaItems. videoUrls is
        // the field the feed's own display actually reads to decide
        // whether to show a video carousel at all -- without writing
        // it here, a video-only post had nothing in that field, which
        // is exactly why it wasn't showing up in the feed at all.
        'imageUrls': orderedMedia.where((m) => m['type'] == 'image').map((m) => m['url']).toList(),
        'videoUrls': orderedMedia.where((m) => m['type'] == 'video').map((m) => m['url']).toList(),
        if (audioUrl != null) 'audioUrl': audioUrl,
        if (audioUrl != null) 'durationMs': _voiceNote!.durationMs,
        if (audioUrl != null) 'waveform': _voiceNote!.waveform,
        if (widget.quotedPost != null) 'quotedPostId': widget.quotedPost!['id'],
        if (_validPollOptions.length >= 2) 'pollOptions': _validPollOptions,
        if (_validPollOptions.length >= 2) 'pollVoteCounts': List.filled(_validPollOptions.length, 0),
        // Only meaningful (and only ever true) when posted by the
        // group's own class rep -- _isAlert can't be toggled at all
        // unless _isClassRep is true, enforced in the UI below.
        if (_isClassRep && _isAlert) 'isAlert': true,
        'feedTarget': _feedTarget,
        'likeCount': 0, 'commentCount': 0, 'repostCount': 0, 'views': 0,
        'verified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      _notifyFollowers(uid, displayName, postRef.id);
      if (_myGroupId != null) {
        NotificationService.notifyGroupMembers(
          groupId: _myGroupId!,
          postId: postRef.id,
          isAlert: _isClassRep && _isAlert,
        );
      }
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      final message = _mediaItems.isNotEmpty || _voiceNote != null
          ? 'Failed to upload media: $e'
          : 'Failed to post: $e';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message,
          style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating));
    } finally {
      if (mounted) setState(() {
        _posting = false;
        _uploadProgress = 0.0;
      });
    }
  }

  Future<void> _notifyFollowers(String posterUid, String posterName, String postId) async {
    try {
      final followers = await FirebaseFirestore.instance
          .collection('users').doc(posterUid).collection('followers')
          .limit(500).get();
      final batch = FirebaseFirestore.instance.batch();
      for (final doc in followers.docs) {
        final followerUid = doc.id;
        final notifRef = FirebaseFirestore.instance.collection('notifications').doc();
        batch.set(notifRef, {
          'uid': followerUid,
          'fromUid': posterUid,
          'fromDisplayName': posterName,
          'type': 'new_post',
          'postId': postId,
          'title': '$posterName shared a new post',
          'body': 'Tap to view it',
          'read': false,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      if (followers.docs.isNotEmpty) await batch.commit();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final charCount = _textCtrl.text.length;
    final charColor = charCount > _maxChars * 0.9 ? AppColors.error : Colors.white38;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: GestureDetector(
                onTap: _canPost ? _post : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: _canPost ? AppColors.accent : Colors.white12,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _canPost ? AppColors.accent : Colors.white24),
                  ),
                  child: _posting
                      ? Row(mainAxisSize: MainAxisSize.min, children: [
                          const SizedBox(width: 14, height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
                          if (_uploadStatus.isNotEmpty) ...[
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(_uploadStatus, overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white70)),
                            ),
                          ] else if (_uploadProgress > 0 && _uploadProgress < 1.0) ...[
                            const SizedBox(width: 6),
                            Text('${(_uploadProgress * 100).toInt()}%',
                              style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white70)),
                          ],
                        ])
                      : Text('Post', style: GoogleFonts.dmSans(
                          fontSize: 13, fontWeight: FontWeight.w600,
                          color: _canPost ? Colors.white : Colors.white38)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (widget.quotedPost != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white24),
                        borderRadius: BorderRadius.circular(12)),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Quoting ${widget.quotedPost!['displayName'] ?? 'User'}',
                          style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white70)),
                        const SizedBox(height: 4),
                        Text((widget.quotedPost!['content'] as String?) ?? '',
                          maxLines: 3, overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white54)),
                      ]),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    controller: _textCtrl,
                    autofocus: true,
                    maxLines: null,
                    maxLength: _maxChars,
                    style: GoogleFonts.dmSans(fontSize: 17, color: Colors.white, height: 1.4),
                    decoration: InputDecoration(
                      hintText: "What's happening?",
                      hintStyle: GoogleFonts.dmSans(fontSize: 17, color: Colors.white38),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      counterText: '',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('$charCount/$_maxChars', style: GoogleFonts.dmSans(fontSize: 11, color: charColor)),
                ),

                // Unified media carousel -- photos and videos together,
                // swipeable in the exact order they were added, matching
                // Instagram's mixed-carousel behavior rather than
                // treating photos and video as mutually exclusive.
                if (_mediaItems.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: SizedBox(
                      height: 220,
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: PageView.builder(
                            controller: _mediaPreviewController,
                            onPageChanged: (i) => setState(() => _mediaPreviewIndex = i),
                            itemCount: _mediaItems.length,
                            itemBuilder: (_, i) {
                              final item = _mediaItems[i];
                              if (item.isVideo && item.controller != null && item.controller!.value.isInitialized) {
                                return FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width: item.controller!.value.size.width,
                                    height: item.controller!.value.size.height,
                                    child: VideoPlayer(item.controller!),
                                  ),
                                );
                              }
                              return Image.file(item.file, width: double.infinity, height: 220, fit: BoxFit.cover);
                            },
                          ),
                        ),
                        Positioned(top: 8, right: 8,
                          child: GestureDetector(
                            onTap: () => _removeMediaAt(_mediaPreviewIndex),
                            child: Container(
                              width: 26, height: 26,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.55), shape: BoxShape.circle),
                              child: const Icon(Icons.close_rounded, size: 14, color: Colors.white)))),
                        if (_mediaItems[_mediaPreviewIndex].isVideo)
                          const Positioned(top: 8, left: 8,
                            child: Icon(Icons.videocam_rounded, size: 18, color: Colors.white)),
                        Positioned(bottom: 8, left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.55), borderRadius: BorderRadius.circular(12)),
                            child: Text('${_mediaPreviewIndex + 1}/${_mediaItems.length}',
                              style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white)))),
                      ]),
                    ),
                  ),

                if (_voiceNote != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(children: [
                        const Icon(Icons.graphic_eq_rounded, color: Colors.white70, size: 20),
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
                                    decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(2)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('${_voiceNote!.durationMs ~/ 1000}s',
                          style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white70)),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _removeVoiceNote,
                          child: const Icon(Icons.close_rounded, size: 16, color: Colors.white54),
                        ),
                      ]),
                    ),
                  ),

                if (_showPollBuilder)
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text('Poll options', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70)),
                        GestureDetector(
                          onTap: _togglePollBuilder,
                          child: const Icon(Icons.close_rounded, size: 18, color: Colors.white54),
                        ),
                      ]),
                      const SizedBox(height: 8),
                      for (var i = 0; i < _pollOptionCtrls.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(children: [
                            Expanded(
                              child: TextField(
                                controller: _pollOptionCtrls[i],
                                maxLength: 60,
                                style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Option ${i + 1}',
                                  hintStyle: GoogleFonts.dmSans(fontSize: 13, color: Colors.white38),
                                  filled: true, fillColor: Colors.white10,
                                  counterText: '',
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            if (_pollOptionCtrls.length > 2)
                              GestureDetector(
                                onTap: () => _removePollOption(i),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Icon(Icons.remove_circle_outline, size: 18, color: Colors.white54),
                                ),
                              ),
                          ]),
                        ),
                      if (_pollOptionCtrls.length < _maxPollOptions)
                        GestureDetector(
                          onTap: _addPollOption,
                          child: Row(children: [
                            const Icon(Icons.add_circle_outline, size: 16, color: Colors.white70),
                            const SizedBox(width: 6),
                            Text('Add option', style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white70)),
                          ]),
                        ),
                    ]),
                  ),

                const SizedBox(height: 24),
              ]),
            ),
          ),

          if (_isRecording)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(children: [
                Icon(Icons.fiber_manual_record_rounded, color: AppColors.error, size: 14),
                const SizedBox(width: 8),
                Text('Recording ${_recordingSeconds ~/ 60}:${(_recordingSeconds % 60).toString().padLeft(2, '0')}',
                  style: GoogleFonts.dmSans(fontSize: 14, color: Colors.white)),
                const Spacer(),
                GestureDetector(
                  onTap: _cancelRecording,
                  child: Container(
                    width: 34, height: 34,
                    decoration: const BoxDecoration(color: Colors.white12, shape: BoxShape.circle),
                    child: const Icon(Icons.close_rounded, color: Colors.white70, size: 16)),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _attachRecording,
                  child: Container(
                    width: 34, height: 34,
                    decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                    child: const Icon(Icons.check_rounded, color: Colors.white, size: 18)),
                ),
              ]),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Row(children: [
                IconButton(
                  onPressed: _addMedia,
                  icon: Icon(Icons.add_photo_alternate_outlined,
                    color: PremiumService.isFree ? _iconColorDisabled : _iconColor),
                  tooltip: 'Add photos or videos',
                ),
                IconButton(
                  onPressed: _voiceNote == null ? _startRecording : null,
                  icon: Icon(Icons.mic_none_rounded,
                    color: _voiceNote != null
                        ? _iconColorDisabled
                        : PremiumService.isFree ? _iconColorDisabled : _iconColor),
                ),
                IconButton(
                  onPressed: _togglePollBuilder,
                  icon: Icon(Icons.poll_outlined,
                    color: _showPollBuilder ? Colors.white : _iconColor),
                ),
                if (_isClassRep)
                  GestureDetector(
                    onTap: () => setState(() => _isAlert = !_isAlert),
                    child: Container(
                      margin: const EdgeInsets.only(left: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: _isAlert ? AppColors.error.withOpacity(0.2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _isAlert ? AppColors.error : Colors.white24),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text('🚨', style: TextStyle(fontSize: 13, color: _isAlert ? null : Colors.white38)),
                        const SizedBox(width: 4),
                        Text('Alert', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600,
                          color: _isAlert ? AppColors.error : Colors.white54)),
                      ]),
                    ),
                  ),
                if (_mediaItems.isNotEmpty) ...[
                  const Spacer(),
                  Text('${_mediaItems.length}/$_maxMedia',
                    style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white38)),
                  const SizedBox(width: 8),
                ],
              ]),
            ),
        ]),
      ),
    );
  }
}