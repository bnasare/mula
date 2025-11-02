import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';

/// Learn tab - placeholder for future implementation
class LearnTab extends StatelessWidget {
  const LearnTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconlyBold.document,
              size: 60,
              color: AppColors.appPrimary.withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            AppText.large(
              context.localize.learn,
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
