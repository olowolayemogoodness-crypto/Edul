// lib/features/social/presentation/pages/story_caption_compose_page.dart
//
// The caption-only story type -- deliberately styled like a Substack
// post preview (serif typography, soft cream background, understated)
// rather than WhatsApp Status's bold saturated-gradient look. This is
// the one screen in the whole app that intentionally breaks from the
// established Poppins/DM Sans sans-serif convention -- that's the
// actual point of the reference, not an inconsistency.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/story_service.dart';
import '../../../../core/services/user_service.dart';

class StoryCaptionComposePage extends StatefulWidget {
  const StoryCaptionComposePage({super.key});

  @override
  State<StoryCaptionComposePage> createState() => _StoryCaptionComposePageState();
}

class _StoryCaptionComposePageState extends State<StoryCaptionComposePage> {
  final _ctrl = TextEditingController();
  bool _posting = false;

  // Cream/off-white, not black or a bold gradient -- the actual
  // Substack-preview reference point.
  static const _bg = Color(0xFFFBF8F3);
  static const _ink = Color(0xFF1A1815);
  static const _muted = Color(0xFF8C8478);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _post() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty || _posting) return;
    setState(() => _posting = true);
    try {
      await StoryService.postStory(type: StoryType.text, textContent: text, backgroundColor: '#FBF8F3');
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not post: $e')));
      }
    } finally {
      if (mounted) setState(() => _posting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateLabel = '${_monthName(now.month)} ${now.day}';

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg, elevation: 0,
        iconTheme: const IconThemeData(color: _ink),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: _posting ? null : _post,
              child: _posting
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: _ink))
                  : Text('Post', style: GoogleFonts.ptSerif(fontSize: 15, fontWeight: FontWeight.w700, color: _ink)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 12),
            // Byline row, matching how a Substack post preview shows
            // author + date above the text itself.
            FutureBuilder<Map<String, dynamic>?>(
              future: UserService.getProfile(),
              builder: (context, snap) {
                final profile = snap.data;
                final username = profile?['usernameDisplay'] as String?;
                final label = (username != null && username.trim().isNotEmpty)
                    ? '@$username' : (profile?['displayName'] as String? ?? 'You');
                return Text('$label  ·  $dateLabel',
                  style: GoogleFonts.ptSerif(fontSize: 12.5, color: _muted, fontStyle: FontStyle.italic));
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _ctrl,
                autofocus: true,
                maxLines: null,
                maxLength: 280,
                style: GoogleFonts.ptSerif(fontSize: 22, height: 1.5, color: _ink),
                decoration: InputDecoration(
                  hintText: "What's on your mind today?",
                  hintStyle: GoogleFonts.ptSerif(fontSize: 22, color: _muted.withOpacity(0.6), fontStyle: FontStyle.italic),
                  border: InputBorder.none,
                  counterStyle: GoogleFonts.dmSans(fontSize: 11, color: _muted),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  String _monthName(int m) => const ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m];
}