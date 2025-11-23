import 'package:flutter/material.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
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
                color: const Color(0xFFFFC107).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star, color: Color(0xFFFFC107), size: 40),
            ),
            const SizedBox(height: 24),

            // Title
            AppText.large(
              context.localize.wellDone(userName),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Score text
            AppText.smaller(
              context.localize.youAnsweredCorrectly(
                result.correctAnswers,
                result.totalQuestions,
              ),
              style: TextStyle(color: AppColors.secondaryText(context)),
              align: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Try Again button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  NavigationHelper.navigateBack(context);
                  onTryAgain();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimary,
                  foregroundColor: AppColors.white(context),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: AppText.smaller(
                  context.localize.tryAgain,
                  style: TextStyle(
                    color: AppColors.white(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Go to Home button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Navigate back to home
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
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
                  context.localize.goToHome,
                  style: TextStyle(
                    color: AppColors.primaryText(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
