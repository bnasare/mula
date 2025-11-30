import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';

class CommentInputBottomSheet extends StatefulWidget {
  final String? replyToName;
  final String? parentCommentId;

  const CommentInputBottomSheet({
    super.key,
    this.replyToName,
    this.parentCommentId,
  });

  static Future<String?> show(
    BuildContext context, {
    String? replyToName,
    String? parentCommentId,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CommentInputBottomSheet(
        replyToName: replyToName,
        parentCommentId: parentCommentId,
      ),
    );
  }

  @override
  State<CommentInputBottomSheet> createState() =>
      _CommentInputBottomSheetState();
}

class _CommentInputBottomSheetState extends State<CommentInputBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      Navigator.pop(context, text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isReply = widget.replyToName != null;
    final title = isReply
        ? '${context.localize.reply} to ${widget.replyToName}'
        : context.localize.leaveComment;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.hintText(context).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppText.large(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText(context),
                      fontSize: 22,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.cancel,
                    size: 22,
                    color: AppColors.secondaryText(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Text input field
            TextField(
              controller: _controller,
              autofocus: true,
              maxLines: null,
              minLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: isReply
                    ? context.localize.writeYourReply
                    : context.localize.shareYourThoughts,
                hintStyle: TextStyle(
                  color: AppColors.secondaryText(context),
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.border(context)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.border(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.appPrimary,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                filled: true,
                fillColor: AppColors.offWhite(context),
              ),
              onChanged: (value) {
                setState(() {
                  _hasText = value.trim().isNotEmpty;
                });
              },
            ),
            const SizedBox(height: 20),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _hasText ? _handleSubmit : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimary,
                  foregroundColor: AppColors.white(context),
                  disabledBackgroundColor: AppColors.lightGrey(context),
                  disabledForegroundColor: AppColors.secondaryText(context),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(IconlyLight.send, size: 18),
                    const SizedBox(width: 8),
                    AppText.smaller(
                      isReply ? context.localize.reply : context.localize.postComment,
                      style: TextStyle(
                        color: _hasText
                            ? AppColors.white(context)
                            : AppColors.secondaryText(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
