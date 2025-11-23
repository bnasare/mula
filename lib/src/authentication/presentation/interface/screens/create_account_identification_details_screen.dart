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
import 'bank_details_screen.dart';

class CreateAccountIdentificationDetailsScreen extends StatefulWidget {
  const CreateAccountIdentificationDetailsScreen({super.key});

  @override
  State<CreateAccountIdentificationDetailsScreen> createState() =>
      _CreateAccountIdentificationDetailsScreenState();
}

class _CreateAccountIdentificationDetailsScreenState
    extends State<CreateAccountIdentificationDetailsScreen> {
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _issueDateController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  DateTime? _selectedIssueDate;
  DateTime? _selectedExpiryDate;
  String? _frontImagePath;
  String? _backImagePath;

  @override
  void dispose() {
    _idNumberController.dispose();
    _issueDateController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  void _showDatePicker({required bool isIssueDate}) {
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
                  initialDateTime: isIssueDate
                      ? (_selectedIssueDate ??
                            DateTime.now().subtract(const Duration(days: 365)))
                      : (_selectedExpiryDate ??
                            DateTime.now().add(const Duration(days: 365))),
                  maximumDate: isIssueDate ? DateTime.now() : null,
                  minimumDate: isIssueDate
                      ? DateTime(1900)
                      : DateTime.now().add(const Duration(days: 1)),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      if (isIssueDate) {
                        _selectedIssueDate = newDate;
                        _issueDateController.text =
                            'Eg: ${newDate.day.toString().padLeft(2, '0')}-${newDate.month.toString().padLeft(2, '0')}-${newDate.year}';
                      } else {
                        _selectedExpiryDate = newDate;
                        _expiryDateController.text =
                            'Eg: ${newDate.day.toString().padLeft(2, '0')}-${newDate.month.toString().padLeft(2, '0')}-${newDate.year}';
                      }
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

  void _pickImage({required bool isFront}) {
    // TODO: Implement image picker
    setState(() {
      if (isFront) {
        _frontImagePath = 'temp_front_path';
      } else {
        _backImagePath = 'temp_back_path';
      }
    });
  }

  void _onSubmit() {
    // TODO: Validate inputs
    NavigationHelper.navigateTo(context, const BankDetailsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MulaAppBarHelpers.withProgress(
          title: context.localize.identificationDetails,
          currentStep: 3,
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
              const AppSpacer.vLarge(),
              // Front picture upload
              _buildUploadArea(
                label: context.localize.pictureOfFront,
                isFront: true,
                hasImage: _frontImagePath != null,
              ),
              const AppSpacer.vShort(),
              // Back picture upload
              _buildUploadArea(
                label: context.localize.pictureOfBack,
                isFront: false,
                hasImage: _backImagePath != null,
              ),
              const AppSpacer.vLarge(),
              // Ghana Card Number
              MulaTextField(
                controller: _idNumberController,
                labelText:
                    '${context.localize.ghanaCard} ${context.localize.number}',
                hintText: 'Eg: GHA-2346-250234',
                suffixIcon: Icon(
                  IconlyLight.paper,
                  color: AppColors.hintText(context),
                  size: 20,
                ),
              ),
              const AppSpacer.vShort(),
              // Issue date
              MulaTextField(
                controller: _issueDateController,
                labelText: context.localize.issueDate,
                hintText: 'Eg: 15-12-2025',
                readOnly: true,
                onTap: () => _showDatePicker(isIssueDate: true),
                suffixIcon: Icon(
                  IconlyLight.calendar,
                  color: AppColors.hintText(context),
                  size: 20,
                ),
              ),
              const AppSpacer.vShort(),
              // Expiry date
              MulaTextField(
                controller: _expiryDateController,
                labelText: context.localize.expiryDate,
                hintText: 'Eg: 15-12-2029',
                readOnly: true,
                onTap: () => _showDatePicker(isIssueDate: false),
                suffixIcon: Icon(
                  IconlyLight.calendar,
                  color: AppColors.hintText(context),
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
              text: context.localize.submit,
              backgroundColor: AppColors.appPrimary,
              textColor: Colors.white,
              borderRadius: 12,
              padding: const EdgeInsets.all(0),
              onTap: _onSubmit,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadArea({
    required String label,
    required bool isFront,
    required bool hasImage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black54,
            fontSize: context.responsiveFontSize(mobile: 14),
          ),
        ),
        SizedBox(height: context.responsiveSpacing(mobile: 8)),
        GestureDetector(
          onTap: () => _pickImage(isFront: isFront),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(
                color: hasImage ? AppColors.appPrimary : Colors.grey.shade300,
                width: hasImage ? 0.6 : 1,
                style: hasImage ? BorderStyle.solid : BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8),
              color: hasImage
                  ? AppColors.appPrimary.withValues(alpha: 0.05)
                  : AppColors.transparent,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    hasImage ? Icons.check_circle : IconlyLight.upload,
                    color: hasImage
                        ? AppColors.appPrimary
                        : AppColors.appPrimary,
                    size: 32,
                  ),
                  const AppSpacer.vShorter(),
                  AppText.smaller(
                    hasImage
                        ? context.localize.imageUploaded
                        : context.localize.tapToUpload,
                    style: TextStyle(
                      color: hasImage
                          ? AppColors.appPrimary
                          : AppColors.appPrimary,
                    ),
                  ),
                  if (!hasImage) ...[
                    const AppSpacer.vShorter(),
                    AppText.smaller(
                      context.localize.maxSize,
                      color: AppColors.secondaryText(context),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
