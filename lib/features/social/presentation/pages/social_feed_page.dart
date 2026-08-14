// lib/features/social/presentation/pages/social_feed_page.dart

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/post_interaction_service.dart';
import '../../../../core/services/user_follow_service.dart';
import '../../../../core/services/user_tier_service.dart';
import '../../../../core/services/premium_service.dart';
import '../../../../core/services/social_streak_service.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/voice_note_service.dart';
import '../../../../core/services/aspirants_engagement_service.dart';
import '../../../../core/services/feed_video_watch_service.dart';
import 'fullscreen_video_feed_page.dart';
import 'post_composer_page.dart';


// Username is the "active" identity on the feed once someone's claimed
// one -- shown as @handle. Falls back to displayName for anyone who
// hasn't set a username yet (it's optional, not everyone will have
// claimed one immediately), so nothing shows blank.
String _authorLabel(Map<String, dynamic> data) {
  final username = data['usernameDisplay'] as String?;
  if (username != null && username.trim().isNotEmpty) return '@$username';
  return data['displayName'] as String? ?? 'User';
}

class SocialFeedPage extends StatefulWidget {
  const SocialFeedPage({super.key});

  @override
  State<SocialFeedPage> createState() => _SocialFeedPageState();
}

class _SocialFeedPageState extends State<SocialFeedPage> {
  int _selectedTab = 0;
  // Deliberately resets every time Aspirants is left and re-entered, not
  // a one-time "seen it" flag -- the whole point is a clear speed bump
  // each time, so it never gets mistaken for the main feed.
  bool _aspirantsEntered = false;
  String _university = 'My Uni';
  String _universityFull = ''; // untruncated — used for the actual query filter
  Set<String> _myFollowing = {}; // who I follow — scopes repost visibility

  @override
  void initState() {
    super.initState();
    _loadUniversity();
    _loadFollowing();
  }

  Future<void> _loadFollowing() async {
    final following = await UserFollowService.myFollowingUids();
    if (mounted) setState(() => _myFollowing = following);
  }

  Future<void> _loadUniversity() async {
    // Must match the composer's own source-of-truth priority exactly
    // (Firestore profile first) — otherwise a post's stored `university`
    // field and this page's filter value can silently disagree if the
    // local SharedPreferences cache is stale, empty, or from a different
    // device than the one that registered.
    String? uni;
    try {
      final profile = await UserService.getProfile();
      uni = profile?['university'] as String?;
    } catch (_) {
      // offline or read failed — fall through to the local cache below
    }
    if (uni == null || uni.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      uni = prefs.getString('user_university') ?? '';
    }
    final safeUni = uni;
    if (mounted && safeUni.isNotEmpty) {
      setState(() {
        _universityFull = safeUni; // full value, for filtering
        _university = safeUni.length > 10
            ? safeUni.substring(0, 10).trim() : safeUni; // truncated, for the pill label only
      });
    }
  }

  // News (tab 2) is locked/verified-only -- nobody composes into it, so
  // it isn't a real mapping target; falls back to Global if ever hit.
  String _targetForTab(int tab) => switch (tab) {
    1 => 'uni',
    3 => 'aspirant',
    _ => 'global',
  };

  Stream<List<Map<String, dynamic>>> _postsStream() {
    // Deliberately a single orderBy with no combined where() — combining
    // where + orderBy on different fields requires a Firestore composite
    // index to be manually created in the console, and a missing index
    // causes the whole query to fail silently (StreamBuilder just shows
    // "No posts yet" with no error visible). Filtering client-side after
    // a single, simple, always-valid query avoids that dependency
    // entirely. Fine at this scale since we only ever fetch the 50 most
    // recent posts to begin with.
    final query = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(50);

    return query.snapshots().map((snap) {
      final myUid = FirebaseAuth.instance.currentUser?.uid ?? '';
      final all = snap.docs
          .map((d) => {'id': d.id, ...d.data()})
          // Reposts are only visible to the reposter's own followers (and
          // to the reposter themselves) — everyone else still sees the
          // repost COUNT on the original post, just not this pointer
          // appearing in their feed.
          .where((p) {
            if (p['type'] != 'repost') return true;
            final reposterUid = p['uid'] as String? ?? '';
            return reposterUid == myUid || _myFollowing.contains(reposterUid);
          })
          .toList();
      if (_selectedTab == 1) {
        // My Uni: every post from this university, regardless of feedTarget
        return all.where((p) => p['university'] == _universityFull).toList();
      } else if (_selectedTab == 2) {
        // News: verified posts only — locked down, no user can set this
        // themselves (Firestore rule blocks it on both create and update).
        return all.where((p) => p['verified'] == true).toList();
      } else if (_selectedTab == 3) {
        // Aspirants: deliberately NOT a general/global aspirant feed --
        // scoped to the viewer's own university, same field the Uni tab
        // already uses. A UNILAG student only ever sees UNILAG aspirant
        // posts, not a mixed pool from every school.
        return all.where((p) =>
            p['feedTarget'] == 'aspirant' && p['university'] == _universityFull).toList();
      } else {
        // Global: only posts explicitly targeted at Global, but weighted
        // so posts from people you follow surface more often -- not
        // exclusively, since a feed that only ever shows followed users
        // stops being a discovery surface. Roughly 2 followed-user posts
        // for every 1 from someone else, each side keeping its own
        // recency order from the underlying query.
        final globalPosts = all.where((p) => p['feedTarget'] == 'global').toList();
        return _rankByFollowing(globalPosts, myUid);
      }
    });
  }

  /// Interleaves posts from followed users ahead of others at roughly a
  /// 2:1 ratio, preserving each group's original (recency) order rather
  /// than fully re-sorting -- this keeps the feed feeling chronological
  /// within each group while still surfacing followed accounts more.
  List<Map<String, dynamic>> _rankByFollowing(List<Map<String, dynamic>> posts, String myUid) {
    if (_myFollowing.isEmpty) return posts; // nothing to weight toward yet
    final followed = <Map<String, dynamic>>[];
    final others = <Map<String, dynamic>>[];
    for (final p in posts) {
      final uid = p['uid'] as String? ?? '';
      if (uid == myUid || _myFollowing.contains(uid)) {
        followed.add(p);
      } else {
        others.add(p);
      }
    }
    final result = <Map<String, dynamic>>[];
    int fi = 0, oi = 0;
    while (fi < followed.length || oi < others.length) {
      for (var k = 0; k < 2 && fi < followed.length; k++) {
        result.add(followed[fi++]);
      }
      if (oi < others.length) result.add(others[oi++]);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(children: [
                Text('Social', style: GoogleFonts.dmSans(
                  fontSize: 22, fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
                const SizedBox(width: 8),
                const _SocialStreakCapsule(),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SocialSearchPage())),
                  child: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.search_rounded,
                      size: 20, color: AppColors.textSecondary),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PostComposerPage(initialTarget: _targetForTab(_selectedTab))),
                    );
                    if (result == true && mounted) setState(() {});
                  },
                  child: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.edit_rounded,
                      size: 18, color: Colors.white),
                  ),
                ),
              ]),
            ),

            const SizedBox(height: 14),

            // Tab pills
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _Pill(label: 'Global', selected: _selectedTab == 0,
                    onTap: () => setState(() { _selectedTab = 0; _aspirantsEntered = false; })),
                  const SizedBox(width: 8),
                  _Pill(label: _university, selected: _selectedTab == 1,
                    onTap: () => setState(() { _selectedTab = 1; _aspirantsEntered = false; })),
                  const SizedBox(width: 8),
                  _Pill(label: 'News', selected: _selectedTab == 2,
                    onTap: () => setState(() { _selectedTab = 2; _aspirantsEntered = false; })),
                  const SizedBox(width: 8),
                  _Pill(label: 'Aspirants', selected: _selectedTab == 3,
                    onTap: () => setState(() => _selectedTab = 3)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Feed
            Expanded(
              child: (_selectedTab == 3 && !_aspirantsEntered)
                  ? _AspirantsGate(
                      university: _university,
                      onEnter: () {
                        AspirantsEngagementService.recordEntry();
                        setState(() => _aspirantsEntered = true);
                      },
                    )
                  : StreamBuilder<List<Map<String, dynamic>>>(
                stream: _postsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(
                      color: AppColors.accent));
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text('Could not load posts:\n${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.error)),
                      ),
                    );
                  }

                  final posts = snapshot.data ?? [];

                  if (posts.isEmpty) {
                    final isNews = _selectedTab == 2;
                    final isAspirants = _selectedTab == 3;
                    return Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Text(isNews ? '📰' : isAspirants ? '🎓' : '💬', style: const TextStyle(fontSize: 48)),
                        const SizedBox(height: 16),
                        Text(isNews ? 'No news available yet' : isAspirants ? 'No questions yet' : 'No posts yet', style: GoogleFonts.dmSans(
                          fontSize: 16, fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary)),
                        const SizedBox(height: 8),
                        Text(isNews
                            ? 'Official updates and announcements will appear here'
                            : isAspirants
                                ? 'Be the first to ask something about $_university'
                                : 'Be the first to post something!',
                          style: GoogleFonts.dmSans(
                            fontSize: 13, color: AppColors.textTertiary)),
                        if (!isNews) ...[
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PostComposerPage(initialTarget: _targetForTab(_selectedTab)))),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(20)),
                              child: Text('Write a post',
                                style: GoogleFonts.dmSans(
                                  fontSize: 13, fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                            ),
                          ),
                        ],
                      ]),
                    );
                  }

                  final showAds = PremiumService.isRealFree;
                  const adInterval = 5;
                  final numAds = showAds ? posts.length ~/ adInterval : 0;
                  final blockSize = adInterval + 1;

                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: posts.length + numAds,
                    separatorBuilder: (_, __) => const Divider(
                      color: Color(0xFF1E1E24), height: 1, thickness: 1),
                    itemBuilder: (_, i) {
                      if (showAds && i % blockSize == adInterval) {
                        return _FeedNativeAdCard(key: ValueKey('ad_$i'));
                      }
                      final postIndex = showAds ? i - (i ~/ blockSize) : i;
                      return _PostCard(
                        key: ValueKey(posts[postIndex]['id']),
                        post: posts[postIndex],
                      );
                    },
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pill tab
// ─────────────────────────────────────────────────────────────────────────────
// A deliberate speed bump before entering Aspirants -- distinct enough
// (different background, its own headline) that nobody mistakes it for
// the main feed, and it re-appears every time this tab is re-entered,
// not just the first time ever.
class _AspirantsGate extends StatelessWidget {
  final String university;
  final VoidCallback onEnter;
  const _AspirantsGate({required this.university, required this.onEnter});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF120B1F),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('🎓', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 18),
            Text('Aspirants', style: GoogleFonts.dmSans(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(height: 8),
            Text(
              "A space for people hoping to get into $university — ask "
              "current students what it's really like.",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white60, height: 1.5),
            ),
            const SizedBox(height: 28),
            GestureDetector(
              onTap: onEnter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF9333EA),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text('Enter Aspirants', style: GoogleFonts.dmSans(
                  fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Pill({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border),
        ),
        child: Text(label, style: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          color: selected ? Colors.white : AppColors.textSecondary)),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Post card
// ─────────────────────────────────────────────────────────────────────────────
class _FeedNativeAdCard extends StatefulWidget {
  const _FeedNativeAdCard({super.key});

  @override
  State<_FeedNativeAdCard> createState() => _FeedNativeAdCardState();
}

class _FeedNativeAdCardState extends State<_FeedNativeAdCard> {
  NativeAd? _ad;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    NativeAd(
      adUnitId: 'ca-app-pub-8635571505694976/8988009786',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (!mounted) { ad.dispose(); return; }
          setState(() { _ad = ad as NativeAd; _loaded = true; });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      // Small template is the one Google recommends specifically for
      // in-feed/list placements -- medium is meant for landing-page-style
      // full ads, wrong shape for a scrolling feed.
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
        mainBackgroundColor: AppColors.surface,
        cornerRadius: 12.0,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          backgroundColor: AppColors.accent,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: AppColors.textPrimary,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: AppColors.textSecondary,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: AppColors.textTertiary,
        ),
      ),
    ).load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded || _ad == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SizedBox(height: 100, child: AdWidget(ad: _ad!)),
    );
  }
}

class _TierBadge extends StatelessWidget {
  final String uid;
  const _TierBadge({required this.uid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: UserTierService.getTier(uid),
      builder: (context, snap) {
        final tier = snap.data;
        if (tier == null || tier.isEmpty) return const SizedBox.shrink();
        IconData icon;
        Color color;
        switch (tier) {
          case 'active':
            icon = Icons.circle;
            color = const Color(0xFF1D9E75);
            break;
          case 'contributor':
            icon = Icons.verified_rounded;
            color = const Color(0xFF534AB7);
            break;
          case 'plug':
            icon = Icons.workspace_premium_rounded;
            color = const Color(0xFF854F0B);
            break;
          default:
            return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Tooltip(
            message: UserTierService.label(tier),
            child: Icon(icon, size: tier == 'active' ? 10 : 14, color: color),
          ),
        );
      },
    );
  }
}

class _QuotedPostPreview extends StatelessWidget {
  final String postId;
  const _QuotedPostPreview({required this.postId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').doc(postId).snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const SizedBox.shrink();
        if (!snap.data!.exists) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(12)),
            child: Text('Original post was deleted', style: GoogleFonts.dmSans(
              fontSize: 12, color: AppColors.textTertiary)));
        }
        final data = snap.data!.data() as Map<String, dynamic>;
        final name = _authorLabel(data);
        final content = data['content'] as String? ?? '';
        final imageUrls = (data['imageUrls'] as List<dynamic>?) ?? [];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 20, height: 20,
                decoration: BoxDecoration(color: AppColors.accentSurface, shape: BoxShape.circle),
                child: Center(child: Text(name.isNotEmpty ? name[0].toUpperCase() : 'U',
                  style: GoogleFonts.dmSans(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.accentLight)))),
              const SizedBox(width: 6),
              Text(name, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            ]),
            if (content.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(content, maxLines: 3, overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
            ],
            if (imageUrls.isNotEmpty) ...[
              const SizedBox(height: 8),
              ClipRRect(borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrls[0] as String,
                  width: double.infinity, height: 120, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox())),
            ],
          ]),
        );
      },
    );
  }
}

class _PostCard extends StatefulWidget {
  final Map<String, dynamic> post;
  const _PostCard({super.key, required this.post});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  // Tracks which posts have already been counted this app session, so a
  // ListView rebuild (e.g. from a new comment arriving) doesn't inflate
  // the view count every time this widget remounts.
  static final Set<String> _countedPostIds = {};

  @override
  void initState() {
    super.initState();
    _countImpression();
  }

  void _countImpression() {
    final postId = widget.post['id'] as String?;
    final authorUid = widget.post['uid'] as String? ?? '';
    final myUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (postId == null || _countedPostIds.contains(postId)) return;
    if (authorUid == myUid) return; // don't count the author's own view
    _countedPostIds.add(postId);
    FirebaseFirestore.instance.collection('posts').doc(postId)
        .update({'views': FieldValue.increment(1)})
        .catchError((_) {}); // best-effort, never block the UI on this
  }

  void _showRepostMenu(BuildContext context, String postId, bool alreadyReposted, Map<String, dynamic> originalPost) async {
    if (alreadyReposted) {
      // Tapping again un-reposts directly, no need to show the menu again.
      final profile = await UserService.getProfile();
      await PostInteractionService.toggleRepost(postId,
        feedTarget: originalPost['feedTarget'] as String? ?? 'global',
        myDisplayName: profile?['displayName'] as String? ?? 'User',
        myUniversity: profile?['university'] as String? ?? '');
      return;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetContext) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          Container(width: 36, height: 4,
            decoration: BoxDecoration(color: AppColors.border,
              borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.repeat_rounded, color: AppColors.textPrimary),
            title: Text('Repost', style: GoogleFonts.dmSans(
              fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
            subtitle: Text('Shares this to your feed instantly', style: GoogleFonts.dmSans(
              fontSize: 12, color: AppColors.textTertiary)),
            onTap: () async {
              Navigator.pop(sheetContext);
              final profile = await UserService.getProfile();
              await PostInteractionService.toggleRepost(postId,
                feedTarget: originalPost['feedTarget'] as String? ?? 'global',
                myDisplayName: profile?['displayName'] as String? ?? 'User',
                myUniversity: profile?['university'] as String? ?? '');
            },
          ),
          ListTile(
            leading: Icon(Icons.edit_outlined, color: AppColors.textPrimary),
            title: Text('Quote post', style: GoogleFonts.dmSans(
              fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
            subtitle: Text('Add your own comment above it', style: GoogleFonts.dmSans(
              fontSize: 12, color: AppColors.textTertiary)),
            onTap: () {
              Navigator.pop(sheetContext);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => PostComposerPage(quotedPost: originalPost)));
            },
          ),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  String _timeAgo(dynamic createdAt) {
    if (createdAt == null) return 'now';
    DateTime dt;
    if (createdAt is Timestamp) {
      dt = createdAt.toDate();
    } else {
      return 'now';
    }
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  String _initials(String name) {
    // Guard against empty segments from double spaces or odd formatting
    // (e.g. "John  Doe") which would otherwise index into an empty
    // string and crash with a RangeError.
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (parts.isNotEmpty) return parts[0][0].toUpperCase();
    return 'U';
  }

  Color _avatarColor(String uid) {
    final colors = [
      const Color(0xFF7C3AED), const Color(0xFF0891B2),
      const Color(0xFF16A34A), const Color(0xFFD97706),
      const Color(0xFFBE185D), const Color(0xFF9333EA),
    ];
    return colors[uid.hashCode.abs() % colors.length];
  }

  void _showPostMenu(BuildContext context, String postId, bool isOwner) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetContext) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          Container(width: 36, height: 4,
            decoration: BoxDecoration(color: AppColors.border,
              borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 8),
          if (isOwner)
            ListTile(
              leading: Icon(Icons.delete_outline_rounded,
                color: AppColors.error),
              title: Text('Delete post', style: GoogleFonts.dmSans(
                fontSize: 14, color: AppColors.error)),
              onTap: () {
                Navigator.pop(sheetContext);
                _confirmDelete(context, postId);
              },
            )
          else
            ListTile(
              leading: Icon(Icons.flag_outlined,
                color: AppColors.textTertiary),
              title: Text('Report post', style: GoogleFonts.dmSans(
                fontSize: 14, color: AppColors.textSecondary)),
              onTap: () => Navigator.pop(sheetContext),
            ),
          ListTile(
            leading: Icon(Icons.close_rounded,
              color: AppColors.textTertiary),
            title: Text('Cancel', style: GoogleFonts.dmSans(
              fontSize: 14, color: AppColors.textSecondary)),
            onTap: () => Navigator.pop(sheetContext),
          ),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String postId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Delete this post?', style: GoogleFonts.dmSans(
          fontSize: 16, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary)),
        content: Text("This can't be undone.", style: GoogleFonts.dmSans(
          fontSize: 13, color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: GoogleFonts.dmSans(
              color: AppColors.textSecondary))),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              PostInteractionService.deletePost(postId);
            },
            child: Text('Delete', style: GoogleFonts.dmSans(
              color: AppColors.error, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  void _openComments(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CommentsSheet(postId: postId),
    );
  }

  void _openUserProfile(BuildContext context, Map<String, dynamic> post) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => _UserProfilePage(
        uid: post['uid'] as String? ?? '',
        displayName: post['displayName'] as String? ?? 'User',
        usernameDisplay: post['usernameDisplay'] as String?,
        university: post['university'] as String? ?? '',
        course: post['course'] as String? ?? '',
        verified: post['verified'] as bool? ?? false,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    // Repost pointer: this doc has no content/likes/comments of its own —
    // fetch and render the ORIGINAL post live, so every interaction
    // (like, comment, repost count) stays tied to whoever actually wrote
    // it, not to this reposter.
    if (post['type'] == 'repost') {
      final originalId = post['originalPostId'] as String?;
      final reposterName = _authorLabel(post);
      if (originalId == null) return const SizedBox.shrink();
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').doc(originalId).snapshots(),
        builder: (context, snap) {
          if (!snap.hasData || !snap.data!.exists) return const SizedBox.shrink();
          final originalData = {'id': snap.data!.id, ...snap.data!.data() as Map<String, dynamic>};
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(children: [
                Icon(Icons.repeat_rounded, size: 14, color: AppColors.textTertiary),
                const SizedBox(width: 6),
                Text('$reposterName reposted', style: GoogleFonts.dmSans(
                  fontSize: 12, color: AppColors.textTertiary)),
              ]),
            ),
            _PostCard(post: originalData),
          ]);
        },
      );
    }

    final postId = post['id'] as String;
    final displayName = post['displayName'] as String? ?? 'User';
    final authorLabel = _authorLabel(post);
    final uid = post['uid'] as String? ?? '';
    final content = post['content'] as String? ?? '';
    final views = post['views'] as int? ?? 0;
    final verified = post['verified'] as bool? ?? false;
    final imageUrls = (post['imageUrls'] as List<dynamic>?) ?? [];
    final audioUrl = post['audioUrl'] as String?;
    final quotedPostId = post['quotedPostId'] as String?;
    final timeAgo = _timeAgo(post['createdAt']);
    final isOwner = UserService.uid != null && UserService.uid == uid;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Avatar
        GestureDetector(
          onTap: () => _openUserProfile(context, post),
          child: Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: _avatarColor(uid), shape: BoxShape.circle),
            child: Center(child: Text(_initials(displayName),
              style: GoogleFonts.dmSans(
                fontSize: 14, fontWeight: FontWeight.w700,
                color: Colors.white))),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Name row
          Row(children: [
            Flexible(
              child: GestureDetector(
                onTap: () => _openUserProfile(context, post),
                child: Text(authorLabel, style: GoogleFonts.dmSans(
                  fontSize: 14, fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary),
                  overflow: TextOverflow.ellipsis),
              ),
            ),
            if (verified) ...[
              const SizedBox(width: 4),
              Container(
                width: 16, height: 16,
                decoration: BoxDecoration(
                  color: AppColors.accent, shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded,
                  size: 10, color: Colors.white)),
            ],
            _TierBadge(uid: uid),
            const SizedBox(width: 6),
            Text('· $timeAgo', style: GoogleFonts.dmSans(
              fontSize: 12, color: AppColors.textTertiary)),
            const Spacer(),
            GestureDetector(
              onTap: () => _showPostMenu(context, postId, isOwner),
              child: Icon(Icons.more_horiz_rounded,
                size: 18, color: AppColors.textTertiary),
            ),
          ]),
          const SizedBox(height: 6),
          // Content
          if (content.isNotEmpty)
            Text(content, style: GoogleFonts.dmSans(
              fontSize: 14, color: AppColors.textPrimary, height: 1.5)),
          // Quoted post preview (read-only — tapping/interacting here is
          // about the ORIGINAL post, this quote post has its own separate
          // likes/comments below, shown as normal for this post)
          if (quotedPostId != null) ...[
            const SizedBox(height: 10),
            _QuotedPostPreview(postId: quotedPostId),
          ],
          // Voice note
          if (audioUrl != null && audioUrl.isNotEmpty) ...[
            const SizedBox(height: 10),
            _VoiceNoteBubble(
              commentId: postId,
              audioUrl: audioUrl,
              durationMs: post['durationMs'] as int? ?? 0,
              waveform: ((post['waveform'] as List<dynamic>?) ?? [])
                  .map((e) => (e as num).toDouble())
                  .toList(),
            ),
          ],
          // Video or images (mutually exclusive, matching the composer)
          if (post['videoUrl'] != null) ...[
            const SizedBox(height: 10),
            _FeedVideoPlayer(videoUrl: post['videoUrl'] as String, postId: post['id'] as String),
          ] else if (imageUrls.isNotEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrls[0] as String,
                width: double.infinity, height: 200,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox())),
          ],
          const SizedBox(height: 12),
          // Actions
          Row(children: [
            StreamBuilder<int>(
              stream: PostInteractionService.commentCount(postId),
              builder: (context, snap) => _ActionBtn(
                icon: Icons.chat_bubble_outline_rounded,
                label: _fmt(snap.data ?? 0),
                color: AppColors.textTertiary,
                onTap: () => _openComments(context, postId),
              ),
            ),
            const SizedBox(width: 20),
            StreamBuilder<bool>(
              stream: PostInteractionService.isRepostedByMe(postId),
              builder: (context, repostedSnap) {
                final reposted = repostedSnap.data ?? false;
                return StreamBuilder<int>(
                  stream: PostInteractionService.repostCount(postId),
                  builder: (context, countSnap) => _ActionBtn(
                    icon: Icons.repeat_rounded,
                    label: _fmt(countSnap.data ?? 0),
                    color: reposted ? AppColors.success : AppColors.textTertiary,
                    onTap: () => _showRepostMenu(context, postId, reposted, post),
                  ),
                );
              },
            ),
            const SizedBox(width: 20),
            StreamBuilder<bool>(
              stream: PostInteractionService.isLikedByMe(postId),
              builder: (context, likedSnap) {
                final liked = likedSnap.data ?? false;
                return StreamBuilder<int>(
                  stream: PostInteractionService.likeCount(postId),
                  builder: (context, countSnap) => _ActionBtn(
                    icon: liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    label: _fmt(countSnap.data ?? 0),
                    color: liked ? const Color(0xFFE24B4A) : AppColors.textTertiary,
                    onTap: () => PostInteractionService.toggleLike(postId, uid),
                  ),
                );
              },
            ),
            const SizedBox(width: 20),
            _ActionBtn(
              icon: Icons.bar_chart_rounded,
              label: _fmt(views),
              color: AppColors.textTertiary,
              onTap: () {},
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.bookmark_border_rounded,
                size: 18, color: AppColors.textTertiary)),
          ]),
        ])),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Comments sheet
// ─────────────────────────────────────────────────────────────────────────────
// A palette of 40 distinct hues, evenly spaced — so across many voice
// notes you see real color variety (not a random color per note, which
// would look noisy) while still only cycling through ~40 total colors.
// Same comment always gets the same color (hashed from its id).
final List<Color> _voiceNoteColorPalette = List.generate(40, (i) {
  final hue = (i * 360 / 40) % 360;
  return HSLColor.fromAHSL(1.0, hue, 0.62, 0.55).toColor();
});

Color _voiceNoteColor(String seed) =>
    _voiceNoteColorPalette[seed.hashCode.abs() % _voiceNoteColorPalette.length];

String _fmtSeconds(int totalSeconds) {
  final m = totalSeconds ~/ 60;
  final s = totalSeconds % 60;
  return '$m:${s.toString().padLeft(2, '0')}';
}

class _CommentsSheet extends StatefulWidget {
  final String postId;
  const _CommentsSheet({required this.postId});

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  final _ctrl = TextEditingController();
  bool _sending = false;

  bool _isRecording = false;
  bool _uploadingVoice = false;
  int _recordingSeconds = 0;
  Timer? _recordTimer;

  @override
  void dispose() {
    _ctrl.dispose();
    _recordTimer?.cancel();
    super.dispose();
  }

  String _timeAgo(dynamic createdAt) {
    if (createdAt == null) return 'now';
    if (createdAt is! Timestamp) return 'now';
    final diff = DateTime.now().difference(createdAt.toDate());
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      await PostInteractionService.addComment(widget.postId, text);
      _ctrl.clear();
    } finally {
      if (mounted) setState(() => _sending = false);
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

  Future<void> _sendRecording() async {
    _recordTimer?.cancel();
    setState(() {
      _isRecording = false;
      _uploadingVoice = true;
    });
    try {
      final result = await VoiceNoteService.stopRecording();
      if (result == null) return; // too short — silently discarded
      await VoiceNoteService.sendAsComment(
        postId: widget.postId,
        file: result.file,
        durationMs: result.durationMs,
        waveform: result.waveform,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Voice note failed: $e',
          style: GoogleFonts.dmSans(fontSize: 13)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating));
    } finally {
      if (mounted) setState(() => _uploadingVoice = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(children: [
          const SizedBox(height: 8),
          Container(width: 36, height: 4,
            decoration: BoxDecoration(color: AppColors.border,
              borderRadius: BorderRadius.circular(2))),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Comments', style: GoogleFonts.dmSans(
              fontSize: 16, fontWeight: FontWeight.w600,
              color: AppColors.textPrimary)),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: PostInteractionService.comments(widget.postId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Could not load comments:\n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 12, color: AppColors.error),
                      ),
                    ),
                  );
                }
                final comments = snapshot.data ?? [];
                if (comments.isEmpty) {
                  return Center(
                    child: Text('No comments yet — be the first',
                      style: GoogleFonts.dmSans(
                        fontSize: 13, color: AppColors.textTertiary)),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: comments.length,
                  itemBuilder: (_, i) {
                    final c = comments[i];
                    final commentId = c['id'] as String;
                    final name = c['displayName'] as String? ?? 'User';
                    final commentAuthorLabel = _authorLabel(c);
                    final audioUrl = c['audioUrl'] as String?;
                    final isVoice = audioUrl != null && audioUrl.isNotEmpty;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                          width: 32, height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.accentSurface, shape: BoxShape.circle),
                          child: Center(child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : 'U',
                            style: GoogleFonts.dmSans(fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.accentLight))),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(children: [
                            Text(commentAuthorLabel, style: GoogleFonts.dmSans(
                              fontSize: 13, fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary)),
                            _TierBadge(uid: c['uid'] as String? ?? ''),
                            const SizedBox(width: 6),
                            Text(_timeAgo(c['createdAt']), style: GoogleFonts.dmSans(
                              fontSize: 11, color: AppColors.textTertiary)),
                          ]),
                          const SizedBox(height: 4),
                          if (isVoice)
                            _VoiceNoteBubble(
                              commentId: commentId,
                              audioUrl: audioUrl,
                              durationMs: c['durationMs'] as int? ?? 0,
                              waveform: ((c['waveform'] as List<dynamic>?) ?? [])
                                  .map((e) => (e as num).toDouble())
                                  .toList(),
                            )
                          else
                            Text(c['content'] as String? ?? '',
                              style: GoogleFonts.dmSans(
                                fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                          const SizedBox(height: 4),
                          StreamBuilder<bool>(
                            stream: PostInteractionService.isCommentLikedByMe(
                              widget.postId, commentId),
                            builder: (context, likedSnap) {
                              final liked = likedSnap.data ?? false;
                              return StreamBuilder<int>(
                                stream: PostInteractionService.commentLikeCount(
                                  widget.postId, commentId),
                                builder: (context, countSnap) => GestureDetector(
                                  onTap: () => PostInteractionService
                                      .toggleCommentLike(widget.postId, commentId),
                                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                                    Icon(
                                      liked ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                      size: 14,
                                      color: liked
                                          ? const Color(0xFFE24B4A)
                                          : AppColors.textTertiary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text('${countSnap.data ?? 0}',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 11,
                                        color: liked
                                            ? const Color(0xFFE24B4A)
                                            : AppColors.textTertiary)),
                                  ]),
                                ),
                              );
                            },
                          ),
                        ])),
                      ]),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16,
              MediaQuery.of(context).viewInsets.bottom + 12),
            child: _isRecording
                ? Row(children: [
                    Icon(Icons.fiber_manual_record_rounded,
                      color: AppColors.error, size: 14),
                    const SizedBox(width: 8),
                    Text('Recording ${_fmtSeconds(_recordingSeconds)}',
                      style: GoogleFonts.dmSans(
                        fontSize: 13, color: AppColors.textPrimary)),
                    const Spacer(),
                    GestureDetector(
                      onTap: _cancelRecording,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant, shape: BoxShape.circle),
                        child: Icon(Icons.close_rounded,
                          color: AppColors.textSecondary, size: 18)),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _sendRecording,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.accent, shape: BoxShape.circle),
                        child: const Icon(Icons.check_rounded,
                          color: Colors.white, size: 18)),
                    ),
                  ])
                : Row(children: [
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Add a comment…',
                          hintStyle: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textTertiary),
                          filled: true,
                          fillColor: AppColors.surface,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: AppColors.border)),
                        ),
                        onSubmitted: (_) => _send(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _uploadingVoice ? null : _startRecording,
                      child: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.surface, shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border)),
                        child: _uploadingVoice
                            ? Padding(padding: EdgeInsets.all(10),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2, color: AppColors.accent))
                            : Icon(Icons.mic_none_rounded,
                                color: AppColors.textSecondary, size: 18),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _send,
                      child: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.accent, shape: BoxShape.circle),
                        child: _sending
                            ? const Padding(padding: EdgeInsets.all(10),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                            : const Icon(Icons.arrow_upward_rounded,
                                size: 18, color: Colors.white),
                      ),
                    ),
                  ]),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// User profile preview sheet
// ─────────────────────────────────────────────────────────────────────────────
Future<int> _fetchPostCount(String uid) async {
  try {
    final snap = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: uid)
        .count()
        .get();
    return snap.count ?? 0;
  } catch (_) {
    return 0;
  }
}

class _UserProfilePage extends StatelessWidget {
  final String uid;
  final String displayName;
  final String? usernameDisplay;
  final String university;
  final String course;
  final bool verified;

  const _UserProfilePage({
    required this.uid,
    required this.displayName,
    this.usernameDisplay,
    required this.university,
    required this.course,
    required this.verified,
  });

  String _initials(String name) {
    // Guard against empty segments from double spaces or odd formatting
    // (e.g. "John  Doe") which would otherwise index into an empty
    // string and crash with a RangeError.
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (parts.isNotEmpty) return parts[0][0].toUpperCase();
    return 'U';
  }

  Color _avatarColor(String uid) {
    final colors = [
      const Color(0xFF7C3AED), const Color(0xFF0891B2),
      const Color(0xFF16A34A), const Color(0xFFD97706),
      const Color(0xFFBE185D), const Color(0xFF9333EA),
    ];
    return colors[uid.hashCode.abs() % colors.length];
  }

  void _openPost(BuildContext context, Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85, minChildSize: 0.5, maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            child: _PostCard(post: post),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSelf = UserService.uid != null && UserService.uid == uid;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(displayName, style: GoogleFonts.dmSans(
          fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
              child: Column(children: [
                Container(
                  width: 72, height: 72,
                  decoration: BoxDecoration(
                    color: _avatarColor(uid), shape: BoxShape.circle),
                  child: Center(child: Text(_initials(displayName),
                    style: GoogleFonts.dmSans(
                      fontSize: 24, fontWeight: FontWeight.w700,
                      color: Colors.white))),
                ),
                const SizedBox(height: 14),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(displayName, style: GoogleFonts.dmSans(
                    fontSize: 18, fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary)),
                  if (verified) ...[
                    const SizedBox(width: 6),
                    Container(
                      width: 18, height: 18,
                      decoration: BoxDecoration(
                        color: AppColors.accent, shape: BoxShape.circle),
                      child: const Icon(Icons.check_rounded,
                        size: 11, color: Colors.white)),
                  ],
                ]),
                if (usernameDisplay != null && usernameDisplay!.trim().isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text('@$usernameDisplay', style: GoogleFonts.dmSans(
                    fontSize: 13, color: AppColors.accentLight)),
                ],
                const SizedBox(height: 4),
                if (university.isNotEmpty)
                  Text(course.isNotEmpty ? '$university · $course' : university,
                    style: GoogleFonts.dmSans(
                      fontSize: 13, color: AppColors.textTertiary),
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  FutureBuilder<int>(
                    future: _fetchPostCount(uid),
                    builder: (context, snap) =>
                        _StatColumn(label: 'Posts', value: snap.data ?? 0),
                  ),
                  StreamBuilder<int>(
                    stream: UserFollowService.followerCount(uid),
                    builder: (context, snap) =>
                        _StatColumn(label: 'Followers', value: snap.data ?? 0),
                  ),
                  StreamBuilder<int>(
                    stream: UserFollowService.followingCount(uid),
                    builder: (context, snap) =>
                        _StatColumn(label: 'Following', value: snap.data ?? 0),
                  ),
                ]),
                const SizedBox(height: 22),
                if (!isSelf)
                  StreamBuilder<bool>(
                    stream: UserFollowService.isFollowing(uid),
                    builder: (context, snap) {
                      final following = snap.data ?? false;
                      return GestureDetector(
                        onTap: () => UserFollowService.toggleFollow(uid),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: following ? Colors.transparent : AppColors.accent,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColors.accent),
                          ),
                          child: Text(following ? 'Following' : 'Follow',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              fontSize: 14, fontWeight: FontWeight.w600,
                              color: following ? AppColors.accent : Colors.white)),
                        ),
                      );
                    },
                  ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(height: 0.5, color: AppColors.border, margin: const EdgeInsets.only(bottom: 2)),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .where('uid', isEqualTo: uid)
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }
              final docs = snap.data?.docs ?? [];
              if (docs.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Center(child: Text('No posts yet',
                      style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary))),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.all(2),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final data = docs[i].data() as Map<String, dynamic>;
                      final post = {...data, 'id': docs[i].id};
                      final imageUrls = (post['imageUrls'] as List<dynamic>?) ?? [];
                      final videoUrl = post['videoUrl'] as String?;
                      final audioUrl = post['audioUrl'] as String?;
                      final content = post['content'] as String? ?? '';

                      return GestureDetector(
                        onTap: () => _openPost(context, post),
                        child: Container(
                          color: AppColors.surface,
                          child: imageUrls.isNotEmpty
                              ? Image.network(imageUrls.first as String, fit: BoxFit.cover)
                              : videoUrl != null
                                  ? Center(child: Icon(Icons.play_circle_fill_rounded, color: AppColors.textTertiary, size: 28))
                                  : audioUrl != null
                                      ? Center(child: Icon(Icons.graphic_eq_rounded, color: AppColors.textTertiary, size: 24))
                                      : Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(content,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textSecondary)),
                                        ),
                        ),
                      );
                    },
                    childCount: docs.length,
                  ),
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final int value;
  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('$value', style: GoogleFonts.dmSans(
        fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      const SizedBox(height: 2),
      Text(label, style: GoogleFonts.dmSans(
        fontSize: 11, color: AppColors.textTertiary)),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Voice note playback bubble
// ─────────────────────────────────────────────────────────────────────────────
class _VoiceNoteBubble extends StatefulWidget {
  final String commentId;
  final String audioUrl;
  final int durationMs;
  final List<double> waveform;

  const _VoiceNoteBubble({
    required this.commentId,
    required this.audioUrl,
    required this.durationMs,
    required this.waveform,
  });

  @override
  State<_VoiceNoteBubble> createState() => _VoiceNoteBubbleState();
}

class _VoiceNoteBubbleState extends State<_VoiceNoteBubble> {
  final _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _total = Duration.zero;
  StreamSubscription? _posSub, _durSub, _completeSub;

  @override
  void initState() {
    super.initState();
    _total = Duration(milliseconds: widget.durationMs);
    _posSub = _player.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    });
    _durSub = _player.onDurationChanged.listen((d) {
      if (mounted) setState(() => _total = d);
    });
    _completeSub = _player.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _position = Duration.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    _posSub?.cancel();
    _durSub?.cancel();
    _completeSub?.cancel();
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_isPlaying) {
      await _player.pause();
      if (mounted) setState(() => _isPlaying = false);
    } else {
      await _player.play(UrlSource(widget.audioUrl));
      if (mounted) setState(() => _isPlaying = true);
    }
  }

  String _fmtDuration(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final color = _voiceNoteColor(widget.commentId);
    final waveform = widget.waveform.isEmpty
        ? List<double>.filled(40, 0.15)
        : widget.waveform;
    final progress = _total.inMilliseconds == 0
        ? 0.0
        : (_position.inMilliseconds / _total.inMilliseconds).clamp(0.0, 1.0);
    final playedBars = (progress * waveform.length).round();
    final displayDuration =
        (_isPlaying || _position > Duration.zero) ? _position : _total;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 240),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Row(children: [
        GestureDetector(
          onTap: _toggle,
          child: Container(
            width: 30, height: 30,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white, size: 16),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 26,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(waveform.length, (i) {
                final amp = waveform[i].clamp(0.08, 1.0);
                final played = i < playedBars;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    height: 4 + amp * 18,
                    decoration: BoxDecoration(
                      color: played ? color : color.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(_fmtDuration(displayDuration),
          style: GoogleFonts.dmSans(fontSize: 10, color: color)),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Action button
// ─────────────────────────────────────────────────────────────────────────────
class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon, required this.label,
    required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 17, color: color),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.dmSans(fontSize: 12, color: color)),
      ]),
    );
  }
}

class SocialSearchPage extends StatefulWidget {
  const SocialSearchPage({super.key});

  @override
  State<SocialSearchPage> createState() => _SocialSearchPageState();
}

class _SocialSearchPageState extends State<SocialSearchPage> {
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

  // Firestore has no native "contains" text search, so -- same pattern
  // already used for the feed itself -- fetch a bounded, recent batch and
  // filter client-side. Fine at this scale; revisit with a real search
  // index (Algolia etc.) if the user/post count grows large enough that
  // relevant results start falling outside this batch.
  Future<List<Map<String, dynamic>>> _searchUsers(String q) async {
    if (q.isEmpty) return [];
    final snap = await FirebaseFirestore.instance.collection('users').limit(200).get();
    return snap.docs
        .map((d) => {'uid': d.id, ...d.data()})
        .where((u) => (u['displayName'] as String? ?? '').toLowerCase().contains(q))
        .take(15)
        .toList();
  }

  Future<List<Map<String, dynamic>>> _searchPosts(String q) async {
    if (q.isEmpty) return [];
    final snap = await FirebaseFirestore.instance.collection('posts')
        .orderBy('createdAt', descending: true).limit(150).get();
    return snap.docs
        .map((d) => {'id': d.id, ...d.data()})
        .where((p) {
          if (p['type'] == 'repost') return false; // search real content only
          final content = (p['content'] as String? ?? '').toLowerCase();
          return content.contains(q);
        })
        .take(20)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Row(children: [
            GestureDetector(onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary)),
            const SizedBox(width: 12),
            Expanded(child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(24)),
              child: TextField(
                controller: _searchCtrl,
                autofocus: true,
                onChanged: _onChanged,
                style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search people and posts',
                  hintStyle: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textDisabled),
                  isDense: true, contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            )),
          ]),
        ),
        Expanded(
          child: _query.isEmpty
            ? Center(child: Text('Search for people or posts', style: GoogleFonts.dmSans(
                fontSize: 13, color: AppColors.textTertiary)))
            : FutureBuilder<List<List<Map<String, dynamic>>>>(
                future: Future.wait([_searchUsers(_query), _searchPosts(_query)]),
                builder: (context, snap) {
                  if (!snap.hasData) {
                    return Center(child: CircularProgressIndicator(color: AppColors.accent));
                  }
                  final users = snap.data![0];
                  final posts = snap.data![1];
                  if (users.isEmpty && posts.isEmpty) {
                    return Center(child: Text('No results for "$_query"', style: GoogleFonts.dmSans(
                      fontSize: 13, color: AppColors.textTertiary)));
                  }
                  return ListView(padding: const EdgeInsets.only(bottom: 40), children: [
                    if (users.isNotEmpty) ...[
                      Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                        child: Text('People', style: GoogleFonts.dmSans(
                          fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textTertiary))),
                      ...users.map((u) => ListTile(
                        leading: Container(width: 40, height: 40,
                          decoration: BoxDecoration(color: AppColors.accentSurface, shape: BoxShape.circle),
                          child: Center(child: Text(
                            (u['displayName'] as String? ?? 'U').isNotEmpty
                                ? (u['displayName'] as String)[0].toUpperCase() : 'U',
                            style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w700,
                              color: AppColors.accentLight)))),
                        title: Text(u['displayName'] as String? ?? 'User', style: GoogleFonts.dmSans(
                          fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                        subtitle: Text(u['university'] as String? ?? '', style: GoogleFonts.dmSans(
                          fontSize: 12, color: AppColors.textTertiary)),
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (_) => _UserProfilePage(
                            uid: u['uid'] as String? ?? '',
                            displayName: u['displayName'] as String? ?? 'User',
                            university: u['university'] as String? ?? '',
                            course: u['course'] as String? ?? '',
                            verified: false,
                          ),
                        )),
                      )),
                    ],
                    if (posts.isNotEmpty) ...[
                      Padding(padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
                        child: Text('Posts', style: GoogleFonts.dmSans(
                          fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textTertiary))),
                      ...posts.map((p) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _PostCard(post: p),
                      )),
                    ],
                  ]);
                },
              ),
        ),
      ])),
    );
  }
}
class _FeedVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String postId;
  const _FeedVideoPlayer({required this.videoUrl, required this.postId});

  @override
  State<_FeedVideoPlayer> createState() => _FeedVideoPlayerState();
}

class _FeedVideoPlayerState extends State<_FeedVideoPlayer> {
  VideoPlayerController? _controller;
  bool _loading = false;
  bool _started = false;

  // Deliberately NOT autoplaying or preloading -- a feed can hold many
  // video posts at once, and initializing every controller simultaneously
  // would burn bandwidth and battery for videos the user never actually
  // watches. Only loads once tapped.
  Future<void> _start() async {
    if (_started) return;
    setState(() { _started = true; _loading = true; });
    final controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    try {
      await controller.initialize();
      if (!mounted) { controller.dispose(); return; }
      setState(() { _controller = controller; _loading = false; });
      controller
        ..setLooping(true)
        ..play();
      FeedVideoWatchService.recordWatch();
    } catch (_) {
      if (mounted) setState(() { _loading = false; _started = false; });
      controller.dispose();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GestureDetector(
        onTap: () {
          if (_controller == null) {
            _start();
          } else {
            setState(() => _controller!.value.isPlaying
                ? _controller!.pause() : _controller!.play());
          }
        },
        onDoubleTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => FullscreenVideoFeedPage(initialPostId: widget.postId)),
        ),
        child: Container(
          width: double.infinity, height: 200,
          color: AppColors.surfaceVariant,
          child: Stack(alignment: Alignment.center, children: [
            if (_controller != null && _controller!.value.isInitialized)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller!.value.size.width,
                    height: _controller!.value.size.height,
                    child: VideoPlayer(_controller!),
                  ),
                ),
              ),
            if (_loading)
              CircularProgressIndicator(color: AppColors.accent)
            else if (_controller == null || !_controller!.value.isPlaying)
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle),
                child: const Icon(Icons.play_arrow_rounded,
                  color: Colors.white, size: 28)),
          ]),
        ),
      ),
    );
  }
}

// Deliberately no animation here, by design -- distinct from the Home
// screen's streak celebration. Just a static fire-in-a-capsule badge,
// small and quiet, next to the Social title.
class _SocialStreakCapsule extends StatelessWidget {
  const _SocialStreakCapsule();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: SocialStreakService.streamCurrentStreak(),
      builder: (context, snap) {
        final streak = snap.data ?? 0;
        if (streak <= 0) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF2A1200),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Text('🔥', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Text('$streak', style: GoogleFonts.dmSans(
              fontSize: 12, fontWeight: FontWeight.w600,
              color: const Color(0xFFFF9F0A))),
          ]),
        );
      },
    );
  }
}