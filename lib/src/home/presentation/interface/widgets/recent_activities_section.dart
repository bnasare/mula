import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../dashboard/presentation/interface/widgets/activity_list_item.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.medium(
                  context.localize.recentActivities,
                  color: AppColors.primaryText(context),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: View all activities
                  },
                  child: AppText.small(
                    context.localize.viewAll,
                    color: AppColors.appPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Activities list
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.recentActivities.length,
              separatorBuilder: (context, index) =>
                  Divider(color: AppColors.border(context), height: 1),
              itemBuilder: (context, index) {
                return ActivityListItem(
                  activity: provider.recentActivities[index],
                  onTap: () {
                    // TODO: Navigate to activity details
                  },
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
