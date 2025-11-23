import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mula/shared/presentation/theme/app_colors.dart';
import 'package:smooth_corner/smooth_corner.dart';

class OverlayLoadingIndicator extends StatelessWidget {
  final String? message;
  const OverlayLoadingIndicator({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Material(
            color: AppColors.transparent,
            child: ColoredBox(
              color: AppColors.transparent,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmoothContainer(
                      smoothness: 1,
                      color: AppColors.white(context),
                      borderRadius: const SmoothBorderRadius.all(
                        SmoothRadius(
                          cornerRadius: 15 * 1.5,
                          cornerSmoothing: 0.8,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 25,
                      ),
                      child: Row(
                        children: [
                          LoadingAnimationWidget.staggeredDotsWave(
                            size: 30,
                            color: AppColors.orange,
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              message ?? 'Please wait...',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.2,
                                height: 1.2,
                                fontSize: 14,
                                color: AppColors.defaultText(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
