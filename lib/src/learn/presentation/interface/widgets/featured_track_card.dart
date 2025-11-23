import 'package:flutter/material.dart';
import 'package:mula/shared/presentation/theme/app_colors.dart';
import 'package:mula/shared/presentation/widgets/constants/app_spacer.dart';
import 'package:mula/shared/utils/localization_extension.dart';

import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../domain/entities/learning_track.dart';

class FeaturedTrackCard extends StatelessWidget {
  final LearningTrack track;

  const FeaturedTrackCard({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient:
            track.gradient ??
            const LinearGradient(
              colors: [Color(0xFFFF9F43), Color(0xFFFF8A00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppText.large(track.icon, style: TextStyle(fontSize: 32)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.smaller(
                      track.title,
                      style: TextStyle(
                        color: AppColors.white(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    AppText.smallest(
                      track.description,
                      style: TextStyle(
                        color: AppColors.white(context).withOpacity(0.95),
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacer.vShorter(),
          Align(
            alignment: Alignment.bottomRight,
            child: AppText.smallest(
              context.localize.mins(track.durationMinutes),
              style: TextStyle(
                color: AppColors.white(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
