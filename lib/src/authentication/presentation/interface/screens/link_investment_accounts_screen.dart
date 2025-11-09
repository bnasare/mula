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
import '../../../../linked_accounts/presentation/interface/screens/add_account_details_screen.dart';
import 'csd_account_number_screen.dart';
import 'personal_details_screen.dart';
import 'select_fund_manager_screen.dart';

class LinkInvestmentAccountsScreen extends StatefulWidget {
  final bool fromLinkedAccounts;

  const LinkInvestmentAccountsScreen({
    super.key,
    this.fromLinkedAccounts = false,
  });

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
          SelectFundManagerScreen(fromLinkedAccounts: widget.fromLinkedAccounts),
        );
      } else if (_selectedAccountType == 'csd') {
        // Navigate to CSD Account Number screen for CSD account
        NavigationHelper.navigateTo(
          context,
          CsdAccountNumberScreen(fromLinkedAccounts: widget.fromLinkedAccounts),
        );
      } else if (_selectedAccountType == 'bank') {
        // Navigate to Add Account Details screen for Bank
        NavigationHelper.navigateTo(
          context,
          const AddAccountDetailsScreen(accountType: 'bank'),
        );
      } else if (_selectedAccountType == 'mobile_money') {
        // Navigate to Add Account Details screen for Mobile Money
        NavigationHelper.navigateTo(
          context,
          const AddAccountDetailsScreen(accountType: 'mobile_money'),
        );
      } else {
        // User doesn't have an account - navigate to Personal Details screen
        NavigationHelper.navigateTo(context, const PersonalDetailsScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.fromLinkedAccounts
          ? MulaAppBarHelpers.simple(
              title: context.localize.linkAccount,
              onBackPressed: () => Navigator.pop(context),
            )
          : MulaAppBarHelpers.withProgress(
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
                widget.fromLinkedAccounts
                    ? context.localize.linkMoreAccountsDescription
                    : context.localize.linkAccountsDescription,
                color: AppColors.secondaryText(context),
              ),
              const AppSpacer.vLarge(),
              // CSD Account option
              SelectableOptionCard(
                value: 'csd',
                selectedValue: _selectedAccountType,
                title: widget.fromLinkedAccounts
                    ? context.localize.csdAccountSimple
                    : context.localize.csdAccount,
                description: widget.fromLinkedAccounts
                    ? context.localize.csdAccountDescriptionSimple
                    : context.localize.csdAccountDescription,
                onTap: () => setState(() => _selectedAccountType = 'csd'),
              ),
              const AppSpacer.vShort(),
              // CIS Account option
              SelectableOptionCard(
                value: 'cis',
                selectedValue: _selectedAccountType,
                title: widget.fromLinkedAccounts
                    ? context.localize.cisAccountSimple
                    : context.localize.cisAccount,
                description: widget.fromLinkedAccounts
                    ? context.localize.cisAccountDescriptionSimple
                    : context.localize.cisAccountDescription,
                onTap: () => setState(() => _selectedAccountType = 'cis'),
              ),
              const AppSpacer.vShort(),
              // Mobile Money option (only show when from linked accounts)
              if (widget.fromLinkedAccounts) ...[
                SelectableOptionCard(
                  value: 'mobile_money',
                  selectedValue: _selectedAccountType,
                  title: context.localize.mobileMoneyDeposit,
                  description: 'Link your mobile money account',
                  onTap: () =>
                      setState(() => _selectedAccountType = 'mobile_money'),
                ),
                const AppSpacer.vShort(),
              ],
              // Bank Account option (only show when from linked accounts)
              if (widget.fromLinkedAccounts) ...[
                SelectableOptionCard(
                  value: 'bank',
                  selectedValue: _selectedAccountType,
                  title: context.localize.bankAccount,
                  description: 'Link your bank account',
                  onTap: () => setState(() => _selectedAccountType = 'bank'),
                ),
                const AppSpacer.vShort(),
              ],
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
