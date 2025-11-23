import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/single_category_selector.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../authentication/presentation/interface/widgets/mula_text_field.dart';
import 'enter_bank_amount_screen.dart';

/// Screen for entering bank account information for deposit
class EnterBankAccountInfoScreen extends StatefulWidget {
  final String? selectedBank;
  final String? selectedAccountNumber;

  const EnterBankAccountInfoScreen({
    super.key,
    this.selectedBank,
    this.selectedAccountNumber,
  });

  @override
  State<EnterBankAccountInfoScreen> createState() =>
      _EnterBankAccountInfoScreenState();
}

class _EnterBankAccountInfoScreenState
    extends State<EnterBankAccountInfoScreen> {
  final _accountNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  String? _selectedBank;

  final List<String> _banks = [
    'Ecobank',
    'Access Bank',
    'Fidelity Bank',
    'GCB Bank',
    'Absa Bank',
    'Stanbic Bank',
    'Standard Chartered',
    'Zenith Bank',
    'CalBank',
    'ADB Bank',
  ];

  @override
  void initState() {
    super.initState();
    // Pre-fill if coming from account selection
    if (widget.selectedBank != null) {
      _selectedBank = widget.selectedBank;
    }
    if (widget.selectedAccountNumber != null) {
      _accountNumberController.text = widget.selectedAccountNumber!;
    }
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _selectedBank != null &&
        _accountNameController.text.isNotEmpty &&
        _accountNumberController.text.isNotEmpty &&
        _accountNumberController.text.length >= 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.deposit,
        showBottomDivider: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: context.responsivePadding(
                  mobile: const EdgeInsets.all(24.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      context.localize.enterBankAccountInfo,
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(mobile: 16.0),
                        color: AppColors.primaryText(context),
                      ),
                    ),
                    const AppSpacer.vLarge(),
                    // Bank Selector
                    SingleCategorySelector(
                      title: context.localize.bank,
                      hintText: context.localize.selectBank,
                      options: _banks,
                      selectedOption: _selectedBank,
                      onSelectionChanged: (value) {
                        setState(() {
                          _selectedBank = value;
                        });
                      },
                    ),
                    const AppSpacer.vShort(),
                    // Account Name Input
                    MulaTextField(
                      controller: _accountNameController,
                      labelText: context.localize.accountName,
                      hintText: context.localize.enterAccountName,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      suffixIcon: Icon(
                        IconlyLight.profile,
                        color: AppColors.hintText(context),
                        size: 20,
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const AppSpacer.vShort(),
                    // Account Number Input
                    MulaTextField(
                      controller: _accountNumberController,
                      labelText: context.localize.bankAccountNumber,
                      hintText: context.localize.enterYourAccountNumber,
                      keyboardType: TextInputType.number,
                      suffixIcon: Icon(
                        IconlyLight.document,
                        color: AppColors.hintText(context),
                        size: 20,
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Button
            Padding(
              padding: context.responsivePadding(
                mobile: const EdgeInsets.all(24.0),
              ),
              child: AppButton(
                text: context.localize.next,
                backgroundColor: _isFormValid
                    ? AppColors.appPrimary
                    : AppColors.grey(context),
                textColor: Colors.white,
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: _isFormValid
                    ? () {
                        NavigationHelper.navigateTo(
                          context,
                          EnterBankAmountScreen(
                            bank: _selectedBank!,
                            accountName: _accountNameController.text,
                            accountNumber: _accountNumberController.text,
                          ),
                        );
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
