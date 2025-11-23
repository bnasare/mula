import 'package:flutter/material.dart';
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
    final bool shouldHighlightCorrect = showCorrectAnswer && isCorrect;
    final bool shouldShowAsSelected = isSelected || shouldHighlightCorrect;

    return GestureDetector(
      onTap: showCorrectAnswer ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: shouldShowAsSelected
              ? AppColors.appPrimary
              : AppColors.card(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: shouldShowAsSelected
                ? AppColors.appPrimary
                : AppColors.lightGrey(context),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText.smaller(
                '${option.label} ${option.text}',
                style: TextStyle(
                  color: shouldShowAsSelected
                      ? AppColors.white(context)
                      : AppColors.primaryText(context),
                ),
              ),
            ),
            if (shouldHighlightCorrect) ...[
              const SizedBox(width: 12),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Color(0xFFFFC107),
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  AppText.smallest(
                    context.localize.pts(option.isCorrect ? 5 : 0),
                    style: const TextStyle(
                      color: Color(0xFFFFC107),
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
