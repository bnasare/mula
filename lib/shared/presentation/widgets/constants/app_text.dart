import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'app_sizes.dart';

enum _TextType {
  smallest,
  smaller,
  small,
  normal,
  medium,
  large,
  larger,
  xlarge,
  largest,
  rich,
}

class AppText extends StatelessWidget {
  /// Has [fontSize] of [AppSizes.body] = 18
  const AppText(
    this.text, {
    super.key,
    this.size,
    this.style,
    this.align,
    this.color,
    this.maxLines,
    this.children,
    this.softWrap = true,
    this.clipped = false,
    this.padding = EdgeInsets.zero,
  }) : _type = _TextType.normal,
       assert(
         color == null || style == null,
         'Cannot provide both a color and a style\n'
         'To provide both, use "style: TextStyle(color: color)".',
       );

  /// Has [fontSize] of [AppSizes.bodySmallest] = 12
  const AppText.smallest(
    this.text, {
    super.key,
    this.size,
    this.style,
    this.align,
    this.color,
    this.maxLines,
    this.children,
    this.softWrap = true,
    this.clipped = false,
    this.padding = EdgeInsets.zero,
  }) : _type = _TextType.smallest,
       assert(
         color == null || style == null,
         'Cannot provide both a color and a style\n'
         'To provide both, use "style: TextStyle(color: color)".',
       );

  /// Has [fontSize] of [AppSizes.bodySmaller] = 14
  const AppText.smaller(
    this.text, {
    super.key,
    this.size,
    this.style,
    this.align,
    this.color,
    this.maxLines,
    this.children,
    this.softWrap = true,
    this.clipped = false,
    this.padding = EdgeInsets.zero,
  }) : _type = _TextType.smaller,
       assert(
         color == null || style == null,
         'Cannot provide both a color and a style\n'
         'To provide both, use "style: TextStyle(color: color)".',
       );

  /// Has [fontSize] of [AppSizes.bodySmall] = 16
  const AppText.small(
    this.text, {
    super.key,
    this.size,
    this.style,
    this.align,
    this.color,
    this.maxLines,
    this.children,
    this.softWrap = true,
    this.clipped = false,
    this.padding = EdgeInsets.zero,
  }) : _type = _TextType.small,
       assert(
         color == null || style == null,
         'Cannot provide both a color and a style\n'
         'To provide both, use "style: TextStyle(color: color)".',
       );

  /// Has [fontSize] of [AppSizes.body] = 18
  const AppText.medium(
    this.text, {
    super.key,
    this.size,
    this.style,
    this.align,
    this.color,
    this.maxLines,
    this.children,
    this.softWrap = true,
    this.clipped = false,
    this.padding = EdgeInsets.zero,
  }) : _type = _TextType.medium,
       assert(
         color == null || style == null,
         'Cannot provide both a color and a style\n'
         'To provide both, use "style: TextStyle(color: color)".',
       );

  /// Has [fontSize] of [AppSizes.heading5] = 24
  const AppText.large(
    this.text, {
    super.key,
    this.size,
    this.style,
    this.align,
    this.color,
    this.maxLines,
    this.children,
    this.softWrap = true,
    this.clipped = false,
    this.padding = EdgeInsets.zero,
  }) : _type = _TextType.large,
       assert(
         color == null || style == null,
         'Cannot provide both a color and a style\n'
         'To provide both, use "style: TextStyle(color: color)".',
       );

  /// Has [fontSize] of [AppSizes.heading3] = 38
  const AppText.larger(
    this.text, {
    super.key,
    this.size,
    this.style,
    this.align,
    this.color,
    this.maxLines,
    this.children,
    this.softWrap = true,
    this.clipped = false,
    this.padding = EdgeInsets.zero,
  }) : _type = _TextType.larger,
       assert(
         color == null || style == null,
         'Cannot provide both a color and a style\n'
         'To provide both, use "style: TextStyle(color: color)".',
       );

  /// Has [fontSize] of [AppSizes.heading2] = 42
  const AppText.extraLarge(
    this.text, {
    super.key,
    this.size,
    this.style,
    this.align,
    this.color,
    this.maxLines,
    this.children,
    this.softWrap = true,
    this.clipped = false,
    this.padding = EdgeInsets.zero,
  }) : _type = _TextType.xlarge,
       assert(
         color == null || style == null,
         'Cannot provide both a color and a style\n'
         'To provide both, use "style: TextStyle(color: color)".',
       );

  /// Has [fontSize] of [AppSizes.heading1] = 60
  const AppText.huge(
    this.text, {
    super.key,
    this.size,
    this.style,
    this.align,
    this.color,
    this.maxLines,
    this.children,
    this.softWrap = true,
    this.clipped = false,
    this.padding = EdgeInsets.zero,
  }) : _type = _TextType.largest,
       assert(
         color == null || style == null,
         'Cannot provide both a color and a style\n'
         'To provide both, use "style: TextStyle(color: color)".',
       );

  const AppText.rich({
    super.key,
    this.size,
    this.style,
    this.align,
    this.color,
    this.maxLines,
    this.children,
    this.softWrap = true,
    this.clipped = false,
    this.padding = EdgeInsets.zero,
  }) : text = "",
       _type = _TextType.rich,
       assert(
         color == null || style == null,
         'Cannot provide both a color and a style\n'
         'To provide both, use "style: TextStyle(color: color)".',
       );

  final String text;
  final double? size;
  final bool clipped;
  final Color? color;
  final bool softWrap;
  final int? maxLines;
  final _TextType _type;
  final TextStyle? style;
  final TextAlign? align;
  final EdgeInsets padding;
  final List<InlineSpan>? children;

  @override
  Widget build(BuildContext context) {
    final defaultColor = color ?? AppColors.primaryText(context);
    TextStyle textStyle = TextStyle(
      color: defaultColor,
      fontFamily: 'Raleway',
    );

    switch (_type) {
      case _TextType.smallest:
        textStyle = textStyle.copyWith(
          fontSize: AppSizes.bodySmallest,
          fontWeight: FontWeight.w400,
          color: defaultColor,
        );
        break;
      case _TextType.smaller:
        textStyle = textStyle.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.bodySmaller,
          color: defaultColor,
        );
        break;
      case _TextType.small:
        textStyle = textStyle.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.bodySmall,
          color: defaultColor,
        );
        break;
      case _TextType.medium:
        textStyle = textStyle.copyWith(
          fontSize: AppSizes.body,
          fontWeight: FontWeight.w500,
          color: defaultColor,
        );
        break;
      case _TextType.large:
        textStyle = textStyle.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: AppSizes.heading5,
          color: defaultColor,
        );
        break;
      case _TextType.larger:
        textStyle = textStyle.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: AppSizes.heading3,
          color: defaultColor,
        );
        break;
      case _TextType.xlarge:
        textStyle = textStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: AppSizes.heading2,
          color: defaultColor,
        );
        break;
      case _TextType.largest:
        textStyle = textStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: AppSizes.heading1,
          color: defaultColor,
        );
        break;
      default:
        textStyle = textStyle.copyWith(
          fontSize: AppSizes.bodySmall,
          color: defaultColor,
        );
        break;
    }

    if (_type == _TextType.rich) {}

    return Padding(
      padding: padding,
      child: switch (_type) {
        _TextType.rich => Text.rich(
          softWrap: softWrap,
          TextSpan(
            children: children,
            style: textStyle
                .copyWith(fontSize: size, color: defaultColor)
                .merge(style),
          ),
          textAlign: align,
          maxLines: maxLines,
          overflow: clipped ? TextOverflow.ellipsis : null,
          style: textStyle
              .copyWith(fontSize: size, color: defaultColor)
              .merge(style),
        ),
        _ => Text(
          text,
          textAlign: align,
          softWrap: softWrap,
          maxLines: maxLines,
          overflow: clipped ? TextOverflow.ellipsis : null,
          style: textStyle
              .copyWith(fontSize: size, color: defaultColor)
              .merge(style),
        ),
      },
    );
  }
}
