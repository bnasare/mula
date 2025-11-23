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
import 'asset_holding_detail_screen.dart';
import 'portfolio_summary_screen.dart';

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
                              // TODO: Navigate to all assets screen
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
                            onTap: () {
                              NavigationHelper.navigateTo(
                                context,
                                const AssetHoldingDetailScreen(
                                  ticker: 'GSE.MTNGH',
                                  companyName: 'Scancom PLC',
                                  currentPrice: 4.02,
                                  change: 0.10,
                                  changePercentage: 2.3,
                                ),
                              );
                            },
                          ),
                          AssetHoldingCard(
                            companyName: 'Scancom PLC',
                            brokerName: 'Databank Brokerage',
                            value: 2098,
                            changePercentage: 1.15,
                            shares: 150,
                            onTap: () {
                              NavigationHelper.navigateTo(
                                context,
                                const AssetHoldingDetailScreen(
                                  ticker: 'GSE.MTNGH',
                                  companyName: 'Scancom PLC',
                                  currentPrice: 4.02,
                                  change: 0.10,
                                  changePercentage: 2.3,
                                ),
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
}
