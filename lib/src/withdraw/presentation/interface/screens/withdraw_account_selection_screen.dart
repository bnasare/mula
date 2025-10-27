import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/selectable_option_card.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import 'select_withdraw_mobile_money_account_screen.dart';
import 'select_withdraw_bank_account_screen.dart';

/// Screen for selecting the withdrawal destination
/// (Mobile Money or Bank Account)
class WithdrawAccountSelectionScreen extends StatefulWidget {
  const WithdrawAccountSelectionScreen({super.key});

  @override
  State<WithdrawAccountSelectionScreen> createState() =>
      _WithdrawAccountSelectionScreenState();
}

class _WithdrawAccountSelectionScreenState
    extends State<WithdrawAccountSelectionScreen> {
  String? _selectedAccountType;

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
                      context.localize.chooseWithdrawalDestination,
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(mobile: 20.0),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText(context),
                      ),
                    ),
                    const AppSpacer.vLarge(),
                    // Mobile Money Option
                    SelectableOptionCard(
                      value: 'mobile_money',
                      selectedValue: _selectedAccountType,
                      title: context.localize.mobileMoneyDeposit,
                      description: 'MTN, Telecel, AirtelTigo, Vodafone',
                      onTap: () {
                        setState(() {
                          _selectedAccountType = 'mobile_money';
                        });
                      },
                    ),
                    const AppSpacer.vShort(),
                    // Bank Account Option
                    SelectableOptionCard(
                      value: 'bank_account',
                      selectedValue: _selectedAccountType,
                      title: context.localize.bankAccount,
                      description: 'Direct bank transfer',
                      onTap: () {
                        setState(() {
                          _selectedAccountType = 'bank_account';
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Continue Button
            Padding(
              padding: context.responsivePadding(
                mobile: const EdgeInsets.all(24.0),
              ),
              child: AppButton(
                text: context.localize.continueButton,
                backgroundColor: _selectedAccountType != null
                    ? AppColors.appPrimary
                    : AppColors.grey(context),
                textColor: Colors.white,
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: _selectedAccountType != null
                    ? () {
                        if (_selectedAccountType == 'mobile_money') {
                          NavigationHelper.navigateTo(
                            context,
                            const SelectWithdrawMobileMoneyAccountScreen(),
                          );
                        } else {
                          NavigationHelper.navigateTo(
                            context,
                            const SelectWithdrawBankAccountScreen(),
                          );
                        }
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
