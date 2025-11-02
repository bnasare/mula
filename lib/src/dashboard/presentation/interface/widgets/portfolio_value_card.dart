import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../domain/entities/portfolio_summary.dart';

/// Card displaying total portfolio value and daily change
class PortfolioValueCard extends StatelessWidget {
  final PortfolioSummary portfolioSummary;

  const PortfolioValueCard({
    super.key,
    required this.portfolioSummary,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: 'GHS ', decimalDigits: 2);
    final isPositive = portfolioSummary.isPositiveChange;

    return Center(
      child: Column(
        children: [
          // Label with eye icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.small(
                context.localize.totalPortfolioValue,
                color: AppColors.secondaryText(context),
              ),
              const SizedBox(width: 8),
              Icon(
                IconlyLight.show,
                size: 16,
                color: AppColors.secondaryText(context),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Total value
          AppText(
            currencyFormat.format(portfolioSummary.totalValue),
            style: TextStyle(
              fontSize: 38.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText(context),
            ),
          ),
          const SizedBox(height: 8),

          // Daily change
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.small(
                'Daily Change: ${currencyFormat.format(portfolioSummary.dailyChange.abs())}',
                color: AppColors.secondaryText(context),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppColors.appPrimary.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12,
                      color: isPositive ? AppColors.appPrimary : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    AppText.smallest(
                      '${portfolioSummary.dailyChangePercentage.abs().toStringAsFixed(2)}%',
                      color: isPositive ? AppColors.appPrimary : Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
