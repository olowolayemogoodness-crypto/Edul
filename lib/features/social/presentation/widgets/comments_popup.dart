// lib/features/social/presentation/widgets/comments_popup.dart
//
// The actual "popup, not full screen" comment section -- matches the
// exact showModalBottomSheet pattern the main feed already used
// (isScrollControlled: true, transparent background, this widget owns
// its own rounded-top shape). Shows just the comment thread + input,
// not the whole post again -- the post is already visible behind the
// sheet, no reason to duplicate it.
//
// Open with:
//   showModalBottomSheet(
//     context: context, isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (_) => CommentsPopup(postId: postId, collectionPath: collectionPath),
//   );

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/post_interaction_service.dart';
import '../../../../core/services/voice_note_service.dart';
import '../../../../core/widgets/voice_note_bubble.dart';

class CommentsPopup extends StatefulWidget {
  final String postId;
  final String collectionPath;
  const CommentsPopup({super.key, required this.postId, this.collectionPath = 'posts'});

  @override
  State<CommentsPopup> createState() => _CommentsPopupState();
}

class _CommentsPopupState extends State<CommentsPopup> {
  final _ctrl = TextEditingController();
  bool _sending = false;

  bool _isRecording = false;
  bool _uploadingVoice = false;
  int _recordingSeconds = 0;
  Timer? _recordTimer;

  // Replies attach to whichever TOP-LEVEL comment they're within, even
  // if you tap "Reply" on a reply itself -- one level of nesting, same
  // as Instagram, rather than infinite reply-to-reply chains.
  String? _replyingToId;
  String? _replyingToLabel;
  final Set<String> _expandedThreads = {};

  void _startReplyingTo(String commentId, String label) {
    setState(() { _replyingToId = commentId; _replyingToLabel = label; });
  }

  void _cancelReply() {
    setState(() { _replyingToId = null; _replyingToLabel = null; });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _recordTimer?.cancel();
    super.dispose();
  }

  String _authorLabel(Map<String, dynamic> data) {
    final username = data['usernameDisplay'] as String?;
    if (username != null && username.trim().isNotEmpty) return '@$username';
    return data['displayName'] as String? ?? 'User';
  }

  String _timeAgo(dynamic createdAt) {
    if (createdAt is! Timestamp) return 'now';
    final diff = DateTime.now().difference(createdAt.toDate());
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
    final text = _ctrl.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      await PostInteractionService.addComment(widget.postId, text,
          collectionPath: widget.collectionPath, parentCommentId: _replyingToId);
      _ctrl.clear();
      if (_replyingToId != null) _cancelReply();
    } catch (e) {
      // The original _CommentsSheet this was ported from didn't surface
      // errors here either -- fixing that gap while porting, not
      // carrying it forward.
      debugPrint('[CommentsPopup] Comment failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not send comment')));
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _startRecording() async {
    try {
      await VoiceNoteService.startRecording();
      if (!mounted) return;
      setState(() { _isRecording = true; _recordingSeconds = 0; });
      _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() => _recordingSeconds++);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not start recording: $e')));
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
      if (result == null) return;
      await VoiceNoteService.sendAsComment(
        postId: widget.postId,
        file: result.file,
        durationMs: result.durationMs,
        waveform: result.waveform,
        collectionPath: widget.collectionPath,
        parentCommentId: _replyingToId,
      );
      if (_replyingToId != null) _cancelReply();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Voice note failed: $e')));
    } finally {
      if (mounted) setState(() => _uploadingVoice = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65, minChildSize: 0.4, maxChildSize: 0.92, expand: false,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(children: [
          const SizedBox(height: 10),
          Container(width: 36, height: 4, decoration: BoxDecoration(
            color: AppColors.border, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 14),
          Text('Comments', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: PostInteractionService.comments(widget.postId, collectionPath: widget.collectionPath),
              builder: (context, s) {
                final list = s.data ?? [];
                if (list.isEmpty) {
                  return Center(child: Text('No comments yet', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)));
                }

                final topLevel = list.where((c) => c['parentCommentId'] == null).toList();
                Map<String, dynamic> findRoot(Map<String, dynamic> c) {
                  final parentId = c['parentCommentId'] as String?;
                  if (parentId == null) return c;
                  // A reply's root is always the top-level comment it's
                  // attached to, even if you tapped "Reply" on a reply --
                  // one level of nesting, matching how sends are routed.
                  return topLevel.firstWhere((t) => t['id'] == parentId, orElse: () => c);
                }
                final repliesByRoot = <String, List<Map<String, dynamic>>>{};
                for (final c in list) {
                  if (c['parentCommentId'] == null) continue;
                  final root = findRoot(c);
                  final rootId = root['id'] as String;
                  repliesByRoot.putIfAbsent(rootId, () => []).add(c);
                }

                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: topLevel.length,
                  itemBuilder: (context, i) {
                    final c = topLevel[i];
                    final commentId = c['id'] as String;
                    final replies = repliesByRoot[commentId] ?? [];
                    final expanded = _expandedThreads.contains(commentId);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        _CommentRow(
                          comment: c,
                          label: _authorLabel(c),
                          timeAgo: _timeAgo(c['createdAt']),
                          postId: widget.postId,
                          onReply: () => _startReplyingTo(commentId, _authorLabel(c)),
                        ),
                        if (replies.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.only(left: 38),
                            child: GestureDetector(
                              onTap: () => setState(() => expanded
                                  ? _expandedThreads.remove(commentId)
                                  : _expandedThreads.add(commentId)),
                              child: Row(children: [
                                Container(width: 20, height: 1, color: AppColors.border),
                                const SizedBox(width: 6),
                                Text(
                                  expanded ? 'Hide replies' : 'View ${replies.length} ${replies.length == 1 ? "reply" : "replies"}',
                                  style: GoogleFonts.dmSans(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.accent),
                                ),
                              ]),
                            ),
                          ),
                          if (expanded)
                            Padding(
                              padding: const EdgeInsets.only(left: 38, top: 8),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: replies.map((r) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _CommentRow(
                                    comment: r,
                                    label: _authorLabel(r),
                                    timeAgo: _timeAgo(r['createdAt']),
                                    postId: widget.postId,
                                    avatarRadius: 12,
                                    onReply: () => _startReplyingTo(commentId, _authorLabel(r)),
                                  ),
                                )).toList(),
                              ),
                            ),
                        ],
                      ]),
                    );
                  },
                );
              },
            ),
          ),
          if (_replyingToId != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
              child: Row(children: [
                Icon(Icons.reply_rounded, size: 14, color: AppColors.textTertiary),
                const SizedBox(width: 6),
                Text('Replying to $_replyingToLabel', style: GoogleFonts.dmSans(fontSize: 11.5, color: AppColors.textTertiary)),
                const Spacer(),
                GestureDetector(onTap: _cancelReply, child: Icon(Icons.close_rounded, size: 16, color: AppColors.textTertiary)),
              ]),
            ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(12, 8, 12, MediaQuery.of(context).viewInsets.bottom + 8),
              child: _isRecording
                  ? Row(children: [
                      Icon(Icons.fiber_manual_record_rounded, color: AppColors.error, size: 14),
                      const SizedBox(width: 8),
                      Text('Recording ${_fmtSeconds(_recordingSeconds)}', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary)),
                      const Spacer(),
                      GestureDetector(onTap: _cancelRecording, child: Container(width: 34, height: 34,
                        decoration: BoxDecoration(color: AppColors.surfaceVariant, shape: BoxShape.circle),
                        child: Icon(Icons.close_rounded, color: AppColors.textSecondary, size: 16))),
                      const SizedBox(width: 8),
                      GestureDetector(onTap: _sendRecording, child: Container(width: 34, height: 34,
                        decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                        child: const Icon(Icons.check_rounded, color: Colors.white, size: 16))),
                    ])
                  : Row(children: [
                      Expanded(child: TextField(
                        controller: _ctrl,
                        style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Add a comment…',
                          hintStyle: GoogleFonts.dmSans(color: AppColors.textTertiary),
                          filled: true, fillColor: AppColors.surfaceVariant,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                        ),
                        onSubmitted: (_) => _send(),
                      )),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _uploadingVoice ? null : _startRecording,
                        child: Container(width: 36, height: 36,
                          decoration: BoxDecoration(color: AppColors.background, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
                          child: _uploadingVoice
                              ? const Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator(strokeWidth: 2))
                              : Icon(Icons.mic_none_rounded, color: AppColors.textSecondary, size: 17)),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _sending ? null : _send,
                        child: Container(width: 36, height: 36,
                          decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                          child: _sending
                              ? const Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 17)),
                      ),
                    ]),
            ),
          ),
        ]),
      ),
    );
  }
}

// One comment or reply row -- shared by both so top-level comments and
// replies render identically (just at different indentation, handled
// by the caller's Padding, not by this widget).
class _CommentRow extends StatelessWidget {
  final Map<String, dynamic> comment;
  final String label;
  final String timeAgo;
  final String postId;
  final double avatarRadius;
  final VoidCallback onReply;

  const _CommentRow({
    required this.comment,
    required this.label,
    required this.timeAgo,
    required this.postId,
    required this.onReply,
    this.avatarRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    final audioUrl = comment['audioUrl'] as String?;
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CircleAvatar(
        radius: avatarRadius, backgroundColor: AppColors.surfaceVariant,
        child: Text(label.replaceAll('@', '').isNotEmpty ? label.replaceAll('@', '')[0].toUpperCase() : 'U',
          style: TextStyle(fontSize: avatarRadius > 13 ? 12 : 10, color: AppColors.textSecondary)),
      ),
      const SizedBox(width: 8),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(label, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(width: 6),
          Text(timeAgo, style: GoogleFonts.dmSans(fontSize: 10.5, color: AppColors.textTertiary)),
        ]),
        const SizedBox(height: 3),
        if (audioUrl != null && audioUrl.isNotEmpty)
          VoiceNoteBubble(
            id: (comment['id'] as String?) ?? postId,
            audioUrl: audioUrl,
            durationMs: (comment['durationMs'] as int?) ?? 0,
            waveform: ((comment['waveform'] as List<dynamic>?) ?? [])
                .map((e) => (e as num).toDouble()).toList(),
          )
        else
          Text(comment['content'] as String? ?? '', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: onReply,
          child: Text('Reply', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textTertiary)),
        ),
      ])),
    ]);
  }
}