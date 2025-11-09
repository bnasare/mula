import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import '../presentation/widgets/snackbar.dart';
import 'extension.dart';
import 'image_cropper.dart';
import 'localization_extension.dart';

class ImageSelectionUtils {
  static final ImagePicker _picker = ImagePicker();

  static void showImageSourceOptions({
    required BuildContext context,
    required Function(File) onImageSelected,
    required bool isProfileImage,
    String? cameraText,
    String? galleryText,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: context
              .responsivePadding(mobile: const EdgeInsets.all(20))
              .copyWith(top: context.responsiveSpacing(mobile: 12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  IconlyBold.camera,
                  size: context.responsiveValue(mobile: 20.0),
                  color: Colors.black54,
                ),
                title: Text(
                  cameraText ?? context.localize.takePhoto,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: context.responsiveFontSize(mobile: 14),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromCamera(
                    context: context,
                    onImageSelected: onImageSelected,
                    isProfileImage: isProfileImage,
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  IconlyBold.image,
                  size: context.responsiveValue(mobile: 20.0),
                  color: Colors.black54,
                ),
                title: Text(
                  galleryText ?? context.localize.uploadFromGallery,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: context.responsiveFontSize(mobile: 14),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromGallery(
                    context: context,
                    onImageSelected: onImageSelected,
                    isProfileImage: isProfileImage,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Shows a bottom sheet with image management options (Change/Remove)
  static void showImageManagementOptions({
    required BuildContext context,
    required Function(File) onImageSelected,
    required VoidCallback onImageRemoved,
    required bool isProfileImage,
    String? changeText,
    String? removeText,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: context.responsivePadding(mobile: const EdgeInsets.all(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  IconlyBold.camera,
                  size: context.responsiveValue(mobile: 20.0),
                  color: Colors.black54,
                ),
                title: Text(
                  changeText ??
                      (isProfileImage
                          ? context.localize.changeProfileImage
                          : context.localize.changeCoverImage),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: context.responsiveFontSize(mobile: 14),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showImageSourceOptions(
                    context: context,
                    onImageSelected: onImageSelected,
                    isProfileImage: isProfileImage,
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  IconlyBold.delete,
                  size: context.responsiveValue(mobile: 20.0),
                  color: Colors.black54,
                ),
                title: Text(
                  removeText ?? context.localize.removeImage,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: context.responsiveFontSize(mobile: 14),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onImageRemoved();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Private method to get image from camera
  static Future<void> _getImageFromCamera({
    required BuildContext context,
    required Function(File) onImageSelected,
    required bool isProfileImage,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        final croppedFile = isProfileImage
            ? await cropProfileImage(image.path, context)
            : await cropCoverImage(image.path, context);

        if (croppedFile != null) {
          onImageSelected(File(croppedFile.path));
        } else {
          if (context.mounted) {
            SnackBarHelper.showErrorSnackBar(
              context,
              context.localize.failedToCropImage,
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarHelper.showErrorSnackBar(
          context,
          '${context.localize.errorCapturingImage}: $e',
        );
      }
    }
  }

  /// Private method to get image from gallery
  static Future<void> _getImageFromGallery({
    required BuildContext context,
    required Function(File) onImageSelected,
    required bool isProfileImage,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final croppedFile = isProfileImage
            ? await cropProfileImage(image.path, context)
            : await cropCoverImage(image.path, context);

        if (croppedFile != null) {
          onImageSelected(File(croppedFile.path));
        } else {
          if (context.mounted) {
            SnackBarHelper.showErrorSnackBar(
              context,
              context.localize.failedToCropImage,
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarHelper.showErrorSnackBar(
          context,
          '${context.localize.errorSelectingImage}: $e',
        );
      }
    }
  }
}
