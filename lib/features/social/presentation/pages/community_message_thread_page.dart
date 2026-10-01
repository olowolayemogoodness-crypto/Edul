// lib/features/social/presentation/pages/community_message_thread_page.dart
//
// Opened by tapping a message's "N replied" row. Shows the parent
// message pinned at the top, then every reply to it in order.
// Replying from here goes through the same CommunityChatService.
// sendMessage(replyToMessageId: ...) path as swiping in the main
// room -- a reply is a reply regardless of where it was composed.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/community_chat_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/widgets/user_avatar.dart';

class CommunityMessageThreadPage extends StatefulWidget {
  final String communityId;
  final Map<String, dynamic> parentMessage;
  const CommunityMessageThreadPage({super.key, required this.communityId, required this.parentMessage});

  @override
  State<CommunityMessageThreadPage> createState() => _CommunityMessageThreadPageState();
}

class _CommunityMessageThreadPageState extends State<CommunityMessageThreadPage> {
  final _textCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  void _send() {
    final text = _textCtrl.text;
    if (text.trim().isEmpty) return;
    _textCtrl.clear();
    CommunityChatService.sendMessage(
      widget.communityId, text,
      replyToMessageId: widget.parentMessage['id'] as String,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      }
    });
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parent = widget.parentMessage;
    final parentUid = parent['uid'] as String? ?? '';
    final parentName = parent['displayName'] as String? ?? 'User';
    final parentTitle = parent['title'] as String?;
    final parentContent = parent['content'] as String? ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        title: Text('Thread', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SafeArea(
        child: Column(children: [
          // Parent message, pinned -- always visible for context while scrolling replies
          Container(
            padding: const EdgeInsets.all(14),
            color: AppColors.card,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              UserAvatar(uid: parentUid, displayName: parentName, photoUrl: parent['photoUrl'] as String?, size: 34),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(parentName, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  const SizedBox(height: 3),
                  if (parentTitle != null && parentTitle.isNotEmpty)
                    Text(parentTitle, style: GoogleFonts.dmSans(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  Text(parentContent, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                ]),
              ),
            ]),
          ),
          Container(height: 1, color: AppColors.border),

          // The replies
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: CommunityChatService.threadMessages(widget.communityId, parent['id'] as String),
              builder: (context, snap) {
                if (snap.hasError) {
                  // ignore: avoid_print
                  print('[CommunityMessageThreadPage] threadMessages failed: ${snap.error}');
                  return Center(child: Text('Could not load replies', style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
                }
                if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                final replies = snap.data!;
                if (replies.isEmpty) {
                  return Center(child: Text('No replies yet', style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollCtrl.hasClients) _scrollCtrl.jumpTo(_scrollCtrl.position.maxScrollExtent);
                });
                return ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                  itemCount: replies.length,
                  itemBuilder: (context, i) {
                    final m = replies[i];
                    final uid = m['uid'] as String? ?? '';
                    final name = m['displayName'] as String? ?? 'User';
                    final content = m['content'] as String? ?? '';
                    final isMe = uid == UserService.uid;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        UserAvatar(uid: uid, displayName: name, photoUrl: m['photoUrl'] as String?, size: 32),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(isMe ? 'You' : name, style: GoogleFonts.dmSans(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                            const SizedBox(height: 2),
                            Text(content, style: GoogleFonts.dmSans(fontSize: 13.5, color: AppColors.textPrimary, height: 1.4)),
                          ]),
                        ),
                      ]),
                    );
                  },
                );
              },
            ),
          ),

          // Composer -- always replying to the pinned parent from here
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
            decoration: BoxDecoration(color: AppColors.card, border: Border(top: BorderSide(color: AppColors.border))),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _textCtrl,
                  style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Reply to $parentName',
                    hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary),
                    filled: true, fillColor: AppColors.background,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: BorderSide.none),
                  ),
                  onSubmitted: (_) => _send(),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _send,
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 18),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}