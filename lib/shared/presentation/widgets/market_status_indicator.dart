import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../../utils/localization_extension.dart';
import '../../utils/market_status.dart';
import 'constants/app_text.dart';

class MarketStatusIndicator extends StatelessWidget {
  const MarketStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    if (MarketStatus.isStockMarketOpen()) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: AppColors.red.withValues(alpha: 0.1)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          AppText.smallest(
            context.localize.marketClosed,
            style: const TextStyle(
              color: AppColors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
