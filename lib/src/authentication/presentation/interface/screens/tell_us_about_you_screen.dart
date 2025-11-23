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
import 'id_verification_type_screen.dart';

class TellUsAboutYouScreen extends StatefulWidget {
  const TellUsAboutYouScreen({super.key});

  @override
  State<TellUsAboutYouScreen> createState() => _TellUsAboutYouScreenState();
}

class _TellUsAboutYouScreenState extends State<TellUsAboutYouScreen> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _residentialAddressController =
      TextEditingController();
  final TextEditingController _gpsAddressController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _dobController.dispose();
    _residentialAddressController.dispose();
    _gpsAddressController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  void _showDatePicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              // Done button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    onPressed: () => NavigationHelper.navigateBack(context),
                    child: const Text('Done'),
                  ),
                ],
              ),
              // Date picker
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate ?? DateTime.now(),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                      _dobController.text =
                          '${newDate.day.toString().padLeft(2, '0')}-${newDate.month.toString().padLeft(2, '0')}-${newDate.year}';
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onContinue() {
    // TODO: Validate inputs
    NavigationHelper.navigateTo(context, const IdVerificationTypeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MulaAppBarHelpers.withProgress(
          title: context.localize.tellUsAboutYou,
          currentStep: 5,
          totalSteps: 11,
          progressColor: AppColors.appPrimary.withValues(alpha: 0.7),
          onBackPressed: () => Navigator.pop(context),
        ),
        body: SafeArea(
          child: ListView(
            padding: context.responsivePadding(
              mobile: const EdgeInsets.all(16.0),
            ),
            children: [
              AppText.smaller(
                context.localize.tellUsAboutYouDescription,
                color: AppColors.secondaryText(context),
              ),
              const AppSpacer.vLarge(),
              // Date of Birth
              MulaTextField(
                controller: _dobController,
                labelText: context.localize.dateOfBirth,
                hintText: context.localize.selectDate,
                readOnly: true,
                onTap: _showDatePicker,
                suffixIcon: Icon(
                  IconlyLight.calendar,
                  color: AppColors.hintText(context),
                  size: 20,
                ),
              ),
              const AppSpacer.vShort(),
              // Gender
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.localize.gender,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: context.responsiveFontSize(mobile: 14),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: context.responsiveSpacing(mobile: 12)),
                  Row(
                    children: [
                      // Male Option
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedGender = 'male'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedGender == 'male'
                                  ? AppColors.appPrimary.withValues(alpha: 0.1)
                                  : AppColors.offWhite(context),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedGender == 'male'
                                    ? AppColors.appPrimary
                                    : AppColors.border(context),
                                width: _selectedGender == 'male' ? 0.6 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.male,
                                  color: _selectedGender == 'male'
                                      ? AppColors.appPrimary
                                      : AppColors.darkGrey(context),
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  context.localize.male,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontSize(
                                      mobile: 15,
                                    ),
                                    color: _selectedGender == 'male'
                                        ? AppColors.appPrimary
                                        : AppColors.defaultText(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Female Option
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedGender = 'female'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedGender == 'female'
                                  ? AppColors.appPrimary.withValues(alpha: 0.1)
                                  : AppColors.offWhite(context),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedGender == 'female'
                                    ? AppColors.appPrimary
                                    : AppColors.border(context),
                                width: _selectedGender == 'female' ? 0.6 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.female,
                                  color: _selectedGender == 'female'
                                      ? AppColors.appPrimary
                                      : AppColors.darkGrey(context),
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  context.localize.female,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontSize(
                                      mobile: 15,
                                    ),
                                    color: _selectedGender == 'female'
                                        ? AppColors.appPrimary
                                        : AppColors.defaultText(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const AppSpacer.vShort(),
              // Residential Address
              MulaTextField(
                controller: _residentialAddressController,
                labelText: context.localize.residentialAddress,
                hintText: context.localize.enterResidentialAddress,
                suffixIcon: Icon(
                  IconlyLight.location,
                  color: AppColors.hintText(context),
                  size: 20,
                ),
              ),
              const AppSpacer.vShort(),
              // GPS Address
              MulaTextField(
                controller: _gpsAddressController,
                labelText: context.localize.gpsAddress,
                hintText: context.localize.enterGpsAddress,
                suffixIcon: Icon(
                  IconlyLight.discovery,
                  color: AppColors.hintText(context),
                  size: 20,
                ),
              ),
              const AppSpacer.vShort(),
              // Occupation
              MulaTextField(
                controller: _occupationController,
                labelText: context.localize.occupation,
                hintText: context.localize.whatIsYourOccupation,
                suffixIcon: Icon(
                  IconlyLight.work,
                  color: AppColors.hintText(context),
                  size: 20,
                ),
              ),
              const AppSpacer.vLarger(),
              // Continue Button
              AppButton(
                text: context.localize.continueButton,
                backgroundColor: AppColors.appPrimary,
                textColor: Colors.white,
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
