import 'package:flutter/material.dart';

import '../../../../../shared/data/image_assets.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../authentication/presentation/interface/screens/sign_in_screen.dart';
import '../../../../authentication/presentation/interface/screens/sign_up_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void _getStarted() {
    // widget.completeOnboardingChecks();
    NavigationHelper.navigateTo(context, const SignUpScreen());
  }

  void _signIn() {
    NavigationHelper.navigateTo(context, const SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

              const Spacer(flex: 1),

              // Welcome text
              AppText.rich(
                align: TextAlign.center,
                children: [
                  TextSpan(
                    text: '${context.localize.welcomeTo} ',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: context.localize.mula,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
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
                style: TextStyle(color: AppColors.defaultText(context)),
              ),

              const AppSpacer.vShort(),

              // Description
              AppText.smaller(
                context.localize.onboardingDescription,
                color: AppColors.secondaryText(context),
              ),

              const AppSpacer.vLarger(),

              // Get Started Button
              AppButton(
                text: context.localize.getStarted,
                backgroundColor: AppColors.appPrimary,
                textColor: Colors.white,
                borderRadius: 12,
                padding: EdgeInsets.zero,
                height: 50,
                onTap: _getStarted,
              ),

              const AppSpacer.vShort(),

              // Sign In Link
              Center(
                child: GestureDetector(
                  onTap: _signIn,
                  child: AppText.rich(
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
                ),
              ),

              const AppSpacer.vLarge(),
            ],
          ),
        ),
      ),
    );
  }
}
