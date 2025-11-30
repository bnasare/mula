import 'package:mula/shared/utils/extension.dart';
import 'package:mula/shared/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A reusable custom text field component for the TastyPad app that
/// maintains consistent height even with suffix icons.
class TastyPadTextField extends StatelessWidget {
  /// The controller for the text field.
  final TextEditingController? controller;

  /// The text that suggests what the user should type.
  final String? hintText;

  /// Whether to hide the text being edited.
  final bool obscureText;

  /// The icon to show at the end of the text field.
  final Widget? suffixIcon;

  /// The type of information being edited.
  final TextInputType keyboardType;

  /// The action to perform on the keyboard press.
  final TextInputAction textInputAction;

  /// The capitalization style for the text.
  final TextCapitalization textCapitalization;

  /// Function used to validate input.
  final String? Function(String?)? validator;

  /// How the text field should be validated automatically.
  final AutovalidateMode autovalidateMode;

  /// The text style for the input text.
  final TextStyle? style;

  /// The border radius for the text field.
  final double borderRadius;

  /// Called when the user submits the text field.
  final VoidCallback? onSubmitted;

  /// Called when the text field content changes.
  final Function(String)? onChanged;

  /// Whether the text field is enabled.
  final bool readOnly;

  /// The label text displayed above the field.
  final String? labelText;

  /// Whether to fill the background of the text field.
  final bool filled;

  /// The background color of the text field.
  final Color? fillColor;

  /// The maximum number of lines for the text field.
  final int? maxLines;

  /// The minimum number of lines for the text field.
  final int? minLines;

  /// The fixed height for the input field (excluding any error messages).
  final double inputHeight;

  /// Whether to show the title as a row with character count
  final bool showTitleWithCounter;

  /// Maximum length of input text
  final int? maxLength;

  /// List of text input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Callback when the text field is tapped.
  final VoidCallback? onTap;

  const TastyPadTextField({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.style,
    this.borderRadius = 8.0,
    this.onSubmitted,
    this.onChanged,
    this.readOnly = false,
    this.labelText,
    this.filled = true,
    this.fillColor,
    this.maxLines = 1,
    this.minLines,
    this.inputHeight = 40.0,
    this.showTitleWithCounter = false,
    this.maxLength,
    this.inputFormatters,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          if (showTitleWithCounter && controller != null)
            Row(
              children: [
                Text(
                  labelText!,
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(mobile: 14),
                    color: AppColors.secondaryText(context),
                  ),
                ),
                const Spacer(),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller!,
                  builder: (context, value, child) {
                    return Text(
                      "${value.text.length}/${maxLength ?? 40}",
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(mobile: 14),
                        color: AppColors.secondaryText(context),
                      ),
                    );
                  },
                ),
              ],
            )
          else
            Text(
              labelText!,
              style: TextStyle(
                color: AppColors.secondaryText(context),
                fontSize: context.responsiveFontSize(mobile: 14),
              ),
            ),
          SizedBox(height: context.responsiveSpacing(mobile: 8)),
        ],
        Stack(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: context.responsiveValue(mobile: inputHeight),
              ),
              child: TextFormField(
                autofocus: false,
                onTap: onTap,
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                textCapitalization: textCapitalization,
                validator: validator,
                autovalidateMode: autovalidateMode,
                style:
                    style ??
                    TextStyle(
                      color: AppColors.black(context),
                      fontSize: context.responsiveFontSize(mobile: 14),
                    ),
                readOnly: readOnly,
                onChanged: onChanged,
                maxLines: obscureText ? 1 : maxLines,
                minLines: minLines,
                maxLength: maxLength,
                inputFormatters:
                    inputFormatters ??
                    [
                      if (maxLength != null)
                        LengthLimitingTextInputFormatter(maxLength),
                    ],
                // Hide the built-in counter when we show our custom one
                buildCounter: showTitleWithCounter
                    ? (
                        BuildContext context, {
                        required int currentLength,
                        required bool isFocused,
                        required int? maxLength,
                      }) => null
                    : null,
                onFieldSubmitted: (_) => onSubmitted?.call(),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: AppColors.hintText(context),
                    fontSize: context.responsiveFontSize(mobile: 13),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: AppColors.border(context)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: AppColors.border(context)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: AppColors.hintText(context)),
                  ),
                  filled: filled,
                  fillColor: fillColor,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.responsiveSpacing(mobile: 16),
                    vertical:
                        (inputHeight - 20) /
                        2, // Adjust vertical padding to maintain height
                  ),
                  // When using the custom suffix icon placement, we don't want the built-in one
                  suffixIcon: suffixIcon != null
                      ? const SizedBox(width: 40)
                      : null,
                ),
              ),
            ),
            // Custom suffix icon positioning
            if (suffixIcon != null)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: SizedBox(
                    width: 40,
                    height: inputHeight,
                    child: Center(child: suffixIcon),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
