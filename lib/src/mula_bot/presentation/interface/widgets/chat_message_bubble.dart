import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/data/image_assets.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../domain/entities/chat_message.dart';

/// Chat message bubble widget
class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bot icon (only for bot messages)
          if (message.isBot) ...[
            Image.asset(ImageAssets.ai, width: 32, height: 32),
            const SizedBox(width: 8),
          ],

          // Message bubble
          Flexible(
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: message.isUser
                        ? AppColors.activitySuccessLightAdaptive(context)
                        : AppColors.card(context),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: Radius.circular(message.isUser ? 12 : 4),
                      bottomRight: Radius.circular(message.isUser ? 4 : 12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey(context).withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: AppText.small(
                    message.text,
                    style: TextStyle(
                      color: AppColors.primaryText(context),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Timestamp
                AppText.smallest(
                  _formatTime(message.timestamp),
                  style: TextStyle(
                    color: AppColors.secondaryText(context),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return DateFormat('h:mma').format(timestamp);
  }
}
