import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/selectable_option_card.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import 'select_fund_manager_screen.dart';

class LinkInvestmentAccountsScreen extends StatefulWidget {
  const LinkInvestmentAccountsScreen({super.key});

  @override
  State<LinkInvestmentAccountsScreen> createState() =>
      _LinkInvestmentAccountsScreenState();
}

class _LinkInvestmentAccountsScreenState
    extends State<LinkInvestmentAccountsScreen> {
  String? _selectedAccountType;

  void _onContinue() {
    if (_selectedAccountType != null) {
      if (_selectedAccountType == 'cis') {
        // Navigate to Select Fund Manager screen for CIS account
        NavigationHelper.navigateTo(
          context,
          const SelectFundManagerScreen(),
        );
      } else {
        // TODO: Navigate to appropriate screen for CSD or none
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      appBar: MulaAppBarHelpers.withProgress(
        backgroundColor: AppColors.white(context),
        title: context.localize.linkInvestmentAccounts,
        currentStep: 10,
        totalSteps: 11,
        progressColor: AppColors.appPrimary.withValues(alpha: 0.7),
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.smaller(
                context.localize.linkAccountsDescription,
                color: AppColors.secondaryText(context),
              ),
              const AppSpacer.vLarge(),
              // CSD Account option
              SelectableOptionCard(
                value: 'csd',
                selectedValue: _selectedAccountType,
                title: context.localize.csdAccount,
                description: context.localize.csdAccountDescription,
                onTap: () => setState(() => _selectedAccountType = 'csd'),
              ),
              const AppSpacer.vShort(),
              // CIS Account option
              SelectableOptionCard(
                value: 'cis',
                selectedValue: _selectedAccountType,
                title: context.localize.cisAccount,
                description: context.localize.cisAccountDescription,
                onTap: () => setState(() => _selectedAccountType = 'cis'),
              ),
              const AppSpacer.vShort(),
              // Don't have an account option
              SelectableOptionCard(
                value: 'none',
                selectedValue: _selectedAccountType,
                title: context.localize.dontHaveAccount,
                description: context.localize.dontHaveAccountDescription,
                onTap: () => setState(() => _selectedAccountType = 'none'),
              ),
              const Spacer(),
              // Continue Button
              AppButton(
                text: context.localize.continueButton,
                backgroundColor: _selectedAccountType != null
                    ? AppColors.appPrimary
                    : AppColors.lightGrey(context),
                textColor: _selectedAccountType != null
                    ? Colors.white
                    : AppColors.secondaryText(context),
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: _onContinue,
              ),
              const AppSpacer.vLarge(),
            ],
          ),
        ),
      ),
    );
  }
}
