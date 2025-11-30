import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';

/// Bottom sheet showing account details before removal
class AccountDetailsBottomSheet extends StatelessWidget {
  const AccountDetailsBottomSheet({
    super.key,
    required this.accountType,
    required this.account,
    required this.onRemoveAccount,
  });

  final String accountType;
  final Map<String, String> account;
  final VoidCallback onRemoveAccount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.medium(
                _getTitle(context),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: context.primaryTextColor,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.cancel,
                  size: 22,
                  color: context.secondaryTextColor,
                ),
              ),
            ],
          ),
          AppSpacer.vLarge(),

          // Account Details
          _buildContent(context),

          AppSpacer.vLarge(),

          // Remove Account Button
          AppButton(
            text: context.localize.unlinkAccount,
            backgroundColor: AppColors.error,
            textColor: Colors.white,
            borderRadius: 8,
            padding: EdgeInsets.zero,
            onTap: () {
              Navigator.pop(context);
              onRemoveAccount();
            },
          ),
          AppSpacer.vShort(),
        ],
      ),
    );
  }

  String _getTitle(BuildContext context) {
    switch (accountType) {
      case 'CIS':
        return 'CIS Account';
      case 'CSD':
        return 'Broker';
      case 'MobileMoney':
        return 'Mobile Money Account';
      case 'Bank':
        return 'Bank Account';
      default:
        return 'Account';
    }
  }

  Widget _buildContent(BuildContext context) {
    switch (accountType) {
      case 'CIS':
        return _buildCISContent(context);
      case 'CSD':
        return _buildCSDContent(context);
      case 'MobileMoney':
        return _buildMobileMoneyContent(context);
      case 'Bank':
        return _buildBankContent(context);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCISContent(BuildContext context) {
    final name = account['name'] ?? '';
    // Extract first word for logo placeholder
    final logoText = name.split(' ').first.toUpperCase();

    return Column(
      children: [
        // Logo placeholder
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.offWhite(context),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: AppText.smaller(
              logoText.length > 6 ? logoText.substring(0, 6) : logoText,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: context.primaryTextColor,
                fontSize: 10,
              ),
            ),
          ),
        ),
        AppSpacer.vShort(),

        // Name
        AppText.smaller(
          name,
          align: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: context.primaryTextColor,
          ),
        ),
        const SizedBox(height: 4),

        // Website (dummy)
        AppText.smallest(
          '${account['id'] ?? 'company'}invest.com',
          style: const TextStyle(color: AppColors.appPrimary),
        ),
        const SizedBox(height: 4),

        // Address (dummy)
        AppText.smallest(
          'P.O Box CS 8876',
          style: TextStyle(color: context.secondaryTextColor),
        ),

        AppSpacer.vLarge(),

        // Funds section
        Align(
          alignment: Alignment.centerLeft,
          child: AppText.smaller(
            'Funds managed by $name',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: context.primaryTextColor,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: AppText.smallest(
            'Select',
            style: TextStyle(color: context.secondaryTextColor),
          ),
        ),
        AppSpacer.vShort(),

        // Fund item (dummy)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.appPrimary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.appPrimary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppText.smaller(
                  'Gold Money Market Fund Plc',
                  style: TextStyle(color: context.primaryTextColor),
                ),
              ),
              const Icon(
                Icons.check_circle,
                color: AppColors.appPrimary,
                size: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCSDContent(BuildContext context) {
    final name = account['name'] ?? '';
    final logoText = name.split(' ').first.toUpperCase();

    return Center(
      child: Column(
        children: [
          // Logo placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.offWhite(context),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: AppText.smaller(
                logoText.length > 6 ? logoText.substring(0, 6) : logoText,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: context.primaryTextColor,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          AppSpacer.vShort(),

          // Name
          AppText.smaller(
            name.contains(' ') ? name.split(' ').take(2).join(' ') : name,
            align: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: context.primaryTextColor,
            ),
          ),
          const SizedBox(height: 4),

          // Website (dummy)
          AppText.smallest(
            '${account['id'] ?? 'broker'}.com',
            style: const TextStyle(color: AppColors.appPrimary),
          ),
          const SizedBox(height: 4),

          // Address (dummy)
          AppText.smallest(
            'P.O Box CS 8876',
            style: TextStyle(color: context.secondaryTextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileMoneyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.smaller(
          account['network'] ?? '',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: context.primaryTextColor,
          ),
        ),
        const SizedBox(height: 4),
        AppText.smaller(
          account['number'] ?? '',
          style: TextStyle(color: context.secondaryTextColor),
        ),
      ],
    );
  }

  Widget _buildBankContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.offWhite(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Bank logo placeholder
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white(context),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border(context)),
            ),
            child: Center(
              child: AppText.smallest(
                account['bank']?.substring(0, 3).toUpperCase() ?? 'BNK',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: context.primaryTextColor,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.smaller(
                  account['bank'] ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                AppText.smallest(
                  account['accountNumber'] ?? '',
                  style: TextStyle(color: context.secondaryTextColor),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: context.secondaryTextColor,
          ),
        ],
      ),
    );
  }
}
