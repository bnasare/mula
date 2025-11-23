import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../domain/entities/lesson.dart';
import '../screens/lesson_detail_screen.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;

  const LessonCard({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationHelper.navigateTo(
          context,
          LessonDetailScreen(lessonId: lesson.id),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.card(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image placeholder
              Container(
                width: 110,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey(context),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.smaller(
                        lesson.title,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 6),
                      AppText.smallest(
                        lesson.subtitle,
                        color: AppColors.secondaryText(context),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.purpleLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: AppText.smallest(
                              context.localize.article,
                              style: TextStyle(
                                color: AppColors.purple,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: AppText.smallest(
                              context.localize.mins(lesson.durationMinutes),
                              color: AppColors.secondaryText(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
