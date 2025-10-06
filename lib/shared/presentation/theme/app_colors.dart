import 'package:flutter/material.dart';

/// Comprehensive app colors with theme-aware and static colors
class AppColors {
  // ==================== THEME-AWARE COLORS ====================

  /// White in light mode, black in dark mode
  static Color white(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xDD000000) : const Color(0xFFFFFFFF);
  }

  /// Black in light mode, white in dark mode
  static Color black(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFFFFFFF) : const Color(0xDD000000);
  }

  // Surface & Background
  static Color surface(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  static Color background(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF4F4F4);
  }

  static Color onSurface(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  static Color onBackground(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  // Primary & Secondary
  static Color primary(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color onPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary;
  }

  static Color secondary(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color onSecondary(BuildContext context) {
    return Theme.of(context).colorScheme.onSecondary;
  }

  // Greys
  static Color grey(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF8E8E93) : const Color(0xFF808080);
  }

  static Color lightGrey(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF2C2C2E) : const Color(0xFFEEEEEE);
  }

  static Color darkGrey(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF636366) : const Color(0xFF4D4D4D);
  }

  static Color newGrey(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF4F4F4);
  }

  static Color offWhite(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFAFAFA);
  }

  // Cards and containers
  static Color card(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFAFAFA);
  }

  static Color container(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F2);
  }

  static Color main(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFFFFFF);
  }

  // Text colors
  static Color primaryText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFFFFFFF) : const Color(0xDD000000);
  }

  static Color secondaryText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF8E8E93) : const Color(0xFF757575);
  }

  static Color defaultText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF636366) : const Color(0xFF666666);
  }

  static Color faintText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF48484A) : const Color(0xFF808080);
  }

  static Color hintText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF8E8E93) : const Color(0xFFBDBDBD);
  }

  // Border colors
  static Color border(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF38383A) : const Color(0xFFE0E0E0);
  }

  static Color hardBorder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF4F4F4);
  }

  static Color softBorder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFAFAFA);
  }

  static Color divider(BuildContext context) {
    return Theme.of(context).dividerColor;
  }

  // ==================== STATIC BRAND COLORS ====================

  // App Primary
  static const Color appPrimary = Color(0xFF0E9D20);

  // Status colors
  static const Color success = Color(0xFF56875A);
  static const Color successLight = Color(0xFF8CDE9C);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Blues
  static const Color blue = Color(0xFF0D47A1);
  static const Color link = Color(0xFF4994EC);
  static const Color linkLight = Color(0XFFC2DDF8);
  static const Color darkBlue = Color(0xFF2E3E5C);
  static const Color skyBlue = Color(0xFF87CEEB);
  static const Color navyBlue = Color(0xFF175CD3);

  // Greens
  static const Color emerald = Color(0xFF50C878);
  static const Color green = Color(0xFF2DC76D);
  static const Color darkGreen = Color(0xFF1B6E42);
  static const Color olive = Color(0xFF808000);

  // Yellows & Golds
  static const Color yellow = Color(0xFFFFC107);
  static const Color goldenrod = Color(0xFFDAA520);
  static const Color amber = Color(0xFFFDB11D);

  // Oranges
  static const Color orange = Color(0xFFFC6011);
  static const Color lightOrange = Color(0xFFFF9933);
  static const Color midOrange = Color(0xFFF28627);
  static const Color peach = Color(0xFFFFE5B4);

  // Reds
  static const Color red = Color(0xFFFF3B30);
  static const Color crimson = Color(0xFFB42318);
  static const Color burgundy = Color(0xFF800020);

  // Purples
  static const Color lavender = Color(0xFFE6E6FA);
  static const Color plum = Color(0xFF8E4585);

  // Browns
  static const Color sienna = Color(0xFF882D17);
  static const Color tan = Color(0xFFD2B48C);

  // Others
  static const Color teal = Color(0xFF008080);
  static const Color turquoise = Color(0xFF40E0D0);
  static const Color transparent = Colors.transparent;
}

/// Extension to make color access easier via context
extension AppColorsExtension on BuildContext {
  // Theme-aware colors
  Color get whiteColor => AppColors.white(this);
  Color get blackColor => AppColors.black(this);
  Color get surfaceColor => AppColors.surface(this);
  Color get backgroundColor => AppColors.background(this);
  Color get onSurfaceColor => AppColors.onSurface(this);
  Color get onBackgroundColor => AppColors.onBackground(this);
  Color get primaryColor => AppColors.primary(this);
  Color get secondaryColor => AppColors.secondary(this);

  Color get greyColor => AppColors.grey(this);
  Color get lightGreyColor => AppColors.lightGrey(this);
  Color get darkGreyColor => AppColors.darkGrey(this);
  Color get newGreyColor => AppColors.newGrey(this);
  Color get offWhiteColor => AppColors.offWhite(this);

  Color get cardColor => AppColors.card(this);
  Color get containerColor => AppColors.container(this);
  Color get mainColor => AppColors.main(this);

  Color get primaryTextColor => AppColors.primaryText(this);
  Color get secondaryTextColor => AppColors.secondaryText(this);
  Color get defaultTextColor => AppColors.defaultText(this);
  Color get faintTextColor => AppColors.faintText(this);
  Color get hintTextColor => AppColors.hintText(this);

  Color get borderColor => AppColors.border(this);
  Color get hardBorderColor => AppColors.hardBorder(this);
  Color get softBorderColor => AppColors.softBorder(this);
  Color get dividerColor => AppColors.divider(this);
}
