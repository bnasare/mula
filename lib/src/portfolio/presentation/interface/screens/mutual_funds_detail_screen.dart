import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../dashboard/presentation/interface/widgets/performance_chart.dart';
import '../../../../home/presentation/interface/widgets/asset_tab_button.dart';

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

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: 'GHS ',
      decimalDigits: 2,
    );
    final isPositive = widget.change >= 0;

    return Scaffold(
      backgroundColor: AppColors.offWhite(context),
      appBar: const MulaAppBar(
        title: 'Mutual Funds',
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

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
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Navigate to advanced chart
                        },
                        child: AppText.smaller(
                          'See Advanced Chart',
                          color: AppColors.appPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

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
        return _buildPlaceholderTab('Holdings');
      case 2:
        return _buildPlaceholderTab('Allocation');
      case 3:
        return _buildPlaceholderTab('Metrics');
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
                        ),
                        const SizedBox(height: 16),
                        _buildInvestmentItem(
                          context,
                          label: 'Cost Price',
                          value: currencyFormat.format(2.50),
                        ),
                        const SizedBox(height: 16),
                        _buildInvestmentItem(
                          context,
                          label: 'Capital Gains/(Losses)',
                          value: currencyFormat.format(2000.00),
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
                  context, 'Easy Access: Withdrawals processed within 1 business day.'),
              const SizedBox(height: 8),
              _buildBulletPoint(
                  context, 'Convenient: Invest any amount at regular intervals.'),
              const SizedBox(height: 8),
              _buildBulletPoint(
                  context, 'Safe & Managed: Professional management with focus on security.'),
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
                return _buildInfoItem(
                  context,
                  label: 'Rank',
                  value: '24',
                );
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          style: TextStyle(
            fontSize: 14,
            color: AppColors.primaryText(context),
          ),
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
}
