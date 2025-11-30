import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../widgets/mula_text_field.dart';
import 'linked_brokers_screen.dart';

class CsdAccountNumberScreen extends StatefulWidget {
  final bool fromLinkedAccounts;

  const CsdAccountNumberScreen({super.key, this.fromLinkedAccounts = false});

  @override
  State<CsdAccountNumberScreen> createState() => _CsdAccountNumberScreenState();
}

class _CsdAccountNumberScreenState extends State<CsdAccountNumberScreen> {
  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  void _onSearchLinkedBrokers() {
    if (_accountNumberController.text.isNotEmpty) {
      // TODO: Implement account number lookup logic
      print(
        'Searching for brokers with account: ${_accountNumberController.text}',
      );

      // Navigate to Linked Brokers screen (first time - hide bottom buttons)
      NavigationHelper.navigateTo(
        context,
        LinkedBrokersScreen(
          isFirstTime: true,
          fromLinkedAccounts: widget.fromLinkedAccounts,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MulaAppBarHelpers.simple(
          title: widget.fromLinkedAccounts
              ? context.localize.csdAccountSimple
              : context.localize.csdAccount,
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
                // Title
                AppText.medium(
                  context.localize.enterCsdAccountNumber,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const AppSpacer.vShort(),
                // Description
                AppText.smaller(
                  context.localize.csdAccountNumberDescription,
                  color: AppColors.secondaryText(context),
                ),
                const AppSpacer.vLarge(),
                MulaTextField(
                  labelText: context.localize.accountNumber,
                  controller: _accountNumberController,
                  hintText: context.localize.csdAccountNumberHint,
                  keyboardType: TextInputType.text,
                  onChanged: (_) => setState(() {}),
                ),
                const AppSpacer.vLarger(),
                // Search Linked Brokers Button
                AppButton(
                  height: 50,
                  text: context.localize.searchLinkedBrokers,
                  backgroundColor: _accountNumberController.text.isNotEmpty
                      ? AppColors.appPrimary
                      : AppColors.lightGrey(context),
                  textColor: _accountNumberController.text.isNotEmpty
                      ? AppColors.white(context)
                      : AppColors.secondaryText(context),
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  onTap: _accountNumberController.text.isNotEmpty
                      ? _onSearchLinkedBrokers
                      : null,
                ),
                const AppSpacer.vLarge(),
                // Don't have an account link (only show if not from linked accounts)
                if (!widget.fromLinkedAccounts)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText.smaller(
                        '${context.localize.dontHaveAccount} ',
                        color: AppColors.secondaryText(context),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: Navigate to account creation flow
                          print('Navigate to create account');
                        },
                        child: AppText.smaller(
                          context.localize.createOne,
                          style: TextStyle(
                            color: AppColors.appPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
