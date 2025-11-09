import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/utils/extension.dart';

/// Widget for displaying an individual linked account
class LinkedAccountItem extends StatelessWidget {
  /// The name of the account (e.g., "Ashfield Investment Managers Ltd", "MTN", "Ecobank")
  final String name;

  /// Optional subtitle (e.g., phone number for mobile money, account number for bank)
  final String? subtitle;

  /// The type of account (CIS, CSD, MobileMoney, Bank)
  final String accountType;

  /// Callback when the item is tapped
  final VoidCallback onTap;

  const LinkedAccountItem({
    super.key,
    required this.name,
    this.subtitle,
    required this.accountType,
    required this.onTap,
  });

  Widget _buildIcon(BuildContext context) {
    // Generate icon based on account type
    IconData iconData;
    Color iconColor;

    switch (accountType) {
      case 'CIS':
      case 'CSD':
        iconData = IconlyLight.work;
        iconColor = AppColors.appPrimary;
        break;
      case 'MobileMoney':
        iconData = Icons.phone_android;
        iconColor = AppColors.appPrimary;
        break;
      case 'Bank':
        iconData = Icons.account_balance;
        iconColor = AppColors.appPrimary;
        break;
      default:
        iconData = Icons.account_circle;
        iconColor = AppColors.secondaryText(context);
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.offWhite(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: iconColor, size: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(mobile: 16.0),
          vertical: context.responsiveValue(mobile: 16.0),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border(context), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Icon
            _buildIcon(context),
            SizedBox(width: context.responsiveSpacing(mobile: 12.0)),
            // Name and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: context.responsiveFontSize(mobile: 14.0),
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText(context),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(mobile: 12.0),
                        color: AppColors.secondaryText(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Trailing chevron
            Icon(
              Icons.chevron_right,
              color: AppColors.secondaryText(context),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
