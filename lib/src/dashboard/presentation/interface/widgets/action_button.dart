import 'package:flutter/material.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

/// Action button for dashboard actions (Deposit, Withdraw, Trade, etc.)
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon container
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.card(context),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.border(context),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryText(context).withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 18,
              color: iconColor ?? AppColors.primaryText(context),
            ),
          ),
          const SizedBox(height: 8),

          // Label
          AppText.smallest(
            label,
            color: AppColors.primaryText(context),
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
