import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../cash_wallet/presentation/interface/screens/cash_wallet_screen.dart';
import '../../../../dashboard/domain/entities/asset.dart';
import '../../../../dashboard/presentation/interface/widgets/activity_list_item.dart';
import '../../../../dashboard/presentation/interface/widgets/performance_chart.dart';
import '../../../../dashboard/presentation/interface/widgets/portfolio_value_card.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../../../../transactions/presentation/interface/screens/transactions_screen.dart';
import '../widgets/asset_holding_card.dart';
import '../widgets/cash_wallet_section.dart';
import '../widgets/portfolio_asset_breakdown.dart';
import 'all_asset_holdings_screen.dart';
import 'asset_holding_detail_screen.dart';
import 'mutual_funds_detail_screen.dart';
import 'portfolio_summary_screen.dart';
import 'tbill_detail_screen.dart';

/// Portfolio tab - displays complete portfolio overview
class PortfolioTab extends StatelessWidget {
  const PortfolioTab({super.key});

  /// Build broker assets data (dummy data for now)
  List<Asset> _getBrokerAssets() {
    return const [
      Asset(
        name: 'Petra Investments',
        value: 3868.36,
        percentage: 30.0,
        type: AssetType.stocks,
      ),
      Asset(
        name: 'Databank',
        value: 5157.81,
        percentage: 40.0,
        type: AssetType.tBills,
      ),
      Asset(
        name: 'Apakan',
        value: 3868.36,
        percentage: 30.0,
        type: AssetType.cashWallet,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.portfolio,
        showBackButton: false,
        actions: [
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            icon: Icon(
              Icons.more_vert,
              color: AppColors.primaryText(context),
              size: 22,
            ),
            onSelected: (value) {
              if (value == 'summary') {
                NavigationHelper.navigateTo(
                  context,
                  const PortfolioSummaryScreen(),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'summary',
                child: Text('See portfolio summary'),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<DashboardProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingPortfolio || provider.isLoadingActivities) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.portfolioSummary == null) {
            return Center(
              child: AppText.small(
                'No portfolio data available',
                color: AppColors.secondaryText(context),
              ),
            );
          }

          final portfolioSummary = provider.portfolioSummary!;
          final recentActivities = provider.recentActivities;
          final userProfile = provider.userProfile;

          return RefreshIndicator(
            onRefresh: () => provider.refresh(),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Portfolio Value Card
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: PortfolioValueCard(
                        portfolioSummary: portfolioSummary,
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),

                  // Performance Chart
                  const SliverToBoxAdapter(child: PerformanceChart()),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),

                  // Asset Breakdown Section
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AppText.medium(
                            'Asset Breakdown',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText(context),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        PortfolioAssetBreakdown(
                          assetsByClass: portfolioSummary.assets,
                          assetsByBroker: _getBrokerAssets(),
                        ),
                      ],
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 32)),

                  // Asset Holdings Section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.medium(
                            'Asset Holdings',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText(context),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              NavigationHelper.navigateTo(
                                context,
                                const AllAssetHoldingsScreen(),
                              );
                            },
                            child: AppText.smaller(
                              'View all',
                              color: AppColors.appPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Asset Holding Cards
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Sample asset holdings (replace with real data)
                          AssetHoldingCard(
                            companyName: 'Scancom PLC',
                            brokerName: 'Databank Brokerage',
                            value: 2098,
                            changePercentage: 1.15,
                            shares: 150,
                            assetType: AssetType.stocks,
                            onTap: () {
                              _navigateToAssetDetail(
                                context,
                                AssetType.stocks,
                                ticker: 'GSE.MTNGH',
                                name: 'Scancom PLC',
                                currentPrice: 4.02,
                                change: 0.10,
                                changePercentage: 2.3,
                              );
                            },
                          ),
                          AssetHoldingCard(
                            companyName: 'IC Liquidity Fund',
                            brokerName: 'IC Asset Managers',
                            value: 2025,
                            changePercentage: 0.89,
                            shares: 1000,
                            assetType: AssetType.mutualFunds,
                            onTap: () {
                              _navigateToAssetDetail(
                                context,
                                AssetType.mutualFunds,
                                ticker: 'ICLF',
                                name: 'IC Liquidity Fund',
                                currentPrice: 2.0231,
                                change: 0.0001,
                                changePercentage: 0.89,
                              );
                            },
                          ),
                          AssetHoldingCard(
                            companyName: 'TB 27-OCT-25',
                            brokerName: 'Government of Ghana',
                            value: 10000,
                            changePercentage: -0.34,
                            shares: 10000,
                            assetType: AssetType.tBills,
                            onTap: () {
                              _navigateToAssetDetail(
                                context,
                                AssetType.tBills,
                                ticker: 'TB 27-OCT-25',
                                name: 'GOG 91-Day Treasury Bill',
                                currentPrice: 10.83,
                                change: -0.66,
                                changePercentage: -0.34,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),

                  // Cash Wallet Section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.medium(
                            'Cash Wallet',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText(context),
                            ),
                          ),
                          const SizedBox(height: 16),
                          CashWalletSection(
                            balance: 21090.00,
                            userName: userProfile?['name'] ?? 'Frui Kyei',
                            onTap: () {
                              NavigationHelper.navigateTo(
                                context,
                                CashWalletScreen(dashboardProvider: provider),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 32)),

                  // Transactions Section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.medium(
                            'Transactions',
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
                              'View all',
                              color: AppColors.appPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Recent Transactions List
                  if (recentActivities.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 32,
                        ),
                        child: Center(
                          child: AppText.small(
                            'No transactions yet',
                            color: AppColors.secondaryText(context),
                          ),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final activity = recentActivities[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ActivityListItem(
                              activity: activity,
                              onTap: () {
                                // TODO: Show transaction details
                              },
                            ),
                          );
                        },
                        childCount: recentActivities.length > 5
                            ? 5
                            : recentActivities.length,
                      ),
                    ),

                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ),
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
