import 'package:flutter/material.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../domain/entities/learning_track.dart';

class FeaturedTrackCard extends StatelessWidget {
  final LearningTrack track;

  const FeaturedTrackCard({
    super.key,
    required this.track,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: track.gradient ??
            const LinearGradient(
              colors: [Color(0xFFFF9F43), Color(0xFFFF8A00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  track.icon,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const Spacer(),
              AppText.smaller(
                context.localize.mins(track.durationMinutes),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppText.medium(
            track.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          AppText.smaller(
            track.description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.95),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
