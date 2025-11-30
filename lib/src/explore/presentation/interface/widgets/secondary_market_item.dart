import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../domain/entities/tbill_bond_data.dart';

class SecondaryMarketListItem extends StatelessWidget {
  final SecondaryMarketItem item;
  final VoidCallback onTap;

  const SecondaryMarketListItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.border(context), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            // Logo placeholder
            _buildLogoPlaceholder(context),
            const SizedBox(width: 12),

            // Code and type
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.medium(
                    item.code,
                    style: TextStyle(color: AppColors.primaryText(context)),
                  ),
                  const SizedBox(height: 2),
                  AppText.smallest(
                    item.typeLabel,
                    color: AppColors.defaultText(context),
                  ),
                ],
              ),
            ),

            // Mini chart
            _buildMiniChart(context),
            const SizedBox(width: 24),

            // Rate and change
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppText.medium(
                  '${item.rate.toStringAsFixed(2)}%',
                  style: TextStyle(color: AppColors.primaryText(context)),
                ),
                const SizedBox(height: 4),
                _buildChangeText(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoPlaceholder(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.softBorder(context),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border(context), width: 1),
      ),
      child: Center(
        child: AppText.smaller(
          item.logoAbbreviation,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText(context),
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Widget _buildMiniChart(BuildContext context) {
    final color = item.isNeutral
        ? AppColors.activityError
        : (item.isPositive ? AppColors.appPrimary : AppColors.activityError);

    // Use item code hashCode as seed for variance
    final seed = item.code.hashCode;

    // Simple mini chart representation
    return SizedBox(
      width: 60,
      height: 24,
      child: CustomPaint(
        painter: _MiniChartPainter(
          color: color,
          isPositive: item.isPositive && !item.isNeutral,
          seed: seed,
        ),
      ),
    );
  }

  Widget _buildChangeText(BuildContext context) {
    if (item.isNeutral) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_drop_down, size: 16, color: AppColors.activityError),
          AppText.smaller('0.0%', color: AppColors.activityError),
        ],
      );
    }

    final color = item.isPositive
        ? AppColors.appPrimary
        : AppColors.activityError;
    final arrow = item.isPositive ? '\u25B2' : '\u25BC';

    return AppText.smaller(
      '$arrow ${item.change.abs().toStringAsFixed(1)}%',
      color: color,
    );
  }
}

class _MiniChartPainter extends CustomPainter {
  final Color color;
  final bool isPositive;
  final int seed;

  _MiniChartPainter({
    required this.color,
    required this.isPositive,
    required this.seed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Generate variance based on seed
    final variance1 = ((seed % 30) + 10) / 100; // 0.10 to 0.40
    final variance2 = (((seed ~/ 10) % 25) + 15) / 100; // 0.15 to 0.40
    final variance3 = (((seed ~/ 100) % 35) + 5) / 100; // 0.05 to 0.40
    final variance4 = (((seed ~/ 1000) % 20) + 20) / 100; // 0.20 to 0.40

    if (isPositive) {
      // Uptrend pattern with variance
      path.moveTo(0, size.height * (0.6 + variance1));
      path.lineTo(size.width * 0.2, size.height * (0.4 + variance2));
      path.lineTo(size.width * 0.4, size.height * (0.5 + variance3));
      path.lineTo(size.width * 0.6, size.height * (0.25 + variance4));
      path.lineTo(size.width * 0.8, size.height * (0.35 + variance1));
      path.lineTo(size.width, size.height * (0.15 + variance3));
    } else {
      // Downtrend pattern with variance
      path.moveTo(0, size.height * (0.2 + variance1));
      path.lineTo(size.width * 0.2, size.height * (0.35 + variance2));
      path.lineTo(size.width * 0.4, size.height * (0.25 + variance3));
      path.lineTo(size.width * 0.6, size.height * (0.5 + variance4));
      path.lineTo(size.width * 0.8, size.height * (0.45 + variance1));
      path.lineTo(size.width, size.height * (0.6 + variance2));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MiniChartPainter oldDelegate) =>
      oldDelegate.seed != seed ||
      oldDelegate.color != color ||
      oldDelegate.isPositive != isPositive;
}
