import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../shared/data/svg_assets.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/confetti_success_screen.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import 'add_pin_screen.dart';
import 'tell_us_about_you_screen.dart';

class EnableFaceIdScreen extends StatelessWidget {
  const EnableFaceIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      appBar: MulaAppBarHelpers.withProgress(
        backgroundColor: AppColors.white(context),
        title: context.localize.security,
        currentStep: 3,
        totalSteps: 11,
        progressColor: AppColors.appPrimary.withValues(alpha: 0.7),
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(24.0),
          ),
          child: Column(
            children: [
              AppText.small(
                context.localize.enableFaceId,
                color: AppColors.secondaryText(context),
              ),
              const Spacer(),
              // Face ID Icon
              SvgPicture.asset(
                SvgAssets.faceid,
                width: context.responsiveValue(mobile: 120),
                height: context.responsiveValue(mobile: 120),
              ),
              const Spacer(),
              // Enable Button
              AppButton(
                text: context.localize.enable,
                backgroundColor: AppColors.appPrimary,
                textColor: Colors.white,
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: () {
                  // Navigate to Face ID success screen
                  NavigationHelper.navigateTo(
                    context,
                    ConfettiSuccessScreen(
                      title: context.localize.faceIdSuccessfullyAdded,
                      description: context.localize.faceIdSuccessDescription,
                      primaryButtonText: context.localize.createPin,
                      onPrimaryButtonTap: () {
                        // Navigate to Add PIN screen
                        NavigationHelper.navigateTo(
                          context,
                          const AddPinScreen(),
                        );
                      },
                      secondaryButtonText: context.localize.skip,
                      onSecondaryButtonTap: () {
                        // Navigate to Tell Us About You screen
                        NavigationHelper.navigateTo(
                          context,
                          const TellUsAboutYouScreen(),
                        );
                      },
                    ),
                  );
                },
              ),
              const AppSpacer.vLarge(),
            ],
          ),
        ),
      ),
    );
  }
}
