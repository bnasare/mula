import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../dashboard/domain/entities/asset.dart';

/// Card displaying a single asset holding with details
class AssetHoldingCard extends StatelessWidget {
  final String companyName;
  final String brokerName;
  final double value;
  final double changePercentage;
  final int shares;
  final AssetType assetType;
  final VoidCallback? onTap;
  final String? logoUrl;

  const AssetHoldingCard({
    super.key,
    required this.companyName,
    required this.brokerName,
    required this.value,
    required this.changePercentage,
    required this.shares,
    required this.assetType,
    this.onTap,
    this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: 'GHS ',
      decimalDigits: 0,
    );
    final isPositive = changePercentage >= 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.white(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border(context), width: 0.5),
        ),
        child: Row(
          children: [
            // Logo placeholder
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.offWhite(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: logoUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        logoUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            IconlyLight.work,
                            size: 20,
                            color: AppColors.secondaryText(context),
                          );
                        },
                      ),
                    )
                  : Icon(
                      IconlyLight.work,
                      size: 20,
                      color: AppColors.secondaryText(context),
                    ),
            ),
            const SizedBox(width: 12),

            // Company name and broker
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.small(
                    companyName,
                    color: AppColors.primaryText(context),
                  ),
                  const SizedBox(height: 4),
                  AppText.smallest(
                    brokerName,
                    color: AppColors.secondaryText(context),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Value, change, and shares
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Value
                AppText.medium(
                  currencyFormat.format(value),
                  color: AppColors.primaryText(context),
                ),
                const SizedBox(height: 4),

                // Change percentage and shares in same row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12,
                      color: isPositive ? AppColors.appPrimary : AppColors.activityError,
                    ),
                    const SizedBox(width: 2),
                    AppText.smallest(
                      '${changePercentage.abs().toStringAsFixed(2)}%',
                      color: isPositive ? AppColors.appPrimary : AppColors.activityError,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryText(context),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    AppText.smallest(
                      '$shares Shares',
                      color: AppColors.secondaryText(context),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
