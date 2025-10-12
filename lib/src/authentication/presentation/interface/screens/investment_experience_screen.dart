import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/selectable_option_card.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import 'good_hands_info_screen.dart';

class InvestmentExperienceScreen extends StatefulWidget {
  const InvestmentExperienceScreen({super.key});

  @override
  State<InvestmentExperienceScreen> createState() =>
      _InvestmentExperienceScreenState();
}

class _InvestmentExperienceScreenState
    extends State<InvestmentExperienceScreen> {
  String? _selectedLevel;

  void _onContinue() {
    if (_selectedLevel != null) {
      NavigationHelper.navigateTo(context, const GoodHandsInfoScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      appBar: MulaAppBarHelpers.withProgress(
        backgroundColor: AppColors.white(context),
        title: context.localize.investmentExperience,
        currentStep: 8,
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
              AppText.smaller(
                context.localize.investmentExperienceDescription,
                color: AppColors.secondaryText(context),
              ),
              const AppSpacer.vLarge(),
              // Beginner option
              SelectableOptionCard(
                value: 'beginner',
                selectedValue: _selectedLevel,
                title: context.localize.beginner,
                description: context.localize.beginnerDescription,
                onTap: () => setState(() => _selectedLevel = 'beginner'),
              ),
              const AppSpacer.vShort(),
              // Intermediate option
              SelectableOptionCard(
                value: 'intermediate',
                selectedValue: _selectedLevel,
                title: context.localize.intermediate,
                description: context.localize.intermediateDescription,
                onTap: () => setState(() => _selectedLevel = 'intermediate'),
              ),
              const AppSpacer.vShort(),
              // Advanced option
              SelectableOptionCard(
                value: 'advanced',
                selectedValue: _selectedLevel,
                title: context.localize.advanced,
                description: context.localize.advancedDescription,
                onTap: () => setState(() => _selectedLevel = 'advanced'),
              ),
              const Spacer(),
              // Continue Button
              AppButton(
                text: context.localize.continueButton,
                backgroundColor: _selectedLevel != null
                    ? AppColors.appPrimary
                    : AppColors.lightGrey(context),
                textColor: _selectedLevel != null
                    ? Colors.white
                    : AppColors.secondaryText(context),
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: _onContinue,
              ),
              const AppSpacer.vLarge(),
            ],
          ),
        ),
      ),
    );
  }
}
