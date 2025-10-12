import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

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
import 'enter_pin_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MulaAppBarHelpers.simple(
          backgroundColor: AppColors.white(context),
          title: context.localize.accessYourMulaAccount,
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
                  context.localize.signInToYourAccount,
                  color: AppColors.secondaryText(context),
                ),
                const AppSpacer.vLarge(),
                MulaTextField(
                  controller: _emailOrPhoneController,
                  labelText: context.localize.emailOrPhone,
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
                const AppSpacer.vShort(),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Navigate to forgot password screen
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      context.localize.forgotPassword,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.appPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const AppSpacer.vLarge(),
                AppButton(
                  text: context.localize.signIn,
                  backgroundColor: AppColors.appPrimary,
                  textColor: Colors.white,
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  onTap: () {
                    NavigationHelper.navigateTo(
                      context,
                      const EnterPinScreen(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.small(
                      '${context.localize.dontHaveAccount} ',
                      color: AppColors.secondaryText(context),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationHelper.navigateTo(
                          context,
                          const SignUpScreen(),
                        );
                      },
                      child: Text(
                        context.localize.signUp,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.appPrimary,
                          fontWeight: FontWeight.w600,
                        ),
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
