import 'package:flutter/material.dart';
import 'package:mula/shared/presentation/theme/app_colors.dart';
import 'package:mula/shared/utils/extension.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconAsset;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double height;
  final double iconSize;
  final double borderRadius;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconAsset,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.height = 12.0,
    this.iconSize = 18.0,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(
        iconAsset,
        height: context.responsiveValue(mobile: iconSize),
        width: context.responsiveValue(mobile: iconSize),
      ),
      label: Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColors.black(context),
          fontSize: context.responsiveFontSize(mobile: 14),
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveValue(mobile: height),
        ),
        backgroundColor: backgroundColor ?? AppColors.white(context),
        side: BorderSide(color: borderColor ?? AppColors.grey(context).withValues(alpha: 0.12)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
