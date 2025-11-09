import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../authentication/presentation/interface/screens/link_investment_accounts_screen.dart';
import '../widgets/account_section.dart';
import '../widgets/linked_account_item.dart';

/// Screen displaying all linked accounts grouped by type
class LinkedAccountsScreen extends StatelessWidget {
  const LinkedAccountsScreen({super.key});

  // Dummy data for CIS accounts (Investment Managers)
  static const List<Map<String, String>> _cisAccounts = [
    {
      'id': 'ashfield',
      'name': 'Ashfield Investment Managers Ltd',
      'type': 'CIS',
    },
    {
      'id': 'crystal',
      'name': 'Crystal Capital & Investment',
      'type': 'CIS',
    },
    {
      'id': 'ecocapital',
      'name': 'EcoCapital Investment Management Limited',
      'type': 'CIS',
    },
  ];

  // Dummy data for CSD accounts (Securities/Capital)
  static const List<Map<String, String>> _csdAccounts = [
    {
      'id': 'brassica',
      'name': 'Brassica Capital Limited',
      'type': 'CSD',
    },
    {
      'id': 'cidan',
      'name': 'Cidan Investments Limited',
      'type': 'CSD',
    },
    {
      'id': 'databank',
      'name': 'Databank Asset Management Services Ltd',
      'type': 'CSD',
    },
  ];

  // Dummy data for Mobile Money accounts
  static const List<Map<String, String>> _mobileMoneyAccounts = [
    {
      'id': 'mtn_1',
      'network': 'MTN',
      'number': '+233 556 715 5578',
    },
    {
      'id': 'telecel_1',
      'network': 'Telecel',
      'number': '+233 50 223 5001',
    },
  ];

  // Dummy data for Bank accounts
  static const List<Map<String, String>> _bankAccounts = [
    {
      'id': 'ecobank_1',
      'bank': 'Ecobank',
      'accountNumber': '144 ********* 1223',
    },
  ];

  void _onAccountTap(BuildContext context, Map<String, String> account) {
    // Show unlink confirmation dialog directly
    _showUnlinkConfirmation(context, account);
  }

  void _showUnlinkConfirmation(
    BuildContext context,
    Map<String, String> account,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          context.localize.unlinkAccount,
          style: TextStyle(
            fontSize: context.responsiveFontSize(mobile: 18.0),
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText(context),
          ),
        ),
        content: Text(
          context.localize.areYouSureYouWantToUnlink,
          style: TextStyle(
            fontSize: context.responsiveFontSize(mobile: 14.0),
            color: AppColors.secondaryText(context),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.localize.cancel,
              style: TextStyle(
                color: AppColors.secondaryText(context),
                fontSize: context.responsiveFontSize(mobile: 14.0),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement actual unlinking logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.localize.accountUnlinkedSuccessfully),
                  backgroundColor: AppColors.appPrimary,
                ),
              );
            },
            child: Text(
              context.localize.unlinkAccount,
              style: TextStyle(
                color: Colors.red,
                fontSize: context.responsiveFontSize(mobile: 14.0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onAddAccount(BuildContext context) {
    // Navigate to the link investment accounts screen
    NavigationHelper.navigateTo(
      context,
      const LinkInvestmentAccountsScreen(fromLinkedAccounts: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      appBar: MulaAppBarHelpers.withActions(
        title: context.localize.linkedAccounts,
        onBackPressed: () => NavigationHelper.navigateBack(context),
        showDivider: false,
        actions: [
          // Add Account button
          Padding(
            padding: EdgeInsets.only(
              right: context.responsiveValue(mobile: 16.0),
            ),
            child: TextButton(
              onPressed: () => _onAddAccount(context),
              child: Text(
                context.localize.addAccount,
                style: TextStyle(
                  fontSize: context.responsiveFontSize(mobile: 14.0),
                  fontWeight: FontWeight.w500,
                  color: AppColors.appPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CIS Accounts Section
              if (_cisAccounts.isNotEmpty) ...[
                AccountSection(
                  title: context.localize.cisAccounts,
                  accounts: _cisAccounts.map((account) {
                    return LinkedAccountItem(
                      name: account['name']!,
                      accountType: 'CIS',
                      onTap: () => _onAccountTap(context, account),
                    );
                  }).toList(),
                ),
                const AppSpacer.vLarge(),
              ],

              // CSD Accounts Section
              if (_csdAccounts.isNotEmpty) ...[
                AccountSection(
                  title: context.localize.csdAccounts,
                  accounts: _csdAccounts.map((account) {
                    return LinkedAccountItem(
                      name: account['name']!,
                      accountType: 'CSD',
                      onTap: () => _onAccountTap(context, account),
                    );
                  }).toList(),
                ),
                const AppSpacer.vLarge(),
              ],

              // Mobile Money Accounts Section
              if (_mobileMoneyAccounts.isNotEmpty) ...[
                AccountSection(
                  title: context.localize.mobileMoneyAccounts,
                  accounts: _mobileMoneyAccounts.map((account) {
                    return LinkedAccountItem(
                      name: account['network']!,
                      subtitle: account['number']!,
                      accountType: 'MobileMoney',
                      onTap: () => _onAccountTap(context, account),
                    );
                  }).toList(),
                ),
                const AppSpacer.vLarge(),
              ],

              // Bank Accounts Section
              if (_bankAccounts.isNotEmpty) ...[
                AccountSection(
                  title: context.localize.bankAccounts,
                  accounts: _bankAccounts.map((account) {
                    return LinkedAccountItem(
                      name: account['bank']!,
                      subtitle: account['accountNumber']!,
                      accountType: 'Bank',
                      onTap: () => _onAccountTap(context, account),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
