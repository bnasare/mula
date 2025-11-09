import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../dashboard/presentation/interface/widgets/activity_list_item.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../../../../transactions/presentation/interface/screens/transactions_screen.dart';

/// Recent activities section with transaction history
class RecentActivitiesSection extends StatelessWidget {
  const RecentActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, _) {
        if (provider.isLoadingActivities) {
          return _buildShimmer(context);
        }

        if (provider.recentActivities.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppSpacer.vShort(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.medium(
                  context.localize.recentActivities,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText(context),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    NavigationHelper.navigateTo(
                      context,
                      TransactionsScreen(dashboardProvider: provider),
                    );
                  },
                  child: AppText.smaller(
                    context.localize.viewAll,
                    color: AppColors.appPrimary,
                  ),
                ),
              ],
            ),
            const AppSpacer.vShort(),

            // Activities list
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.recentActivities.length,
              separatorBuilder: (context, index) => Divider(
                color: AppColors.border(context),
                height: 6,
                thickness: 0.4,
              ),
              itemBuilder: (context, index) {
                return ActivityListItem(
                  activity: provider.recentActivities[index],
                  // No onTap - clicking on home transactions does nothing
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.secondaryText(context).withOpacity(0.1),
      highlightColor: AppColors.secondaryText(context).withOpacity(0.05),
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            height: 80,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
