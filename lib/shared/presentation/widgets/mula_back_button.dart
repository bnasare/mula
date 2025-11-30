import 'package:flutter/material.dart';

import '../../utils/extension.dart';
import '../theme/app_colors.dart';

class MulaBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double iconSize;

  const MulaBackButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(
          context.responsivePadding(mobile: const EdgeInsets.all(8)).top,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: iconSize,
          color: iconColor ?? AppColors.black(context),
        ),
      ),
    );
  }
}
