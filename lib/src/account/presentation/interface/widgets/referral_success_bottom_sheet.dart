import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';

class ReferralSuccessBottomSheet extends StatelessWidget {
  const ReferralSuccessBottomSheet({
    super.key,
    required this.pointsEarned,
  });

  final int pointsEarned;

  static Future<void> show(BuildContext context, int pointsEarned) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          ReferralSuccessBottomSheet(pointsEarned: pointsEarned),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.hintText(context).withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Close button row
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey(context),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: AppColors.secondaryText(context),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Coins placeholder
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Iconsax.dollar_circle,
              size: 60,
              color: AppColors.warning,
            ),
          ),

          const SizedBox(height: 24),

          // Congratulations title
          AppText.large(
            context.localize.congratulations,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText(context),
            ),
          ),

          const SizedBox(height: 8),

          // Points earned message
          AppText.medium(
            context.localize.youEarnedPoints(pointsEarned),
            align: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.primaryText(context),
            ),
          ),

          const SizedBox(height: 12),

          // Friend joined message
          AppText.smaller(
            context.localize.friendJoinedMessage,
            align: TextAlign.center,
            color: AppColors.secondaryText(context),
          ),

          const SizedBox(height: 24),

          // Done button
          AppButton(
            text: context.localize.done,
            onTap: () => Navigator.pop(context),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
