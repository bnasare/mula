import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';

import '../presentation/theme/app_colors.dart';

Future<CroppedFile?> cropProfileImage(
  String imagePath,
  BuildContext context,
) async {
  try {
    return await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Profile Image',
          toolbarColor: AppColors.orange,
          toolbarWidgetColor: AppColors.white(context),
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Profile Image',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );
  } catch (e) {
    // debugPrint('Error cropping profile image: $e');
    return null;
  }
}

Future<CroppedFile?> cropCoverImage(
  String imagePath,
  BuildContext context,
) async {
  try {
    return await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Cover Image',
          toolbarColor: AppColors.orange,
          toolbarWidgetColor: AppColors.white(context),
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Cover Image',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );
  } catch (e) {
    // debugPrint('Error cropping cover image: $e');
    return null;
  }
}
