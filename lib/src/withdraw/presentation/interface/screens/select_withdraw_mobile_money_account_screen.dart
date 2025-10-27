import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../deposit/presentation/interface/widgets/account_list_tile.dart';
import 'enter_withdraw_phone_number_screen.dart';

/// Screen for selecting which mobile money account to withdraw to
class SelectWithdrawMobileMoneyAccountScreen extends StatelessWidget {
  const SelectWithdrawMobileMoneyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample accounts - in production, this would come from state/API
    final accounts = [
      {'network': 'MTN', 'number': '+233 556 776 5578'},
      {'network': 'Telecel', 'number': '+233 90 223 8001'},
    ];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                context.localize.selectWithdrawAccount,
                style: TextStyle(
                  fontSize: context.responsiveFontSize(mobile: 20.0),
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
              ),
              const AppSpacer.vLarge(),
              // Account List
              ...accounts.map((account) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: AccountListTile(
                    icon: _getNetworkIcon(account['network']!),
                    title: account['network']!,
                    subtitle: account['number']!,
                    onTap: () {
                      NavigationHelper.navigateTo(
                        context,
                        EnterWithdrawPhoneNumberScreen(
                          selectedNetwork: account['network']!,
                          selectedAccountNumber: account['number']!,
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
                    const EnterWithdrawPhoneNumberScreen(),
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
                      AppText.medium(
                        context.localize.addAnotherAccount,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.appPrimary,
                        ),
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

  /// Returns the appropriate icon for the network
  Widget _getNetworkIcon(String network) {
    // Using first letter as icon
    return Text(
      network.substring(0, 1),
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}
