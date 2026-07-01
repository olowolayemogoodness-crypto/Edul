import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class LeaderboardStrip extends StatefulWidget {
  const LeaderboardStrip({super.key});

  @override
  State<LeaderboardStrip> createState() => _LeaderboardStripState();
}

class _LeaderboardStripState extends State<LeaderboardStrip>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _barAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300));
    _barAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  static const _rows = [
    _LbRow(rank: '1', initials: 'OK', name: 'Olumide K.', pts: 4820,
        barW: 1.0, rankColor: Color(0xFFEF9F27), isGold: true),
    _LbRow(rank: '#2', initials: 'ZN', name: 'Zara N.', pts: 3960,
        barW: 0.82, rankColor: AppColors.textSecondary, isGold: false),
    _LbRow(rank: '#38', initials: 'AO', name: 'You · Adaeze', pts: 2840,
        barW: 0.58, rankColor: AppColors.accentLight, isYou: true),
    _LbRow(rank: '#39', initials: 'TF', name: 'Tunde F.', pts: 2790,
        barW: 0.56, rankColor: AppColors.textSecondary, isGold: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: _rows.map((r) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _LbRowWidget(row: r, barAnim: _barAnim),
          );
        }).toList(),
      ),
    );
  }
}

class _LbRowWidget extends StatelessWidget {
  final _LbRow row;
  final Animation<double> barAnim;
  const _LbRowWidget({required this.row, required this.barAnim});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: row.isYou
          ? const EdgeInsets.symmetric(horizontal: 6, vertical: 4)
          : EdgeInsets.zero,
      decoration: row.isYou
          ? BoxDecoration(
              color: AppColors.accentSurface,
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(row.rank,
                style: AppTextStyles.labelMedium
                    .copyWith(color: row.rankColor),
                textAlign: TextAlign.center),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: row.isGold
                  ? const Color(0xFF2A1F00)
                  : row.isYou
                      ? AppColors.accentSurface
                      : AppColors.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(row.initials,
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: row.rankColor)),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(row.name,
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColors.textPrimary, fontSize: 11)),
          ),
          AnimatedBuilder(
            animation: barAnim,
            builder: (_, __) => SizedBox(
              width: 60,
              height: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: barAnim.value * row.barW,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      row.isGold ? const Color(0xFFEF9F27) : AppColors.accent),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(row.pts.toString(),
              style: AppTextStyles.labelMedium
                  .copyWith(color: row.isYou ? AppColors.accentLight : AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _LbRow {
  final String rank;
  final String initials;
  final String name;
  final int pts;
  final double barW;
  final Color rankColor;
  final bool isGold;
  final bool isYou;

  const _LbRow({
    required this.rank,
    required this.initials,
    required this.name,
    required this.pts,
    required this.barW,
    required this.rankColor,
    this.isGold = false,
    this.isYou = false,
  });
}