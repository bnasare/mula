import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/image_popup.dart';
import '../../../../../shared/presentation/widgets/snackbar.dart';
import '../../../../../shared/utils/image_cropper.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../widgets/profile_image_bottom_sheet.dart';

/// Mixin to provide profile image management functionality
/// Usage: Add `with ProfileImageMixin` to your StatefulWidget's State class
mixin ProfileImageMixin<T extends StatefulWidget> on State<T> {
  File? localProfileImage;
  final ImagePicker _picker = ImagePicker();

  /// Handle the profile image tap - shows the bottom sheet
  void handleProfileImageTap() async {
    final action = await showModalBottomSheet<ProfileImageAction>(
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (context) => const ProfileImageBottomSheet(),
    );

    if (action == null || !mounted) return;

    switch (action) {
      case ProfileImageAction.changePhoto:
        handleChangePhoto();
        break;
      case ProfileImageAction.viewFullscreen:
        handleViewFullscreen();
        break;
      case ProfileImageAction.deletePhoto:
        handleDeletePhoto();
        break;
    }
  }

  /// Handle changing the profile photo
  void handleChangePhoto() async {
    // Show dialog to choose camera or gallery
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.card(context),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grey(context).withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(IconlyLight.camera),
              title: const Text('Take Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(IconlyLight.image),
              title: const Text('Choose from Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null || !mounted) return;

    try {
      // Pick image
      final XFile? image = await _picker.pickImage(source: source);

      if (image != null && mounted) {
        // Crop the image
        final croppedFile = await cropProfileImage(image.path, context);

        if (croppedFile != null && mounted) {
          setState(() {
            localProfileImage = File(croppedFile.path);
          });
        } else if (mounted) {
          SnackBarHelper.showErrorSnackBar(context, 'Failed to crop image');
        }
      }
    } catch (e) {
      if (mounted) {
        SnackBarHelper.showErrorSnackBar(context, 'Error selecting image: $e');
      }
    }
  }

  /// Handle viewing fullscreen
  void handleViewFullscreen() {
    // Check if there's a local image
    if (localProfileImage != null) {
      ImagePopup.show(context, imageFile: localProfileImage);
      return;
    }

    // Check if there's a network image
    final dashboardProvider = context.read<DashboardProvider>();
    final profileImageUrl = dashboardProvider.userProfile?['profileImage'];

    if (profileImageUrl != null) {
      ImagePopup.show(context, imageUrl: profileImageUrl, isNetworkImage: true);
      return;
    }

    // No image available
    SnackBarHelper.showInfoSnackBar(context, 'No profile image available');
  }

  /// Handle deleting the photo (placeholder)
  void handleDeletePhoto() {
    SnackBarHelper.showWarningSnackBar(context, 'Delete Photo - Coming soon');
  }
}
