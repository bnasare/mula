import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';

class ArticleHeader extends StatelessWidget {
  final String? imageUrl;
  final bool hasVideo;
  final String date;
  final int durationMinutes;
  final String views;

  const ArticleHeader({
    super.key,
    this.imageUrl,
    this.hasVideo = false,
    required this.date,
    required this.durationMinutes,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero image/video
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00C853), Color(0xFF00E676)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: hasVideo
              ? Center(
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      IconlyBold.play,
                      color: Color(0xFF00C853),
                      size: 32,
                    ),
                  ),
                )
              : null,
        ),
        const SizedBox(height: 16),
        // Metadata row
        Row(
          children: [
            AppText.smallest(
              date,
              color: AppColors.secondaryText(context),
            ),
            const SizedBox(width: 8),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.secondaryText(context),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            AppText.smallest(
              context.localize.minsRead(durationMinutes),
              color: AppColors.secondaryText(context),
            ),
            const SizedBox(width: 8),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.secondaryText(context),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              IconlyLight.show,
              size: 16,
              color: AppColors.secondaryText(context),
            ),
            const SizedBox(width: 4),
            AppText.smallest(
              context.localize.views(views),
              color: AppColors.secondaryText(context),
            ),
          ],
        ),
      ],
    );
  }
}
