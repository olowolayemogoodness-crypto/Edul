// lib/features/social/presentation/pages/community_room_page.dart
//
// The Room: real-time chat. Every message shows full identity
// (avatar, name, never collapsed) plus that sender's Clout tier IN
// THIS COMMUNITY. Message types (Ask/Snippet/Resource/Shipped) plus
// Solved-marking with a Clout reward for accepted answers.
//
// Threading: swipe right on ANY message to reply -- not just typed
// ones. A message with replies shows an avatar-stack "N replied" row
// (same pattern as "9 welcomed her"); tapping it opens the full
// thread. The replied-to message also "bumps" back toward the
// bottom of the room (via bumpedAt, see community_chat_service.dart)
// so live discussion doesn't get buried under newer, unrelated
// messages.

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/community_chat_service.dart';
import '../../../../core/services/community_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/widgets/user_avatar.dart';
import 'community_message_thread_page.dart';
import 'community_page.dart';

class CommunityRoomPage extends StatefulWidget {
  final String communityId;
  final String communityName;
  const CommunityRoomPage({super.key, required this.communityId, required this.communityName});

  @override
  State<CommunityRoomPage> createState() => _CommunityRoomPageState();
}

class _CommunityRoomPageState extends State<CommunityRoomPage> {
  final _textCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  String _composeType = 'general';
  File? _pendingImage;
  Map<String, dynamic>? _replyingTo;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) setState(() => _pendingImage = File(picked.path));
  }

  void _startReply(Map<String, dynamic> message) {
    setState(() => _replyingTo = message);
  }

  final Map<String, String> _tierCache = {};

  Future<String> _tierFor(String uid) async {
    if (_tierCache.containsKey(uid)) return _tierCache[uid]!;
    final doc = await FirebaseFirestore.instance
        .collection('users').doc(uid).collection('clout').doc(widget.communityId).get();
    final tier = doc.data()?['tier'] as String? ?? 'Newcomer';
    _tierCache[uid] = tier;
    return tier;
  }

  Color _tierColor(String tier) {
    switch (tier) {
      case 'Legend': return const Color(0xFF7C3AED);
      case 'Top Voice': return const Color(0xFFD97706);
      case 'Regular': return const Color(0xFF16A34A);
      default: return AppColors.textTertiary;
    }
  }

  static const Map<String, String> _typeLabels = {
    'ask': 'Question', 'snippet': 'Snippet', 'resource': 'Resource', 'shipped': 'Shipped',
  };
  static const Map<String, IconData> _typeIcons = {
    'ask': Icons.help_outline_rounded, 'snippet': Icons.code_rounded,
    'resource': Icons.link_rounded, 'shipped': Icons.rocket_launch_rounded,
  };
  Color _typeColor(String type) {
    switch (type) {
      case 'ask': return const Color(0xFF9A3412);
      case 'snippet': return AppColors.accent;
      case 'resource': return const Color(0xFF0E7490);
      case 'shipped': return const Color(0xFF15803D);
      default: return AppColors.textTertiary;
    }
  }

  void _send() {
    final text = _textCtrl.text;
    if (text.trim().isEmpty && _pendingImage == null) return;
    final type = _composeType;
    final title = _titleCtrl.text;
    final image = _pendingImage;
    final replyToId = _replyingTo?['id'] as String?;
    _textCtrl.clear();
    _titleCtrl.clear();
    setState(() {
      _composeType = 'general';
      _pendingImage = null;
      _replyingTo = null;
    });
    CommunityChatService.sendMessage(widget.communityId, text,
      type: type, title: title.isEmpty ? null : title, imageFile: image, replyToMessageId: replyToId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      }
    });
  }

  void _markSolved(Map<String, dynamic> question, List<Map<String, dynamic>> allMessages) {
    final questionId = question['id'] as String;
    final questionIndex = allMessages.indexWhere((m) => m['id'] == questionId);
    final candidates = questionIndex >= 0 ? allMessages.sublist(questionIndex + 1) : <Map<String, dynamic>>[];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Which message answered this?', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 4),
              Text('Whoever wrote it gets +15 Clout in this community.', style: GoogleFonts.dmSans(fontSize: 12.5, color: AppColors.textTertiary)),
              const SizedBox(height: 14),
              if (candidates.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text('No messages after this question yet.', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
                )
              else
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 320),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: candidates.length,
                    itemBuilder: (context, i) {
                      final m = candidates[i];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: UserAvatar(uid: m['uid'] as String? ?? '', displayName: m['displayName'] as String? ?? 'User', photoUrl: m['photoUrl'] as String?, size: 32),
                        title: Text(m['displayName'] as String? ?? 'User', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        subtitle: Text(m['content'] as String? ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontSize: 12.5, color: AppColors.textSecondary)),
                        onTap: () {
                          Navigator.pop(sheetContext);
                          CommunityChatService.markSolved(
                            communityId: widget.communityId,
                            questionMessageId: questionId,
                            answerMessageId: m['id'] as String,
                            answererUid: m['uid'] as String? ?? '',
                          );
                        },
                      );
                    },
                  ),
                ),
            ]),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _titleCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        title: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => CommunityPage(communityId: widget.communityId))),
          child: Text(widget.communityName, style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_rounded, size: 20, color: AppColors.textSecondary),
            tooltip: 'Leave room',
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  backgroundColor: AppColors.card,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: Text('Leave ${widget.communityName}?', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  content: Text('You\'ll need to join again to see new messages.', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text('Cancel', style: GoogleFonts.dmSans(color: AppColors.textTertiary)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        CommunityService.leaveRoom(widget.communityId);
                        Navigator.pop(context);
                      },
                      child: Text('Leave', style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, color: AppColors.error)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: CommunityChatService.messages(widget.communityId),
              builder: (context, snap) {
                if (snap.hasError) {
                  // ignore: avoid_print
                  print('[CommunityRoomPage] messages stream failed: ${snap.error}');
                  return Center(child: Text('Could not load messages', style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
                }
                if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                final messages = snap.data!;
                if (messages.isEmpty) {
                  return Center(child: Text('No messages yet — say hello', style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollCtrl.hasClients) _scrollCtrl.jumpTo(_scrollCtrl.position.maxScrollExtent);
                });
                return ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                  itemCount: messages.length,
                  itemBuilder: (context, i) {
                    final m = messages[i];
                    final uid = m['uid'] as String? ?? '';
                    final name = m['displayName'] as String? ?? 'User';
                    final photoUrl = m['photoUrl'] as String?;
                    final content = m['content'] as String? ?? '';
                    final type = m['type'] as String? ?? 'general';
                    final title = m['title'] as String?;
                    final resolved = m['resolved'] == true;
                    final isMe = uid == UserService.uid;
                    final canMarkSolved = type == 'ask' && !resolved && isMe;
                    final replyToSenderName = m['replyToSenderName'] as String?;
                    final replyToPreview = m['replyToPreview'] as String?;
                    final replyToType = m['replyToType'] as String?;
                    final replyCount = (m['replyCount'] as num?)?.toInt() ?? 0;
                    final recentRepliers = (m['recentReplierUids'] as List<dynamic>?)?.cast<String>() ?? [];

                    return Dismissible(
                      key: ValueKey(m['id']),
                      direction: DismissDirection.startToEnd,
                      confirmDismiss: (_) async {
                        _startReply(m);
                        return false; // snaps back -- swiping starts a reply, never removes the message
                      },
                      background: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(Icons.reply_rounded, color: AppColors.accent, size: 22),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          UserAvatar(uid: uid, displayName: name, photoUrl: photoUrl, size: 36),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(children: [
                                Text(isMe ? 'You' : name, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                                const SizedBox(width: 6),
                                FutureBuilder<String>(
                                  future: _tierFor(uid),
                                  builder: (context, tierSnap) {
                                    final tier = tierSnap.data ?? '';
                                    if (tier.isEmpty || tier == 'Newcomer') return const SizedBox.shrink();
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                      decoration: BoxDecoration(color: _tierColor(tier), borderRadius: BorderRadius.circular(999)),
                                      child: Text(tier.toUpperCase(), style: GoogleFonts.dmSans(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white)),
                                    );
                                  },
                                ),
                                if (type != 'general') ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(color: _typeColor(type).withOpacity(0.12), borderRadius: BorderRadius.circular(999)),
                                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                                      Icon(_typeIcons[type], size: 10, color: _typeColor(type)),
                                      const SizedBox(width: 3),
                                      Text(_typeLabels[type] ?? type, style: GoogleFonts.dmSans(fontSize: 9, fontWeight: FontWeight.w700, color: _typeColor(type))),
                                    ]),
                                  ),
                                ],
                                if (type == 'ask' && resolved) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(color: const Color(0xFF15803D).withOpacity(0.12), borderRadius: BorderRadius.circular(999)),
                                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                                      const Icon(Icons.check_rounded, size: 11, color: Color(0xFF15803D)),
                                      const SizedBox(width: 2),
                                      Text('Solved', style: GoogleFonts.dmSans(fontSize: 9, fontWeight: FontWeight.w700, color: const Color(0xFF15803D))),
                                    ]),
                                  ),
                                ],
                              ]),
                              const SizedBox(height: 3),
                              if (replyToSenderName != null && replyToPreview != null) ...[
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    border: Border(left: BorderSide(color: AppColors.accent, width: 3)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Row(children: [
                                      Text(replyToSenderName, style: GoogleFonts.dmSans(fontSize: 10.5, fontWeight: FontWeight.w700, color: AppColors.accent)),
                                      if (replyToType != null && replyToType != 'general') ...[
                                        const SizedBox(width: 5),
                                        Icon(_typeIcons[replyToType], size: 10, color: _typeColor(replyToType)),
                                        const SizedBox(width: 2),
                                        Text(_typeLabels[replyToType] ?? replyToType, style: GoogleFonts.dmSans(fontSize: 9.5, fontWeight: FontWeight.w700, color: _typeColor(replyToType))),
                                      ],
                                    ]),
                                    Text(replyToPreview, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
                                  ]),
                                ),
                              ],
                              if (title != null && title.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Text(title, style: GoogleFonts.dmSans(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                                ),
                              Text(content, style: GoogleFonts.dmSans(fontSize: 13.5, color: AppColors.textPrimary, height: 1.45)),
                              if ((m['imageUrl'] as String?) != null) ...[
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(m['imageUrl'] as String, width: 240, height: 240, fit: BoxFit.cover),
                                ),
                              ],
                              if (canMarkSolved) ...[
                                const SizedBox(height: 6),
                                GestureDetector(
                                  onTap: () => _markSolved(m, messages),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(999)),
                                    child: Text('Mark solved', style: GoogleFonts.dmSans(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                                  ),
                                ),
                              ],
                              if (replyCount > 0) ...[
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CommunityMessageThreadPage(
                                    communityId: widget.communityId, parentMessage: m,
                                  ))),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                                    decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(11)),
                                    child: Row(children: [
                                      SizedBox(
                                        width: 18 + (recentRepliers.length - 1).clamp(0, 3) * 12,
                                        height: 22,
                                        child: Stack(children: [
                                          for (var r = 0; r < recentRepliers.length && r < 4; r++)
                                            Positioned(
                                              left: r * 12,
                                              child: Container(
                                                width: 18, height: 18,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: UserAvatar.colorFor(recentRepliers[r]),
                                                  border: Border.all(color: AppColors.background, width: 1.5),
                                                ),
                                              ),
                                            ),
                                        ]),
                                      ),
                                      const SizedBox(width: 6),
                                      Text('$replyCount replied', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                                      const Spacer(),
                                      Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.textTertiary),
                                    ]),
                                  ),
                                ),
                              ],
                            ]),
                          ),
                        ]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
            decoration: BoxDecoration(color: AppColors.card, border: Border(top: BorderSide(color: AppColors.border))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (_replyingTo != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    border: Border(left: BorderSide(color: AppColors.accent, width: 3)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Replying to ${_replyingTo!['displayName'] ?? 'Someone'}',
                          style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.accent)),
                        Text(
                          (_replyingTo!['title'] as String?)?.isNotEmpty == true
                            ? _replyingTo!['title'] as String
                            : (_replyingTo!['content'] as String? ?? ''),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(fontSize: 11.5, color: AppColors.textTertiary),
                        ),
                      ]),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _replyingTo = null),
                      child: Container(
                        width: 22, height: 22,
                        decoration: BoxDecoration(color: AppColors.card, shape: BoxShape.circle),
                        child: Icon(Icons.close_rounded, size: 13, color: AppColors.textTertiary),
                      ),
                    ),
                  ]),
                ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(children: messageTypes.map((type) {
                  final selected = type == _composeType;
                  final label = type == 'general' ? 'Message' : (_typeLabels[type] ?? type);
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () => setState(() => _composeType = type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.accent : AppColors.background,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: selected ? AppColors.accent : AppColors.border),
                        ),
                        child: Text(label, style: GoogleFonts.dmSans(fontSize: 11.5, fontWeight: FontWeight.w700,
                          color: selected ? Colors.white : AppColors.textSecondary)),
                      ),
                    ),
                  );
                }).toList()),
              ),
              if (_composeType != 'general')
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _titleCtrl,
                    style: GoogleFonts.dmSans(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: _composeType == 'ask' ? 'What\'s your question?' : 'Short title',
                      hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary),
                      filled: true, fillColor: AppColors.background,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                ),
              if (_pendingImage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(_pendingImage!, height: 72, width: 72, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: -6, right: -6,
                      child: GestureDetector(
                        onTap: () => setState(() => _pendingImage = null),
                        child: Container(
                          width: 22, height: 22,
                          decoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
                          child: const Icon(Icons.close_rounded, color: Colors.white, size: 14),
                        ),
                      ),
                    ),
                  ]),
                ),
              Row(children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 40, height: 40,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(999)),
                    child: Icon(Icons.image_outlined, color: AppColors.textSecondary, size: 19),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _textCtrl,
                    style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: _replyingTo != null ? 'Reply to the room' : 'Message ${widget.communityName}',
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
            ]),
          ),
        ]),
      ),
    );
  }
}