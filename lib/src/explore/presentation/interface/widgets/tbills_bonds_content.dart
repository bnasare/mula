import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../home/presentation/interface/widgets/asset_tab_button.dart';
import '../../../../portfolio/presentation/interface/screens/tbill_detail_screen.dart';
import '../../../data/dummy_explore_data.dart';
import 'auction_market_item.dart';
import 'secondary_market_item.dart';

class TBillsBondsContent extends StatefulWidget {
  const TBillsBondsContent({super.key});

  @override
  State<TBillsBondsContent> createState() => _TBillsBondsContentState();
}

class _TBillsBondsContentState extends State<TBillsBondsContent> {
  int _selectedTab = 0; // 0: Auction Market, 1: Secondary Market

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    label: context.localize.auctionMarket,
                    isActive: _selectedTab == 0,
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                ),
                Expanded(
                  child: AssetTabButton(
                    label: context.localize.secondaryMarket,
                    isActive: _selectedTab == 1,
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Content based on selected tab
        Expanded(
          child: _selectedTab == 0
              ? _buildAuctionMarketList()
              : _buildSecondaryMarketList(),
        ),
      ],
    );
  }

  Widget _buildAuctionMarketList() {
    final items = DummyExploreData.getAuctionMarketItems();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return AuctionMarketListItem(item: items[index]);
      },
    );
  }

  Widget _buildSecondaryMarketList() {
    final items = DummyExploreData.getSecondaryMarketItems();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return SecondaryMarketListItem(
          item: item,
          onTap: () {
            NavigationHelper.navigateTo(
              context,
              TBillDetailScreen(
                tbillCode: item.code,
                description: item.typeLabel,
                currentRate: item.rate,
                change: item.change,
                showAppBarTitle: false,
              ),
            );
          },
        );
      },
    );
  }
}
