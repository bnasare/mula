import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../dashboard/domain/entities/asset.dart';
import '../../../../dashboard/presentation/interface/widgets/asset_donut_chart.dart';
import '../../../../home/presentation/interface/widgets/asset_tab_button.dart';

/// Asset breakdown section with 2 tabs: Class and Broker
class PortfolioAssetBreakdown extends StatefulWidget {
  final List<Asset> assetsByClass;
  final List<Asset> assetsByBroker;

  const PortfolioAssetBreakdown({
    super.key,
    required this.assetsByClass,
    required this.assetsByBroker,
  });

  @override
  State<PortfolioAssetBreakdown> createState() =>
      _PortfolioAssetBreakdownState();
}

class _PortfolioAssetBreakdownState extends State<PortfolioAssetBreakdown> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab buttons (matching home screen style) - with padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    isActive: _selectedTab == 0,
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                ),
                Expanded(
                  child: AssetTabButton(
                    label: context.localize.broker,
                    isActive: _selectedTab == 1,
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Chart content - NO padding (chart handles its own)
        _selectedTab == 0
            ? AssetDonutChart(assets: widget.assetsByClass)
            : AssetDonutChart(assets: widget.assetsByBroker),
      ],
    );
  }
}
