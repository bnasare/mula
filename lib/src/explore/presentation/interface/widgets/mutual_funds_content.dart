import 'package:flutter/material.dart';

import '../../../../../shared/utils/navigation.dart';
import '../../../../portfolio/presentation/interface/screens/mutual_funds_detail_screen.dart';
import '../../../data/dummy_explore_data.dart';
import 'asset_list_item.dart';

class MutualFundsContent extends StatelessWidget {
  const MutualFundsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final mutualFunds = DummyExploreData.getMutualFunds();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: mutualFunds.length,
      itemBuilder: (context, index) {
        final asset = mutualFunds[index];
        return AssetListItem(
          asset: asset,
          onTap: () {
            NavigationHelper.navigateTo(
              context,
              MutualFundsDetailScreen(
                ticker: asset.ticker,
                fundName: asset.companyName,
                currentPrice: asset.currentPrice,
                change: asset.change,
                changePercentage: asset.changePercentage,
                showAppBarTitle: false,
              ),
            );
          },
        );
      },
    );
  }
}
