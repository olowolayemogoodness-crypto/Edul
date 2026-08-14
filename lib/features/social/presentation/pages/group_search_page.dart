// lib/features/social/presentation/pages/group_search_page.dart
//
// Simple client-side name filter over recent groups -- same
// "fetch broad, filter client-side" pattern used for the main feed,
// avoiding any composite-index dependency for a basic search.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/group_service.dart';

class GroupSearchPage extends StatefulWidget {
  const GroupSearchPage({super.key});

  @override
  State<GroupSearchPage> createState() => _GroupSearchPageState();
}

class _GroupSearchPageState extends State<GroupSearchPage> {
  final _searchCtrl = TextEditingController();
  List<Map<String, dynamic>> _allGroups = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final snap = await FirebaseFirestore.instance.collection('groups')
        .orderBy('createdAt', descending: true).limit(100).get();
    if (!mounted) return;
    setState(() {
      _allGroups = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
      _loading = false;
    });
  }

  Future<void> _requestJoin(String groupId, String groupName) async {
    final result = await GroupService.requestToJoin(groupId);
    if (!mounted) return;
    final message = switch (result) {
      JoinRequestResult.success => 'Request sent to $groupName',
      JoinRequestResult.alreadyMember => "You're already in this group",
      JoinRequestResult.alreadyRequested => 'Request already pending',
      JoinRequestResult.capReached => 'You can join up to ${GroupService.freeJoinCap} groups on the free plan',
      JoinRequestResult.notSignedIn => 'Sign in to join groups',
    };
    if (result == JoinRequestResult.success) HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchCtrl.text.trim().toLowerCase();
    final filtered = query.isEmpty
        ? _allGroups
        : _allGroups.where((g) => (g['name'] as String? ?? '').toLowerCase().contains(query)).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        title: TextField(
          controller: _searchCtrl,
          autofocus: true,
          onChanged: (_) => setState(() {}),
          style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: 'Search groups…',
            hintStyle: GoogleFonts.dmSans(color: AppColors.textTertiary),
            border: InputBorder.none,
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final g = filtered[i];
                final name = g['name'] as String? ?? 'Group';
                final memberCount = g['memberCount'] as int? ?? 0;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border)),
                  child: Row(children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: AppColors.accentSurface, borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: (g['iconUrl'] as String?)?.isNotEmpty == true
                          ? Image.network(g['iconUrl'] as String, width: 40, height: 40, fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Center(child: Text(name.isNotEmpty ? name[0].toUpperCase() : 'G',
                                style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.accent))))
                          : Center(child: Text(name.isNotEmpty ? name[0].toUpperCase() : 'G',
                              style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.accent))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(name, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      Text('$memberCount members', style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
                    ])),
                    TextButton(
                      onPressed: () => _requestJoin(g['id'] as String, name),
                      child: Text('Join', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.accent)),
                    ),
                  ]),
                );
              },
            ),
    );
  }
}