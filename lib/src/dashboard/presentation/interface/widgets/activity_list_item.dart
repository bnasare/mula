import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../domain/entities/activity.dart';

/// List item for displaying a single activity/transaction
class ActivityListItem extends StatelessWidget {
  final Activity activity;
  final VoidCallback? onTap;

  const ActivityListItem({
    super.key,
    required this.activity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.card(context),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.border(context),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Activity icon
            _ActivityIcon(type: activity.type),
            const SizedBox(width: 12),

            // Activity details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  AppText.small(
                    activity.title,
                    color: AppColors.primaryText(context),
                  ),
                  const SizedBox(height: 4),

                  // Subtitle
                  Row(
                    children: [
                      AppText.smallest(
                        activity.subtitle,
                        color: AppColors.secondaryText(context),
                      ),
                      if (activity.shares != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.appPrimary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: AppText.smallest(
                            activity.shares!,
                            color: AppColors.appPrimary,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Timestamp
                  AppText.smallest(
                    _formatTimestamp(activity.timestamp),
                    color: AppColors.secondaryText(context),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Amount and status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Amount
                AppText.small(
                  'GHS ${activity.amount.toStringAsFixed(0)}',
                  color: _getAmountColor(activity.type),
                ),
                const SizedBox(height: 4),

                // Status badge
                _StatusBadge(status: activity.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getAmountColor(ActivityType type) {
    switch (type) {
      case ActivityType.buy:
      case ActivityType.deposit:
        return AppColors.appPrimary;
      case ActivityType.sell:
      case ActivityType.withdrawal:
        return Colors.red;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d, y').format(timestamp);
    }
  }
}

/// Icon representing the activity type
class _ActivityIcon extends StatelessWidget {
  final ActivityType type;

  const _ActivityIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    final IconData iconData;
    final Color backgroundColor;
    final Color iconColor;

    switch (type) {
      case ActivityType.buy:
        iconData = IconlyBold.arrow_up;
        backgroundColor = AppColors.appPrimary.withOpacity(0.1);
        iconColor = AppColors.appPrimary;
        break;
      case ActivityType.sell:
        iconData = IconlyBold.arrow_down;
        backgroundColor = Colors.red.withOpacity(0.1);
        iconColor = Colors.red;
        break;
      case ActivityType.deposit:
        iconData = IconlyBold.wallet;
        backgroundColor = AppColors.appPrimary.withOpacity(0.1);
        iconColor = AppColors.appPrimary;
        break;
      case ActivityType.withdrawal:
        iconData = IconlyBold.wallet;
        backgroundColor = Colors.orange.withOpacity(0.1);
        iconColor = Colors.orange;
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        iconData,
        size: 20,
        color: iconColor,
      ),
    );
  }
}

/// Status badge for activity status
class _StatusBadge extends StatelessWidget {
  final ActivityStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final String label;
    final Color color;

    switch (status) {
      case ActivityStatus.completed:
        label = 'Completed';
        color = AppColors.appPrimary;
        break;
      case ActivityStatus.pending:
        label = 'Pending';
        color = Colors.orange;
        break;
      case ActivityStatus.failed:
        label = 'Failed';
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: AppText.smallest(
        label,
        color: color,
      ),
    );
  }
}
