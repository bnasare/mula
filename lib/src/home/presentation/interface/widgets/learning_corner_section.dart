import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/snackbar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../dashboard/presentation/interface/widgets/learning_corner_card.dart';

/// Learning corner section with educational content
class LearningCornerSection extends StatelessWidget {
  const LearningCornerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium(
          context.localize.learningCorner,
          color: AppColors.primaryText(context),
        ),
        const SizedBox(height: 12),
        LearningCornerCard(
          title: context.localize.learningCorner,
          description: context.localize.learnHowBondsWork,
          onLearnMore: () {
            // TODO: Navigate to learning content
            SnackBarHelper.showInfoSnackBar(
              context,
              context.localize.comingSoon,
            );
          },
        ),
      ],
    );
  }
}
