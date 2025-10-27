import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../domain/entities/notification.dart';

/// A reusable list tile widget for displaying a notification
class NotificationListTile extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationListTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final notificationConfig = _getNotificationConfig(notification.type);

    return Container(
      padding: EdgeInsets.all(context.responsiveValue(mobile: 16.0)),
      decoration: BoxDecoration(
        color: notification.isRead
            ? Colors.transparent
            : AppColors.offWhite(context),
        border: Border(
          bottom: BorderSide(
            color: AppColors.border(context).withValues(alpha: 0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: notificationConfig.color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              notificationConfig.icon,
              color: notificationConfig.color,
              size: 20,
            ),
          ),
          SizedBox(width: context.responsiveSpacing(mobile: 12.0)),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                AppText.smaller(
                  notification.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryText(context),
                  ),
                ),
                const SizedBox(height: 4),
                // Description
                AppText.smallest(
                  notification.description,
                  color: AppColors.secondaryText(context),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                // Timestamp
                AppText.smallest(
                  _formatTimestamp(notification.timestamp),
                  color: AppColors.secondaryText(
                    context,
                  ).withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
          // Unread indicator
          if (!notification.isRead)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 6, left: 8),
              decoration: BoxDecoration(
                color: AppColors.appPrimary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  /// Get the icon and color configuration for a notification type
  _NotificationConfig _getNotificationConfig(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return _NotificationConfig(
          icon: IconlyBold.chart,
          color: const Color(0xFF10B981), // Green
        );
      case NotificationType.warning:
        return _NotificationConfig(
          icon: IconlyBold.danger,
          color: const Color(0xFFEF4444), // Red
        );
      case NotificationType.deposit:
        return _NotificationConfig(
          icon: IconlyBold.download,
          color: const Color(0xFF3B82F6), // Blue
        );
      case NotificationType.withdrawal:
        return _NotificationConfig(
          icon: IconlyBold.upload,
          color: const Color(0xFF8B5CF6), // Purple
        );
      case NotificationType.info:
        return _NotificationConfig(
          icon: IconlyBold.notification,
          color: const Color(0xFF6B7280), // Grey
        );
    }
  }

  /// Format timestamp to display format (e.g., "24th July 2025 • 3:41PM")
  String _formatTimestamp(DateTime timestamp) {
    final day = timestamp.day;
    final suffix = _getDaySuffix(day);
    final dateFormat = DateFormat("d'$suffix' MMMM yyyy");
    final timeFormat = DateFormat("h:mma");

    return '${dateFormat.format(timestamp)} • ${timeFormat.format(timestamp)}';
  }

  /// Get the ordinal suffix for a day (st, nd, rd, th)
  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

/// Configuration for notification icon and color
class _NotificationConfig {
  final IconData icon;
  final Color color;

  _NotificationConfig({required this.icon, required this.color});
}
