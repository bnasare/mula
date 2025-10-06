import 'package:flutter/material.dart';

import '../../../shared/utils/extension.dart';

class RoundedLinearProgressIndicator extends StatelessWidget {
  final double value;
  final Color? backgroundColor;
  final Color? color;
  final double minHeight;
  final double borderRadius;

  const RoundedLinearProgressIndicator({
    super.key,
    required this.value,
    this.backgroundColor,
    this.color,
    this.minHeight = 6,
    this.borderRadius = 3,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: backgroundColor,
        color: color,
        minHeight: context.responsiveValue(mobile: minHeight),
      ),
    );
  }
}
