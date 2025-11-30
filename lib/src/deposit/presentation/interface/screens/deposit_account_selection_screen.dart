import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/selectable_option_card.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import 'select_account_screen.dart';
import 'select_bank_account_screen.dart';

/// Screen for selecting the account type to deposit from
/// (Mobile Money or Bank Account)
class DepositAccountSelectionScreen extends StatefulWidget {
  const DepositAccountSelectionScreen({super.key});

  @override
  State<DepositAccountSelectionScreen> createState() =>
      _DepositAccountSelectionScreenState();
}

class _DepositAccountSelectionScreenState
    extends State<DepositAccountSelectionScreen> {
  String? _selectedAccountType;

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
                      context.localize.chooseAccountToTopUp,
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(mobile: 16.0),
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
                textColor: AppColors.white(context),
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: _selectedAccountType != null
                    ? () {
                        if (_selectedAccountType == 'mobile_money') {
                          NavigationHelper.navigateTo(
                            context,
                            const SelectAccountScreen(),
                          );
                        } else {
                          NavigationHelper.navigateTo(
                            context,
                            const SelectBankAccountScreen(),
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
