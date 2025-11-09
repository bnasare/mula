import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../dashboard/domain/entities/asset.dart';
import '../../../../dashboard/presentation/interface/widgets/asset_donut_chart.dart';
import '../../../../dashboard/presentation/interface/widgets/performance_chart.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import 'asset_tab_button.dart';

/// Asset overview section with tabs for Class, Broker, and Performance
class AssetOverviewSection extends StatefulWidget {
  const AssetOverviewSection({super.key});

  @override
  State<AssetOverviewSection> createState() => _AssetOverviewSectionState();
}

class _AssetOverviewSectionState extends State<AssetOverviewSection> {
  int _selectedAssetTab = 0; // 0: Class, 1: Broker, 2: Performance

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, _) {
        if (provider.isLoadingPortfolio) {
          return _buildShimmer();
        }

        if (provider.portfolioSummary == null ||
            provider.portfolioSummary!.assets.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AppText.medium(
                context.localize.assetOverview,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tab buttons (Class, Broker, Performance)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.grey(context).withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AssetTabButton(
                        label: context.localize.classLabel,
                        isActive: _selectedAssetTab == 0,
                        onTap: () => setState(() => _selectedAssetTab = 0),
                      ),
                    ),
                    Expanded(
                      child: AssetTabButton(
                        label: context.localize.broker,
                        isActive: _selectedAssetTab == 1,
                        onTap: () => setState(() => _selectedAssetTab = 1),
                      ),
                    ),
                    Expanded(
                      child: AssetTabButton(
                        label: context.localize.performance,
                        isActive: _selectedAssetTab == 2,
                        onTap: () => setState(() => _selectedAssetTab = 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Chart based on selected tab
            if (_selectedAssetTab == 0)
              AssetDonutChart(assets: provider.portfolioSummary!.assets)
            else if (_selectedAssetTab == 1)
              _buildBrokerChart()
            else
              const PerformanceChart(),
          ],
        );
      },
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.secondaryText(context).withOpacity(0.1),
      highlightColor: AppColors.secondaryText(context).withOpacity(0.05),
      child: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrokerChart() {
    // Dummy broker data
    final brokerAssets = [
      const Asset(
        name: 'Petra Investments',
        value: 3868.36,
        percentage: 30.0,
        type: AssetType.stocks,
      ),
      const Asset(
        name: 'Databank',
        value: 5157.81,
        percentage: 40.0,
        type: AssetType.tBills,
      ),
      const Asset(
        name: 'Apakan',
        value: 3868.36,
        percentage: 30.0,
        type: AssetType.cashWallet,
      ),
    ];

    return AssetDonutChart(assets: brokerAssets);
  }
}
