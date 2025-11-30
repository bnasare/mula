import 'package:flutter/material.dart';

import '../../../../../shared/utils/navigation.dart';
import '../../../../portfolio/presentation/interface/screens/stock_detail_screen.dart';
import '../../../data/dummy_explore_data.dart';
import 'stock_list_item.dart';

class GhanaStocksContent extends StatelessWidget {
  const GhanaStocksContent({super.key});

  @override
  Widget build(BuildContext context) {
    final stocks = DummyExploreData.getGhanaStocks();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return StockListItem(
          stock: stock,
          onTap: () {
            NavigationHelper.navigateTo(
              context,
              StockDetailScreen(
                ticker: stock.ticker,
                companyName: stock.companyName,
                currentPrice: stock.currentPrice,
                change: stock.change,
                changePercentage: stock.changePercentage,
                showAppBarTitle: false,
              ),
            );
          },
        );
      },
    );
  }
}
