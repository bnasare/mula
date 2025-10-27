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
import 'enter_withdraw_amount_screen.dart';

/// Screen for entering phone number for mobile money withdrawal
class EnterWithdrawPhoneNumberScreen extends StatefulWidget {
  final String? selectedNetwork;
  final String? selectedAccountNumber;

  const EnterWithdrawPhoneNumberScreen({
    super.key,
    this.selectedNetwork,
    this.selectedAccountNumber,
  });

  @override
  State<EnterWithdrawPhoneNumberScreen> createState() =>
      _EnterWithdrawPhoneNumberScreenState();
}

class _EnterWithdrawPhoneNumberScreenState
    extends State<EnterWithdrawPhoneNumberScreen> {
  final _phoneController = TextEditingController();
  String? _selectedNetwork;

  final List<String> _networks = [
    'MTN Mobile Money',
    'Telecel Cash',
    'AirtelTigo Money',
    'Vodafone Cash',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.selectedNetwork != null) {
      _selectedNetwork = _getFullNetworkName(widget.selectedNetwork!);
    }
    if (widget.selectedAccountNumber != null) {
      _phoneController.text = widget.selectedAccountNumber!;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String _getFullNetworkName(String shortName) {
    switch (shortName) {
      case 'MTN':
        return 'MTN Mobile Money';
      case 'Telecel':
        return 'Telecel Cash';
      case 'AirtelTigo':
        return 'AirtelTigo Money';
      case 'Vodafone':
        return 'Vodafone Cash';
      default:
        return shortName;
    }
  }

  bool get _isFormValid {
    return _selectedNetwork != null &&
        _phoneController.text.isNotEmpty &&
        _phoneController.text.length >= 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.withdraw,
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
                      context.localize.enterPhoneNumber,
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(mobile: 20.0),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText(context),
                      ),
                    ),
                    const AppSpacer.vLarge(),
                    // Network Selector
                    SingleCategorySelector(
                      title: context.localize.network,
                      hintText: context.localize.selectNetwork,
                      options: _networks,
                      selectedOption: _selectedNetwork,
                      onSelectionChanged: (value) {
                        setState(() {
                          _selectedNetwork = value;
                        });
                      },
                    ),
                    const AppSpacer.vShort(),
                    // Phone Number Input
                    MulaTextField(
                      controller: _phoneController,
                      labelText: context.localize.phoneNumber,
                      hintText: context.localize.enterYourPhoneNumber,
                      keyboardType: TextInputType.phone,
                      suffixIcon: Icon(
                        IconlyLight.call,
                        color: Colors.grey.shade400,
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
                          EnterWithdrawAmountScreen(
                            network: _selectedNetwork!,
                            phoneNumber: _phoneController.text,
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
