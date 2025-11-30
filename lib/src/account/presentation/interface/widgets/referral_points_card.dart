import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

class ReferralPointsCard extends StatelessWidget {
  const ReferralPointsCard({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.card(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border(context)),
        ),
        child: Column(
          children: [
            AppText.smallest(
              label,
              color: AppColors.secondaryText(context),
            ),
            const SizedBox(height: 8),
            AppText.large(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
