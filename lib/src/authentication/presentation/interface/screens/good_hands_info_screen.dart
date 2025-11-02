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
import 'select_fund_manager_screen.dart';

class GoodHandsInfoScreen extends StatelessWidget {
  final bool isCisFlow;
  final bool useNormalAppBar;

  const GoodHandsInfoScreen({
    super.key,
    this.isCisFlow = false,
    this.useNormalAppBar = false,
  });

  /// Constructor for CIS account flow
  const GoodHandsInfoScreen.cisFlow({super.key})
    : isCisFlow = true,
      useNormalAppBar = false;

  /// Constructor for CSD account flow (from brokers)
  const GoodHandsInfoScreen.fromCsd({super.key})
    : isCisFlow = false,
      useNormalAppBar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      appBar: useNormalAppBar || isCisFlow
          ? MulaAppBarHelpers.simple(
              backgroundColor: AppColors.white(context),
              onBackPressed: () => Navigator.pop(context),
              title: '',
            )
          : MulaAppBarHelpers.withProgress(
              backgroundColor: AppColors.white(context),
              title: 'Almost There',
              currentStep: 9,
              totalSteps: 11,
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
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
              const AppSpacer.vShort(),
              // Description
              AppText.smaller(
                context.localize.goodHandsDescription,
                color: AppColors.secondaryText(context),
              ),
              const AppSpacer.vLarge(),
              // "Here's what you can expect:" header
              AppText.smaller(
                context.localize.hereIsWhatYouCanExpect,
                color: AppColors.black(context),
              ),
              const AppSpacer.vShort(),
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
              // Buttons - different for CIS flow
              if (isCisFlow)
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: context.localize.addAnother,
                        backgroundColor: AppColors.white(context),
                        textColor: AppColors.black(context),
                        borderRadius: 12,
                        padding: EdgeInsets.zero,
                        borderColor: AppColors.lightGrey(context),
                        onTap: () {
                          // Navigate back to Select Fund Manager screen
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SelectFundManagerScreen(),
                            ),
                            (route) => route.isFirst,
                          );
                        },
                      ),
                    ),
                    const AppSpacer.hShort(),
                    Expanded(
                      child: AppButton(
                        text: context.localize.done,
                        backgroundColor: AppColors.appPrimary,
                        textColor: Colors.white,
                        borderRadius: 12,
                        padding: EdgeInsets.zero,
                        onTap: () {
                          // Do nothing as requested
                        },
                      ),
                    ),
                  ],
                )
              else
                AppButton(
                  text: context.localize.continueButton,
                  backgroundColor: AppColors.appPrimary,
                  textColor: Colors.white,
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  onTap: () {
                    // Only navigate if not from CSD flow
                    if (!useNormalAppBar) {
                      NavigationHelper.navigateTo(
                        context,
                        const LinkInvestmentAccountsScreen(),
                      );
                    }
                    // Do nothing for CSD flow
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
        Expanded(child: AppText.smaller(text, color: AppColors.black(context))),
      ],
    );
  }
}
