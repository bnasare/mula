import 'package:flutter/material.dart';

import '../../../../../shared/data/image_assets.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../authentication/presentation/interface/screens/sign_up_screen.dart';
import '../../bloc/onboarding_mixin.dart';

class OnboardingScreen extends StatefulWidget with OnboardingMixin {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void _getStarted() {
    // widget.completeOnboardingChecks();
    NavigationHelper.navigateToReplacement(context, const SignUpScreen());
  }

  void _signIn() {
    // TODO: Navigate to Sign In screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Trading/Investment illustration
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  ImageAssets.onboarding,
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),

              const AppSpacer.vLarger(),

              // Welcome text
              AppText.rich(
                align: TextAlign.center,
                children: [
                  TextSpan(
                    text: '${context.localize.welcomeTo} ',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: context.localize.mula,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.appPrimary,
                    ),
                  ),
                ],
              ),

              const AppSpacer.vShort(),

              // Subtitle
              AppText.small(
                context.localize.oneAppAllInvestments,
                align: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.black(context),
                ),
              ),

              const AppSpacer.vShort(),

              // Description
              AppText.smaller(
                context.localize.onboardingDescription,
                align: TextAlign.center,
                color: AppColors.secondaryText(context),
              ),

              const Spacer(flex: 1),

              // Get Started Button
              AppButton(
                text: context.localize.getStarted,
                backgroundColor: AppColors.appPrimary,
                textColor: Colors.white,
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: _getStarted,
              ),

              const AppSpacer.vShort(),

              // Sign In Link
              AppText.rich(
                align: TextAlign.center,
                children: [
                  TextSpan(
                    text: '${context.localize.alreadyHaveAccount} ',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryText(context),
                    ),
                  ),
                  TextSpan(
                    text: context.localize.signIn,
                    style: const TextStyle(
                      fontSize: 14,
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
    );
  }
}
