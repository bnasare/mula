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
                    onPressed: () => Navigator.of(context).pop(),
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
        backgroundColor: AppColors.white(context),
        appBar: MulaAppBarHelpers.withProgress(
          backgroundColor: AppColors.white(context),
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
                  color: Colors.grey.shade400,
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
                    ),
                  ),
                  SizedBox(height: context.responsiveSpacing(mobile: 8)),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedGender = 'male'),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'male',
                                  groupValue: _selectedGender,
                                  activeColor: AppColors.appPrimary,
                                  onChanged: (value) =>
                                      setState(() => _selectedGender = value),
                                ),
                                Text(
                                  context.localize.male,
                                  style: TextStyle(
                                    fontSize:
                                        context.responsiveFontSize(mobile: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedGender = 'female'),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'female',
                                  groupValue: _selectedGender,
                                  activeColor: AppColors.appPrimary,
                                  onChanged: (value) =>
                                      setState(() => _selectedGender = value),
                                ),
                                Text(
                                  context.localize.female,
                                  style: TextStyle(
                                    fontSize:
                                        context.responsiveFontSize(mobile: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  color: Colors.grey.shade400,
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
                  IconlyLight.location,
                  color: Colors.grey.shade400,
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
                  color: Colors.grey.shade400,
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
