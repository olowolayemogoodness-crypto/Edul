// lib/features/tutor/presentation/pages/tutor_page.dart
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/groq_services.dart';
import '../../../../core/services/premium_service.dart';
import '../../../../core/services/tutor_usage_service.dart';
import '../../../../core/utils/paywall_helper.dart';
import '../../../../core/services/vision_service.dart';
import '../../../../core/services/user_service.dart';
import '../../domain/models/message_model.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({super.key});
  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  final TextEditingController inputCtrl = TextEditingController();
  final ScrollController scrollCtrl = ScrollController();
  final List<TutorMessage> messages = [];
  bool isLoading = false;
  final String chatTitle = 'AI Tutor';
  DateTime? _sessionStart;

  // Minutes used today, persisted in Firestore from previous sessions —
  // combined with the local `_sessionStart` timer this makes the daily cap
  // survive closing and reopening the app, not just leaving this screen.
  int _persistedMinutesToday = 0;
  int _lastFlushedLocalMinutes = 0;

  @override
  void initState() {
    super.initState();
    _loadPersistedUsage();
    _loadChatHistory();
  }

  // Firestore subcollection, same pattern already established for
  // per-user data elsewhere (followers, studyStats, tutorUsage) --
  // scoped under the user's own doc, only they can read/write it.
  CollectionReference<Map<String, dynamic>>? get _historyCol {
    final uid = UserService.uid;
    if (uid == null) return null;
    return FirebaseFirestore.instance.collection('users').doc(uid).collection('tutorMessages');
  }

  Future<void> _loadChatHistory() async {
    final col = _historyCol;
    if (col == null) return;
    try {
      final snap = await col.orderBy('timestamp').limit(100).get();
      if (!mounted || snap.docs.isEmpty) return;
      setState(() {
        messages.addAll(snap.docs.map((d) => TutorMessage.fromMap(d.id, d.data())));
      });
    } catch (_) {
      // Best-effort -- a fresh conversation is a fine fallback, not
      // worth surfacing an error over.
    }
  }

  // Fire-and-forget -- never blocks the chat UI waiting on a Firestore
  // write. Skips error-only messages deliberately (those are ephemeral
  // UI feedback, not real conversation content worth restoring later).
  void _persistMessage(TutorMessage msg) {
    if (msg.hasError) return;
    final col = _historyCol;
    if (col == null) return;
    // Fire-and-forget, but via a real try/catch rather than .catchError
    // -- col.add() returns Future<DocumentReference>, and .catchError's
    // handler has to return something assignable to that same type,
    // which an empty {} callback doesn't satisfy.
    () async {
      try {
        await col.add(msg.toMap());
      } catch (_) {
        // Best-effort -- losing one message from history isn't worth
        // surfacing an error over.
      }
    }();
  }

  Future<void> _loadPersistedUsage() async {
    final minutes = await TutorUsageService.getMinutesUsedToday();
    if (mounted) setState(() => _persistedMinutesToday = minutes);
  }

  /// Total minutes used today: what's already persisted, plus elapsed time
  /// in the current local session.
  int get _totalMinutesUsedToday {
    final localElapsed = _sessionStart == null
        ? 0
        : DateTime.now().difference(_sessionStart!).inMinutes;
    return _persistedMinutesToday + localElapsed;
  }

  /// Persists any newly-elapsed local minutes since the last flush, so
  /// usage is saved incrementally through the conversation rather than
  /// only at a clean "end session" point the app might never reach.
  Future<void> _flushLocalUsage() async {
    if (_sessionStart == null) return;
    final localElapsed = DateTime.now().difference(_sessionStart!).inMinutes;
    final delta = localElapsed - _lastFlushedLocalMinutes;
    if (delta <= 0) return;
    _lastFlushedLocalMinutes = localElapsed;
    await TutorUsageService.addMinutes(delta);
  }

  @override
  void dispose() {
    _flushLocalUsage();
    inputCtrl.dispose();
    scrollCtrl.dispose();
    super.dispose();
  }

  void sendMessage() async {
    final text = inputCtrl.text.trim();
    if (text.isEmpty || isLoading) return;

    // ── Free tier: 20-minute daily session limit ──────────────────────────
    // Checks total minutes today (persisted + local), not just this local
    // session, so it can't be reset by leaving and reopening this screen.
    if (PremiumService.isRealFree) {
      _sessionStart ??= DateTime.now();
      if (_totalMinutesUsedToday >= 20) {
        showPaywall(context,
          triggerReason: "You've used your 20-minute daily AI Tutor limit. Upgrade to Plus for unlimited access.",
        );
        return;
      }
    }

    HapticFeedback.lightImpact();

    setState(() {
      messages.add(TutorMessage(
        id: DateTime.now().toString(),
        content: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      isLoading = true;
    });
    _persistMessage(messages.last);

    inputCtrl.clear();
    scrollDown();

    try {
      // Build the conversation so far into the {role, content} shape
      // Groq expects, EXCLUDING the user message just added above (it's
      // passed separately as `text`) and excluding any error bubbles,
      // which aren't real assistant turns and would confuse the model
      // into thinking it just failed.
      final history = messages
          .where((m) => !m.hasError)
          .take(messages.length - 1) // drop the message just appended
          .map((m) => {
                'role': m.isUser ? 'user' : 'assistant',
                'content': m.content,
              })
          .toList();

      final response = await GroqService.askTutorWithHistory(
        text,
        history,
        isPro: PremiumService.isPro,
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
        messages.add(TutorMessage(
          id: DateTime.now().toString(),
          content: response,
          isUser: false,
          timestamp: DateTime.now(),
          xpEarned: 50,
        ));
      });
      _persistMessage(messages.last);

      scrollDown();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        messages.add(TutorMessage(
          id: DateTime.now().toString(),
          content: e.toString(),
          isUser: false,
          timestamp: DateTime.now(),
          error: e.toString(),
        ));
      });

      scrollDown();
    } finally {
      unawaited(_flushLocalUsage());
    }
  }

  void scrollDown() => Future.delayed(const Duration(milliseconds: 100), () {
    if (scrollCtrl.hasClients) {
      scrollCtrl.animateTo(scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  });

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      analyzeImage(File(pickedFile.path));
    }
  }

  void analyzeImage(File imageFile) async {
    HapticFeedback.lightImpact();

    setState(() {
      messages.add(TutorMessage(
        id: DateTime.now().toString(),
        content: '📸 Analyzing image...',
        isUser: true,
        timestamp: DateTime.now(),
      ));
      isLoading = true;
    });
    _persistMessage(messages.last);

    scrollDown();

    try {
      final response = await VisionService.analyzeImage(imageFile);

      if (!mounted) return;

      setState(() {
        isLoading = false;
        messages.add(TutorMessage(
          id: DateTime.now().toString(),
          content: response,
          isUser: false,
          timestamp: DateTime.now(),
          xpEarned: 75,
        ));
      });
      _persistMessage(messages.last);

      scrollDown();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        messages.add(TutorMessage(
          id: DateTime.now().toString(),
          content: e.toString(),
          isUser: false,
          timestamp: DateTime.now(),
          error: e.toString(),
        ));
      });

      scrollDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary, size: 24),
          ),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFEC4899)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(chatTitle,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                                fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.verified, color: AppColors.success, size: 16),
                      if (PremiumService.isRealFree) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A1F0A),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFF854F0B)),
                          ),
                          child: Text('Limited · 20 min/day',
                            style: GoogleFonts.dmSans(
                              fontSize: 9, fontWeight: FontWeight.w500,
                              color: const Color(0xFFEF9F27))),
                        ),
                      ],
                    ],
                  ),
                  Text(PremiumService.isPro ? 'GPT-OSS-120B via Groq' : 'GPT-OSS-20B via Groq',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.more_vert_rounded, color: AppColors.textTertiary, size: 20),
            ),
          ),
        ],
      ),
      body: Column(
  children: [
    Expanded(
      child: messages.isEmpty
          ? SingleChildScrollView(
              child: buildEmptyState(),
            )
          : ListView.builder(
                    controller: scrollCtrl,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    itemCount: messages.length + (isLoading ? 1 : 0),
                    itemBuilder: (ctx, i) => i == messages.length ? buildTypingBubble() : buildMessageBubble(messages[i]),
                  ),
    ),
    buildInputBar(),
  ],
),
    );
  }

  Widget buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 20),
          Text('Eddy, your AI Tutor',
              style: GoogleFonts.dmSans(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Ask me anything about your studies',
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textTertiary)),
          const SizedBox(height: 32),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              suggestionChip('Explain photosynthesis'),
              suggestionChip('Binary search trees'),
              suggestionChip('IELTS writing tips'),
            ],
          ),
        ],
      ),
    );
  }

  Widget suggestionChip(String text) {
    return GestureDetector(
      onTap: () {
        inputCtrl.text = text;
        sendMessage();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.accentSurface,
          border: Border.all(color: const Color(0xFF3D2580)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text,
            style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.accentLight)),
      ),
    );
  }

  Widget buildMessageBubble(TutorMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: msg.isUser
            ? [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 280),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      child: Text(
                        msg.content,
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'now',
                      style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textDisabled),
                    ),
                  ],
                ),
              ]
            : [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 280),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: msg.hasError ? AppColors.errorSurface : AppColors.surface,
                        border: Border.all(
                          color: msg.hasError ? AppColors.error : AppColors.border,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(18),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (msg.hasError)
                            Text(
                              msg.content,
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                color: AppColors.error,
                                height: 1.6,
                              ),
                            )
                          else
                            GptMarkdown(
                              msg.content,
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                height: 1.6,
                              ),
                            ),
                          if (msg.xpEarned != null && !msg.hasError) ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star_rounded, color: AppColors.success, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  '+${msg.xpEarned} XP',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 11,
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'now',
                      style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textDisabled),
                    ),
                  ],
                ),
              ],
      ),
    );
  }

  Widget buildTypingBubble() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: AnimatedDot(delay: Duration(milliseconds: i * 150)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputBar() {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: AppColors.border)),
    ),
    child: Row(
      children: [
        // CAMERA BUTTON
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.surface,
                            AppColors.background,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.border, width: 1.5),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text('🔥', style: TextStyle(fontSize: 45)),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Camera Analysis',
                            style: GoogleFonts.dmSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Coming Soon',
                            style: GoogleFonts.dmSans(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFF8C42),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'We\'re bringing vision AI to analyze your questions. Stay tuned!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: AppColors.textTertiary,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.camera_alt_rounded, color: AppColors.textTertiary, size: 20),
          ),
        ),
        const SizedBox(width: 10),
        // TEXT INPUT FIELD
        Expanded(
          child: TextField(
            controller: inputCtrl,
            style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Ask Eddy anything…',
              hintStyle: GoogleFonts.dmSans(fontSize: 15, color: AppColors.textTertiary),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.accent, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            ),
            onSubmitted: (_) => sendMessage(),
          ),
        ),
        const SizedBox(width: 10),
        // SEND BUTTON
        GestureDetector(
          onTap: isLoading ? null : sendMessage,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_upward_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    ),
  );
}
}

class AnimatedDot extends StatefulWidget {
  final Duration delay;
  const AnimatedDot({required this.delay});

  @override
  State<AnimatedDot> createState() => AnimatedDotState();
}

class AnimatedDotState extends State<AnimatedDot> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0, end: -6).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    Future.delayed(widget.delay, () {
      if (mounted) controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, animation.value),
        child: Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: AppColors.accentLight,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}