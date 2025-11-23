import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../domain/entities/comment.dart';
import 'comment_widget.dart';

class CommentsSection extends StatefulWidget {
  final List<Comment> comments;

  const CommentsSection({
    super.key,
    required this.comments,
  });

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Share/Comment prompt with icons
        Row(
          children: [
            Icon(
              IconlyLight.send,
              size: 20,
              color: AppColors.secondaryText(context),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppText.smaller(
                context.localize.shareWithFriends,
                color: AppColors.secondaryText(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // View comments button
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            children: [
              AppText.smaller(
                context.localize.viewComments('1.8k'),
                style: TextStyle(
                  color: AppColors.appPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.appPrimary,
              ),
            ],
          ),
        ),

        // Comments list (expandable)
        if (_isExpanded) ...[
          const SizedBox(height: 24),
          ...widget.comments.map((comment) {
            return Column(
              children: [
                CommentWidget(
                  comment: comment,
                  onReplyPressed: () {
                    // TODO: Implement reply functionality
                  },
                ),
                // Render replies
                ...comment.replies.map((reply) {
                  return CommentWidget(
                    comment: reply,
                    isReply: true,
                  );
                }),
              ],
            );
          }),
          // Show more replies button (if needed)
          if (widget.comments.any((c) => c.replies.length > 1))
            Padding(
              padding: const EdgeInsets.only(left: 40, bottom: 16),
              child: GestureDetector(
                onTap: () {
                  // TODO: Implement show more replies
                },
                child: AppText.smallest(
                  context.localize.showMoreReplies(4),
                  style: TextStyle(
                    color: AppColors.appPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ],
    );
  }
}
