import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/single_category_selector.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../widgets/mula_text_field.dart';
import 'choose_account_type_screen.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final TextEditingController _accountNumberController =
      TextEditingController();

  String? _selectedBank;

  // List of banks
  final List<String> _banks = [
    'Access Bank Ghana',
    'Agricultural Development Bank',
    'Bank of Africa Ghana',
    'Cal Bank',
    'Ecobank Ghana',
    'Fidelity Bank Ghana',
    'First Atlantic Bank',
    'First National Bank Ghana',
    'GCB Bank',
    'Guaranty Trust Bank Ghana',
    'National Investment Bank',
    'OmniBSIC Bank',
    'Prudential Bank',
    'Republic Bank Ghana',
    'Societe Generale Ghana',
    'Standard Chartered Bank Ghana',
    'Stanbic Bank Ghana',
    'United Bank for Africa Ghana',
    'Zenith Bank Ghana',
  ];

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  void _onDone() {
    // TODO: Validate inputs
    NavigationHelper.navigateTo(context, const ChooseAccountTypeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MulaAppBarHelpers.withProgress(
          title: context.localize.bankDetails,
          currentStep: 4,
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
              const AppSpacer.vLarge(),
              // Select Bank
              SingleCategorySelector(
                title: context.localize.selectBank,
                hintText: context.localize.selectYourBank,
                options: _banks,
                selectedOption: _selectedBank,
                onSelectionChanged: (value) {
                  setState(() {
                    _selectedBank = value;
                  });
                },
              ),
              const AppSpacer.vShort(),
              // Bank Account Number
              MulaTextField(
                controller: _accountNumberController,
                labelText: context.localize.bankAccountNumber,
                hintText: context.localize.enterYourAccountNumber,
                keyboardType: TextInputType.number,
              ),
              const AppSpacer.vLarger(),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(
              text: context.localize.done,
              backgroundColor: AppColors.appPrimary,
              textColor: Colors.white,
              borderRadius: 12,
              padding: const EdgeInsets.all(0),
              onTap: _onDone,
            ),
          ),
        ),
      ),
    );
  }
}
