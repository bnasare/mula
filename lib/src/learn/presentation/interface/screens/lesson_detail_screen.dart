import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../data/dummy_learn_data.dart';
import '../../../domain/entities/lesson_detail.dart';
import '../widgets/article_content.dart';
import '../widgets/article_header.dart';
import '../widgets/comments_section.dart';
import '../widgets/lesson_action_buttons.dart';
import 'quiz_screen.dart';

class LessonDetailScreen extends StatefulWidget {
  final String lessonId;

  const LessonDetailScreen({super.key, required this.lessonId});

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  late LessonDetail? lessonDetail;
  bool isRead = false;

  @override
  void initState() {
    super.initState();
    lessonDetail = DummyLearnData.getLessonDetail(widget.lessonId);
    isRead = lessonDetail?.isRead ?? false;
  }

  void _toggleReadStatus() {
    setState(() {
      isRead = !isRead;
      if (lessonDetail != null) {
        lessonDetail = lessonDetail!.copyWith(isRead: isRead);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (lessonDetail == null) {
      return Scaffold(
        backgroundColor: AppColors.offWhite(context),
        appBar: MulaAppBar(
          title: '',
          onBackPressed: () => Navigator.of(context).pop(),
        ),
        body: Center(child: AppText.small(context.localize.lessonNotFound)),
      );
    }

    return Scaffold(
      appBar: MulaAppBar(
        title: lessonDetail!.title,
        onBackPressed: () => Navigator.of(context).pop(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: AppColors.secondaryText(context),
            ),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article header (image + metadata)
            ArticleHeader(
              imageUrl: lessonDetail!.heroImageUrl,
              hasVideo: lessonDetail!.hasVideo,
              date: lessonDetail!.date,
              durationMinutes: lessonDetail!.durationMinutes,
              views: lessonDetail!.views,
            ),
            AppSpacer.vLarger(),

            // Article content
            ArticleContent(content: lessonDetail!.content),
            AppSpacer.vShort(),

            // Mark as read button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _toggleReadStatus,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  isRead ? context.localize.read : context.localize.markAsRead,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.appPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            AppSpacer.vShort(),

            // Action buttons
            LessonActionButtons(
              assetName: 'Bonds',
              onInvestPressed: () {
                // TODO: Navigate to investment screen
              },
              onQuizPressed: () {
                NavigationHelper.navigateTo(
                  context,
                  QuizScreen(
                    lessonId: widget.lessonId,
                    onReturnToLearn: () {
                      // Pop back to Learn tab (pops QuizScreen then LessonDetailScreen)
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
            AppSpacer.vLarger(),

            // Divider
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.lightGrey(context),
            ),
            AppSpacer.vLarge(),

            // Comments section
            CommentsSection(comments: lessonDetail!.comments),
            AppSpacer.vLarger(),
          ],
        ),
      ),
    );
  }
}
