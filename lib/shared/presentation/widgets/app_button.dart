import 'package:flutter/material.dart';

import '../../../shared/utils/extension.dart';
import 'constants/app_text.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Widget? child;
  final double? internalPadding;

  const AppButton({
    super.key,
    this.onTap,
    this.text,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.6,
    this.padding,
    this.height,
    this.width,
    this.borderRadius,
    this.child,
    this.internalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ??
          EdgeInsets.only(
            left: context.responsiveValue(mobile: 16.0),
            right: context.responsiveValue(mobile: 16.0),
            top: context.responsiveValue(mobile: 16.0),
          ),
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 30),
              side:
                  borderColor != null
                      ? BorderSide(color: borderColor!, width: borderWidth!)
                      : BorderSide.none,
            ),
          ),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: context.responsiveValue(
                mobile: internalPadding ?? 0.0,
              ),
            ),
          ),
        ),
        child:
            child ??
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: AppText.smaller(
                text ?? 'Continue',
                style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
              ),
            ),
      ),
    );
  }
}
