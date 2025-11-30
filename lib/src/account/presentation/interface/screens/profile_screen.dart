import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/single_category_selector.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../authentication/presentation/interface/widgets/mula_text_field.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../mixins/profile_image_mixin.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with ProfileImageMixin {
  bool _isEditing = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _residentialAddressController =
      TextEditingController();
  final TextEditingController _gpsAddressController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDate;

  final List<String> _genders = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserProfile();
    });
  }

  void _loadUserProfile() {
    final dashboardProvider = context.read<DashboardProvider>();
    final profile = dashboardProvider.userProfile;

    if (profile != null) {
      setState(() {
        _firstNameController.text = profile['firstName'] ?? '';
        _lastNameController.text = profile['lastName'] ?? '';
        _emailController.text = profile['email'] ?? '';
        _phoneController.text = profile['phone'] ?? '';
        _dobController.text = profile['dateOfBirth'] ?? '';
        _selectedGender = profile['gender'];
        _residentialAddressController.text =
            profile['residentialAddress'] ?? '';
        _gpsAddressController.text = profile['gpsAddress'] ?? '';
        _occupationController.text = profile['occupation'] ?? '';
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _residentialAddressController.dispose();
    _gpsAddressController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _showDatePicker() {
    if (!_isEditing) return;

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: AppColors.surface(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    onPressed: () => NavigationHelper.navigateBack(context),
                    child: Text(context.localize.done),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate ?? DateTime.now(),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                      _dobController.text =
                          '${newDate.day.toString().padLeft(2, '0')}/${newDate.month.toString().padLeft(2, '0')}/${newDate.year}';
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

  void _onSave() {
    // TODO: Implement save functionality
    setState(() {
      _isEditing = false;
    });
  }

  String _getInitial() {
    if (_firstNameController.text.isNotEmpty) {
      return _firstNameController.text[0].toUpperCase();
    }
    return 'U';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MulaAppBarHelpers.withActions(
          title: context.localize.profile,
          actions: [
            AppBarActions.textButton(
              text: _isEditing ? context.localize.save : context.localize.edit,
              onPressed: _isEditing ? _onSave : _toggleEditMode,
              context: context,
              textColor: AppColors.appPrimary,
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: context.responsivePadding(
              mobile: const EdgeInsets.all(16.0),
            ),
            children: [
              // Profile Avatar
              Center(
                child: Stack(
                  children: [
                    Consumer<DashboardProvider>(
                      builder: (context, dashboardProvider, _) {
                        final profileImageUrl =
                            dashboardProvider.userProfile?['profileImage'];

                        return Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.appPrimary.withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                            image: localProfileImage != null
                                ? DecorationImage(
                                    image: FileImage(localProfileImage!),
                                    fit: BoxFit.cover,
                                  )
                                : (profileImageUrl != null
                                    ? DecorationImage(
                                        image: NetworkImage(profileImageUrl),
                                        fit: BoxFit.cover,
                                      )
                                    : null),
                          ),
                          child: localProfileImage == null &&
                                  profileImageUrl == null
                              ? Center(
                                  child: AppText.large(
                                    _getInitial(),
                                    style: TextStyle(
                                      color: AppColors.white(context),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : null,
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: handleProfileImageTap,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColors.appPrimary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.card(context),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Iconsax.more,
                            size: 16,
                            color: AppColors.white(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const AppSpacer.vLarge(),

              // Basic Information Section
              AppText.medium(
                context.localize.basicInformation,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: context.primaryTextColor,
                ),
              ),
              const AppSpacer.vShort(),

              // First Name & Last Name Row
              Row(
                children: [
                  Expanded(
                    child: MulaTextField(
                      controller: _firstNameController,
                      labelText: context.localize.firstName,
                      readOnly: !_isEditing,
                      fillColor: _isEditing
                          ? null
                          : AppColors.lightGrey(context).withValues(alpha: 0.3),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MulaTextField(
                      controller: _lastNameController,
                      labelText: context.localize.lastName,
                      readOnly: !_isEditing,
                      fillColor: _isEditing
                          ? null
                          : AppColors.lightGrey(context).withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
              const AppSpacer.vShort(),

              // Email
              MulaTextField(
                controller: _emailController,
                labelText: context.localize.emailAddress,
                keyboardType: TextInputType.emailAddress,
                readOnly: !_isEditing,
                fillColor: _isEditing
                    ? null
                    : AppColors.lightGrey(context).withValues(alpha: 0.3),
                suffixIcon: Icon(
                  IconlyLight.message,
                  color: AppColors.hintText(context),
                  size: 20,
                ),
              ),
              const AppSpacer.vShort(),

              // Phone Number
              MulaTextField(
                controller: _phoneController,
                labelText: context.localize.phoneNumber,
                keyboardType: TextInputType.phone,
                readOnly: !_isEditing,
                fillColor: _isEditing
                    ? null
                    : AppColors.lightGrey(context).withValues(alpha: 0.3),
                suffixIcon: Icon(
                  IconlyLight.message,
                  color: AppColors.hintText(context),
                  size: 20,
                ),
              ),
              const AppSpacer.vLarge(),

              // Other Information Section
              AppText.medium(
                context.localize.otherInformation,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: context.primaryTextColor,
                ),
              ),
              const AppSpacer.vShort(),

              // Date of Birth
              MulaTextField(
                controller: _dobController,
                labelText: context.localize.dateOfBirth,
                readOnly: true,
                onTap: _showDatePicker,
                fillColor: _isEditing
                    ? null
                    : AppColors.lightGrey(context).withValues(alpha: 0.3),
                suffixIcon: Icon(
                  IconlyLight.calendar,
                  color: AppColors.hintText(context),
                  size: 20,
                ),
              ),
              const AppSpacer.vShort(),

              // Gender
              if (_isEditing)
                SingleCategorySelector(
                  title: context.localize.gender,
                  hintText: context.localize.selectGender,
                  options: _genders,
                  selectedOption: _selectedGender,
                  onSelectionChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                )
              else
                _buildReadOnlyField(
                  label: context.localize.gender,
                  value: _selectedGender ?? '',
                ),
              const AppSpacer.vShort(),

              // Residential Address
              MulaTextField(
                controller: _residentialAddressController,
                labelText: context.localize.residentialAddress,
                readOnly: !_isEditing,
                fillColor: _isEditing
                    ? null
                    : AppColors.lightGrey(context).withValues(alpha: 0.3),
              ),
              const AppSpacer.vShort(),

              // GPS Address
              MulaTextField(
                controller: _gpsAddressController,
                labelText: context.localize.gpsAddress,
                readOnly: !_isEditing,
                fillColor: _isEditing
                    ? null
                    : AppColors.lightGrey(context).withValues(alpha: 0.3),
              ),
              const AppSpacer.vShort(),

              // Occupation
              MulaTextField(
                controller: _occupationController,
                labelText: context.localize.occupation,
                readOnly: !_isEditing,
                fillColor: _isEditing
                    ? null
                    : AppColors.lightGrey(context).withValues(alpha: 0.3),
              ),
              const AppSpacer.vLarger(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.secondaryText(context),
            fontSize: context.responsiveFontSize(mobile: 14),
          ),
        ),
        SizedBox(height: context.responsiveSpacing(mobile: 8)),
        Container(
          width: double.infinity,
          padding: context.responsivePadding(
            mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          decoration: BoxDecoration(
            color: AppColors.lightGrey(context).withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border(context)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value.isEmpty ? '-' : value,
                style: TextStyle(
                  color: AppColors.black(context),
                  fontSize: context.responsiveFontSize(mobile: 14),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.hintText(context),
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
