import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../dashboard/presentation/interface/widgets/action_button.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../../../../deposit/presentation/interface/screens/deposit_account_selection_screen.dart';
import '../../../../withdraw/presentation/interface/screens/withdraw_account_selection_screen.dart';

/// Action buttons section for deposit, withdraw, trade, view portfolio
class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        ActionButton(
          icon: IconlyBold.chart,
          label: 'View Portfolio',
          onTap: () {
            // Switch to portfolio tab
            context.read<DashboardProvider>().changeTab(2);
          },
        ),
      ],
    );
  }
}
