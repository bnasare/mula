import 'package:cached_network_image/cached_network_image.dart';
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
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Background image
              imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: AppColors.articleHeaderGreenGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.white(context),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: AppColors.articleHeaderGreenGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.white(context),
                          size: 48,
                        ),
                      ),
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: AppColors.articleHeaderGreenGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
              // Play button overlay for videos
              if (hasVideo)
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.white(context).withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        IconlyBold.play,
                        color: imageUrl != null
                            ? AppColors.appPrimary
                            : AppColors.articleHeaderGreenGradient.first,
                        size: 32,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Metadata row
        Row(
          children: [
            AppText.smallest(date, color: AppColors.secondaryText(context)),
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
