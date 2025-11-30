import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../shared/utils/extension.dart';
import '../theme/app_colors.dart';

class SnackBarHelper {
  static void showSuccessSnackBar(BuildContext context, String message) {
    _showCustomSnackBar(context, message, Icons.verified, AppColors.emerald);
  }

  static void showInfoSnackBar(BuildContext context, String message) {
    _showCustomSnackBar(context, message, Icons.info, AppColors.info);
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    _showCustomSnackBar(context, message, Icons.error, AppColors.error);
  }

  static void showWarningSnackBar(BuildContext context, String message) {
    _showCustomSnackBar(
      context,
      message,
      Icons.warning_amber,
      AppColors.warning,
    );
  }

  static void _showCustomSnackBar(
    BuildContext context,
    String message,
    IconData icon,
    Color color,
  ) {
    showTopSnackBar(
      Overlay.of(context),
      Material(
        color: AppColors.transparent,
        child: Container(
          height: context.responsiveValue(mobile: 50.0),
          width: MediaQuery.sizeOf(context).width,
          padding: context.responsivePadding(
            mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: context.responsiveValue(mobile: 18.0),
              ),
              SizedBox(width: context.responsiveSpacing(mobile: 10)),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(mobile: 11),
                  ),
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
      ),
      displayDuration: const Duration(seconds: 3),
    );
  }
}
