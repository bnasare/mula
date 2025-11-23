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
import 'linked_brokers_screen.dart';

enum LoginFlowType { cis, csd }

class FundManagerLoginScreen extends StatefulWidget {
  final String entityId;
  final String entityName;
  final String? entityLogoAsset;
  final LoginFlowType flowType;
  final VoidCallback? onAuthSuccess;
  final bool fromLinkedAccounts;

  const FundManagerLoginScreen({
    super.key,
    required this.entityId,
    required this.entityName,
    this.entityLogoAsset,
    this.flowType = LoginFlowType.cis,
    this.onAuthSuccess,
    this.fromLinkedAccounts = false,
  });

  /// Constructor for CIS fund manager flow
  factory FundManagerLoginScreen.cisFundManager({
    Key? key,
    required FundManager fundManager,
    bool fromLinkedAccounts = false,
  }) {
    return FundManagerLoginScreen(
      key: key,
      entityId: fundManager.id,
      entityName: fundManager.name,
      entityLogoAsset: fundManager.logoAsset,
      flowType: LoginFlowType.cis,
      fromLinkedAccounts: fromLinkedAccounts,
    );
  }

  /// Constructor for CSD broker flow
  factory FundManagerLoginScreen.csdBroker({
    Key? key,
    required Broker broker,
    VoidCallback? onAuthSuccess,
    bool fromLinkedAccounts = false,
  }) {
    return FundManagerLoginScreen(
      key: key,
      entityId: broker.id,
      entityName: broker.name,
      entityLogoAsset: broker.logoAsset,
      flowType: LoginFlowType.csd,
      onAuthSuccess: onAuthSuccess,
      fromLinkedAccounts: fromLinkedAccounts,
    );
  }

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
      // TODO: Implement authentication logic
      print('Signing in to ${widget.entityName}');
      print('Email/Phone: ${_emailOrPhoneController.text}');
      print('Flow type: ${widget.flowType}');

      // Navigate to OTP screen based on flow type
      if (widget.flowType == LoginFlowType.cis) {
        NavigationHelper.navigateTo(
          context,
          OtpVerificationScreen.cisAccount(
            fromLinkedAccounts: widget.fromLinkedAccounts,
          ),
        );
      } else {
        // CSD flow
        NavigationHelper.navigateTo(
          context,
          OtpVerificationScreen.csdAccount(
            fromLinkedAccounts: widget.fromLinkedAccounts,
            onVerificationSuccess: () {
              // Call the success callback when OTP is verified
              widget.onAuthSuccess?.call();
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MulaAppBarHelpers.simple(
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
                // Entity (Fund Manager or Broker) Logo/Name
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
                        child: widget.entityLogoAsset != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  widget.entityLogoAsset!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Center(
                                child: AppText.small(
                                  widget.entityName
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                      const AppSpacer.hShort(),
                      // Entity name
                      Expanded(
                        child: AppText.small(
                          widget.entityName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
                    color: AppColors.hintText(context),
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
                      color: AppColors.hintText(context),
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
