import 'package:flutter/material.dart';

import '../../utils/extension.dart';
import '../../utils/navigation.dart';
import '../theme/app_colors.dart';
import 'mula_back_button.dart';
import 'rounded_linear_progress_indicator.dart';

/// A highly customizable AppBar widget that follows the established patterns in the app.
///
/// This widget provides all common AppBar configurations used throughout the app:
/// - Custom back button handling
/// - Flexible title positioning (center/left)
/// - Custom actions
/// - Optional bottom widget/divider
/// - Progress indicators
/// - Responsive design using established utilities
class MulaAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title text to display in the AppBar
  final String? title;

  /// Custom title widget (overrides [title] if provided)
  final Widget? titleWidget;

  /// Whether to center the title (default: false for left alignment)
  final bool centerTitle;

  /// Custom back button press handler (if null, uses Navigator.pop)
  final VoidCallback? onBackPressed;

  /// Whether to show the back button (default: true)
  final bool showBackButton;

  /// Custom leading widget (overrides back button if provided)
  final Widget? leading;

  /// List of action widgets to display in the AppBar
  final List<Widget>? actions;

  /// Optional bottom widget (e.g., progress bar, tabs, divider)
  final PreferredSizeWidget? bottom;

  /// Background color of the AppBar (defaults to AppColors.offWhite)
  final Color? backgroundColor;

  /// Elevation of the AppBar (default: 0)
  final double elevation;

  /// ScrolledUnderElevation of the AppBar (default: 0)
  final double scrolledUnderElevation;

  /// Custom height for the AppBar (defaults to kToolbarHeight)
  final double? height;

  /// Whether to show a bottom divider (default: true)
  final bool showBottomDivider;

  const MulaAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = false,
    this.onBackPressed,
    this.showBackButton = true,
    this.leading,
    this.actions,
    this.bottom,
    this.backgroundColor,
    this.elevation = 0,
    this.scrolledUnderElevation = 0,
    this.height,
    this.showBottomDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate preferred size based on bottom widget and custom height
    final double appBarHeight = height ?? kToolbarHeight;
    final double bottomHeight = bottom?.preferredSize.height ?? 0;
    final double dividerHeight = showBottomDivider ? 1 : 0;

    return PreferredSize(
      preferredSize: Size.fromHeight(
        appBarHeight + bottomHeight + dividerHeight,
      ),
      child: AppBar(
        backgroundColor: backgroundColor ?? AppColors.offWhite(context),
        elevation: elevation,
        scrolledUnderElevation: scrolledUnderElevation,
        centerTitle: centerTitle,

        // Title handling
        title:
            titleWidget ??
            (title != null
                ? Text(
                    title!,
                    style: TextStyle(
                      color: AppColors.black(context),
                      fontSize: context.responsiveFontSize(mobile: 16.0),
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null),

        // Leading widget handling
        leading:
            leading ??
            (showBackButton
                ? Transform.scale(
                    scale: context.responsiveValue(mobile: 0.6),
                    child: MulaBackButton(
                      iconSize: context.responsiveValue(mobile: 24.0),
                      onPressed:
                          onBackPressed ??
                          () => NavigationHelper.navigateBack(context),
                    ),
                  )
                : null),

        // Actions
        actions: actions,

        // Bottom widget with optional divider
        bottom: _buildBottom(context, bottomHeight, dividerHeight),
      ),
    );
  }

  PreferredSizeWidget? _buildBottom(
    BuildContext context,
    double bottomHeight,
    double dividerHeight,
  ) {
    if (bottom == null && !showBottomDivider) {
      return null;
    }

    return PreferredSize(
      preferredSize: Size.fromHeight(bottomHeight + dividerHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (bottom != null) bottom!,
          if (showBottomDivider)
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.lightGrey(context),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    final double appBarHeight = height ?? kToolbarHeight;
    final double bottomHeight = bottom?.preferredSize.height ?? 0;
    final double dividerHeight = showBottomDivider ? 1 : 0;
    return Size.fromHeight(appBarHeight + bottomHeight + dividerHeight);
  }
}

/// Extension methods for common AppBar configurations used in the app
extension MulaAppBarHelpers on MulaAppBar {
  /// Creates an AppBar with step progress indicator (used in create flow)
  static MulaAppBar withProgress({
    required String title,
    required int currentStep,
    required int totalSteps,
    required Color progressColor,
    VoidCallback? onBackPressed,
    List<Widget>? actions,
    Color? backgroundColor,
  }) {
    return MulaAppBar(
      backgroundColor: backgroundColor,
      title: title,
      onBackPressed: onBackPressed,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(16),
        child: Builder(
          builder: (context) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                child: RoundedLinearProgressIndicator(
                  value: currentStep / totalSteps,
                  backgroundColor: AppColors.lightGrey(context),
                  color: progressColor,
                  minHeight: 4,
                  borderRadius: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates an AppBar with custom actions and divider
  static MulaAppBar withActions({
    required String title,
    required List<Widget> actions,
    bool centerTitle = false,
    VoidCallback? onBackPressed,
    bool showDivider = true,
  }) {
    return MulaAppBar(
      title: title,
      centerTitle: centerTitle,
      onBackPressed: onBackPressed,
      actions: actions,
      showBottomDivider: showDivider,
    );
  }

  /// Creates a simple AppBar with just title and back button (most common pattern)
  static MulaAppBar simple({
    required String title,
    bool centerTitle = false,
    VoidCallback? onBackPressed,
    Color? backgroundColor,
    bool showDivider = true,
  }) {
    return MulaAppBar(
      title: title,
      centerTitle: centerTitle,
      onBackPressed: onBackPressed,
      backgroundColor: backgroundColor,
      showBottomDivider: showDivider,
    );
  }
}

/// Common AppBar action widgets used throughout the app
class AppBarActions {
  /// Creates a step counter widget (e.g., "2/7")
  static Widget stepCounter({
    required BuildContext context,
    required int currentStep,
    required int totalSteps,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.newGrey(context),
      child: Padding(
        padding: context.responsivePadding(
          mobile: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
        child: Text(
          '$currentStep/$totalSteps',
          style: TextStyle(
            color: AppColors.secondaryText(context),
            fontSize: context.responsiveFontSize(mobile: 14.0),
          ),
        ),
      ),
    );
  }

  /// Creates a custom popup menu button
  static Widget popupMenuButton({
    required BuildContext context,
    required List<PopupMenuEntry<String>> menuItems,
    required void Function(String) onSelected,
    IconData icon = Icons.more_vert,
  }) {
    return Padding(
      padding: context.responsivePadding(
        mobile: const EdgeInsets.symmetric(horizontal: 12),
      ),
      child: PopupMenuButton<String>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        offset: const Offset(0, 40),
        onSelected: onSelected,
        child: Container(
          height: context.responsiveValue(mobile: 36.0),
          width: context.responsiveValue(mobile: 36.0),
          decoration: BoxDecoration(
            color: AppColors.offWhite(context),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border(context)),
          ),
          child: Icon(
            icon,
            size: context.responsiveValue(mobile: 18.0),
            color: AppColors.darkGrey(context),
          ),
        ),
        itemBuilder: (context) => menuItems,
      ),
    );
  }

  /// Creates a text button action (e.g., "View Drafts")
  static Widget textButton({
    required String text,
    required VoidCallback onPressed,
    required BuildContext context,
    Color? textColor,
    double? fontSize,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: context.responsivePadding(
          mobile: const EdgeInsets.symmetric(horizontal: 8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? AppColors.darkGrey(context),
            fontSize: fontSize ?? context.responsiveFontSize(mobile: 13),
          ),
        ),
      ),
    );
  }

  /// Creates a button action (e.g., "Preview" button)
  static Widget button({
    required String text,
    required VoidCallback onPressed,
    required BuildContext context,
    Color? backgroundColor,
    Color? textColor,
    double width = 100,
  }) {
    return Container(
      width: width,
      margin: context.responsivePadding(
        mobile: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: context.responsivePadding(
            mobile: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? AppColors.white(context),
            fontSize: context.responsiveFontSize(mobile: 13),
          ),
        ),
      ),
    );
  }
}
