import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/confetti_success_screen.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../widgets/mula_text_field.dart';
import 'sign_in_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement password reset logic
      // Navigate to confetti success screen
      NavigationHelper.navigateTo(
        context,
        ConfettiSuccessScreen(
          title: context.localize.passwordResetSuccessful,
          description: context.localize.passwordResetSuccessDescription,
          primaryButtonText: context.localize.signIn,
          onPrimaryButtonTap: () {
            // Navigate to sign in and remove all previous routes
            NavigationHelper.navigateToAndRemoveUntil(
              context,
              const SignInScreen(),
            );
          },
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
          title: context.localize.createNewPassword,
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
                  context.localize.createNewPasswordDescription,
                  color: AppColors.secondaryText(context),
                ),
                const AppSpacer.vLarge(),
                MulaTextField(
                  controller: _newPasswordController,
                  labelText: context.localize.newPassword,
                  hintText: context.localize.enterNewPassword,
                  obscureText: _obscureNewPassword,
                  suffixIcon: IconButton(
                    iconSize: 20,
                    icon: Icon(
                      color: AppColors.hintText(context),
                      _obscureNewPassword ? IconlyLight.hide : IconlyLight.show,
                    ),
                    onPressed: () => setState(
                      () => _obscureNewPassword = !_obscureNewPassword,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const AppSpacer.vShort(),
                MulaTextField(
                  controller: _confirmPasswordController,
                  labelText: context.localize.confirmNewPassword,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const AppSpacer.vLarger(),
                AppButton(
                  text: context.localize.resetPassword,
                  backgroundColor: AppColors.appPrimary,
                  textColor: Colors.white,
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  onTap: _resetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
