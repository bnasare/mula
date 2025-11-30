import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../widgets/account_list_tile.dart';
import 'enter_bank_account_info_screen.dart';

/// Screen for selecting which bank account to deposit to
class SelectBankAccountScreen extends StatelessWidget {
  const SelectBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample bank accounts - in production, this would come from state/API
    final accounts = [
      {'bank': 'Ecobank', 'accountNumber': '4544229482039'},
    ];

    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.deposit,
        showBottomDivider: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(24.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                context.localize.selectBankAccount,
                style: TextStyle(
                  fontSize: context.responsiveFontSize(mobile: 16.0),
                  color: AppColors.primaryText(context),
                ),
              ),
              const AppSpacer.vLarge(),
              // Account List
              ...accounts.map((account) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: AccountListTile(
                    icon: _getBankIcon(account['bank']!, context),
                    title: account['bank']!,
                    subtitle: account['accountNumber']!,
                    onTap: () {
                      NavigationHelper.navigateTo(
                        context,
                        EnterBankAccountInfoScreen(
                          selectedBank: account['bank']!,
                          selectedAccountNumber: account['accountNumber']!,
                        ),
                      );
                    },
                  ),
                );
              }),
              const AppSpacer.vShort(),
              // Add another account button
              InkWell(
                onTap: () {
                  NavigationHelper.navigateTo(
                    context,
                    const EnterBankAccountInfoScreen(),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveValue(mobile: 16.0),
                    vertical: context.responsiveValue(mobile: 16.0),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.border(context),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.appPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.add,
                          color: AppColors.appPrimary,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: context.responsiveSpacing(mobile: 12.0)),
                      AppText.smaller(
                        context.localize.addAnotherAccount,
                        style: TextStyle(color: AppColors.appPrimary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the appropriate icon for the bank
  Widget _getBankIcon(String bank, BuildContext context) {
    // Using first letter as icon
    return Text(
      bank.substring(0, 1),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.black(context),
      ),
    );
  }
}
