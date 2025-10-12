import 'package:flutter/material.dart';
import 'package:mula/shared/utils/extension.dart';

class OrDivider extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final Color dividerColor;
  final double dividerThickness;
  final double dividerHeight;

  const OrDivider({
    super.key,
    this.text = 'OR',
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.dividerColor = Colors.grey,
    this.dividerThickness = 1.0,
    this.dividerHeight = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: context.responsiveFontSize(mobile: 14),
      fontWeight: FontWeight.normal,
    );

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: dividerThickness,
            height: dividerHeight,
          ),
        ),
        Padding(
          padding: context.responsivePadding(mobile: padding as EdgeInsets),
          child: Text(text, style: textStyle ?? defaultTextStyle),
        ),
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: dividerThickness,
            height: dividerHeight,
          ),
        ),
      ],
    );
  }
}
