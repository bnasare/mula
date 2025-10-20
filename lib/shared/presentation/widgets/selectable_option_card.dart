import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'constants/app_spacer.dart';
import 'constants/app_text.dart';

/// A reusable selectable option card component used across multiple screens
/// (ID Verification, Investment Experience, Link Accounts, etc.)
class SelectableOptionCard extends StatelessWidget {
  /// Unique identifier for this option
  final String value;

  /// Currently selected value
  final String? selectedValue;

  /// Title text to display
  final String title;

  /// Optional description text to display below the title
  final String? description;

  /// Callback when this option is tapped
  final VoidCallback onTap;

  const SelectableOptionCard({
    super.key,
    required this.value,
    required this.selectedValue,
    required this.title,
    this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedValue == value;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.appPrimary.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? AppColors.appPrimary
                : AppColors.grey(context).withValues(alpha: 0.15),
            width: isSelected ? 0.6 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: description != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.small(
                          title,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.appPrimary
                                : AppColors.defaultText(context),
                          ),
                        ),
                        const AppSpacer.vShorter(),
                        AppText.smallest(
                          description!,
                          color: AppColors.secondaryText(context),
                        ),
                      ],
                    )
                  : AppText.smaller(
                      title,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.appPrimary
                            : AppColors.defaultText(context),
                      ),
                    ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected
                  ? AppColors.appPrimary
                  : AppColors.grey(context).withValues(alpha: 0.25),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
