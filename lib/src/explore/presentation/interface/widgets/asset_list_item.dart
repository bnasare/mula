import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../domain/entities/asset_data.dart';

/// Widget to display a single asset item in the explore list
class AssetListItem extends StatelessWidget {
  final AssetData asset;
  final VoidCallback onTap;

  const AssetListItem({super.key, required this.asset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: 'GHS ',
      decimalDigits: 2,
    );

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

            // Asset info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.medium(
                    asset.ticker,
                    style: TextStyle(color: AppColors.primaryText(context)),
                  ),
                  AppText.smallest(
                    asset.companyName,
                    size: 10,
                    color: AppColors.secondaryText(context),
                  ),
                  const SizedBox(height: 2),
                  AppText.smallest(
                    asset.assetTypeLabel,
                    color: AppColors.appPrimary,
                  ),
                ],
              ),
            ),

            // Price and change
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppText.medium(
                  currencyFormat.format(asset.currentPrice),
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
          asset.logoAbbreviation,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText(context),
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Widget _buildChangeText(BuildContext context) {
    if (asset.isNeutral) {
      return AppText.smaller(
        '0.00 ( ---- )',
        color: AppColors.secondaryText(context),
      );
    }

    final changeColor = asset.isPositive
        ? AppColors.appPrimary
        : AppColors.activityError;
    final sign = asset.isPositive ? '+' : '';
    final arrow = asset.isPositive ? '\u25B2' : '\u25BC';

    return AppText.smaller(
      '$sign${asset.change.toStringAsFixed(2)} ( $arrow${asset.changePercentage.abs().toStringAsFixed(1)}% )',
      color: changeColor,
    );
  }
}
