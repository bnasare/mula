import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../shared/data/image_assets.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../widgets/mula_text_field.dart';
import '../widgets/or_divider.dart';
import '../widgets/social_login_button.dart';
import 'otp_verification_screen.dart';

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
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
        appBar: MulaAppBarHelpers.withProgress(
          title: context.localize.letsGetYouStarted,
          currentStep: 1,
          totalSteps: 11,
          progressColor: AppColors.appPrimary.withValues(alpha: 0.7),
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
                AppText.smaller(
                  context.localize.createFreeAccountDescription,
                  color: AppColors.secondaryText(context),
                ),
                const AppSpacer.vLarge(),
                MulaTextField(
                  controller: _fullNameController,
                  labelText: context.localize.fullName,
                  hintText: context.localize.enterYourFullName,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  suffixIcon: Icon(
                    IconlyLight.profile,
                    color: AppColors.hintText(context),
                    size: 20,
                  ),
                ),
                const AppSpacer.vShort(),
                MulaTextField(
                  controller: _emailController,
                  labelText: context.localize.emailAddress,
                  hintText: context.localize.enterYourEmailAddress,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: Icon(
                    IconlyLight.message,
                    color: AppColors.hintText(context),
                    size: 20,
                  ),
                ),
                const AppSpacer.vShort(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.localize.enterYourPhoneNumber,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: context.responsiveFontSize(mobile: 14),
                      ),
                    ),
                    SizedBox(height: context.responsiveSpacing(mobile: 8)),
                    IntlPhoneField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: TextStyle(
                          color: AppColors.hintText(context),
                          fontSize: context.responsiveFontSize(mobile: 13),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.border(context)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.border(context)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.hintText(context)),
                        ),
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: context.responsiveSpacing(mobile: 16),
                          vertical: 10,
                        ),
                        counterText: '',
                      ),

                      initialCountryCode: 'GH',
                      countries: countries
                          .where((country) => country.code == 'GH')
                          .toList(),
                      keyboardType: TextInputType.number,
                      showCountryFlag: true,
                      showDropdownIcon: false,
                      disableLengthCheck: false,
                      onCountryChanged: (country) {},
                      onChanged: (phone) {},
                      flagsButtonPadding: EdgeInsets.only(
                        left: context.responsiveSpacing(mobile: 16),
                      ),
                      showCursor: true,
                      autovalidateMode: AutovalidateMode.disabled,
                    ),
                  ],
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
                const AppSpacer.vShort(),
                MulaTextField(
                  controller: _confirmPasswordController,
                  labelText: context.localize.confirmPassword,
                  hintText: context.localize.enterYourPassword,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    iconSize: 20,
                    icon: Icon(
                      color: AppColors.hintText(context),
                      _obscureConfirmPassword
                          ? IconlyLight.hide
                          : IconlyLight.show,
                    ),
                    onPressed: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    ),
                  ),
                ),
                const AppSpacer.vLarge(),
                AppButton(
                  text: context.localize.createAccount,
                  backgroundColor: AppColors.appPrimary,
                  textColor: Colors.white,
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  onTap: () {
                    NavigationHelper.navigateTo(
                      context,
                      const OtpVerificationScreen(),
                    );
                  },
                ),
                const AppSpacer.vShort(),
                OrDivider(
                  text: context.localize.or,
                  dividerColor: AppColors.lightGrey(context),
                ),
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
                    TextSpan(
                      text: '${context.localize.byContinuingYouAgree} ',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.secondaryText(context),
                      ),
                    ),
                    TextSpan(
                      text: context.localize.termsOfService,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appPrimary,
                      ),
                    ),
                    TextSpan(
                      text: ' ${context.localize.and} ',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.secondaryText(context),
                      ),
                    ),
                    TextSpan(
                      text: context.localize.privacyPolicy,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appPrimary,
                      ),
                    ),
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
