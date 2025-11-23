import 'package:flutter/material.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
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
          flex: 2,
          child: ElevatedButton(
            onPressed: onInvestPressed ?? () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: AppText.smaller(
              context.localize.investIn(assetName),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: onQuizPressed ?? () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryText(context),
              side: BorderSide(color: AppColors.lightGrey(context)),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: AppText.smaller(
              context.localize.takeAQuiz,
              style: TextStyle(
                color: AppColors.primaryText(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
