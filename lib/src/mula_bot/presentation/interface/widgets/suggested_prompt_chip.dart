import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

/// Suggested prompt chip for quick actions
class SuggestedPromptChip extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SuggestedPromptChip({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border(context), width: 1),
        ),
        child: AppText.small(
          text,
          style: TextStyle(color: AppColors.primaryText(context), fontSize: 13),
        ),
      ),
    );
  }
}
