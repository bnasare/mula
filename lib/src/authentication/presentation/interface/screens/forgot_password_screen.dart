import 'package:flutter/cupertino.dart';
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPhoneNumber = false;
  final TextEditingController _emailOrPhoneController = TextEditingController();

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    super.dispose();
  }

  void _sendVerificationCode() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement send verification code logic
      NavigationHelper.navigateTo(
        context,
        const OtpVerificationScreen.forgotPassword(),
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
          title: context.localize.resetYourPassword,
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
                  context.localize.resetPasswordDescription,
                  color: AppColors.secondaryText(context),
                ),
                const AppSpacer.vLarge(),
                // Toggle between Phone number and Email address
                Row(
                  children: [
                    AppText.smaller(
                      context.localize.phoneNumber,
                      style: TextStyle(
                        color: _isPhoneNumber
                            ? AppColors.appPrimary
                            : AppColors.secondaryText(context),
                      ),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        value: !_isPhoneNumber,
                        activeTrackColor: AppColors.appPrimary,
                        onChanged: (value) {
                          setState(() => _isPhoneNumber = !value);
                        },
                      ),
                    ),
                    const SizedBox(width: 0),
                    AppText.smaller(
                      context.localize.emailAddress,
                      style: TextStyle(
                        color: !_isPhoneNumber
                            ? AppColors.appPrimary
                            : AppColors.secondaryText(context),
                      ),
                    ),
                  ],
                ),
                const AppSpacer.vLarge(),
                MulaTextField(
                  controller: _emailOrPhoneController,
                  labelText: _isPhoneNumber
                      ? context.localize.phoneNumber
                      : context.localize.emailAddress,
                  hintText: _isPhoneNumber
                      ? context.localize.enterYourPhoneNumber
                      : context.localize.enterYourEmailAddress,
                  keyboardType: _isPhoneNumber
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
                  suffixIcon: Icon(
                    _isPhoneNumber ? IconlyLight.call : IconlyLight.message,
                    color: Colors.grey.shade400,
                    size: 20,
                ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _isPhoneNumber
                          ? 'Please enter your phone number'
                          : 'Please enter your email address';
                    }
                    return null;
                  },
                ),
                const AppSpacer.vLarger(),
                AppButton(
                  text: context.localize.sendVerificationCode,
                  backgroundColor: AppColors.appPrimary,
                  textColor: Colors.white,
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  onTap: _sendVerificationCode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
