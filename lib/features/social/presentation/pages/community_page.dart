// lib/features/social/presentation/pages/community_page.dart
//
// The Handle -- public profile page. Follow is separate from Room
// membership: Follow drives feed inclusion + notifications and works
// on any community; the Room action only appears when hasRoom is
// true, and is a REQUEST an admin approves, not instant access.
//
// Posting no longer happens from a dedicated button on this page --
// it happens from the main feed's composer, by tagging this
// community while writing a normal post (see post_composer_page.dart's
// community-tag picker). This page is now purely the profile: banner,
// identity, member strip, and a tabbed view into posts tagged here.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/community_service.dart';
import '../../../../core/widgets/user_avatar.dart';
import 'community_room_page.dart';
import 'community_settings_page.dart';
import 'social_feed_page.dart' show PostCard;

class CommunityPage extends StatefulWidget {
  final String communityId;
  const CommunityPage({super.key, required this.communityId});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _loadAdminStatus();
  }

  Future<void> _loadAdminStatus() async {
    try {
      final isAdmin = await CommunityService.isAdmin(widget.communityId);
      if (mounted) setState(() => _isAdmin = isAdmin);
    } catch (e) {
      // ignore: avoid_print
      print('[CommunityPage] _loadAdminStatus failed: $e');
    }
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

  // Unchanged from before -- same IntrinsicWidth fix from earlier
  // tonight (see the comment inside), just repositioned within the
  // new banner-based layout below.
  Widget _roomActionButton(String communityId, String name, bool hasRoom, bool requiresApproval) {
    if (!hasRoom) return const SizedBox.shrink();
    return IntrinsicWidth(
      child: StreamBuilder<bool>(
      stream: CommunityService.isRoomMember(communityId),
      builder: (context, memberSnap) {
        final isMember = memberSnap.data ?? false;
        if (isMember) {
          return OutlinedButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CommunityRoomPage(
              communityId: communityId, communityName: name,
            ))),
            icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
            label: Text('Open room', style: GoogleFonts.dmSans(fontSize: 12.5, fontWeight: FontWeight.w700)),
            style: OutlinedButton.styleFrom(shape: const StadiumBorder(), side: BorderSide(color: AppColors.border), backgroundColor: AppColors.card),
          );
        }
        return StreamBuilder<bool>(
          stream: CommunityService.hasPendingJoinRequest(communityId),
          builder: (context, reqSnap) {
            final requested = reqSnap.data ?? false;
            final label = requested ? 'Requested' : (requiresApproval ? 'Request to join room' : 'Join room');
            return OutlinedButton(
              onPressed: () {
                if (requested) {
                  CommunityService.cancelJoinRequest(communityId);
                } else {
                  CommunityService.joinRoom(communityId);
                }
              },
              style: OutlinedButton.styleFrom(shape: const StadiumBorder(), side: BorderSide(color: AppColors.border), backgroundColor: AppColors.card),
              child: Text(label,
                style: GoogleFonts.dmSans(fontSize: 12.5, fontWeight: FontWeight.w700, color: requested ? AppColors.textTertiary : AppColors.textPrimary)),
            );
          },
        );
      },
      ),
    );
  }

  Widget _followButton(String communityId) {
    return IntrinsicWidth(
      child: StreamBuilder<bool>(
      stream: CommunityService.isFollowing(communityId),
      builder: (context, followSnap) {
        final following = followSnap.data ?? false;
        return following
          ? OutlinedButton(
              onPressed: () => CommunityService.unfollow(communityId),
              style: OutlinedButton.styleFrom(shape: const StadiumBorder(), side: BorderSide(color: AppColors.border), backgroundColor: AppColors.card),
              child: Text('Following', style: GoogleFonts.dmSans(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            )
          : ElevatedButton(
              onPressed: () => CommunityService.follow(communityId),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white, shape: const StadiumBorder()),
              child: Text('Follow', style: GoogleFonts.dmSans(fontSize: 12.5, fontWeight: FontWeight.w700)),
            );
      },
      ),
    );
  }

  void _openMenu(BuildContext context, String name, bool hasRoom) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetContext) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          Container(width: 36, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 8),
          if (_isAdmin && hasRoom)
            ListTile(
              leading: Icon(Icons.settings_outlined, color: AppColors.textPrimary),
              title: Text('Room settings', style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary)),
              onTap: () {
                Navigator.pop(sheetContext);
                Navigator.push(context, MaterialPageRoute(builder: (_) => CommunitySettingsPage(
                  communityId: widget.communityId, communityName: name,
                )));
              },
            ),
          ListTile(
            leading: Icon(Icons.close_rounded, color: AppColors.textTertiary),
            title: Text('Cancel', style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary)),
            onTap: () => Navigator.pop(sheetContext),
          ),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }

  void _togglePin(String postId, String? currentPinnedId) {
    CommunityService.setPinnedPost(widget.communityId, currentPinnedId == postId ? null : postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: StreamBuilder<Map<String, dynamic>?>(
        stream: CommunityService.communityStream(widget.communityId),
        builder: (context, snap) {
          if (snap.hasError) {
            // ignore: avoid_print
            print('[CommunityPage] communityStream failed: ${snap.error}');
            return Center(child: Text('Could not load this community', style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
          }
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final community = snap.data;
          if (community == null) {
            return Center(child: Text('Community not found', style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
          }

          final name = community['name'] as String? ?? '';
          final handle = community['handle'] as String? ?? '';
          final category = community['category'] as String?;
          final description = community['description'] as String? ?? '';
          final verified = community['verified'] == true;
          final hasRoom = community['hasRoom'] == true;
          final followerCount = community['followerCount'] as int? ?? 0;
          final color = _colorFor(community['color'] as String?);
          final bannerUrl = community['bannerUrl'] as String?;
          final pinnedPostId = community['pinnedPostId'] as String?;

          return DefaultTabController(
            length: 4,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    // Banner + overlapping avatar
                    Stack(clipBehavior: Clip.none, children: [
                      Container(
                        height: 132,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: color,
                          image: bannerUrl != null ? DecorationImage(image: NetworkImage(bannerUrl), fit: BoxFit.cover) : null,
                        ),
                      ),
                      SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          child: Row(children: [
                            _headerIcon(Icons.arrow_back_rounded, () => Navigator.pop(context)),
                            const Spacer(),
                            _headerIcon(Icons.more_horiz_rounded, () => _openMenu(context, name, hasRoom)),
                          ]),
                        ),
                      ),
                      Positioned(
                        left: 16, bottom: -32,
                        child: Container(
                          width: 72, height: 72,
                          decoration: BoxDecoration(
                            color: color, borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.background, width: 3),
                          ),
                          child: Center(child: Text(_initialsFor(name), style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white))),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 40),

                    // Identity + actions
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          const Spacer(),
                          _roomActionButton(widget.communityId, name, hasRoom, community['requiresApproval'] != false),
                          const SizedBox(width: 8),
                          _followButton(widget.communityId),
                        ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          Flexible(child: Text(name, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary))),
                          if (verified) ...[const SizedBox(width: 5), Icon(Icons.verified_rounded, size: 19, color: AppColors.accent)],
                        ]),
                        Row(children: [
                          Text('@$handle', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
                          if (category != null && category.isNotEmpty) ...[
                            Text(' · ', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
                            Text(category, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
                          ],
                        ]),
                        if (description.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(description, style: GoogleFonts.dmSans(fontSize: 13.5, color: AppColors.textPrimary, height: 1.4)),
                        ],
                        const SizedBox(height: 12),
                        StreamBuilder<List<Map<String, dynamic>>>(
                          stream: CommunityService.members(widget.communityId),
                          builder: (context, memberSnap) {
                            final members = memberSnap.data ?? [];
                            final preview = members.take(4).toList();
                            return Row(children: [
                              if (preview.isNotEmpty)
                                SizedBox(
                                  width: 18 + (preview.length - 1).clamp(0, 3) * 12,
                                  height: 24,
                                  child: Stack(children: [
                                    for (var i = 0; i < preview.length; i++)
                                      Positioned(
                                        left: i * 12,
                                        child: FutureBuilder<DocumentSnapshot>(
                                          future: FirebaseFirestore.instance.collection('users').doc(preview[i]['uid'] as String).get(),
                                          builder: (context, userSnap) {
                                            final userData = userSnap.data?.data() as Map<String, dynamic>?;
                                            return Container(
                                              width: 22, height: 22,
                                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.background, width: 1.5)),
                                              child: UserAvatar(
                                                uid: preview[i]['uid'] as String,
                                                displayName: userData?['displayName'] as String? ?? 'Member',
                                                photoUrl: userData?['photoUrl'] as String?,
                                                size: 22,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                  ]),
                                ),
                              const SizedBox(width: 8),
                              Text('$followerCount members', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                            ]);
                          },
                        ),
                        const SizedBox(height: 4),
                      ]),
                    ),

                    Container(
                      color: AppColors.card,
                      child: TabBar(
                        labelColor: AppColors.accent,
                        unselectedLabelColor: AppColors.textTertiary,
                        indicatorColor: AppColors.accent,
                        labelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500),
                        tabs: const [Tab(text: 'Top'), Tab(text: 'Latest'), Tab(text: 'Media'), Tab(text: 'About')],
                      ),
                    ),
                  ]),
                ),
              ],
              body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('posts')
                    .where('communityId', isEqualTo: widget.communityId)
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, postSnap) {
                  if (postSnap.hasError) {
                    // ignore: avoid_print
                    print('[CommunityPage] posts query failed: ${postSnap.error}');
                    return Center(child: Text('Could not load posts', style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
                  }
                  if (!postSnap.hasData) return const Center(child: CircularProgressIndicator());
                  final posts = postSnap.data!.docs.map((d) => {'id': d.id, ...d.data()}).toList();

                  final latest = posts;
                  final top = [...posts]..sort((a, b) {
                    final aScore = ((a['likeCount'] as num?) ?? 0) + ((a['commentCount'] as num?) ?? 0) * 2;
                    final bScore = ((b['likeCount'] as num?) ?? 0) + ((b['commentCount'] as num?) ?? 0) * 2;
                    return bScore.compareTo(aScore);
                  });
                  final media = posts.where((p) {
                    final imgs = p['imageUrls'] as List<dynamic>?;
                    return (imgs != null && imgs.isNotEmpty) || p['videoUrl'] != null;
                  }).toList();

                  return TabBarView(children: [
                    _PostListTab(posts: top, emptyLabel: 'No posts yet', pinnedPostId: pinnedPostId,
                      isAdmin: _isAdmin, onTogglePin: _togglePin),
                    _PostListTab(posts: latest, emptyLabel: 'No posts yet', pinnedPostId: null,
                      isAdmin: _isAdmin, onTogglePin: _togglePin),
                    _MediaGridTab(posts: media),
                    _AboutTab(communityId: widget.communityId, community: community, followerCount: followerCount),
                  ]);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _headerIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _PostListTab extends StatelessWidget {
  final List<Map<String, dynamic>> posts;
  final String emptyLabel;
  final String? pinnedPostId;
  final bool isAdmin;
  final void Function(String postId, String? currentPinnedId) onTogglePin;
  const _PostListTab({required this.posts, required this.emptyLabel, required this.pinnedPostId, required this.isAdmin, required this.onTogglePin});

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Center(child: Text(emptyLabel, style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
    }
    // Pinned post, if any, always shown first regardless of sort.
    final pinned = pinnedPostId == null ? null : posts.where((p) => p['id'] == pinnedPostId).toList();
    final ordered = [
      if (pinned != null && pinned.isNotEmpty) pinned.first,
      ...posts.where((p) => p['id'] != pinnedPostId),
    ];
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: ordered.length,
      itemBuilder: (_, i) {
        final post = ordered[i];
        final postId = post['id'] as String;
        final isPinned = postId == pinnedPostId;
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (isPinned)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(children: [
                Icon(Icons.push_pin_rounded, size: 13, color: AppColors.textTertiary),
                const SizedBox(width: 5),
                Text('Pinned by admins', style: GoogleFonts.dmSans(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.textTertiary)),
              ]),
            ),
          Stack(children: [
            PostCard(key: ValueKey(postId), post: post),
            if (isAdmin)
              Positioned(
                top: 8, right: 16,
                child: GestureDetector(
                  onTap: () => onTogglePin(postId, pinnedPostId),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: AppColors.card, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
                    child: Icon(isPinned ? Icons.push_pin_rounded : Icons.push_pin_outlined, size: 14, color: isPinned ? AppColors.accent : AppColors.textTertiary),
                  ),
                ),
              ),
          ]),
        ]);
      },
    );
  }
}

class _MediaGridTab extends StatelessWidget {
  final List<Map<String, dynamic>> posts;
  const _MediaGridTab({required this.posts});

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Center(child: Text('No photos or videos yet', style: GoogleFonts.dmSans(color: AppColors.textTertiary)));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemCount: posts.length,
      itemBuilder: (context, i) {
        final post = posts[i];
        final imgs = (post['imageUrls'] as List<dynamic>?) ?? [];
        final thumb = imgs.isNotEmpty ? imgs.first as String : null;
        final isVideo = post['videoUrl'] != null;
        return GestureDetector(
          onTap: () => showModalBottomSheet(
            context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
            builder: (_) => DraggableScrollableSheet(
              initialChildSize: 0.85, expand: false,
              builder: (context, controller) => Container(
                decoration: BoxDecoration(color: AppColors.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
                child: ListView(controller: controller, children: [PostCard(key: ValueKey(post['id']), post: post)]),
              ),
            ),
          ),
          child: Stack(fit: StackFit.expand, children: [
            thumb != null
                ? Image.network(thumb, fit: BoxFit.cover)
                : Container(color: AppColors.card),
            if (isVideo)
              const Align(alignment: Alignment.center, child: Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 28)),
          ]),
        );
      },
    );
  }
}

class _AboutTab extends StatelessWidget {
  final String communityId;
  final Map<String, dynamic> community;
  final int followerCount;
  const _AboutTab({required this.communityId, required this.community, required this.followerCount});

  String _formatDate(dynamic ts) {
    if (ts is! Timestamp) return '';
    final d = ts.toDate();
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final description = community['description'] as String? ?? '';
    final category = community['category'] as String?;
    final createdAt = community['createdAt'];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (description.isNotEmpty) ...[
          Text('ABOUT', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
          const SizedBox(height: 6),
          Text(description, style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary, height: 1.45)),
          const SizedBox(height: 20),
        ],
        if (category != null && category.isNotEmpty) _infoRow(Icons.category_outlined, category),
        _infoRow(Icons.people_outline_rounded, '$followerCount members'),
        _infoRow(Icons.bolt_rounded, '${(community['totalClout'] as num?)?.toInt() ?? 0} Room Clout'),
        if (createdAt != null) _infoRow(Icons.calendar_today_outlined, 'Created ${_formatDate(createdAt)}'),
        const SizedBox(height: 20),
        Builder(builder: (context) {
          final achievements = ((community['achievements'] as List<dynamic>?) ?? []).cast<String>();
          if (achievements.isEmpty) return const SizedBox.shrink();
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('ACHIEVEMENTS', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: achievements.map((id) {
              final info = _achievementInfo(id);
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.border)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(info.$1, style: const TextStyle(fontSize: 13)),
                  const SizedBox(width: 5),
                  Text(info.$2, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                ]),
              );
            }).toList()),
            const SizedBox(height: 20),
          ]);
        }),
        Text('ADMINS', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.3)),
        const SizedBox(height: 8),
        StreamBuilder<List<Map<String, dynamic>>>(
          stream: CommunityService.members(communityId),
          builder: (context, snap) {
            final admins = (snap.data ?? []).where((m) => m['role'] == 'admin').toList();
            if (admins.isEmpty) return Text('None listed', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary));
            return Column(children: admins.map((m) {
              final uid = m['uid'] as String;
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
                builder: (context, userSnap) {
                  final displayName = (userSnap.data?.data() as Map<String, dynamic>?)?['displayName'] as String? ?? 'Member';
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: UserAvatar(uid: uid, displayName: displayName, size: 32),
                    title: Text(displayName, style: GoogleFonts.dmSans(fontSize: 13.5, color: AppColors.textPrimary)),
                  );
                },
              );
            }).toList());
          },
        ),
      ],
    );
  }

  (String, String) _achievementInfo(String id) {
    const labels = {
      'members_10': ('👋', '10 members'),
      'members_50': ('🎉', '50 members'),
      'members_100': ('💯', '100 members'),
      'members_500': ('🚀', '500 members'),
      'clout_100': ('⚡', '100 Room Clout'),
      'clout_500': ('⚡', '500 Room Clout'),
      'clout_1000': ('🔥', '1,000 Room Clout'),
      'clout_5000': ('👑', '5,000 Room Clout'),
    };
    return labels[id] ?? ('🏅', id);
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Icon(icon, size: 16, color: AppColors.textTertiary),
        const SizedBox(width: 10),
        Text(text, style: GoogleFonts.dmSans(fontSize: 13.5, color: AppColors.textSecondary)),
      ]),
    );
  }
}