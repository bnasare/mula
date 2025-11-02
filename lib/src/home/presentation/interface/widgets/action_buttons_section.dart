import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../cash_wallet/presentation/interface/screens/cash_wallet_screen.dart';
import '../../../../dashboard/presentation/interface/widgets/action_button.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../../../../deposit/presentation/interface/screens/deposit_account_selection_screen.dart';
import '../../../../withdraw/presentation/interface/screens/withdraw_account_selection_screen.dart';

/// Action buttons section for deposit, withdraw, trade, view portfolio
class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          ActionButton(
            icon: IconlyBold.wallet,
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
            icon: IconlyBold.download,
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
            icon: IconlyBold.swap,
            label: context.localize.trade,
            onTap: () {
              // TODO: Navigate to trade screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.localize.comingSoon)),
              );
            },
          ),
          const SizedBox(width: 12),
          ActionButton(
            icon: IconlyBold.chart,
            label: 'View Portfolio',
            onTap: () {
              // Switch to portfolio tab
              context.read<DashboardProvider>().changeTab(2);
            },
          ),
          const SizedBox(width: 12),
          ActionButton(
            icon: Icons.link,
            label: 'Link Account',
            onTap: () {
              // TODO: Navigate to link account screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.localize.comingSoon)),
              );
            },
          ),
          const SizedBox(width: 12),
          ActionButton(
            icon: IconlyBold.wallet,
            label: 'Cash Wallet',
            onTap: () {
              NavigationHelper.navigateTo(
                context,
                CashWalletScreen(
                    dashboardProvider: context.read<DashboardProvider>()),
              );
            },
          ),
        ],
      ),
    );
  }
}
