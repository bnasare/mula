import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../domain/entities/comment.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final bool isReply;
  final VoidCallback? onReplyPressed;

  const CommentWidget({
    super.key,
    required this.comment,
    this.isReply = false,
    this.onReplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: isReply ? 40.0 : 0, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.appPrimary.withOpacity(0.1),
            child: AppText.smaller(
              comment.authorName.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: AppColors.appPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText.smaller(
                      comment.authorName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 4),
                    AppText.smallest('•'),
                    const SizedBox(width: 4),
                    AppText.smallest(comment.timestamp),
                  ],
                ),
                const SizedBox(height: 6),
                AppText.smallest(
                  comment.text,
                  color: AppColors.primaryText(context),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onReplyPressed,
                  child: AppText.smallest(
                    context.localize.reply,
                    style: TextStyle(
                      color: AppColors.appPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
