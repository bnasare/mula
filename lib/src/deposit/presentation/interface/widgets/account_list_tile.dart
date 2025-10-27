import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/utils/extension.dart';

/// A reusable list tile widget for displaying account information
/// with a trailing arrow for navigation
class AccountListTile extends StatelessWidget {
  /// The icon to display (e.g., network logo)
  final Widget icon;

  /// The account title (e.g., "MTN")
  final String title;

  /// The account number or description
  final String subtitle;

  /// Callback when the tile is tapped
  final VoidCallback onTap;

  const AccountListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

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
          border: Border.all(
            color: AppColors.border(context),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Icon/Logo
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.offWhite(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: icon),
            ),
            SizedBox(width: context.responsiveSpacing(mobile: 12.0)),
            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: context.responsiveFontSize(mobile: 16.0),
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: context.responsiveFontSize(mobile: 14.0),
                      color: AppColors.secondaryText(context),
                    ),
                  ),
                ],
              ),
            ),
            // Trailing arrow
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
