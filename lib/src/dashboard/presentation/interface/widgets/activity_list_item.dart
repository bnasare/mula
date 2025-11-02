import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../domain/entities/activity.dart';

/// List item for displaying a single activity/transaction
class ActivityListItem extends StatelessWidget {
  final Activity activity;
  final VoidCallback? onTap;

  const ActivityListItem({super.key, required this.activity, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            // Top row: Icon, Title/Subtitle, Amount/Price
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Activity icon
                _ActivityIcon(type: activity.type),
                const SizedBox(width: 12),

                // Left side: Title and Subtitle
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

                      // Subtitle (Broker/Provider)
                      AppText.smallest(
                        activity.subtitle,
                        color: AppColors.secondaryText(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Right side: Amount and Price info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Large amount
                    AppText.medium(
                      'GHS ${activity.amount.toStringAsFixed(0)}',
                      color: AppColors.primaryText(context),
                    ),

                    // Price and shares info (if available)
                    if (activity.shares != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText.smallest(
                            '@GHS ${(activity.amount / double.parse(activity.shares!.split(' ')[0].replaceAll(',', ''))).toStringAsFixed(2)}',
                            color: AppColors.appPrimary,
                          ),
                          const SizedBox(width: 4),
                          AppText.smallest(
                            activity.shares!,
                            color: AppColors.secondaryText(context),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Bottom row: Date/Time/Type + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date, time, and transaction type
                Flexible(
                  child: Row(
                    children: [
                      AppText.smallest(
                        _formatDate(activity.timestamp),
                        color: AppColors.secondaryText(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryText(context),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      AppText.smallest(
                        _formatTime(activity.timestamp),
                        color: AppColors.secondaryText(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryText(context),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      AppText.smallest(
                        _getTypeLabel(activity.type),
                        color: _getTypeColor(activity.type),
                      ),
                    ],
                  ),
                ),

                // Status badge
                _StatusBadge(status: activity.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime timestamp) {
    return DateFormat('d\'th\' MMMM y').format(timestamp);
  }

  String _formatTime(DateTime timestamp) {
    return DateFormat('h:mma').format(timestamp);
  }

  String _getTypeLabel(ActivityType type) {
    switch (type) {
      case ActivityType.buy:
        return 'Buy';
      case ActivityType.sell:
        return 'Sell';
      case ActivityType.deposit:
        return 'Deposit';
      case ActivityType.withdrawal:
        return 'Withdrawal';
    }
  }

  Color _getTypeColor(ActivityType type) {
    switch (type) {
      case ActivityType.buy:
        return const Color(0xFF4CAF50); // Green
      case ActivityType.sell:
        return const Color(0xFFEF5350); // Red
      case ActivityType.deposit:
        return const Color(0xFFFF9800); // Orange
      case ActivityType.withdrawal:
        return const Color(0xFFEF5350); // Red
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

    switch (type) {
      case ActivityType.buy:
        iconData = Icons.arrow_upward_rounded;
        backgroundColor = const Color(0xFFE8F5E9); // Light green
        break;
      case ActivityType.sell:
        iconData = Icons.arrow_downward_rounded;
        backgroundColor = const Color(0xFFFFEBEE); // Light red
        break;
      case ActivityType.deposit:
        iconData = Icons.arrow_upward_rounded;
        backgroundColor = const Color(0xFFFFF3E0); // Light orange
        break;
      case ActivityType.withdrawal:
        iconData = Icons.arrow_downward_rounded;
        backgroundColor = const Color(0xFFFFEBEE); // Light red
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(iconData, size: 20, color: _getIconColor(type)),
    );
  }

  Color _getIconColor(ActivityType type) {
    switch (type) {
      case ActivityType.buy:
        return const Color(0xFF4CAF50); // Green
      case ActivityType.sell:
        return const Color(0xFFEF5350); // Red
      case ActivityType.deposit:
        return const Color(0xFFFF9800); // Orange
      case ActivityType.withdrawal:
        return const Color(0xFFEF5350); // Red
    }
  }
}

/// Status badge for activity status
class _StatusBadge extends StatelessWidget {
  final ActivityStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final String label;
    final Color backgroundColor;
    final Color textColor;

    switch (status) {
      case ActivityStatus.completed:
        label = 'Completed';
        backgroundColor = const Color(0xFFE8F5E9); // Light green
        textColor = const Color(0xFF4CAF50); // Green
        break;
      case ActivityStatus.pending:
        label = 'Pending';
        backgroundColor = const Color(0xFFF3E5F5); // Light purple
        textColor = const Color(0xFF9C27B0); // Purple
        break;
      case ActivityStatus.failed:
        label = 'Failed';
        backgroundColor = const Color(0xFFFFEBEE); // Light red
        textColor = const Color(0xFFEF5350); // Red
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor, width: 0.2),
      ),
      child: AppText.smallest(
        label,
        style: TextStyle(fontSize: 10, color: textColor),
      ),
    );
  }
}
