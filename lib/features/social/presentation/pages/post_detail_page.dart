// lib/features/social/presentation/pages/post_detail_page.dart
//
// The actual destination notifications should take you to -- built
// specifically because tapping a "X commented on your post" or
// "X liked your post" notification previously did nothing except mark
// it as read, no navigation at all. Fetches one post by ID and renders
// it with working like/comment/repost, reusing PostInteractionService
// directly rather than duplicating its logic.
//
// GROUP POST SUPPORT -- optional collectionPath (defaults to 'posts',
// exact existing behavior) lets this same page serve as the comment
// section for a group post too, passing e.g. 'groups/$groupId/posts'.
// Repost stays main-feed-only (doesn't apply to groups), so that icon
// is hidden when collectionPath isn't 'posts'.
//
// Voice-comment recording ported from social_feed_page.dart's inline
// comment sheet -- same state machine, same VoiceNoteService calls,
// now available here too (previously only the main feed's own sheet
// had this, this page was text-only).

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/post_interaction_service.dart';
import '../../../../core/services/voice_note_service.dart';
import '../../../../core/widgets/voice_note_bubble.dart';

class PostDetailPage extends StatefulWidget {
  final String postId;
  final String collectionPath;
  const PostDetailPage({super.key, required this.postId, this.collectionPath = 'posts'});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final _commentCtrl = TextEditingController();

  bool _isRecording = false;
  bool _uploadingVoice = false;
  int _recordingSeconds = 0;
  Timer? _recordTimer;

  @override
  void dispose() {
    _commentCtrl.dispose();
    _recordTimer?.cancel();
    super.dispose();
  }

  String _authorLabel(Map<String, dynamic> data) {
    final username = data['usernameDisplay'] as String?;
    if (username != null && username.trim().isNotEmpty) return '@$username';
    return data['displayName'] as String? ?? 'User';
  }

  String _timeAgo(dynamic ts) {
    if (ts is! Timestamp) return '';
    final diff = DateTime.now().difference(ts.toDate());
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  String _fmtSeconds(int totalSeconds) {
    final m = totalSeconds ~/ 60;
    final s = totalSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Future<void> _send() async {
    final text = _commentCtrl.text.trim();
    if (text.isEmpty) return;
    _commentCtrl.clear();
    try {
      await PostInteractionService.addComment(widget.postId, text, collectionPath: widget.collectionPath);
    } catch (e) {
      debugPrint('[PostDetail] Comment failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Could not send comment'),
          action: SnackBarAction(label: 'Try again', onPressed: () {
            _commentCtrl.text = text;
            _send();
          }),
        ));
      }
    }
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
        content: Text('Could not start recording: $e', style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error, behavior: SnackBarBehavior.floating));
    }
  }

  Future<void> _cancelRecording() async {
    _recordTimer?.cancel();
    await VoiceNoteService.cancelRecording();
    if (mounted) setState(() { _isRecording = false; _recordingSeconds = 0; });
  }

  Future<void> _sendRecording() async {
    _recordTimer?.cancel();
    setState(() { _isRecording = false; _uploadingVoice = true; });
    try {
      final result = await VoiceNoteService.stopRecording();
      if (result == null) return; // too short -- silently discarded
      await VoiceNoteService.sendAsComment(
        postId: widget.postId,
        file: result.file,
        durationMs: result.durationMs,
        waveform: result.waveform,
        collectionPath: widget.collectionPath,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Voice note failed: $e', style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error, behavior: SnackBarBehavior.floating));
    } finally {
      if (mounted) setState(() => _uploadingVoice = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMainFeed = widget.collectionPath == 'posts';
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Post', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection(widget.collectionPath).doc(widget.postId).snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data?.data();
          if (data == null) {
            return Center(
              child: Text('This post no longer exists', style: GoogleFonts.dmSans(
                fontSize: 14, color: AppColors.textTertiary)),
            );
          }
          final postOwnerUid = data['uid'] as String? ?? '';
          final imageUrls = (data['imageUrls'] as List<dynamic>?) ?? [];

          return Column(children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // Author row
                  Row(children: [
                    CircleAvatar(
                      radius: 19, backgroundColor: AppColors.accentSurface,
                      child: Text(_authorLabel(data).replaceAll('@', '').isNotEmpty
                          ? _authorLabel(data).replaceAll('@', '')[0].toUpperCase() : 'U',
                        style: TextStyle(color: AppColors.accentLight, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(_authorLabel(data), style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      Text(_timeAgo(data['createdAt']), style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
                    ])),
                  ]),
                  const SizedBox(height: 12),

                  if ((data['content'] as String? ?? '').isNotEmpty)
                    Text(data['content'] as String, style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary, height: 1.5)),

                  if (imageUrls.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(imageUrls.first as String, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(height: 200, color: AppColors.surfaceVariant)),
                    ),
                  ],

                  const SizedBox(height: 16),
                  // Interaction row
                  Row(children: [
                    StreamBuilder<bool>(
                      stream: PostInteractionService.isLikedByMe(widget.postId, collectionPath: widget.collectionPath),
                      builder: (context, likedSnap) {
                        final liked = likedSnap.data ?? false;
                        return StreamBuilder<int>(
                          stream: PostInteractionService.likeCount(widget.postId, collectionPath: widget.collectionPath),
                          builder: (context, countSnap) {
                            return GestureDetector(
                              onTap: () => PostInteractionService.toggleLike(widget.postId, postOwnerUid, collectionPath: widget.collectionPath),
                              child: Row(children: [
                                Icon(liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  size: 20, color: liked ? AppColors.error : AppColors.textTertiary),
                                const SizedBox(width: 5),
                                Text('${countSnap.data ?? 0}', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                              ]),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 24),
                    StreamBuilder<int>(
                      stream: PostInteractionService.commentCount(widget.postId, collectionPath: widget.collectionPath),
                      builder: (context, s) => Row(children: [
                        Icon(Icons.chat_bubble_outline_rounded, size: 18, color: AppColors.textTertiary),
                        const SizedBox(width: 5),
                        Text('${s.data ?? 0}', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                      ]),
                    ),
                    if (isMainFeed) ...[
                      const SizedBox(width: 24),
                      StreamBuilder<int>(
                        stream: PostInteractionService.repostCount(widget.postId),
                        builder: (context, s) => Row(children: [
                          Icon(Icons.repeat_rounded, size: 18, color: AppColors.textTertiary),
                          const SizedBox(width: 5),
                          Text('${s.data ?? 0}', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                        ]),
                      ),
                    ],
                  ]),

                  const SizedBox(height: 20),
                  Divider(color: AppColors.border),
                  const SizedBox(height: 12),
                  Text('Comments', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 10),

                  StreamBuilder<List<Map<String, dynamic>>>(
                    stream: PostInteractionService.comments(widget.postId, collectionPath: widget.collectionPath),
                    builder: (context, s) {
                      final list = s.data ?? [];
                      if (list.isEmpty) {
                        return Text('No comments yet', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary));
                      }
                      return Column(children: list.map((c) {
                        final label = _authorLabel(c);
                        final audioUrl = c['audioUrl'] as String?;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            CircleAvatar(
                              radius: 15, backgroundColor: AppColors.surfaceVariant,
                              child: Text(label.replaceAll('@', '').isNotEmpty ? label.replaceAll('@', '')[0].toUpperCase() : 'U',
                                style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(label, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                              const SizedBox(height: 2),
                              if (audioUrl != null && audioUrl.isNotEmpty)
                                VoiceNoteBubble(
                                  id: (c['id'] as String?) ?? widget.postId,
                                  audioUrl: audioUrl,
                                  durationMs: (c['durationMs'] as int?) ?? 0,
                                  waveform: ((c['waveform'] as List<dynamic>?) ?? [])
                                      .map((e) => (e as num).toDouble()).toList(),
                                )
                              else
                                Text(c['content'] as String? ?? '', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary)),
                            ])),
                          ]),
                        );
                      }).toList());
                    },
                  ),
                ]),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12, 8, 12, MediaQuery.of(context).viewInsets.bottom + 12),
                child: _isRecording
                    ? Row(children: [
                        Icon(Icons.fiber_manual_record_rounded, color: AppColors.error, size: 14),
                        const SizedBox(width: 8),
                        Text('Recording ${_fmtSeconds(_recordingSeconds)}',
                          style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary)),
                        const Spacer(),
                        GestureDetector(
                          onTap: _cancelRecording,
                          child: Container(width: 36, height: 36,
                            decoration: BoxDecoration(color: AppColors.surfaceVariant, shape: BoxShape.circle),
                            child: Icon(Icons.close_rounded, color: AppColors.textSecondary, size: 18)),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _sendRecording,
                          child: Container(width: 36, height: 36,
                            decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                            child: const Icon(Icons.check_rounded, color: Colors.white, size: 18)),
                        ),
                      ])
                    : Row(children: [
                        Expanded(child: TextField(
                          controller: _commentCtrl,
                          style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            hintText: 'Add a comment…',
                            hintStyle: GoogleFonts.dmSans(color: AppColors.textTertiary),
                            filled: true, fillColor: AppColors.surfaceVariant,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          ),
                          onSubmitted: (_) => _send(),
                        )),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _uploadingVoice ? null : _startRecording,
                          child: Container(
                            width: 38, height: 38,
                            decoration: BoxDecoration(color: AppColors.surface, shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border)),
                            child: _uploadingVoice
                                ? const Padding(padding: EdgeInsets.all(9), child: CircularProgressIndicator(strokeWidth: 2))
                                : Icon(Icons.mic_none_rounded, color: AppColors.textSecondary, size: 18),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _send,
                          child: Container(
                            width: 38, height: 38,
                            decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                            child: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 18),
                          ),
                        ),
                      ]),
              ),
            ),
          ]);
        },
      ),
    );
  }
}