import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../learn/domain/entities/lesson.dart';

enum LearningProgressTab { inProgress, saved, completed }

class LearningProgressCard extends StatelessWidget {
  final Lesson lesson;
  final LearningProgressTab tab;
  final bool isSaved;
  final int completedTracks;
  final int totalTracks;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;

  const LearningProgressCard({
    super.key,
    required this.lesson,
    required this.tab,
    this.isSaved = false,
    this.completedTracks = 0,
    this.totalTracks = 4,
    this.onTap,
    this.onBookmarkTap,
  });

  List<Color> _getGradientColors() {
    switch (tab) {
      case LearningProgressTab.inProgress:
        return AppColors.orangeGradient;
      case LearningProgressTab.saved:
        return AppColors.purpleGradient;
      case LearningProgressTab.completed:
        return AppColors.greenGradient;
    }
  }

  int get progressPercent =>
      totalTracks > 0 ? ((completedTracks / totalTracks) * 100).round() : 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getGradientColors(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.smaller(
                        lesson.title,
                        style: TextStyle(
                          color: AppColors.white(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      AppText.smallest(
                        lesson.subtitle,
                        style: TextStyle(
                          color: AppColors.white(context).withValues(alpha: 0.9),
                        ),
                        maxLines: 2,
                        clipped: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: onBookmarkTap,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.white(context).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isSaved ? IconlyBold.bookmark : IconlyLight.bookmark,
                      color: AppColors.white(context),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressPercent / 100,
                backgroundColor: AppColors.white(context).withValues(alpha: 0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.appPrimary,
                ),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _BadgeChip(
                  label: context.localize.percentCompleted(progressPercent),
                ),
                const SizedBox(width: 8),
                _BadgeChip(
                  label: context.localize.tracksProgress(
                    completedTracks,
                    totalTracks,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final String label;

  const _BadgeChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: AppText.smallest(
        label,
        style: TextStyle(
          color: AppColors.black(context),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
