import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';

class ComingSoonContent extends StatelessWidget {
  const ComingSoonContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconlyBold.discovery,
            size: 60,
            color: AppColors.appPrimary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 24),
          AppText.medium(
            context.localize.comingSoon,
            color: AppColors.secondaryText(context),
          ),
        ],
      ),
    );
  }
}
