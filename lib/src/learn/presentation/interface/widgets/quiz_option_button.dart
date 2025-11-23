import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../domain/entities/quiz_option.dart';

class QuizOptionButton extends StatelessWidget {
  final QuizOption option;
  final bool isSelected;
  final bool showCorrectAnswer;
  final VoidCallback onTap;

  const QuizOptionButton({
    super.key,
    required this.option,
    required this.isSelected,
    this.showCorrectAnswer = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCorrect = option.isCorrect;
    final bool isWrongAnswer = showCorrectAnswer && isSelected && !isCorrect;
    final bool shouldHighlightCorrect = showCorrectAnswer && isCorrect;
    final bool shouldShowAsSelected = isSelected || shouldHighlightCorrect;

    // Determine colors based on correct/incorrect state
    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (isWrongAnswer) {
      // Wrong answer selected - show in red
      backgroundColor = AppColors.error;
      borderColor = AppColors.error;
      textColor = AppColors.white(context);
    } else if (shouldShowAsSelected) {
      // Correct answer (selected or not) - show in app primary green
      backgroundColor = AppColors.appPrimary;
      borderColor = AppColors.appPrimary;
      textColor = AppColors.white(context);
    } else {
      // Default unselected state
      backgroundColor = AppColors.card(context);
      borderColor = AppColors.lightGrey(context);
      textColor = AppColors.primaryText(context);
    }

    return GestureDetector(
      onTap: showCorrectAnswer ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText.smaller(
                '${option.label} ${option.text}',
                style: TextStyle(color: textColor),
              ),
            ),
            if (shouldHighlightCorrect) ...[
              const SizedBox(width: 12),
              Row(
                children: [
                  Icon(
                    IconlyBold.star,
                    color: AppColors.yellow,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  AppText.smallest(
                    context.localize.pts(option.isCorrect ? 5 : 0),
                    style: TextStyle(
                      color: AppColors.yellow,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
