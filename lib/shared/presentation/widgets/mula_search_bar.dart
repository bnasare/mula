import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../utils/extension.dart';
import '../theme/app_colors.dart';

/// Reusable search bar widget for MULA app
///
/// A customizable search bar with consistent styling across the app.
/// Features:
/// - Responsive sizing
/// - Search icon on the left
/// - Optional trailing widget (e.g., filter button)
/// - Customizable hint text
/// - Text input callbacks
class MulaSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Widget? trailing;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool readOnly;

  const MulaSearchBar({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.trailing,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      elevation: const WidgetStatePropertyAll(0),
      constraints: BoxConstraints(
        minHeight: context.responsiveValue(mobile: 45.0),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.lightGrey(context)),
        ),
      ),
      backgroundColor: WidgetStatePropertyAll(AppColors.card(context)),
      hintText: hintText,
      hintStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: context.responsiveFontSize(mobile: 14),
          color: AppColors.secondaryText(context),
        ),
      ),
      leading: Icon(
        IconlyLight.search,
        color: AppColors.secondaryText(context),
        size: 20,
      ),
      trailing: trailing != null ? [trailing!] : null,
      controller: controller,
      onChanged: onChanged,
      focusNode: focusNode,
      onTap: onTap,
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
