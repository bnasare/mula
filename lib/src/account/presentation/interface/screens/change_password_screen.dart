import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../../shared/utils/password_validator.dart';
import '../../../../authentication/presentation/interface/widgets/mula_text_field.dart';
import 'enter_pin_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _currentPinController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _obscureCurrentPin = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentPinController.dispose();
    super.dispose();
  }

  Widget _buildEyeToggle(bool obscured, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        obscured ? IconlyLight.hide : IconlyLight.show,
        color: AppColors.hintText(context),
        size: 20,
      ),
    );
  }

  void _handleUpdatePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      // Mock password update - in production, this would call an API
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: MulaAppBar(
          title: context.localize.changePassword,
          onBackPressed: () => Navigator.pop(context),
        ),
        body: SingleChildScrollView(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(16),
          ),
          child: Form(
            key: _formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Current Password
              MulaTextField(
                controller: _currentPasswordController,
                labelText: context.localize.currentPassword,
                hintText: context.localize.enterCurrentPassword,
                obscureText: _obscureCurrentPassword,
                suffixIcon: _buildEyeToggle(_obscureCurrentPassword, () {
                  setState(() {
                    _obscureCurrentPassword = !_obscureCurrentPassword;
                  });
                }),
                validator: PasswordValidator.validateCurrentPassword,
              ),

              const AppSpacer.vLarge(),

              // New Password
              MulaTextField(
                controller: _newPasswordController,
                labelText: context.localize.newPassword,
                hintText: context.localize.enterNewPassword,
                obscureText: _obscureNewPassword,
                suffixIcon: _buildEyeToggle(_obscureNewPassword, () {
                  setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  });
                }),
                validator: PasswordValidator.validateNewPassword,
                onChanged: (_) {
                  // Clear confirm password validation when new password changes
                  if (_confirmPasswordController.text.isNotEmpty) {
                    _formKey.currentState?.validate();
                  }
                },
              ),

              const AppSpacer.vLarge(),

              // Confirm Password
              MulaTextField(
                controller: _confirmPasswordController,
                labelText: context.localize.confirmNewPassword,
                hintText: context.localize.reEnterNewPassword,
                obscureText: _obscureConfirmPassword,
                suffixIcon: _buildEyeToggle(_obscureConfirmPassword, () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                }),
                validator: (value) => PasswordValidator.validateConfirmPassword(
                  value,
                  _newPasswordController.text,
                ),
              ),

              const AppSpacer.vLarge(),

              // Current PIN
              MulaTextField(
                controller: _currentPinController,
                labelText: context.localize.currentPin,
                hintText: context.localize.enterCurrentPin,
                keyboardType: TextInputType.number,
                obscureText: _obscureCurrentPin,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                suffixIcon: _buildEyeToggle(_obscureCurrentPin, () {
                  setState(() {
                    _obscureCurrentPin = !_obscureCurrentPin;
                  });
                }),
                validator: PasswordValidator.validatePin,
              ),

              const AppSpacer.vShort(),

              // Change PIN link
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    NavigationHelper.navigateTo(
                      context,
                      const EnterPinScreen(isCurrentPin: true),
                    );
                  },
                  child: Text(
                    context.localize.changePin,
                    style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: context.responsiveFontSize(mobile: 14),
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.green,
                    ),
                  ),
                ),
              ),

              const AppSpacer.vLarge(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(16),
          ),
          child: AppButton(
            text: context.localize.updatePassword,
            backgroundColor: AppColors.appPrimary,
            textColor: AppColors.white(context),
            borderRadius: 12,
            padding: EdgeInsets.zero,
            onTap: _handleUpdatePassword,
          ),
        ),
      ),
      ),
    );
  }
}
