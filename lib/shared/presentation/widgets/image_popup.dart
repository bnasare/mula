import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/extension.dart';
import '../theme/app_colors.dart';

class ImagePopup extends StatelessWidget {
  const ImagePopup({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.isNetworkImage = false,
    this.maxWidthFactor = 1.0,
    this.maxHeightFactor = 0.9,
    this.showCloseButton = true,
    this.imageFit = BoxFit.contain,
  }) : assert(imageUrl != null || imageFile != null, 'Either imageUrl or imageFile must be provided');

  final String? imageUrl;
  final File? imageFile;
  final bool isNetworkImage;
  final double maxWidthFactor;
  final double maxHeightFactor;
  final bool showCloseButton;
  final BoxFit imageFit;

  static Future<void> show(
    BuildContext context, {
    String? imageUrl,
    File? imageFile,
    bool isNetworkImage = false,
    double maxWidthFactor = 1.0,
    double maxHeightFactor = 0.9,
    bool showCloseButton = true,
    BoxFit imageFit = BoxFit.contain,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return ImagePopup(
          imageUrl: imageUrl,
          imageFile: imageFile,
          isNetworkImage: isNetworkImage,
          maxWidthFactor: maxWidthFactor,
          maxHeightFactor: maxHeightFactor,
          showCloseButton: showCloseButton,
          imageFit: imageFit,
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(opacity: anim1, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 100) {
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight:
                      MediaQuery.of(context).size.height * maxHeightFactor,
                  maxWidth: MediaQuery.of(context).size.width * maxWidthFactor,
                ),
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: _buildImage(context),
                ),
              ),
            ),
            if (showCloseButton)
              Positioned(
                top: context.responsiveSpacing(mobile: 50),
                right: context.responsiveSpacing(mobile: 20),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white(context),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(
                      context.responsiveSpacing(mobile: 8),
                    ),
                    child: Icon(
                      Icons.cancel,
                      color: AppColors.black(context),
                      size: context.responsiveValue(mobile: 24.0),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    // If imageFile is provided, use it
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        width: double.infinity,
        fit: BoxFit.fitWidth,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.error_outline,
              color: Colors.red,
              size: context.responsiveValue(mobile: 48.0),
            ),
          );
        },
      );
    }

    // Otherwise use imageUrl
    if (isNetworkImage) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        width: double.infinity,
        fit: BoxFit.fitWidth,
        placeholder: (context, url) => Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            size: context.responsiveValue(mobile: 30.0),
            color: AppColors.white(context),
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: Icon(
            Icons.error_outline,
            color: Colors.red,
            size: context.responsiveValue(mobile: 48.0),
          ),
        ),
      );
    } else {
      return Image.asset(
        imageUrl!,
        width: double.infinity,
        fit: BoxFit.fitWidth,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.error_outline,
              color: Colors.red,
              size: context.responsiveValue(mobile: 48.0),
            ),
          );
        },
      );
    }
  }
}
