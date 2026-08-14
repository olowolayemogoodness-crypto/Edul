// lib/features/social/presentation/pages/groups_page.dart
//
// Matches the approved mockup: search icon top-right, Join/Create split
// cards, then the user's existing groups listed below with icon + name
// + member count -- same visual language as the Study Rooms browse cards.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/services/post_image_upload_service.dart';
import 'group_detail_page.dart';
import 'group_search_page.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  Future<void> _createGroup() async {
    final ctrl = TextEditingController();
    File? pickedLogo;

    final name = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: 20, right: 20, top: 20,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
          ),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Create a group', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 14),
            Center(
              child: GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85, maxWidth: 512);
                  if (picked != null) setSheetState(() => pickedLogo = File(picked.path));
                },
                child: Stack(children: [
                  Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.surfaceVariant, border: Border.all(color: AppColors.border)),
                    child: pickedLogo == null
                        ? Icon(Icons.groups_rounded, color: AppColors.textTertiary, size: 28)
                        : ClipOval(child: Image.file(pickedLogo!, width: 72, height: 72, fit: BoxFit.cover)),
                  ),
                  Positioned(bottom: 0, right: 0, child: Container(
                    width: 24, height: 24,
                    decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle, border: Border.all(color: AppColors.surface, width: 2)),
                    child: const Icon(Icons.camera_alt_rounded, size: 11, color: Colors.white),
                  )),
                ]),
              ),
            ),
            const SizedBox(height: 4),
            Center(child: Text('Group logo (optional)', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary))),
            const SizedBox(height: 14),
            TextField(
              controller: ctrl,
              autofocus: true,
              style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Group name',
                hintStyle: GoogleFonts.dmSans(color: AppColors.textTertiary),
                filled: true, fillColor: AppColors.surfaceVariant,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: () => Navigator.pop(sheetContext, ctrl.text),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: Text('Create', style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w600)),
            )),
          ]),
        ),
      ),
    );
    if (name == null || name.trim().isEmpty || !mounted) return;

    try {
      String? iconUrl;
      if (pickedLogo != null) {
        final urls = await PostImageUploadService.uploadAll([pickedLogo!]);
        if (urls.isNotEmpty) iconUrl = urls.first;
      }

      final result = await GroupService.createGroup(name, iconUrl: iconUrl);
      if (!mounted) return;
      switch (result) {
        case CreateGroupResult.success:
          HapticFeedback.lightImpact();
          break;
        case CreateGroupResult.capReached:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('You can admin up to ${GroupService.freeAdminCap} groups on the free plan')));
          break;
        case CreateGroupResult.notSignedIn:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in to create a group')));
          break;
      }
    } catch (e) {
      // This is exactly the gap that caused "nothing happened" with no
      // explanation before -- now a real failure (permissions, network,
      // anything) surfaces instead of failing silently.
      debugPrint('[GroupsPage] Create group failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Could not create the group'),
          action: SnackBarAction(label: 'Try again', onPressed: _createGroup),
        ));
      }
    }
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (parts.isNotEmpty) return parts[0][0].toUpperCase();
    return 'G';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
          Row(children: [
            Expanded(child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GroupSearchPage())),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(color: AppColors.accentSurface, borderRadius: BorderRadius.circular(14)),
                child: Column(children: [
                  Icon(Icons.group_add_rounded, color: AppColors.accent, size: 26),
                  const SizedBox(height: 8),
                  Text('Join group', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                ]),
              ),
            )),
            const SizedBox(width: 12),
            Expanded(child: GestureDetector(
              onTap: _createGroup,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(color: AppColors.successSurface, borderRadius: BorderRadius.circular(14)),
                child: Column(children: [
                  Icon(Icons.add_circle_outline_rounded, color: AppColors.success, size: 26),
                  const SizedBox(height: 8),
                  Text('Create group', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                ]),
              ),
            )),
          ]),
          const SizedBox(height: 20),
          Text('YOUR GROUPS', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textTertiary, letterSpacing: 0.5)),
          const SizedBox(height: 8),
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: GroupService.myGroups(),
            builder: (context, snapshot) {
              final groups = snapshot.data ?? [];
              if (groups.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text("You haven't joined or created any groups yet",
                    style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
                );
              }
              return Column(children: groups.map((g) {
                final name = g['name'] as String? ?? 'Group';
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => GroupDetailPage(
                      groupId: g['id'] as String,
                      groupName: name,
                      isAdmin: g['role'] == 'admin',
                    ))),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border)),
                    child: Row(children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(color: AppColors.accentSurface, borderRadius: BorderRadius.circular(12)),
                        clipBehavior: Clip.antiAlias,
                        child: (g['iconUrl'] as String?)?.isNotEmpty == true
                            ? Image.network(g['iconUrl'] as String, width: 44, height: 44, fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Center(child: Text(_initials(name),
                                  style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.accent))))
                            : Center(child: Text(_initials(name), style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.accent))),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(name, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                        Text(g['role'] == 'admin' ? 'Admin' : 'Member', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
                      ])),
                      Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
                    ]),
                  ),
                );
              }).toList());
            },
          ),
        ],
      );
  }
}