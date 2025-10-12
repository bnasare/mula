import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/data/image_assets.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/rounded_linear_progress_indicator.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../widgets/mula_text_field.dart';
import '../widgets/or_divider.dart';
import '../widgets/social_login_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white(context),
        appBar: AppBar(
          backgroundColor: AppColors.white(context),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.black(context)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: context.responsivePadding(mobile: const EdgeInsets.all(24.0)),
              children: [
                RoundedLinearProgressIndicator(
                  value: 0.2,
                  backgroundColor: AppColors.lightGrey(context),
                  color: AppColors.appPrimary,
                  minHeight: 6,
                  borderRadius: 10,
                ),
                const AppSpacer.vLarge(),
                AppText.large(context.localize.letsGetYouStarted, style: const TextStyle(fontWeight: FontWeight.w700)),
                const AppSpacer.vShort(),
                AppText.smaller(context.localize.createFreeAccountDescription, color: AppColors.secondaryText(context)),
                const AppSpacer.vLarge(),
                MulaTextField(controller: _fullNameController, labelText: context.localize.fullName, hintText: context.localize.enterYourFullName, keyboardType: TextInputType.name, textCapitalization: TextCapitalization.words),
                const AppSpacer.vShort(),
                MulaTextField(controller: _emailController, labelText: context.localize.emailAddress, hintText: context.localize.enterYourEmailAddress, keyboardType: TextInputType.emailAddress),
                const AppSpacer.vShort(),
                MulaTextField(
                  controller: _phoneController,
                  labelText: context.localize.enterYourPhoneNumber,
                  hintText: '',
                  keyboardType: TextInputType.phone,
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🇬🇭', style: TextStyle(fontSize: context.responsiveFontSize(mobile: 20))),
                      const SizedBox(width: 4),
                      AppText.smaller('+233'),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_drop_down, size: context.responsiveValue(mobile: 20)),
                    ],
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
                    icon: Icon(color: Colors.grey.shade400, _obscurePassword ? IconlyLight.hide : IconlyLight.show),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const AppSpacer.vShort(),
                MulaTextField(
                  controller: _confirmPasswordController,
                  labelText: context.localize.confirmPassword,
                  hintText: context.localize.enterYourPassword,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    iconSize: 20,
                    icon: Icon(color: Colors.grey.shade400, _obscureConfirmPassword ? IconlyLight.hide : IconlyLight.show),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                ),
                const AppSpacer.vLarge(),
                AppButton(text: context.localize.createAccount, backgroundColor: AppColors.appPrimary, textColor: Colors.white, borderRadius: 12, padding: EdgeInsets.zero, onTap: () {}),
                const AppSpacer.vShort(),
                OrDivider(text: context.localize.or, dividerColor: AppColors.lightGrey(context)),
                const AppSpacer.vShort(),
                Row(
                  children: [
                    Expanded(
                      child: SocialLoginButton(
                        text: context.localize.google,
                        iconAsset: ImageAssets.google,
                        onPressed: () {},
                        backgroundColor: AppColors.lightGrey(context),
                        borderColor: AppColors.border(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SocialLoginButton(
                        text: context.localize.apple,
                        iconAsset: ImageAssets.apple,
                        onPressed: () {},
                        backgroundColor: AppColors.lightGrey(context),
                        borderColor: AppColors.border(context),
                      ),
                    ),
                  ],
                ),
                const AppSpacer.vLarge(),
                AppText.rich(
                  align: TextAlign.center,
                  children: [
                    TextSpan(text: '${context.localize.byContinuingYouAgree} ', style: TextStyle(fontSize: 12, color: AppColors.secondaryText(context))),
                    TextSpan(text: context.localize.termsOfService, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.appPrimary)),
                    TextSpan(text: ' ${context.localize.and} ', style: TextStyle(fontSize: 12, color: AppColors.secondaryText(context))),
                    TextSpan(text: context.localize.privacyPolicy, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.appPrimary)),
                  ],
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
