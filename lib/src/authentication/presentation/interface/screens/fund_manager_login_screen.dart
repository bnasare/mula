import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../widgets/mula_text_field.dart';
import 'otp_verification_screen.dart';
import 'select_fund_manager_screen.dart';

class FundManagerLoginScreen extends StatefulWidget {
  final FundManager fundManager;

  const FundManagerLoginScreen({
    super.key,
    required this.fundManager,
  });

  @override
  State<FundManagerLoginScreen> createState() => _FundManagerLoginScreenState();
}

class _FundManagerLoginScreenState extends State<FundManagerLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement fund manager authentication logic
      print('Signing in to ${widget.fundManager.name}');
      print('Email/Phone: ${_emailOrPhoneController.text}');

      // Navigate to OTP screen with CIS flow
      NavigationHelper.navigateTo(
        context,
        const OtpVerificationScreen.cisAccount(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white(context),
        appBar: MulaAppBarHelpers.simple(
          backgroundColor: AppColors.white(context),
          title: context.localize.signIn,
          onBackPressed: () => Navigator.pop(context),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: context.responsivePadding(
                mobile: const EdgeInsets.all(16.0),
              ),
              children: [
                // Fund Manager Logo/Name
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Logo placeholder
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.white(context),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: widget.fundManager.logoAsset != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  widget.fundManager.logoAsset!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Center(
                                child: AppText.small(
                                  widget.fundManager.name
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                      const AppSpacer.hShort(),
                      // Fund manager name
                      Expanded(
                        child: AppText.small(
                          widget.fundManager.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const AppSpacer.vLarge(),
                AppText.smaller(
                  context.localize.signInToYourAccount,
                  color: AppColors.secondaryText(context),
                ),
                const AppSpacer.vLarge(),
                MulaTextField(
                  controller: _emailOrPhoneController,
                  labelText: context.localize.emailAddress,
                  hintText: context.localize.enterEmailOrPhone,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: Icon(
                    IconlyLight.message,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ),
                const AppSpacer.vShort(),
                MulaTextField(
                  controller: _passwordController,
                  labelText: context.localize.password,
                  hintText: context.localize.enterYourPassword,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    iconSize: 20,
                    icon: Icon(
                      color: Colors.grey.shade400,
                      _obscurePassword ? IconlyLight.hide : IconlyLight.show,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const AppSpacer.vLarger(),
                AppButton(
                  text: context.localize.signIn,
                  backgroundColor: AppColors.appPrimary,
                  textColor: Colors.white,
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  onTap: _onSignIn,
                ),
                const AppSpacer.vLarge(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
