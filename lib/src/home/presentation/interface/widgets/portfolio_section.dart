import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../dashboard/presentation/interface/widgets/portfolio_value_card.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';

/// Portfolio section showing total value with loading state
class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, _) {
        if (provider.isLoadingPortfolio) {
          return _buildShimmer(context);
        }

        if (provider.portfolioSummary == null) {
          return const SizedBox.shrink();
        }

        return PortfolioValueCard(portfolioSummary: provider.portfolioSummary!);
      },
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.secondaryText(context).withOpacity(0.1),
      highlightColor: AppColors.secondaryText(context).withOpacity(0.05),
      child: Column(
        children: [
          Container(
            height: 20,
            width: 150,
            decoration: BoxDecoration(
              color: AppColors.white(context),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              color: AppColors.white(context),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
