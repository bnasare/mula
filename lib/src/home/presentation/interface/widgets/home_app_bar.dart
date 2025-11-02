import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';

/// App bar widget for the home tab
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.offWhite(context),
      elevation: 0,
      pinned: false,
      floating: true,
      expandedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: context.responsivePadding(
              mobile: const EdgeInsets.symmetric(horizontal: 24.0),
            ),
            child: Consumer<DashboardProvider>(
              builder: (context, provider, _) {
                final userName = provider.userProfile?['name'] ?? 'User';

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // User greeting
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText.small(
                          'Welcome back👋',
                          color: AppColors.secondaryText(context),
                        ),
                        const SizedBox(height: 4),
                        AppText.medium(
                          userName,
                          color: AppColors.primaryText(context),
                        ),
                      ],
                    ),

                    // Notification icon
                    IconButton(
                      icon: Icon(
                        IconlyBold.notification,
                        color: AppColors.primaryText(context),
                      ),
                      onPressed: () {
                        // TODO: Navigate to notifications screen
                        // NavigationHelper.navigateTo(context, NotificationsScreen());
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
