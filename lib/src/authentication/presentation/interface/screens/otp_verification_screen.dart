import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/otp_input_widget.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import 'enable_face_id_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool _isPhoneNumber = false;
  String _otpCode = '';
  Timer? _timer;
  int _remainingSeconds = 12;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _remainingSeconds = 12);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  void _resendCode() {
    // TODO: Implement resend logic
    _startTimer();
  }

  void _verifyOtp() {
    if (_otpCode.length == 6) {
      // TODO: Implement verification logic
      print('Verifying OTP: $_otpCode');
      // Navigate to Enable Face ID screen
      NavigationHelper.navigateTo(context, const EnableFaceIdScreen());
    }
  }

  String get _formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white(context),
        appBar: MulaAppBarHelpers.withProgress(
          backgroundColor: AppColors.white(context),
          title: context.localize.otpVerification,
          currentStep: 2,
          totalSteps: 5,
          progressColor: AppColors.appPrimary.withValues(alpha: 0.7),
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
                AppText.small(
                  context.localize.enterVerificationCode,
                  color: AppColors.secondaryText(context),
                  padding: EdgeInsets.only(
                    top: context.responsiveValue(mobile: 8.0),
                  ),
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
                // OTP Input Widget
                OTPInputWidget(
                  length: 6,
                  onCompleted: (code) {
                    setState(() => _otpCode = code);
                  },
                  onChanged: (code) {
                    setState(() => _otpCode = code);
                  },
                ),
                const AppSpacer.vLarge(),
                // Timer
                AppText.smaller(
                  _formattedTime,
                  color: AppColors.secondaryText(context),
                ),
                const AppSpacer.vLarger(),
                // Verify Button
                AppButton(
                  text: context.localize.verify,
                  backgroundColor: _otpCode.length == 6
                      ? AppColors.appPrimary
                      : AppColors.lightGrey(context),
                  textColor: _otpCode.length == 6
                      ? Colors.white
                      : AppColors.secondaryText(context),
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  onTap: _verifyOtp,
                ),
                const AppSpacer.vShort(),
                // Resend Code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.smaller(
                      '${context.localize.didntReceiveCode} ',
                      color: AppColors.secondaryText(context),
                    ),
                    GestureDetector(
                      onTap: _remainingSeconds == 0 ? _resendCode : null,
                      child: AppText.smaller(
                        context.localize.resend,
                        style: TextStyle(
                          color: _remainingSeconds == 0
                              ? AppColors.appPrimary
                              : AppColors.secondaryText(context),
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
