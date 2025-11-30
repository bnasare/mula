import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/snackbar.dart';
import '../../../../../shared/utils/localization_extension.dart';

class ReferralInfoBottomSheet extends StatelessWidget {
  const ReferralInfoBottomSheet({super.key, required this.referralCode});

  final String referralCode;

  static Future<void> show(BuildContext context, String referralCode) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReferralInfoBottomSheet(referralCode: referralCode),
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: referralCode));
    SnackBarHelper.showSuccessSnackBar(
      context,
      context.localize.copiedToClipboard,
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

          // Gift box placeholder
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Iconsax.gift, size: 50, color: AppColors.purple),
          ),

          const SizedBox(height: 24),

          // Title
          AppText.medium(
            context.localize.goodThingsShared,
            align: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText(context),
            ),
          ),

          const SizedBox(height: 24),

          // Feature 1: Invite your friends
          _FeatureRow(
            icon: Iconsax.link,
            iconColor: AppColors.appPrimary,
            title: context.localize.inviteYourFriends,
            subtitle: context.localize.shareReferralCodeOrLink,
          ),

          const SizedBox(height: 16),

          // Feature 2: Earn rewards together
          _FeatureRow(
            icon: Iconsax.medal_star,
            iconColor: AppColors.warning,
            title: context.localize.earnRewardsTogether,
            subtitle: context.localize.whenFriendSignsUp,
          ),

          const SizedBox(height: 24),

          // Share your link section
          AppText.smaller(
            context.localize.shareYourLink,
            color: AppColors.secondaryText(context),
          ),

          const SizedBox(height: 12),

          // Referral code card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.lightGrey(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border(context)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppText.small(
                    referralCode,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText(context),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _copyToClipboard(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.card(context),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border(context)),
                    ),
                    child: Icon(
                      Iconsax.copy,
                      size: 18,
                      color: AppColors.primaryText(context),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.smaller(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
              ),
              const SizedBox(height: 4),
              AppText.smallest(
                subtitle,
                color: AppColors.secondaryText(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
