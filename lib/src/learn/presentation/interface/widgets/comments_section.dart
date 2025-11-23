import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../domain/entities/comment.dart';
import 'comment_input_bottom_sheet.dart';
import 'comment_widget.dart';

class CommentsSection extends StatefulWidget {
  final List<Comment> comments;

  const CommentsSection({super.key, required this.comments});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  bool _isExpanded = false;
  // Track which comments have expanded replies (comment ID -> show all replies)
  final Map<String, bool> _expandedReplies = {};
  static const int _initialVisibleReplies = 1;
  late List<Comment> _comments;

  @override
  void initState() {
    super.initState();
    _comments = List.from(widget.comments);
  }

  Future<void> _showCommentInput({
    String? replyToName,
    String? parentCommentId,
  }) async {
    final commentText = await CommentInputBottomSheet.show(
      context,
      replyToName: replyToName,
      parentCommentId: parentCommentId,
    );

    if (commentText != null && commentText.isNotEmpty) {
      setState(() {
        if (parentCommentId != null) {
          // Add as a reply to an existing comment
          _addReply(parentCommentId, commentText);
        } else {
          // Add as a new top-level comment
          _addComment(commentText);
        }
      });
    }
  }

  void _addComment(String text) {
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorName: 'You',
      authorAvatar: '',
      text: text,
      timestamp: 'Just now',
      replies: [],
    );
    _comments.insert(0, newComment);
  }

  void _addReply(String parentId, String text) {
    final newReply = Comment(
      id: '$parentId-${DateTime.now().millisecondsSinceEpoch}',
      authorName: 'You',
      authorAvatar: '',
      text: text,
      timestamp: 'Just now',
    );

    // Find the parent comment and add the reply
    for (int i = 0; i < _comments.length; i++) {
      if (_comments[i].id == parentId) {
        final updatedReplies = List<Comment>.from(_comments[i].replies)
          ..add(newReply);
        _comments[i] = Comment(
          id: _comments[i].id,
          authorName: _comments[i].authorName,
          authorAvatar: _comments[i].authorAvatar,
          text: _comments[i].text,
          timestamp: _comments[i].timestamp,
          replies: updatedReplies,
        );
        // Automatically expand this comment's replies to show the new reply
        _expandedReplies[parentId] = true;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leave a comment prompt
        GestureDetector(
          onTap: () => _showCommentInput(),
          child: Row(
            children: [
              Icon(
                IconlyLight.chat,
                size: 20,
                color: AppColors.secondaryText(context),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppText.smaller(
                  context.localize.leaveComment,
                  style: TextStyle(
                    color: AppColors.secondaryText(context),
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.secondaryText(context),
                  ),
                ),
              ),
            ],
          ),
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
                _isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.appPrimary,
              ),
            ],
          ),
        ),

        // Comments list (expandable)
        if (_isExpanded) ...[
          const SizedBox(height: 24),
          ..._comments.map((comment) {
            // Determine if this comment's replies are expanded
            final isExpanded = _expandedReplies[comment.id] ?? false;
            final totalReplies = comment.replies.length;
            final visibleReplies = isExpanded
                ? totalReplies
                : (totalReplies > _initialVisibleReplies
                      ? _initialVisibleReplies
                      : totalReplies);
            final hiddenRepliesCount = totalReplies - visibleReplies;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommentWidget(
                  comment: comment,
                  onReplyPressed: () {
                    _showCommentInput(
                      replyToName: comment.authorName,
                      parentCommentId: comment.id,
                    );
                  },
                ),
                // Render visible replies
                ...comment.replies.take(visibleReplies).map((reply) {
                  return CommentWidget(
                    comment: reply,
                    isReply: true,
                    onReplyPressed: () {
                      _showCommentInput(
                        replyToName: reply.authorName,
                        parentCommentId: comment.id,
                      );
                    },
                  );
                }),
                // Show more replies button for this comment
                if (hiddenRepliesCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 40, bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _expandedReplies[comment.id] = true;
                        });
                      },
                      child: AppText.smallest(
                        context.localize.showMoreReplies(hiddenRepliesCount),
                        style: TextStyle(
                          color: AppColors.appPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ],
    );
  }
}
