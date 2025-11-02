import 'package:flutter/material.dart';
import 'package:mula/shared/presentation/widgets/constants/app_spacer.dart';

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
        AppSpacer.vShort(),
        LearningCornerCard(
          title: context.localize.learningCorner,
          description: context.localize.learnHowBondsWork,
          onLearnMore: () {
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
