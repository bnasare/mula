import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/image_popup.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../authentication/presentation/interface/widgets/mula_text_field.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';

class IdentificationScreen extends StatefulWidget {
  const IdentificationScreen({super.key});

  @override
  State<IdentificationScreen> createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _issueDateController = TextEditingController();

  String? _frontImageUrl =
      'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800';
  String? _backImageUrl;
  String? _frontImageSize = '997KB';
  String? _backImageSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadIdentificationData();
    });
  }

  void _loadIdentificationData() {
    final dashboardProvider = context.read<DashboardProvider>();
    final profile = dashboardProvider.userProfile;

    if (profile != null) {
      setState(() {
        _cardNumberController.text = profile['ghanaCardNumber'] ?? '';
        _expiryDateController.text = profile['cardExpiryDate'] ?? '';
        _issueDateController.text = profile['cardIssueDate'] ?? '';
        if (profile['cardFrontImage'] != null) {
          _frontImageUrl = profile['cardFrontImage'];
        }
        if (profile['cardBackImage'] != null) {
          _backImageUrl = profile['cardBackImage'];
        }
        if (profile['cardFrontImageSize'] != null) {
          _frontImageSize = profile['cardFrontImageSize'];
        }
        if (profile['cardBackImageSize'] != null) {
          _backImageSize = profile['cardBackImageSize'];
        }
      });
    }
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _issueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBarHelpers.simple(title: context.localize.identification),
      body: SafeArea(
        child: ListView(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(16.0),
          ),
          children: [
            // Identification Card Section Title
            AppText.smaller(
              context.localize.identificationCard,
              color: AppColors.secondaryText(context),
            ),
            const AppSpacer.vShort(),

            // Front Card Display
            _buildCardDisplay(
              label: context.localize.pictureOfFront,
              imageUrl: _frontImageUrl,
              fileSize: _frontImageSize,
            ),
            const AppSpacer.vShort(),

            // Back Card Display
            _buildCardDisplay(
              label: context.localize.pictureOfBack,
              imageUrl: _backImageUrl,
              fileSize: _backImageSize,
            ),
            const AppSpacer.vLarge(),

            // Ghana Card Number
            MulaTextField(
              controller: _cardNumberController,
              labelText:
                  '${context.localize.ghanaCard} ${context.localize.number}',
              readOnly: true,
              fillColor: AppColors.lightGrey(context).withValues(alpha: 0.3),
            ),
            const AppSpacer.vShort(),

            // Expiry Date
            MulaTextField(
              controller: _expiryDateController,
              labelText: context.localize.expiryDate,
              readOnly: true,
              fillColor: AppColors.lightGrey(context).withValues(alpha: 0.3),
            ),
            const AppSpacer.vShort(),

            // Issue Date
            MulaTextField(
              controller: _issueDateController,
              labelText: context.localize.issueDate,
              readOnly: true,
              fillColor: AppColors.lightGrey(context).withValues(alpha: 0.3),
            ),
            const AppSpacer.vLarger(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardDisplay({
    required String label,
    String? imageUrl,
    String? fileSize,
  }) {
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;

    return GestureDetector(
      onTap: hasImage
          ? () => ImagePopup.show(
              context,
              imageUrl: imageUrl,
              isNetworkImage: true,
            )
          : null,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.border(context),
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: hasImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      size: context.responsiveValue(mobile: 30.0),
                      color: AppColors.appPrimary,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return _buildPlaceholder(label: label, fileSize: fileSize);
                  },
                ),
              )
            : _buildPlaceholder(label: label, fileSize: fileSize),
      ),
    );
  }

  Widget _buildPlaceholder({required String label, String? fileSize}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.medium(
            context.localize.ghanaCard,
            style: TextStyle(
              color: AppColors.appPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (fileSize != null && fileSize.isNotEmpty) ...[
            const AppSpacer.vShorter(),
            AppText.smaller(fileSize, color: AppColors.secondaryText(context)),
          ],
          const AppSpacer.vShorter(),
          AppText.smaller(label, color: AppColors.secondaryText(context)),
        ],
      ),
    );
  }
}
