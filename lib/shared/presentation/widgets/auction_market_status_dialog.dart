import 'package:flutter/material.dart';

import '../../utils/localization_extension.dart';
import '../theme/app_colors.dart';
import 'constants/app_text.dart';

class AuctionMarketStatusDialog extends StatelessWidget {
  final VoidCallback? onYes;
  final VoidCallback? onNo;

  const AuctionMarketStatusDialog({
    super.key,
    this.onYes,
    this.onNo,
  });

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AuctionMarketStatusDialog(
        onYes: () => Navigator.of(context).pop(true),
        onNo: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            AppText.large(
              context.localize.auctionMarketClosed,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText(context),
              ),
              align: TextAlign.center,
            ),
            const SizedBox(height: 16),
            AppText.small(
              context.localize.notifyWhenOpened,
              color: AppColors.secondaryText(context),
              align: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onYes,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.appPrimary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: AppText.medium(
                          context.localize.yes,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: onNo,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.grey(context).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: AppText.medium(
                          context.localize.no,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
