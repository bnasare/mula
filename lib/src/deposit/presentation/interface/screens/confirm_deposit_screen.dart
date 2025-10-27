import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/confetti_success_screen.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';

/// Screen for confirming deposit details before processing
class ConfirmDepositScreen extends StatelessWidget {
  final String network;
  final String phoneNumber;
  final String amount;

  const ConfirmDepositScreen({
    super.key,
    required this.network,
    required this.phoneNumber,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.deposit,
        showBottomDivider: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: context.responsivePadding(
                  mobile: const EdgeInsets.all(24.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      context.localize.reviewAndConfirm,
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(mobile: 16.0),
                        color: AppColors.primaryText(context),
                      ),
                    ),
                    const AppSpacer.vLarge(),
                    // Details Container
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(
                        context.responsiveValue(mobile: 12.0),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.offWhite(context),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.border(context),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Network
                          _buildDetailRow(
                            context,
                            context.localize.network,
                            network,
                          ),
                          const AppSpacer.vShort(),
                          // Phone Number
                          _buildDetailRow(
                            context,
                            context.localize.phoneNumber,
                            phoneNumber,
                          ),
                          const AppSpacer.vShort(),
                          // Amount
                          _buildDetailRow(
                            context,
                            context.localize.amount,
                            'GHS $amount',
                            isAmount: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Button
            Padding(
              padding: context.responsivePadding(
                mobile: const EdgeInsets.all(24.0),
              ),
              child: AppButton(
                text: context.localize.confirmDeposit,
                backgroundColor: AppColors.appPrimary,
                textColor: Colors.white,
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: () => _showConfirmationDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isAmount = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.smaller(label, color: AppColors.secondaryText(context)),
        const SizedBox(height: 6),
        AppText.smaller(
          value,
          style: TextStyle(
            fontSize: isAmount
                ? context.responsiveFontSize(mobile: 14.0)
                : context.responsiveFontSize(mobile: 14.0),
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.appPrimary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone_android,
                    color: AppColors.appPrimary,
                    size: 32,
                  ),
                ),
                const AppSpacer.vShort(),
                // Message
                AppText.smaller(
                  context.localize.mobileMoneyPrompt,
                  align: TextAlign.center,
                ),
                const AppSpacer.vLarge(),
                // Okay Button
                AppButton(
                  text: context.localize.okay,
                  backgroundColor: AppColors.appPrimary,
                  textColor: Colors.white,
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  onTap: () {
                    // Close dialog
                    Navigator.of(dialogContext).pop();
                    // Navigate to success screen
                    NavigationHelper.navigateTo(
                      context,
                      ConfettiSuccessScreen(
                        title: context.localize.depositSuccessful,
                        description:
                            context.localize.fundsSuccessfullyDeposited,
                        primaryButtonText: context.localize.done,
                        onPrimaryButtonTap: () {
                          // Navigate back to the beginning or home
                          NavigationHelper.popUntil(
                            context,
                            (route) => route.isFirst,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
