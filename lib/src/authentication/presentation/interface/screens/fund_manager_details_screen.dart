import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/confetti_success_screen.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/selectable_option_card.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import 'select_fund_manager_screen.dart';

class FundManagerDetailsScreen extends StatefulWidget {
  final FundManager fundManager;
  final bool isCreateAccountFlow;

  const FundManagerDetailsScreen({
    super.key,
    required this.fundManager,
    this.isCreateAccountFlow = false,
  });

  @override
  State<FundManagerDetailsScreen> createState() =>
      _FundManagerDetailsScreenState();
}

class _FundManagerDetailsScreenState extends State<FundManagerDetailsScreen> {
  String? _selectedFund;

  // Dummy fund options
  final List<String> _funds = [
    'Gold Money Market Fund NG',
    'Equity Growth Fund',
    'Fixed Income Fund',
  ];

  void _onContinue() {
    // Use pushReplacement so "Add another" goes back to Select Fund Manager screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ConfettiSuccessScreen(
          title: context.localize.fundManagerLinkedSuccessfully,
          description: context.localize.fundManagerLinkedSuccessDescription,
          primaryButtonText: context.localize.done,
          onPrimaryButtonTap: () {
            // Do nothing - just stays on success screen
          },
          secondaryButtonText: context.localize.addAnother,
          onSecondaryButtonTap: () {
            // Go back to fund manager selection
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      appBar: MulaAppBarHelpers.withProgress(
        backgroundColor: AppColors.white(context),
        title: context.localize.fundManager,
        currentStep: 6,
        totalSteps: 11,
        progressColor: AppColors.appPrimary.withValues(alpha: 0.7),
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: ListView(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(16.0),
          ),
          children: [
            // Fund Manager Logo/Name Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightGrey(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.white(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: widget.fundManager.logoAsset != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              widget.fundManager.logoAsset!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: AppText.large(
                              widget.fundManager.name
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                  const AppSpacer.vShort(),
                  // Company Name
                  AppText.small(
                    widget.fundManager.name,
                    align: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const AppSpacer.vShorter(),
                  // Email
                  AppText.smaller(
                    'ashfield@mail.com',
                    align: TextAlign.center,
                    color: AppColors.appPrimary,
                  ),
                  const AppSpacer.vShorter(),
                  Center(
                    child: AppText.smaller(
                      'P.O Box CD 6876',
                      color: AppColors.secondaryText(context),
                    ),
                  ),
                ],
              ),
            ),
            const AppSpacer.vLarge(),
            // PO Box            // Description
            AppText.medium(
              '${context.localize.fundsManaged} ${widget.fundManager.name}',
              color: AppColors.black(context),
            ),
            const AppSpacer.vLarge(),
            // Select header
            AppText.smaller(context.localize.select),
            const AppSpacer.vShort(),
            // Fund options
            ..._funds.map((fund) {
              final isLast = fund == _funds[_funds.length - 1];
              return Column(
                children: [
                  SelectableOptionCard(
                    value: fund,
                    selectedValue: _selectedFund,
                    title: fund,
                    onTap: () => setState(() => _selectedFund = fund),
                  ),
                  if (!isLast) const AppSpacer.vShorter(),
                ],
              );
            }),
            const AppSpacer.vLarger(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AppButton(
            text: context.localize.continueButton,
            backgroundColor: AppColors.appPrimary,
            textColor: Colors.white,
            borderRadius: 12,
            padding: const EdgeInsets.all(0),
            onTap: _onContinue,
          ),
        ),
      ),
    );
  }
}
