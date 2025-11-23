import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../dashboard/domain/entities/asset.dart';
import '../../../../dashboard/presentation/interface/widgets/asset_donut_chart.dart';
import '../../../../dashboard/presentation/interface/widgets/performance_chart.dart';
import '../../../../home/presentation/interface/widgets/asset_tab_button.dart';
import 'advanced_chart_screen.dart';

/// Mutual Funds Detail screen showing comprehensive fund information
class MutualFundsDetailScreen extends StatefulWidget {
  final String ticker;
  final String fundName;
  final double currentPrice;
  final double change;
  final double changePercentage;

  const MutualFundsDetailScreen({
    super.key,
    required this.ticker,
    required this.fundName,
    required this.currentPrice,
    required this.change,
    required this.changePercentage,
  });

  @override
  State<MutualFundsDetailScreen> createState() =>
      _MutualFundsDetailScreenState();
}

class _MutualFundsDetailScreenState extends State<MutualFundsDetailScreen> {
  int _selectedTab = 0; // 0: Overview, 1: Holdings, 2: Allocation, 3: Metrics
  String _allocationFilter = 'Country'; // 'Country' or 'Sector'

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: 'GHS ',
      decimalDigits: 2,
    );
    final isPositive = widget.change >= 0;

    return Scaffold(
      appBar: const MulaAppBar(title: 'Mutual Funds'),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Tab Bar
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
                          label: 'Overview',
                          isActive: _selectedTab == 0,
                          onTap: () => setState(() => _selectedTab = 0),
                        ),
                      ),
                      Expanded(
                        child: AssetTabButton(
                          label: 'Holdings',
                          isActive: _selectedTab == 1,
                          onTap: () => setState(() => _selectedTab = 1),
                        ),
                      ),
                      Expanded(
                        child: AssetTabButton(
                          label: 'Allocation',
                          isActive: _selectedTab == 2,
                          onTap: () => setState(() => _selectedTab = 2),
                        ),
                      ),
                      Expanded(
                        child: AssetTabButton(
                          label: 'Metrics',
                          isActive: _selectedTab == 3,
                          onTap: () => setState(() => _selectedTab = 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Header Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: Ticker and Fund Name
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.small(
                                widget.ticker,
                                color: AppColors.secondaryText(context),
                              ),
                              const SizedBox(height: 4),
                              AppText.large(
                                widget.fundName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Right: Price and Change
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppText.large(
                              currencyFormat.format(widget.currentPrice),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText.small(
                                  '${currencyFormat.format(widget.change.abs())} (',
                                  color: isPositive
                                      ? AppColors.appPrimary
                                      : Colors.red,
                                ),
                                Icon(
                                  isPositive
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  size: 12,
                                  color: isPositive
                                      ? AppColors.appPrimary
                                      : Colors.red,
                                ),
                                AppText.small(
                                  '${widget.changePercentage.abs().toStringAsFixed(1)}%)',
                                  color: isPositive
                                      ? AppColors.appPrimary
                                      : Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (_selectedTab == 0 || _selectedTab == 3) ...[
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            NavigationHelper.navigateTo(
                              context,
                              AdvancedChartScreen(
                                ticker: widget.ticker,
                                companyName: widget.fundName,
                                currentPrice: widget.currentPrice,
                                change: widget.change,
                                changePercentage: widget.changePercentage,
                              ),
                            );
                          },
                          child: AppText.smaller(
                            'See Advanced Chart',
                            color: AppColors.appPrimary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Tab Content
              _buildTabContent(currencyFormat),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(NumberFormat currencyFormat) {
    switch (_selectedTab) {
      case 0:
        return _buildOverviewTab(currencyFormat);
      case 1:
        return _buildHoldingsTab();
      case 2:
        return _buildAllocationTab();
      case 3:
        return _buildMetricsTab();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildOverviewTab(NumberFormat currencyFormat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Performance Chart
        const PerformanceChart(),

        const SizedBox(height: 32),

        // Fund Details Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            separatorBuilder: (context, index) => Divider(
              color: AppColors.border(context),
              height: 24,
              thickness: 0.5,
            ),
            itemBuilder: (context, index) {
              return _buildFundDetailItem(context, index);
            },
          ),
        ),

        const SizedBox(height: 32),

        // My Investments Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(
                'My Investments',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // Left Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInvestmentItem(
                          context,
                          label: 'Current Value',
                          value: currencyFormat.format(30000.00),
                        ),
                        const SizedBox(height: 16),
                        _buildInvestmentItem(
                          context,
                          label: 'Total Cost',
                          value: currencyFormat.format(28000.00),
                        ),
                        const SizedBox(height: 16),
                        _buildInvestmentItem(
                          context,
                          label: 'Return',
                          value: '23.5%',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Right Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildInvestmentItem(
                          context,
                          label: 'Units',
                          value: '10,000',
                          alignment: CrossAxisAlignment.end,
                        ),
                        const SizedBox(height: 16),
                        _buildInvestmentItem(
                          context,
                          label: 'Cost Price',
                          value: currencyFormat.format(2.50),
                          alignment: CrossAxisAlignment.end,
                        ),
                        const SizedBox(height: 16),
                        _buildInvestmentItem(
                          context,
                          label: 'Capital Gains/(Losses)',
                          value: currencyFormat.format(2000.00),
                          alignment: CrossAxisAlignment.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Action Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Sell',
                  onTap: () {
                    // TODO: Implement sell
                  },
                  backgroundColor: Colors.transparent,
                  textColor: AppColors.primaryText(context),
                  borderColor: AppColors.border(context),
                  borderWidth: 1,
                  borderRadius: 8,
                  padding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: 'Buy',
                  onTap: () {
                    // TODO: Implement buy
                  },
                  backgroundColor: AppColors.appPrimary,
                  textColor: Colors.white,
                  borderRadius: 8,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Industry Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(
                'Industry',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
              ),
              const SizedBox(height: 8),
              AppText(
                '22nd June 2025',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryText(context),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // About Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(
                'About',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
              ),
              const SizedBox(height: 12),
              AppText(
                'The ICLF is a mutual fund that invests mainly in safe, highly liquid fixed income securities from the Government of Ghana and selected banks. It\'s designed to maximize short-term returns while keeping your money accessible.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.primaryText(context),
                ),
              ),
              const SizedBox(height: 12),
              _buildBulletPoint(
                context,
                'Easy Access: Withdrawals processed within 1 business day.',
              ),
              const SizedBox(height: 8),
              _buildBulletPoint(
                context,
                'Convenient: Invest any amount at regular intervals.',
              ),
              const SizedBox(height: 8),
              _buildBulletPoint(
                context,
                'Safe & Managed: Professional management with focus on security.',
              ),
              const SizedBox(height: 12),
              AppText(
                'Put your cash to work simply, safely, and with flexibility.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.primaryText(context),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Additional Info Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            separatorBuilder: (context, index) => Divider(
              color: AppColors.border(context),
              height: 24,
              thickness: 0.5,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildInfoItem(
                  context,
                  label: 'Currency',
                  value: 'Ghana Cedi',
                );
              } else {
                return _buildInfoItem(context, label: 'Rank', value: '24');
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderTab(String tabName) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: AppText.medium(
          '$tabName - Coming Soon',
          color: AppColors.secondaryText(context),
        ),
      ),
    );
  }

  Widget _buildFundDetailItem(BuildContext context, int index) {
    final Map<String, String> details = {
      'Previous Close(GHS)': '2.0229',
      'Net Asset Value(GHS)': '171.7M',
      '52-Week Range(GHS)': '1.7846 - 2.0231',
      'Minimum Investment(GHS)': '100.00',
      'Fund Manager': 'IC Asset Managers',
      'Fund Type': 'Fixed Income',
      'Management Fee': '2.5% AUM',
      'Inception Date': 'April 29, 2022',
    };

    final keys = details.keys.toList();
    if (index >= keys.length) return const SizedBox.shrink();

    return _buildInfoItem(
      context,
      label: keys[index],
      value: details[keys[index]]!,
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AppText(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryText(context),
            ),
          ),
        ),
        AppText(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText(context),
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentItem(
    BuildContext context, {
    required String label,
    required String value,
    CrossAxisAlignment alignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        AppText(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryText(context),
          ),
        ),
        const SizedBox(height: 4),
        AppText(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText(context),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          '• ',
          style: TextStyle(fontSize: 14, color: AppColors.primaryText(context)),
        ),
        Expanded(
          child: AppText(
            text,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppColors.primaryText(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHoldingsTab() {
    // Get actual holdings data
    final holdingsAssets = _getHoldingsData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Holdings Donut Chart with center text
        Stack(
          alignment: Alignment.center,
          children: [
            AssetDonutChart(assets: holdingsAssets),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    '${holdingsAssets.length}',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText(context),
                    ),
                  ),
                  AppText.small(
                    'Holdings',
                    color: AppColors.secondaryText(context),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Holdings List
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: holdingsAssets.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final asset = holdingsAssets[index];
              return _buildHoldingItem(
                name: asset.name,
                sector: 'Information Technology',
                company: 'Company Inc',
                percentage: asset.percentage,
                assetType: asset.type,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHoldingItem({
    required String name,
    required String sector,
    required String company,
    required double percentage,
    required AssetType assetType,
  }) {
    return Row(
      children: [
        // Color indicator matching donut chart
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: assetType.color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: assetType.color, width: 2),
          ),
        ),
        const SizedBox(width: 12),

        // Company info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.small(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
                maxLines: 1,
                clipped: true,
                softWrap: false,
              ),
              const SizedBox(height: 2),
              AppText.smallest(
                sector,
                color: AppColors.secondaryText(context),
                maxLines: 1,
                clipped: true,
                softWrap: false,
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        // Percentage and company
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.small(
              '${percentage.toStringAsFixed(2)}%',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.primaryText(context),
              ),
            ),
            const SizedBox(height: 2),
            AppText.smallest(
              company,
              color: AppColors.secondaryText(context),
              maxLines: 1,
              clipped: true,
              softWrap: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAllocationTab() {
    // Get allocation data as Asset objects (already includes correct colors)
    final allocationAssets = _getAllocationData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with dropdown
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.medium(
                'Allocation',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
              ),
              PopupMenuButton<String>(
                position: PopupMenuPosition.under,
                onSelected: (value) {
                  setState(() {
                    _allocationFilter = value;
                  });
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'Country',
                    child: AppText.small(
                      'Country',
                      color: AppColors.primaryText(context),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Sector',
                    child: AppText.small(
                      'Sector',
                      color: AppColors.primaryText(context),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Asset Class',
                    child: AppText.small(
                      'Asset Class',
                      color: AppColors.primaryText(context),
                    ),
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.grey(context).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText.smaller(
                        _allocationFilter,
                        color: AppColors.primaryText(context),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: AppColors.primaryText(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Chart - Show bar chart for Asset Class, donut chart for others
        if (_allocationFilter == 'Asset Class')
          _buildBarChart(allocationAssets)
        else
          AssetDonutChart(assets: allocationAssets),

        const SizedBox(height: 24),

        // List header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.small(
                _allocationFilter,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
              ),
              AppText.small(
                'Weight',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Allocation List
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: allocationAssets.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final asset = allocationAssets[index];
              return _buildAllocationItem(
                name: asset.name,
                percentage: asset.percentage,
                color: asset.type.color,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAllocationItem({
    required String name,
    required double percentage,
    required Color color,
  }) {
    return Row(
      children: [
        // Color indicator
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),

        // Name
        Expanded(
          child: AppText.small(name, color: AppColors.primaryText(context)),
        ),

        // Percentage
        AppText.small(
          '${percentage.toStringAsFixed(2)}%',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.primaryText(context),
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart(List<Asset> assets) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Bar charts
          ...assets.map((asset) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: asset.percentage / 100,
                        minHeight: 32,
                        backgroundColor: AppColors.grey(
                          context,
                        ).withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          asset.type.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 8),

          // Axis labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.smallest('0', color: AppColors.secondaryText(context)),
              AppText.smallest('25', color: AppColors.secondaryText(context)),
              AppText.smallest('50', color: AppColors.secondaryText(context)),
              AppText.smallest('75', color: AppColors.secondaryText(context)),
              AppText.smallest('100', color: AppColors.secondaryText(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsTab() {
    final metrics = [
      {'label': 'Annualized Returns', 'value': '12.5%'},
      {'label': 'Average Gain', 'value': '+0.3518'},
      {'label': 'Average Loss', 'value': '-0.2719'},
      {'label': 'Maximum Drawdown', 'value': '-1.3428'},
      {'label': 'Sharpe Ratio', 'value': '0.63'},
      {'label': 'Sortino Ratio', 'value': '0.39'},
      {'label': 'Alpha', 'value': '0.57'},
      {'label': 'Beta', 'value': '2.4'},
      {'label': 'Loads', 'value': '0.075%'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Performance Chart
        const PerformanceChart(),

        const SizedBox(height: 32),

        // Metrics List
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: metrics.length,
            separatorBuilder: (context, index) => Divider(
              color: AppColors.border(context),
              height: 24,
              thickness: 0.5,
            ),
            itemBuilder: (context, index) {
              final metric = metrics[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    metric['label']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText(context),
                    ),
                  ),
                  AppText(
                    metric['value']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText(context),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 32),

        // About Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(
                'About',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText(context),
                ),
              ),
              const SizedBox(height: 12),
              AppText(
                'The Enhanced Equity Beta Fund (EEBF) is an open-ended equity mutual fund that primarily invests in global equities, with a strong emphasis on technology sectors.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.primaryText(context),
                ),
              ),
              const SizedBox(height: 12),
              AppText(
                'It aims to capitalize on the ongoing 4th industrial revolution, focusing on companies involved in AI, semiconductors, cybersecurity, and electric vehicles.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.primaryText(context),
                ),
              ),
              const SizedBox(height: 12),
              AppText(
                'The fund is designed for long-term capital appreciation through a diversified portfolio of equities and equity-related instruments.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.primaryText(context),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Currency and Rank
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // Left Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Currency',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryText(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      'Ghana Cedi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText(context),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              // Right Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      'Rank',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryText(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      '53',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Asset> _getHoldingsData() {
    return const [
      Asset(
        name: 'MTN Ghana',
        value: 2200.00,
        percentage: 22.02,
        type: AssetType.stocks,
      ),
      Asset(
        name: 'Access Bank',
        value: 2100.00,
        percentage: 21.02,
        type: AssetType.tBills,
      ),
      Asset(
        name: 'Republic Bank',
        value: 4100.00,
        percentage: 41.02,
        type: AssetType.mutualFunds,
      ),
      Asset(
        name: 'Treasury Bills',
        value: 1100.00,
        percentage: 11.02,
        type: AssetType.bonds,
      ),
      Asset(
        name: 'Other Holdings',
        value: 3100.00,
        percentage: 31.02,
        type: AssetType.reits,
      ),
    ];
  }

  List<Asset> _getAllocationData() {
    if (_allocationFilter == 'Country') {
      return const [
        Asset(
          name: 'Taiwan',
          value: 2200.00,
          percentage: 22.02,
          type: AssetType.stocks,
        ),
        Asset(
          name: 'Egypt',
          value: 2100.00,
          percentage: 21.02,
          type: AssetType.tBills,
        ),
        Asset(
          name: 'Kenya',
          value: 4100.00,
          percentage: 41.02,
          type: AssetType.mutualFunds,
        ),
        Asset(
          name: 'Mali',
          value: 1100.00,
          percentage: 11.02,
          type: AssetType.bonds,
        ),
        Asset(
          name: 'Finland',
          value: 3100.00,
          percentage: 31.02,
          type: AssetType.reits,
        ),
      ];
    } else if (_allocationFilter == 'Sector') {
      // Sector data
      return const [
        Asset(
          name: 'Information Technology',
          value: 2200.00,
          percentage: 22.02,
          type: AssetType.stocks,
        ),
        Asset(
          name: 'Communication Services',
          value: 2100.00,
          percentage: 21.02,
          type: AssetType.tBills,
        ),
        Asset(
          name: 'Financials',
          value: 4100.00,
          percentage: 41.02,
          type: AssetType.mutualFunds,
        ),
        Asset(
          name: 'Others',
          value: 1100.00,
          percentage: 11.02,
          type: AssetType.bonds,
        ),
        Asset(
          name: 'Industrials',
          value: 3100.00,
          percentage: 31.02,
          type: AssetType.reits,
        ),
      ];
    } else {
      // Asset Class data
      return const [
        Asset(
          name: 'Equities',
          value: 2200.00,
          percentage: 22.02,
          type: AssetType.stocks,
        ),
        Asset(
          name: 'Financials',
          value: 4100.00,
          percentage: 41.02,
          type: AssetType.mutualFunds,
        ),
        Asset(
          name: 'Cash and Cash Equivalents',
          value: 1100.00,
          percentage: 11.02,
          type: AssetType.cashWallet,
        ),
      ];
    }
  }
}
