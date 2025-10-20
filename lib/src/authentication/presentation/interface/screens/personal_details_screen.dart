import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/single_category_selector.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../widgets/mula_text_field.dart';
import 'create_account_identification_details_screen.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _emergencyNumberController =
      TextEditingController();

  String? _selectedNationality;
  DateTime? _selectedDate;

  // Nationalities with emojis
  final List<String> _nationalities = [
    '🇬🇭 Ghanaian',
    '🇳🇬 Nigerian',
    '🇿🇦 South African',
    '🇰🇪 Kenyan',
    '🇺🇸 American',
    '🇬🇧 British',
    '🇨🇦 Canadian',
    '🇫🇷 French',
    '🇩🇪 German',
    '🇮🇹 Italian',
    '🇪🇸 Spanish',
    '🇨🇳 Chinese',
    '🇯🇵 Japanese',
    '🇮🇳 Indian',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _dobController.dispose();
    _occupationController.dispose();
    _emergencyNumberController.dispose();
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
    NavigationHelper.navigateTo(
      context,
      const CreateAccountIdentificationDetailsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white(context),
        appBar: MulaAppBarHelpers.withProgress(
          backgroundColor: AppColors.white(context),
          title: context.localize.personalDetails,
          currentStep: 2,
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
                context.localize.personalDetailsDescription,
                color: AppColors.secondaryText(context),
              ),
              const AppSpacer.vLarge(),
              // Full Name
              MulaTextField(
                controller: _fullNameController,
                labelText: context.localize.fullName,
                hintText: context.localize.enterYourFullName,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                suffixIcon: Icon(
                  IconlyLight.profile,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
              ),
              const AppSpacer.vShort(),
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
              // Nationality
              SingleCategorySelector(
                title: context.localize.nationality,
                hintText: context.localize.selectNationality,
                options: _nationalities,
                selectedOption: _selectedNationality,
                onSelectionChanged: (value) {
                  setState(() {
                    _selectedNationality = value;
                  });
                },
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
              const AppSpacer.vShort(),
              // Emergency Number
              MulaTextField(
                controller: _emergencyNumberController,
                labelText: context.localize.emergencyNumber,
                hintText: context.localize.enterEmergencyNumber,
                keyboardType: TextInputType.phone,
                suffixIcon: Icon(
                  IconlyLight.call,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
              ),
              const AppSpacer.vLarger(),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(
              text: context.localize.continueButton,
              backgroundColor: AppColors.appPrimary,
              textColor: Colors.white,
              borderRadius: 12,
              padding: EdgeInsets.all(0),
              onTap: _onContinue,
            ),
          ),
        ),
      ),
    );
  }
}
