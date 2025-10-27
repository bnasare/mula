import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/confetti_success_screen.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/pin_input_widget.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';

/// Screen for entering PIN to confirm withdrawal
class EnterWithdrawPinScreen extends StatelessWidget {
  final String withdrawType; // 'mobile_money' or 'bank'
  final String? network; // For mobile money
  final String? phoneNumber; // For mobile money
  final String? bank; // For bank
  final String? accountName; // For bank
  final String? accountNumber; // For bank
  final String amount;

  const EnterWithdrawPinScreen({
    super.key,
    required this.withdrawType,
    this.network,
    this.phoneNumber,
    this.bank,
    this.accountName,
    this.accountNumber,
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
        child: Padding(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(24.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppSpacer.vLarge(),
              // Title
              Text(
                context.localize.enterYourPin,
                style: TextStyle(
                  fontSize: context.responsiveFontSize(mobile: 20.0),
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
              ),
              const AppSpacer.vShort(),
              // Description
              Text(
                context.localize.forYourSecurityEnterPin,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontSize(mobile: 14.0),
                  color: AppColors.secondaryText(context),
                ),
              ),
              const AppSpacer.vLarger(),
              // PIN Input Widget
              PinInputWidget(
                onPinComplete: (pin) {
                  // PIN entered, navigate to success screen
                  NavigationHelper.navigateTo(
                    context,
                    ConfettiSuccessScreen(
                      title: context.localize.withdrawalSuccessful,
                      description: context.localize.moneySuccessfullyWithdrawn,
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
      ),
    );
  }
}
