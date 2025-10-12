import 'package:flutter/material.dart';

import '../../../../../shared/data/image_assets.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import 'link_investment_accounts_screen.dart';

class GoodHandsInfoScreen extends StatelessWidget {
  const GoodHandsInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      appBar: MulaAppBarHelpers.withProgress(
        backgroundColor: AppColors.white(context),
        title: '',
        currentStep: 9,
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
              const Spacer(),
              // Image from onboarding
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  ImageAssets.onboarding,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const AppSpacer.vLarge(),
              // Title
              AppText.large(
                context.localize.goodHandsTitle,
                align: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const AppSpacer.vShort(),
              // Description
              AppText.smaller(
                context.localize.goodHandsDescription,
                align: TextAlign.center,
                color: AppColors.secondaryText(context),
              ),
              const AppSpacer.vLarge(),
              // Features list
              _buildFeatureItem(
                context,
                icon: Icons.school_outlined,
                text: context.localize.toolsToGrowKnowledge,
              ),
              const AppSpacer.vShort(),
              _buildFeatureItem(
                context,
                icon: Icons.support_agent_outlined,
                text: context.localize.supportWheneverNeeded,
              ),
              const AppSpacer.vShort(),
              _buildFeatureItem(
                context,
                icon: Icons.lightbulb_outline,
                text: context.localize.guidanceToExplore,
              ),
              const AppSpacer.vShort(),
              _buildFeatureItem(
                context,
                icon: Icons.menu_book_outlined,
                text: context.localize.simpleExplanations,
              ),
              const Spacer(),
              // Continue Button
              AppButton(
                text: context.localize.continueButton,
                backgroundColor: AppColors.appPrimary,
                textColor: Colors.white,
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: () {
                  NavigationHelper.navigateTo(
                    context,
                    const LinkInvestmentAccountsScreen(),
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

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.appPrimary,
            shape: BoxShape.circle,
          ),
        ),
        const AppSpacer.hShort(),
        Expanded(
          child: AppText.smaller(
            text,
            color: AppColors.black(context),
          ),
        ),
      ],
    );
  }
}
