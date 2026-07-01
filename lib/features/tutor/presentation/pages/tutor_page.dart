// lib/features/tutor/presentation/pages/tutor_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/groq_services.dart';
import '../../../../core/services/vision_service.dart';
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

  @override
  void dispose() {
    inputCtrl.dispose();
    scrollCtrl.dispose();
    super.dispose();
  }

  void sendMessage() async {
    final text = inputCtrl.text.trim();
    if (text.isEmpty || isLoading) return;

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

    inputCtrl.clear();
    scrollDown();

    try {
      final response = await GroqService.askTutor(text);

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
      messages.clear();
      messages.add(TutorMessage(
        id: DateTime.now().toString(),
        content: '📸 Analyzing image...',
        isUser: true,
        timestamp: DateTime.now(),
      ));
      isLoading = true;
    });

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
          child: const Padding(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(chatTitle,
                        style: GoogleFonts.dmSans(
                            fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(width: 6),
                    const Icon(Icons.verified, color: AppColors.success, size: 16),
                  ],
                ),
                Text('LLaMA via Groq',
                    style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary)),
              ],
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
              child: const Icon(Icons.more_vert_rounded, color: AppColors.textTertiary, size: 20),
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
          Text('LLaMA AI Tutor',
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
                          Text(
                            msg.content,
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              color: msg.hasError ? AppColors.error : AppColors.textSecondary,
                              height: 1.6,
                            ),
                          ),
                          if (msg.xpEarned != null && !msg.hasError) ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star_rounded, color: AppColors.success, size: 14),
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
    decoration: const BoxDecoration(
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
            child: const Icon(Icons.camera_alt_rounded, color: AppColors.textTertiary, size: 20),
          ),
        ),
        const SizedBox(width: 10),
        // TEXT INPUT FIELD
        Expanded(
          child: TextField(
            controller: inputCtrl,
            style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Ask LLaMA anything…',
              hintStyle: GoogleFonts.dmSans(fontSize: 15, color: AppColors.textTertiary),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
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
          decoration: const BoxDecoration(
            color: AppColors.accentLight,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}