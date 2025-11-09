import 'package:flutter/material.dart';

import '../../../shared/utils/extension.dart';
import '../theme/app_colors.dart';

class WarningModal extends StatelessWidget {
  const WarningModal({
    super.key,
    required this.title,
    required this.content,
    this.primaryButtonLabel,
    this.secondaryButtonLabel,
    this.primaryAction,
    this.secondaryAction,
  });

  final String title;
  final String content;
  final String? primaryButtonLabel;
  final String? secondaryButtonLabel;
  final void Function()? primaryAction;
  final void Function()? secondaryAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Padding(
        padding: EdgeInsets.only(
          top: context.responsiveValue(mobile: 10.0),
          left: context.responsiveValue(mobile: 10.0),
          right: context.responsiveValue(mobile: 10.0),
          bottom: context.responsiveValue(mobile: 10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              '',
              // ImageAssets.warning,
              height: context.responsiveValue(mobile: 80.0),
            ),
            SizedBox(height: context.responsiveSpacing(mobile: 10)),
            Container(
              padding: context.responsivePadding(
                mobile: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: theme.colorScheme.error.withOpacity(0.2),
              ),
              child: Text(
                'Warning',
                style: TextStyle(
                  color: theme.colorScheme.error,
                  fontSize: context.responsiveFontSize(mobile: 10),
                ),
              ),
            ),
            SizedBox(height: context.responsiveSpacing(mobile: 15)),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: context.responsiveFontSize(mobile: 20),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.responsiveSpacing(mobile: 0)),
            Padding(
              padding: context.responsivePadding(
                mobile: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: Text(
                content,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: context.responsiveFontSize(mobile: 15),
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: context.responsiveSpacing(mobile: 20)),
            Visibility(
              visible: primaryAction != null && primaryButtonLabel != null,
              child: ElevatedButton(
                onPressed: primaryAction,
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: theme.colorScheme.error,
                  padding: EdgeInsets.zero,
                  fixedSize: Size(
                    double.maxFinite,
                    context.responsiveValue(mobile: 30.0),
                  ),
                ),
                child: Text(
                  primaryButtonLabel ?? '',
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(mobile: 14),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: secondaryAction != null && secondaryButtonLabel != null,
              child: ElevatedButton(
                onPressed: secondaryAction,
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFF9E9E9E),
                  padding: EdgeInsets.zero,
                  fixedSize: Size(
                    double.maxFinite,
                    context.responsiveValue(mobile: 30.0),
                  ),
                ),
                child: Text(
                  secondaryButtonLabel ?? '',
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(mobile: 14),
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
