// lib/features/social/presentation/pages/community_settings_page.dart
//
// Admin-only. First setting: whether new members need approval to
// join the Room, or join instantly. Also shows a join/leave activity
// log -- who joined or left, and when.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/community_service.dart';
import '../../../../core/services/post_image_upload_service.dart';
import '../../../../core/widgets/user_avatar.dart';
import 'community_join_requests_page.dart';

class CommunitySettingsPage extends StatefulWidget {
  final String communityId;
  final String communityName;
  const CommunitySettingsPage({super.key, required this.communityId, required this.communityName});

  @override
  State<CommunitySettingsPage> createState() => _CommunitySettingsPageState();
}

class _CommunitySettingsPageState extends State<CommunitySettingsPage> {
  bool? _requiresApproval;
  String _inviteCode = '';
  String? _bannerUrl;
  bool _uploadingBanner = false;
  final _picker = ImagePicker();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final community = await CommunityService.getCommunity(widget.communityId);
      if (mounted) setState(() {
        _requiresApproval = community?['requiresApproval'] != false;
        _inviteCode = community?['inviteCode'] as String? ?? '';
        _bannerUrl = community?['bannerUrl'] as String?;
        _loading = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print('[CommunitySettingsPage] _load failed: $e');
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _pickAndUploadBanner() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked == null) return;
    setState(() => _uploadingBanner = true);
    try {
      final urls = await PostImageUploadService.uploadAll([File(picked.path)]);
      if (urls.isNotEmpty) {
        await CommunityService.updateBanner(widget.communityId, urls.first);
        if (mounted) setState(() => _bannerUrl = urls.first);
      }
    } catch (e) {
      // ignore: avoid_print
      print('[CommunitySettingsPage] _pickAndUploadBanner failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not upload banner: $e')));
      }
    } finally {
      if (mounted) setState(() => _uploadingBanner = false);
    }
  }

  Future<void> _toggleApproval(bool value) async {
    setState(() => _requiresApproval = value);
    try {
      await CommunityService.updateRequiresApproval(widget.communityId, value);
    } catch (e) {
      // ignore: avoid_print
      print('[CommunitySettingsPage] updateRequiresApproval failed: $e');
      if (mounted) setState(() => _requiresApproval = !value);
    }
  }

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Room settings', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SafeArea(
        child: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                Text('COVER BANNER', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _uploadingBanner ? null : _pickAndUploadBanner,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                      image: _bannerUrl != null
                          ? DecorationImage(image: NetworkImage(_bannerUrl!), fit: BoxFit.cover)
                          : null,
                    ),
                    child: _uploadingBanner
                        ? const Center(child: CircularProgressIndicator())
                        : _bannerUrl == null
                            ? Center(
                                child: Column(mainAxisSize: MainAxisSize.min, children: [
                                  Icon(Icons.add_photo_alternate_outlined, color: AppColors.textTertiary, size: 26),
                                  const SizedBox(height: 6),
                                  Text('Add a cover banner', style: GoogleFonts.dmSans(fontSize: 12.5, color: AppColors.textTertiary)),
                                ]),
                              )
                            : Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(999)),
                                  child: Text('Change', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                                ),
                              ),
                  ),
                ),
                const SizedBox(height: 28),
                Text('MEMBERSHIP', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14)),
                  child: Row(children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('New members need approval', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        const SizedBox(height: 2),
                        Text(
                          _requiresApproval == true
                            ? 'Requests wait for an admin to approve them'
                            : 'Anyone who taps Join gets in immediately',
                          style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary),
                        ),
                      ]),
                    ),
                    Switch(
                      value: _requiresApproval ?? true,
                      onChanged: _toggleApproval,
                      activeColor: AppColors.accent,
                    ),
                  ]),
                ),
                const SizedBox(height: 28),
                Text('INVITE CODE', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14)),
                  child: Row(children: [
                    Expanded(child: Text(_inviteCode, style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 3, color: AppColors.textPrimary))),
                    TextButton(
                      onPressed: () => Clipboard.setData(ClipboardData(text: _inviteCode)),
                      child: Text('Copy', style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, color: AppColors.accent)),
                    ),
                  ]),
                ),
                const SizedBox(height: 28),
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: CommunityService.pendingJoinRequests(widget.communityId),
                  builder: (context, snap) {
                    final count = snap.data?.length ?? 0;
                    return Material(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        leading: Icon(Icons.person_add_alt_1_rounded, color: AppColors.textPrimary),
                        title: Text('Pending requests', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                          if (count > 0)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(999)),
                              child: Text('$count', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                            ),
                          Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
                        ]),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CommunityJoinRequestsPage(
                          communityId: widget.communityId, communityName: widget.communityName,
                        ))),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 28),
                Text('MEMBERS', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
                const SizedBox(height: 8),
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: CommunityService.members(widget.communityId),
                  builder: (context, snap) {
                    final members = snap.data ?? [];
                    if (members.isEmpty) return const SizedBox.shrink();
                    return Container(
                      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14)),
                      child: Column(children: members.map((m) {
                        final uid = m['uid'] as String;
                        final role = m['role'] as String? ?? 'member';
                        final joinedAt = (m['joinedAt'] as Timestamp?)?.toDate();
                        return ListTile(
                          leading: UserAvatar(uid: uid, displayName: uid, size: 36),
                          title: Text(role == 'admin' ? 'Admin' : 'Member', style: GoogleFonts.dmSans(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          subtitle: joinedAt != null ? Text('Joined ${_relativeTime(joinedAt)}', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)) : null,
                        );
                      }).toList()),
                    );
                  },
                ),
                const SizedBox(height: 28),
                Text('ACTIVITY', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
                const SizedBox(height: 8),
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: CommunityService.activityLog(widget.communityId),
                  builder: (context, snap) {
                    if (snap.hasError) {
                      // ignore: avoid_print
                      print('[CommunitySettingsPage] activityLog failed: ${snap.error}');
                      return Text('Could not load activity', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary));
                    }
                    if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                    final entries = snap.data!;
                    if (entries.isEmpty) {
                      return Text('No activity yet', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary));
                    }
                    return Column(children: entries.map((e) {
                      final type = e['type'] as String? ?? '';
                      final displayName = e['displayName'] as String? ?? 'Someone';
                      final ts = (e['timestamp'] as Timestamp?)?.toDate();
                      final joined = type == 'joined';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(children: [
                          Icon(joined ? Icons.login_rounded : Icons.logout_rounded, size: 15, color: joined ? const Color(0xFF16A34A) : AppColors.textTertiary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text.rich(TextSpan(children: [
                              TextSpan(text: displayName, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                              TextSpan(text: joined ? ' joined the room' : ' left the room', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
                            ])),
                          ),
                          if (ts != null)
                            Text(_relativeTime(ts), style: GoogleFonts.dmSans(fontSize: 11.5, color: AppColors.textTertiary)),
                        ]),
                      );
                    }).toList());
                  },
                ),
              ],
            ),
      ),
    );
  }
}