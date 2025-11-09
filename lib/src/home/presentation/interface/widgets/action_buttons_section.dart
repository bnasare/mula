import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/presentation/widgets/snackbar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../cash_wallet/presentation/interface/screens/cash_wallet_screen.dart';
import '../../../../dashboard/presentation/interface/widgets/action_button.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../../../../deposit/presentation/interface/screens/deposit_account_selection_screen.dart';
import '../../../../linked_accounts/presentation/interface/screens/linked_accounts_screen.dart';
import '../../../../withdraw/presentation/interface/screens/withdraw_account_selection_screen.dart';

/// Action buttons section for deposit, withdraw, trade, view portfolio
class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          ActionButton(
            icon: IconlyLight.wallet,
            label: context.localize.deposit,
            onTap: () {
              NavigationHelper.navigateTo(
                context,
                const DepositAccountSelectionScreen(),
              );
            },
          ),
          const SizedBox(width: 12),
          ActionButton(
            icon: IconlyLight.download,
            label: context.localize.withdraw,
            onTap: () {
              NavigationHelper.navigateTo(
                context,
                const WithdrawAccountSelectionScreen(),
              );
            },
          ),
          const SizedBox(width: 12),
          ActionButton(
            icon: IconlyLight.swap,
            label: context.localize.trade,
            onTap: () {
              // TODO: Navigate to trade screen
              SnackBarHelper.showInfoSnackBar(
                context,
                context.localize.comingSoon,
              );
            },
          ),
          const SizedBox(width: 12),
          ActionButton(
            icon: IconlyLight.chart,
            label: context.localize.viewPortfolio,
            onTap: () {
              // Switch to portfolio tab
              context.read<DashboardProvider>().changeTab(2);
            },
          ),
          const SizedBox(width: 12),
          ActionButton(
            icon: Icons.link,
            label: context.localize.linkAccount,
            onTap: () {
              NavigationHelper.navigateTo(
                context,
                const LinkedAccountsScreen(),
              );
            },
          ),
          const SizedBox(width: 12),
          ActionButton(
            icon: IconlyLight.wallet,
            label: context.localize.cashWallet,
            onTap: () {
              NavigationHelper.navigateTo(
                context,
                CashWalletScreen(
                  dashboardProvider: context.read<DashboardProvider>(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
