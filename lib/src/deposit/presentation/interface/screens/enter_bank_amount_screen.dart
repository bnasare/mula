import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../authentication/presentation/interface/widgets/mula_text_field.dart';
import 'confirm_bank_deposit_screen.dart';

/// Screen for entering bank deposit amount with native numeric keyboard
class EnterBankAmountScreen extends StatefulWidget {
  final String bank;
  final String accountName;
  final String accountNumber;

  const EnterBankAmountScreen({
    super.key,
    required this.bank,
    required this.accountName,
    required this.accountNumber,
  });

  @override
  State<EnterBankAmountScreen> createState() => _EnterBankAmountScreenState();
}

class _EnterBankAmountScreenState extends State<EnterBankAmountScreen> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    final amount = double.tryParse(_amountController.text);
    return amount != null && amount > 0;
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
                      context.localize.enterAmount,
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(mobile: 20.0),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText(context),
                      ),
                    ),
                    const AppSpacer.vLarge(),
                    // Amount Input
                    MulaTextField(
                      controller: _amountController,
                      labelText: context.localize.amount,
                      hintText: '0.00',
                      keyboardType: TextInputType.number,
                      suffixIcon: Icon(
                        IconlyLight.wallet,
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
                          ConfirmBankDepositScreen(
                            bank: widget.bank,
                            accountName: widget.accountName,
                            accountNumber: widget.accountNumber,
                            amount: _amountController.text,
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
