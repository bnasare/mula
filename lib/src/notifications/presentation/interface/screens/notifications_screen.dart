import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../domain/entities/notification.dart';
import '../widgets/notification_list_tile.dart';

/// Screen displaying all user notifications
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Sample notifications - in production, this would come from state/API
  final List<NotificationEntity> _notifications = [
    NotificationEntity(
      id: '1',
      type: NotificationType.success,
      title: 'Your mutual fund gained 3% this week',
      description: 'Keep an eye on your portfolio to track the momentum',
      timestamp: DateTime(2025, 7, 24, 15, 41),
      isRead: false,
    ),
    NotificationEntity(
      id: '2',
      type: NotificationType.deposit,
      title: 'Deposit Successful',
      description: 'GHS 500 has been deposited into your MTN account',
      timestamp: DateTime(2025, 7, 23, 10, 15),
      isRead: true,
    ),
    NotificationEntity(
      id: '3',
      type: NotificationType.withdrawal,
      title: 'Withdrawal Completed',
      description: 'GHS 200 has been withdrawn to your Ecobank account',
      timestamp: DateTime(2025, 7, 22, 14, 30),
      isRead: true,
    ),
    NotificationEntity(
      id: '4',
      type: NotificationType.warning,
      title: 'Market Alert',
      description: 'Your stock portfolio decreased by 2% today',
      timestamp: DateTime(2025, 7, 21, 9, 0),
      isRead: true,
    ),
    NotificationEntity(
      id: '5',
      type: NotificationType.info,
      title: 'System Update',
      description: 'New features available in your MULA app',
      timestamp: DateTime(2025, 7, 20, 8, 0),
      isRead: true,
    ),
  ];

  void _clearAllNotifications() {
    setState(() {
      _notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBarHelpers.withActions(
        title: context.localize.notifications,
        actions: [
          if (_notifications.isNotEmpty)
            AppBarActions.textButton(
              text: context.localize.clearAll,
              onPressed: _clearAllNotifications,
              context: context,
              textColor: AppColors.appPrimary,
            ),
        ],
        showDivider: true,
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return NotificationListTile(
                  notification: _notifications[index],
                );
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: context.responsivePadding(mobile: const EdgeInsets.all(32.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.offWhite(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                IconlyLight.notification,
                size: 60,
                color: AppColors.grey(context),
              ),
            ),
            const AppSpacer.vLarge(),
            // Title
            Text(
              context.localize.noNotifications,
              style: TextStyle(
                fontSize: context.responsiveFontSize(mobile: 20.0),
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText(context),
              ),
            ),
            const AppSpacer.vShort(),
            // Description
            Text(
              context.localize.noNotificationsDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontSize(mobile: 14.0),
                color: AppColors.secondaryText(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
