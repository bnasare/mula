import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../domain/entities/quiz_result.dart';

class QuizResultsDialog extends StatelessWidget {
  final QuizResult result;
  final String userName;
  final VoidCallback onTryAgain;
  final VoidCallback onExploreResources;

  const QuizResultsDialog({
    super.key,
    required this.result,
    required this.userName,
    required this.onTryAgain,
    required this.onExploreResources,
  });

  static Future<void> show(
    BuildContext context, {
    required QuizResult result,
    required String userName,
    required VoidCallback onTryAgain,
    required VoidCallback onExploreResources,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => QuizResultsDialog(
        result: result,
        userName: userName,
        onTryAgain: onTryAgain,
        onExploreResources: onExploreResources,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Star icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.yellow.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(IconlyBold.star, color: AppColors.yellow, size: 40),
            ),
            const SizedBox(height: 24),

            // Title
            AppText.large(
              context.localize.wellDone(userName),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Score text
            Builder(
              builder: (context) {
                final text = context.localize.quizScoreMessage(
                  result.correctAnswers,
                  result.totalQuestions,
                );
                // Extract the numbers to style them green
                final correctStr = '${result.correctAnswers}';
                final totalStr = '${result.totalQuestions}';
                final parts = text.split(correctStr);

                if (parts.length >= 2) {
                  final secondParts = parts[1].split(totalStr);

                  return Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.secondaryText(context),
                          ),
                          children: [
                            TextSpan(text: parts[0]),
                            TextSpan(
                              text: correctStr,
                              style: TextStyle(
                                color: AppColors.appPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (secondParts.isNotEmpty) ...[
                              TextSpan(text: secondParts[0]),
                              TextSpan(
                                text: totalStr,
                                style: TextStyle(
                                  color: AppColors.appPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (secondParts.length > 1)
                                TextSpan(text: secondParts[1]),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppText.smaller(
                        context.localize.keepPracticing,
                        style: TextStyle(
                          color: AppColors.secondaryText(context),
                        ),
                        align: TextAlign.center,
                      ),
                    ],
                  );
                }

                // Fallback if parsing fails
                return Column(
                  children: [
                    AppText.smaller(
                      text,
                      style: TextStyle(color: AppColors.secondaryText(context)),
                      align: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    AppText.smaller(
                      context.localize.keepPracticing,
                      style: TextStyle(color: AppColors.secondaryText(context)),
                      align: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),

            // Buttons row
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: context.localize.tryAgain,
                    backgroundColor: AppColors.appPrimary,
                    textColor: AppColors.white(context),
                    borderRadius: 8,
                    padding: EdgeInsets.zero,
                    height: 50,
                    onTap: () {
                      NavigationHelper.navigateBack(context);
                      onTryAgain();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: context.localize.goToHome,
                    backgroundColor: Colors.transparent,
                    textColor: AppColors.primaryText(context),
                    borderColor: AppColors.grey(context).withValues(alpha: 0.2),
                    borderRadius: 8,
                    padding: EdgeInsets.zero,
                    height: 50,
                    onTap: () {
                      // Navigate back to home
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Explore other resources link
            GestureDetector(
              onTap: () {
                NavigationHelper.navigateBack(context);
                onExploreResources();
              },
              child: AppText.smaller(
                context.localize.exploreOtherResources,
                style: TextStyle(
                  color: AppColors.appPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
