// lib/features/social/presentation/pages/community_search_page.dart
//
// Search scoped to communities only, reached from a search icon in
// the Communities tab itself -- not folded into the general social
// search screen. Same client-side-filter pattern used throughout the
// app for search (no native Firestore text search), just scoped to
// the communities collection.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import 'community_page.dart';

class CommunitySearchPage extends StatefulWidget {
  const CommunitySearchPage({super.key});

  @override
  State<CommunitySearchPage> createState() => _CommunitySearchPageState();
}

class _CommunitySearchPageState extends State<CommunitySearchPage> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  Timer? _debounce;

  @override
  void dispose() {
    _searchCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _query = value.trim().toLowerCase());
    });
  }

  Future<List<Map<String, dynamic>>> _searchCommunities(String q) async {
    if (q.isEmpty) return [];
    final snap = await FirebaseFirestore.instance.collection('communities')
        .where('status', isEqualTo: 'active').limit(500).get();
    return snap.docs
        .map((d) => {'id': d.id, ...d.data()})
        .where((c) {
          final name = (c['name'] as String? ?? '').toLowerCase();
          final handle = (c['handle'] as String? ?? '').toLowerCase();
          return name.contains(q) || handle.contains(q);
        })
        .take(20)
        .toList();
  }

  Color _colorFor(String? hex) {
    if (hex == null) return AppColors.accent;
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return AppColors.accent;
    }
  }

  String _initialsFor(String name) {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).take(2).toList();
    return parts.map((p) => p[0].toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary)),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(24)),
                  child: TextField(
                    controller: _searchCtrl,
                    autofocus: true,
                    onChanged: _onChanged,
                    style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search communities',
                      hintStyle: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textTertiary),
                      isDense: true, contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Expanded(
            child: _query.isEmpty
              ? Center(child: Text('Search for a community by name', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)))
              : FutureBuilder<List<Map<String, dynamic>>>(
                  future: _searchCommunities(_query),
                  builder: (context, snap) {
                    if (!snap.hasData) return Center(child: CircularProgressIndicator(color: AppColors.accent));
                    final communities = snap.data!;
                    if (communities.isEmpty) {
                      return Center(child: Text('No communities found for "$_query"', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: communities.length,
                      itemBuilder: (context, i) {
                        final c = communities[i];
                        final name = c['name'] as String? ?? '';
                        final verified = c['verified'] == true;
                        final followerCount = c['followerCount'] as int? ?? 0;
                        return ListTile(
                          leading: Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(color: _colorFor(c['color'] as String?), borderRadius: BorderRadius.circular(12)),
                            child: Center(child: Text(_initialsFor(name), style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white))),
                          ),
                          title: Row(children: [
                            Flexible(child: Text(name, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
                            if (verified) ...[const SizedBox(width: 4), Icon(Icons.verified_rounded, size: 14, color: AppColors.accent)],
                          ]),
                          subtitle: Text('$followerCount followers', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CommunityPage(communityId: c['id'] as String))),
                        );
                      },
                    );
                  },
                ),
          ),
        ]),
      ),
    );
  }
}