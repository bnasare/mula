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

  // Activity/Transaction status colors
  static const Color activitySuccess = Color(
    0xFF4CAF50,
  ); // Green for completed/buy
  static const Color activitySuccessLight = Color(
    0xFFE8F5E9,
  ); // Light green background
  static const Color activityError = Color(0xFFEF5350); // Red for failed/sell
  static const Color activityErrorLight = Color(
    0xFFFFEBEE,
  ); // Light red background
  static const Color activityPending = Color(0xFFFFA000); // Amber for pending
  static const Color activityPendingLight = Color(
    0xFFFFF8E1,
  ); // Light amber background
  static const Color activityDeposit = Color(0xFFFF9800); // Orange for deposit
  static const Color activityDepositLight = Color(
    0xFFFFF3E0,
  ); // Light orange background

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
  static const Color purple = Color(0xFF9C27B0);
  static const Color purpleLight = Color(0xFFF3E5F5);
  static const Color purpleDark = Color(0xFF7B1FA2);
  static const Color lavender = Color(0xFFE6E6FA);
  static const Color plum = Color(0xFF8E4585);

  // Browns
  static const Color sienna = Color(0xFF882D17);
  static const Color tan = Color(0xFFD2B48C);

  // Others
  static const Color teal = Color(0xFF008080);
  static const Color turquoise = Color(0xFF40E0D0);
  static const Color transparent = Colors.transparent;

  // ==================== GRADIENTS ====================

  static const List<Color> orangeGradient = [
    Color(0xFFFF9F43),
    Color(0xFFFF8A00),
  ];
  static const List<Color> purpleGradient = [
    Color(0xFF667EEA),
    Color(0xFF764BA2),
  ];
  static const List<Color> greenGradient = [
    Color(0xFF4CAF50),
    Color(0xFF2E7D32),
  ];
  static const List<Color> walletGradient = [
    Color(0xFF9C27B0),
    Color(0xFF7B1FA2),
    Color(0xFF6A1B9A),
  ];

  // ==================== CHART COLORS ====================

  static const Color chartBlue = Color(0xFF4A90E2);
  static const Color chartOrange = Color(0xFFFFA726);
  static const Color chartGreen = Color(0xFF66BB6A);
  static const Color chartPurple = Color(0xFFAB47BC);
  static const Color chartRed = Color(0xFFEF5350);
  static const Color chartTeal = Color(0xFF26A69A);

  // ==================== SYSTEM UI COLORS ====================

  static Color systemBarDark(BuildContext context) => const Color(0xFF1E1E1E);
  static Color systemBarLight(BuildContext context) => const Color(0xFFF2F2F2);

  // ==================== NOTIFICATION COLORS ====================

  static const Color notificationSuccess = Color(0xFF10B981);
  static const Color notificationError = Color(0xFFEF4444);
  static const Color notificationInfo = Color(0xFF3B82F6);
  static const Color notificationSystem = Color(0xFF8B5CF6);
  static const Color notificationDefault = Color(0xFF6B7280);
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
