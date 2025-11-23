import 'package:flutter/material.dart';
import '../../../shared/utils/extension.dart';
import '../theme/app_colors.dart';

/// A reusable confirmation dialog that matches modern design patterns
///
/// Features:
/// - Clean, minimal design
/// - Customizable title and description
/// - Primary action button (typically for confirm/destructive actions)
/// - Secondary cancel button
/// - Supports custom colors and button styles
///
/// Example usage:
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) => ConfirmationDialog(
///     title: 'Log Out?',
///     description: 'Are you sure you want to log out of your account?',
///     primaryButtonLabel: 'Log out',
///     secondaryButtonLabel: 'Cancel',
///     onPrimaryAction: () {
///       // Handle logout
///       Navigator.pop(context);
///     },
///     onSecondaryAction: () {
///       Navigator.pop(context);
///     },
///   ),
/// );
/// ```
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.description,
    required this.primaryButtonLabel,
    this.secondaryButtonLabel = 'Cancel',
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.primaryButtonColor,
    this.primaryButtonTextColor,
    this.isDangerousAction = false,
  });

  /// The main title of the dialog
  final String title;

  /// The description/subtitle text
  final String description;

  /// Label for the primary action button
  final String primaryButtonLabel;

  /// Label for the secondary/cancel button
  final String secondaryButtonLabel;

  /// Callback for primary action
  final VoidCallback? onPrimaryAction;

  /// Callback for secondary action
  final VoidCallback? onSecondaryAction;

  /// Custom color for primary button (defaults to green)
  final Color? primaryButtonColor;

  /// Custom text color for primary button (defaults to white)
  final Color? primaryButtonTextColor;

  /// If true, uses error/red color scheme for dangerous actions
  final bool isDangerousAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine button colors based on action type
    final buttonColor = isDangerousAction
        ? theme.colorScheme.error
        : (primaryButtonColor ?? AppColors.appPrimary);

    final buttonTextColor = primaryButtonTextColor ?? AppColors.white(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.white(context),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(mobile: 20.0),
          vertical: context.responsiveValue(mobile: 24.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: context.responsiveFontSize(mobile: 18),
                color: AppColors.primaryText(context),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.responsiveSpacing(mobile: 12)),

            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: context.responsiveFontSize(mobile: 14),
                color: AppColors.secondaryText(context),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.responsiveSpacing(mobile: 24)),

            // Primary Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPrimaryAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: buttonTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: context.responsiveValue(mobile: 14.0),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  primaryButtonLabel,
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(mobile: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.responsiveSpacing(mobile: 12)),

            // Secondary/Cancel Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onSecondaryAction ?? () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.lightGrey(context),
                  foregroundColor: AppColors.primaryText(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: context.responsiveValue(mobile: 14.0),
                  ),
                ),
                child: Text(
                  secondaryButtonLabel,
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(mobile: 16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
