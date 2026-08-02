
// lib/features/social/presentation/widgets/active_now_strip.dart
//
// Horizontal row of currently-active people you follow, shown at the
// top of the social feed. Data comes from ActiveNowService's polled
// (not live) query — see that file for why polling matters here.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/active_now_service.dart';

class ActiveNowStrip extends StatelessWidget {
  const ActiveNowStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ActiveNowService.activeFollowing(),
      builder: (context, snapshot) {
        final active = snapshot.data ?? [];
        if (active.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: 76,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: active.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final u = active[i];
              final name = u['displayName'] as String? ?? 'User';
              final initial = name.isNotEmpty ? name[0].toUpperCase() : 'U';
              return SizedBox(
                width: 52,
                child: Column(children: [
                  Stack(clipBehavior: Clip.none, children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.accentSurface, shape: BoxShape.circle),
                      child: Center(child: Text(initial, style: GoogleFonts.dmSans(
                        fontSize: 16, fontWeight: FontWeight.w700,
                        color: AppColors.accentLight))),
                    ),
                    Positioned(
                      right: -1, bottom: -1,
                      child: Container(
                        width: 13, height: 13,
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E), shape: BoxShape.circle,
                          border: Border.all(color: AppColors.background, width: 2)),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 4),
                  Text(name.split(' ').first, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textSecondary)),
                ]),
              );
            },
          ),
        );
      },
    );
  }
}