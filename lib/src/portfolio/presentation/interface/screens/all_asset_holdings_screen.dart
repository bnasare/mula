import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../dashboard/domain/entities/asset.dart';
import '../../../../transactions/presentation/interface/screens/report_issue_screen.dart';
import '../widgets/asset_filter_bottom_sheet.dart';
import '../widgets/asset_holding_card.dart';
import 'asset_holding_detail_screen.dart';
import 'mutual_funds_detail_screen.dart';
import 'tbill_detail_screen.dart';

/// Screen showing all asset holdings
class AllAssetHoldingsScreen extends StatelessWidget {
  const AllAssetHoldingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy asset holdings data
    final holdings = [
      {
        'companyName': 'Scancom PLC',
        'brokerName': 'Databank Brokerage',
        'value': 2098.0,
        'changePercentage': 1.15,
        'shares': 150,
        'assetType': AssetType.stocks,
        'ticker': 'GSE.MTNGH',
        'currentPrice': 4.02,
        'change': 0.10,
      },
      {
        'companyName': 'IC Liquidity Fund',
        'brokerName': 'IC Asset Managers',
        'value': 2025.0,
        'changePercentage': 0.89,
        'shares': 1000,
        'assetType': AssetType.mutualFunds,
        'ticker': 'ICLF',
        'currentPrice': 2.0231,
        'change': 0.0001,
      },
      {
        'companyName': 'TB 27-OCT-25',
        'brokerName': 'Government of Ghana',
        'value': 10000.0,
        'changePercentage': -0.34,
        'shares': 10000,
        'assetType': AssetType.tBills,
        'ticker': 'TB 27-OCT-25',
        'currentPrice': 10.83,
        'change': -0.66,
      },
      {
        'companyName': 'Access Bank Ghana',
        'brokerName': 'Databank Brokerage',
        'value': 1520.0,
        'changePercentage': 2.45,
        'shares': 200,
        'assetType': AssetType.stocks,
        'ticker': 'GSE.ACCESS',
        'currentPrice': 7.60,
        'change': 0.18,
      },
      {
        'companyName': 'Enhanced Equity Beta Fund',
        'brokerName': 'IC Asset Managers',
        'value': 3090.0,
        'changePercentage': 15.1,
        'shares': 1000,
        'assetType': AssetType.mutualFunds,
        'ticker': 'EEBF',
        'currentPrice': 3.0909,
        'change': 0.40,
      },
      {
        'companyName': 'Tullow Oil Ghana',
        'brokerName': 'Petra Investments',
        'value': 980.0,
        'changePercentage': -1.25,
        'shares': 100,
        'assetType': AssetType.stocks,
        'ticker': 'GSE.TULLOW',
        'currentPrice': 9.80,
        'change': -0.12,
      },
      {
        'companyName': 'TB 15-DEC-25',
        'brokerName': 'Government of Ghana',
        'value': 5000.0,
        'changePercentage': 0.12,
        'shares': 5000,
        'assetType': AssetType.tBills,
        'ticker': 'TB 15-DEC-25',
        'currentPrice': 12.15,
        'change': 0.02,
      },
      {
        'companyName': 'Republic Bank Ghana',
        'brokerName': 'Apakan Securities',
        'value': 2340.0,
        'changePercentage': 3.78,
        'shares': 180,
        'assetType': AssetType.stocks,
        'ticker': 'GSE.REPUBLIC',
        'currentPrice': 13.00,
        'change': 0.47,
      },
      {
        'companyName': 'Gold Balanced Fund',
        'brokerName': 'Databank Asset Management',
        'value': 4560.0,
        'changePercentage': 1.23,
        'shares': 2000,
        'assetType': AssetType.mutualFunds,
        'ticker': 'GBF',
        'currentPrice': 2.28,
        'change': 0.03,
      },
      {
        'companyName': 'AngloGold Ashanti',
        'brokerName': 'Databank Brokerage',
        'value': 8750.0,
        'changePercentage': 4.12,
        'shares': 250,
        'assetType': AssetType.stocks,
        'ticker': 'GSE.AGA',
        'currentPrice': 35.00,
        'change': 1.38,
      },
    ];

    return Scaffold(
      appBar: MulaAppBarHelpers.withActions(
        title: context.localize.assetHoldings,
        actions: [
          // Filter Button
          IconButton(
            icon: Icon(
              size: 20,
              IconlyLight.filter,
              color: AppColors.primaryText(context),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: AppColors.transparent,
                builder: (context) => const AssetFilterBottomSheet(),
              );
            },
          ),
          // More menu with Report Issue
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            child: Icon(
              Icons.more_vert,
              color: AppColors.primaryText(context),
              size: 22,
            ),
            onSelected: (value) {
              if (value == 'report') {
                NavigationHelper.navigateTo(context, const ReportIssueScreen());
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'report',
                child: AppText.small(
                  context.localize.reportAnIssue,
                  color: AppColors.primaryText(context),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: holdings.length,
        itemBuilder: (context, index) {
          final holding = holdings[index];
          return AssetHoldingCard(
            companyName: holding['companyName'] as String,
            brokerName: holding['brokerName'] as String,
            value: holding['value'] as double,
            changePercentage: holding['changePercentage'] as double,
            shares: holding['shares'] as int,
            assetType: holding['assetType'] as AssetType,
            onTap: () {
              _navigateToAssetDetail(
                context,
                holding['assetType'] as AssetType,
                ticker: holding['ticker'] as String,
                name: holding['companyName'] as String,
                currentPrice: holding['currentPrice'] as double,
                change: holding['change'] as double,
                changePercentage: holding['changePercentage'] as double,
              );
            },
          );
        },
      ),
    );
  }

  /// Navigate to the appropriate detail screen based on asset type
  void _navigateToAssetDetail(
    BuildContext context,
    AssetType assetType, {
    required String ticker,
    required String name,
    required double currentPrice,
    required double change,
    required double changePercentage,
  }) {
    Widget detailScreen;

    switch (assetType) {
      case AssetType.stocks:
        detailScreen = AssetHoldingDetailScreen(
          ticker: ticker,
          companyName: name,
          currentPrice: currentPrice,
          change: change,
          changePercentage: changePercentage,
        );
        break;
      case AssetType.mutualFunds:
        detailScreen = MutualFundsDetailScreen(
          ticker: ticker,
          fundName: name,
          currentPrice: currentPrice,
          change: change,
          changePercentage: changePercentage,
        );
        break;
      case AssetType.tBills:
        detailScreen = TBillDetailScreen(
          tbillCode: ticker,
          description: name,
          currentRate: currentPrice,
          change: change,
        );
        break;
      default:
        // For other asset types, navigate to stock detail as fallback
        detailScreen = AssetHoldingDetailScreen(
          ticker: ticker,
          companyName: name,
          currentPrice: currentPrice,
          change: change,
          changePercentage: changePercentage,
        );
    }

    NavigationHelper.navigateTo(context, detailScreen);
  }
}
