import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../../../../notifications/presentation/interface/screens/notifications_screen.dart';

/// App bar widget for the home tab
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      pinned: false,
      floating: true,
      expandedHeight: 80,
      scrolledUnderElevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: context.responsivePadding(
              mobile: const EdgeInsets.symmetric(horizontal: 20.0),
            ),
            child: Consumer<DashboardProvider>(
              builder: (context, provider, _) {
                final userName = provider.userProfile?['name'] ?? 'User';
                final userAvatar = provider.userProfile?['avatar'] as String?;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // User greeting with avatar
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.grey(
                            context,
                          ).withValues(alpha: 0.2),
                          backgroundImage: userAvatar != null
                              ? NetworkImage(userAvatar)
                              : null,
                          child: userAvatar == null
                              ? Text(
                                  userName.isNotEmpty
                                      ? userName[0].toUpperCase()
                                      : 'U',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText(context),
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText.small(
                              '${context.localize.welcomeBack} 👋',
                              color: AppColors.secondaryText(context),
                            ),
                            const SizedBox(height: 2),
                            AppText.medium(
                              userName,
                              color: AppColors.primaryText(context),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Notification icon
                    IconButton.outlined(
                      style: IconButton.styleFrom(
                        side: BorderSide(
                          color: AppColors.grey(context).withValues(alpha: 0.2),
                        ),
                      ),
                      icon: Icon(
                        IconlyLight.notification,
                        color: AppColors.primaryText(context),
                      ),
                      onPressed: () {
                        NavigationHelper.navigateTo(
                          context,
                          const NotificationsScreen(),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
