import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/single_category_selector.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../authentication/presentation/interface/screens/otp_verification_screen.dart';
import '../../../../authentication/presentation/interface/widgets/mula_text_field.dart';

/// Reusable screen for adding account details (Bank or Mobile Money)
class AddAccountDetailsScreen extends StatefulWidget {
  /// The type of account being added ('bank' or 'mobile_money')
  final String accountType;

  const AddAccountDetailsScreen({super.key, required this.accountType});

  @override
  State<AddAccountDetailsScreen> createState() =>
      _AddAccountDetailsScreenState();
}

class _AddAccountDetailsScreenState extends State<AddAccountDetailsScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  String? _selectedOption;

  // List of mobile money networks
  final List<String> _networks = [
    'MTN Mobile Money',
    'Telecel Cash',
    'AirtelTigo Money',
    'Vodafone Cash',
  ];

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
    _phoneController.dispose();
    _accountNameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    if (_selectedOption == null) return false;

    if (widget.accountType == 'mobile_money') {
      return _phoneController.text.isNotEmpty &&
          _phoneController.text.length >= 10;
    } else {
      // Bank account
      return _accountNameController.text.isNotEmpty &&
          _accountNumberController.text.isNotEmpty;
    }
  }

  void _onNext() {
    if (_isFormValid) {
      // Navigate to OTP verification screen
      NavigationHelper.navigateTo(
        context,
        const OtpVerificationScreen.accountLinking(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobileMoney = widget.accountType == 'mobile_money';

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MulaAppBarHelpers.simple(
          title: context.localize.addAccount,
          onBackPressed: () => Navigator.pop(context),
        ),
        body: SafeArea(
          child: ListView(
            padding: context.responsivePadding(
              mobile: const EdgeInsets.all(16.0),
            ),
            children: [
              // Title
              AppText.medium(
                context.localize.enterAccountInformation,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const AppSpacer.vLarge(),

              // Network/Bank Selector
              SingleCategorySelector(
                title: isMobileMoney
                    ? context.localize.network
                    : context.localize.bank,
                hintText: isMobileMoney
                    ? context.localize.selectNetwork
                    : context.localize.selectYourBank,
                options: isMobileMoney ? _networks : _banks,
                selectedOption: _selectedOption,
                onSelectionChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              const AppSpacer.vShort(),

              // Mobile Money: Phone Number
              if (isMobileMoney) ...[
                MulaTextField(
                  controller: _phoneController,
                  labelText: context.localize.phoneNumber,
                  hintText: context.localize.enterYourPhoneNumber,
                  keyboardType: TextInputType.phone,
                  onChanged: (_) => setState(() {}),
                ),
              ],

              // Bank Account: Account Name + Account Number
              if (!isMobileMoney) ...[
                MulaTextField(
                  controller: _accountNameController,
                  labelText: context.localize.accountName,
                  hintText: context.localize.enterAccountName,
                  keyboardType: TextInputType.name,
                  onChanged: (_) => setState(() {}),
                ),
                const AppSpacer.vShort(),
                MulaTextField(
                  controller: _accountNumberController,
                  labelText: context.localize.accountNumber,
                  hintText: context.localize.enterAccountNumber,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                ),
              ],

              const AppSpacer.vLarger(),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(
              text: context.localize.next,
              backgroundColor: _isFormValid
                  ? AppColors.appPrimary
                  : AppColors.lightGrey(context),
              textColor: _isFormValid
                  ? AppColors.white(context)
                  : AppColors.secondaryText(context),
              borderRadius: 12,
              padding: const EdgeInsets.all(0),
              onTap: _isFormValid ? _onNext : null,
            ),
          ),
        ),
      ),
    );
  }
}
