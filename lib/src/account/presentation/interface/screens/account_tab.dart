import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';

/// Account tab - placeholder for future implementation
class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconlyBold.profile,
              size: 60,
              color: AppColors.appPrimary.withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            AppText.large(
              context.localize.account,
              color: AppColors.primaryText(context),
            ),
            const SizedBox(height: 12),
            AppText.small(
              'Coming Soon',
              color: AppColors.secondaryText(context),
            ),
          ],
        ),
      ),
    );
  }
}
