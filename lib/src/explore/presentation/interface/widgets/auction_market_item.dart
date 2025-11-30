import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../domain/entities/tbill_bond_data.dart';

class AuctionMarketListItem extends StatelessWidget {
  final AuctionMarketItem item;

  const AuctionMarketListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
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

          // Name and type
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.medium(
                  item.name,
                  style: TextStyle(color: AppColors.primaryText(context)),
                ),
                const SizedBox(height: 2),
                AppText.smallest(item.typeLabel, color: AppColors.appPrimary),
              ],
            ),
          ),

          // Bid button
          GestureDetector(
            onTap: () {
              // No action on tap
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.appPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppText.smaller(
                context.localize.bid,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white(context),
                ),
              ),
            ),
          ),
        ],
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
}
