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
import 'id_verification_upload_screen.dart';

class IdVerificationTypeScreen extends StatefulWidget {
  const IdVerificationTypeScreen({super.key});

  @override
  State<IdVerificationTypeScreen> createState() =>
      _IdVerificationTypeScreenState();
}

class _IdVerificationTypeScreenState extends State<IdVerificationTypeScreen> {
  String? _selectedIdType;

  void _onContinue() {
    if (_selectedIdType != null) {
      NavigationHelper.navigateTo(
        context,
        IdVerificationUploadScreen(idType: _selectedIdType!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBarHelpers.withProgress(
        title: context.localize.idVerification,
        currentStep: 6,
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
                context.localize.selectIdType,
                color: AppColors.secondaryText(context),
              ),
              const AppSpacer.vLarge(),
              // Ghana Card option
              SelectableOptionCard(
                value: 'ghana_card',
                selectedValue: _selectedIdType,
                title: context.localize.ghanaCard,
                onTap: () => setState(() => _selectedIdType = 'ghana_card'),
              ),
              const AppSpacer.vShort(),
              // Driver's License option
              SelectableOptionCard(
                value: 'drivers_license',
                selectedValue: _selectedIdType,
                title: context.localize.driversLicense,
                onTap: () =>
                    setState(() => _selectedIdType = 'drivers_license'),
              ),
              const AppSpacer.vShort(),
              // Passport option
              SelectableOptionCard(
                value: 'passport',
                selectedValue: _selectedIdType,
                title: context.localize.passport,
                onTap: () => setState(() => _selectedIdType = 'passport'),
              ),
              const Spacer(),
              // Continue Button
              AppButton(
                text: context.localize.continueButton,
                backgroundColor: _selectedIdType != null
                    ? AppColors.appPrimary
                    : AppColors.lightGrey(context),
                textColor: _selectedIdType != null
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
