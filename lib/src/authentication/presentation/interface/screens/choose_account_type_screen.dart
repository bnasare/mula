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
import 'select_broker_screen.dart';
import 'select_fund_manager_screen.dart';

class ChooseAccountTypeScreen extends StatefulWidget {
  const ChooseAccountTypeScreen({super.key});

  @override
  State<ChooseAccountTypeScreen> createState() =>
      _ChooseAccountTypeScreenState();
}

class _ChooseAccountTypeScreenState extends State<ChooseAccountTypeScreen> {
  String? _selectedAccountType;

  void _onContinue() {
    if (_selectedAccountType != null) {
      if (_selectedAccountType == 'csd') {
        // Navigate to Select Broker screen for CSD account
        NavigationHelper.navigateTo(context, const SelectBrokerScreen());
      } else if (_selectedAccountType == 'cis') {
        // Navigate to Select Fund Manager screen for CIS account (create account flow)
        NavigationHelper.navigateTo(
          context,
          const SelectFundManagerScreen(isCreateAccountFlow: true),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      appBar: MulaAppBarHelpers.withProgress(
        backgroundColor: AppColors.white(context),
        title: context.localize.chooseAccountType,
        currentStep: 5,
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
                context.localize.chooseAccountTypeDescription,
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
              const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AppButton(
            text: context.localize.continueButton,
            backgroundColor: _selectedAccountType != null
                ? AppColors.appPrimary
                : AppColors.lightGrey(context),
            textColor: _selectedAccountType != null
                ? Colors.white
                : AppColors.secondaryText(context),
            borderRadius: 12,
            padding: const EdgeInsets.all(0),
            onTap: _onContinue,
          ),
        ),
      ),
    );
  }
}
