import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/utils/localization_extension.dart';

class LessonActionButtons extends StatelessWidget {
  final String assetName;
  final VoidCallback? onInvestPressed;
  final VoidCallback? onQuizPressed;

  const LessonActionButtons({
    super.key,
    required this.assetName,
    this.onInvestPressed,
    this.onQuizPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            onTap: onInvestPressed ?? () {},
            text: context.localize.investIn(assetName),
            backgroundColor: AppColors.appPrimary,
            textColor: AppColors.white(context),
            borderRadius: 8,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AppButton(
            onTap: onQuizPressed ?? () {},
            text: context.localize.takeAQuiz,
            backgroundColor: AppColors.transparent,
            textColor: AppColors.primaryText(context),
            borderColor: AppColors.border(context),
            borderRadius: 8,
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
