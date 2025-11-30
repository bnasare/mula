import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import 'enter_withdraw_pin_screen.dart';

/// Screen for confirming bank withdrawal details
class ConfirmBankWithdrawScreen extends StatelessWidget {
  final String bank;
  final String accountName;
  final String accountNumber;
  final String amount;

  const ConfirmBankWithdrawScreen({
    super.key,
    required this.bank,
    required this.accountName,
    required this.accountNumber,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.withdraw,
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
                        context.responsiveValue(mobile: 13.0),
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
                          // Bank
                          _buildDetailRow(context, context.localize.bank, bank),
                          const AppSpacer.vShort(),
                          const AppSpacer.vShort(), // Account Number
                          _buildDetailRow(
                            context,
                            context.localize.bankAccountNumber,
                            accountNumber,
                          ),
                          const AppSpacer.vShort(),
                          const AppSpacer.vShort(), // Account Name
                          _buildDetailRow(
                            context,
                            context.localize.accountName,
                            accountName,
                          ),
                          const AppSpacer.vShort(),
                          const AppSpacer.vShort(), // Amount
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
                text: context.localize.next,
                backgroundColor: AppColors.appPrimary,
                textColor: AppColors.white(context),
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: () {
                  NavigationHelper.navigateTo(
                    context,
                    EnterWithdrawPinScreen(
                      withdrawType: 'bank',
                      bank: bank,
                      accountName: accountName,
                      accountNumber: accountNumber,
                      amount: amount,
                    ),
                  );
                },
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
}
