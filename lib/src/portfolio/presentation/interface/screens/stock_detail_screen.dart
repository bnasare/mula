import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../dashboard/presentation/interface/widgets/performance_chart.dart';
import '../../../domain/entities/trade_type.dart';
import 'advanced_chart_screen.dart';
import 'stock_choose_order_type_screen.dart';

/// Stock Detail screen showing comprehensive stock information
class StockDetailScreen extends StatelessWidget {
  final String ticker;
  final String companyName;
  final double currentPrice;
  final double change;
  final double changePercentage;

  const StockDetailScreen({
    super.key,
    required this.ticker,
    required this.companyName,
    required this.currentPrice,
    required this.change,
    required this.changePercentage,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: 'GHS ',
      decimalDigits: 2,
    );
    final isPositive = change >= 0;

    return Scaffold(
      appBar: MulaAppBar(title: context.localize.stocks),
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
                        // Left: Ticker and Company Name
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.small(
                                ticker,
                                color: AppColors.secondaryText(context),
                              ),
                              const SizedBox(height: 4),
                              AppText.large(
                                companyName,
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
                              currencyFormat.format(currentPrice),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText.small(
                                  '${currencyFormat.format(change.abs())} (',
                                  color: isPositive
                                      ? AppColors.appPrimary
                                      : AppColors.activityError,
                                ),
                                Icon(
                                  isPositive
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  size: 12,
                                  color: isPositive
                                      ? AppColors.appPrimary
                                      : AppColors.activityError,
                                ),
                                AppText.small(
                                  '${changePercentage.abs().toStringAsFixed(1)}%)',
                                  color: isPositive
                                      ? AppColors.appPrimary
                                      : AppColors.activityError,
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
                          NavigationHelper.navigateTo(
                            context,
                            AdvancedChartScreen(
                              ticker: ticker,
                              companyName: companyName,
                              currentPrice: currentPrice,
                              change: change,
                              changePercentage: changePercentage,
                            ),
                          );
                        },
                        child: AppText.smaller(
                          context.localize.seeAdvancedChart,
                          color: AppColors.appPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Performance Chart
              const PerformanceChart(),

              const SizedBox(height: 32),

              // Stock Details Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  separatorBuilder: (context, index) => Divider(
                    color: AppColors.border(context),
                    height: 24,
                    thickness: 0.5,
                  ),
                  itemBuilder: (context, index) {
                    return _buildStockDetailItem(context, index);
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
                      context.localize.myInvestments,
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
                                label: context.localize.currentValue,
                                value: currencyFormat.format(30000.00),
                              ),
                              const SizedBox(height: 16),
                              _buildInvestmentItem(
                                context,
                                label: context.localize.totalCost,
                                value: currencyFormat.format(23000.00),
                              ),
                              const SizedBox(height: 16),
                              _buildInvestmentItem(
                                context,
                                label: context.localize.returnLabel,
                                value: '30.4%',
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
                                label: context.localize.shares,
                                value: '10,000',
                                alignment: CrossAxisAlignment.end,
                              ),
                              const SizedBox(height: 16),
                              _buildInvestmentItem(
                                context,
                                label: context.localize.costPrice,
                                value: currencyFormat.format(2.50),
                                alignment: CrossAxisAlignment.end,
                              ),
                              const SizedBox(height: 16),
                              _buildInvestmentItem(
                                context,
                                label: context.localize.capitalGains,
                                value: currencyFormat.format(7000.00),
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
                        text: context.localize.sell,
                        onTap: () {
                          NavigationHelper.navigateTo(
                            context,
                            StockChooseOrderTypeScreen(
                              tradeType: TradeType.sell,
                              ticker: ticker,
                              companyName: companyName,
                              currentPrice: currentPrice,
                              availableCashBalance: 20.00, // TODO: Get from wallet
                              currentShares: 1000.0, // TODO: Get from holdings
                              broker: 'Databank', // TODO: Get from asset data
                            ),
                          );
                        },
                        backgroundColor: AppColors.transparent,
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
                        text: context.localize.buy,
                        onTap: () {
                          NavigationHelper.navigateTo(
                            context,
                            StockChooseOrderTypeScreen(
                              tradeType: TradeType.buy,
                              ticker: ticker,
                              companyName: companyName,
                              currentPrice: currentPrice,
                              availableCashBalance: 20.00, // TODO: Get from wallet
                              currentShares: null, // Not needed for buy
                              broker: 'Databank', // TODO: Get from asset data
                            ),
                          );
                        },
                        backgroundColor: AppColors.appPrimary,
                        textColor: AppColors.white(context),
                        borderRadius: 8,
                        padding: EdgeInsets.zero,
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
                      context.localize.about,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText(context),
                      ),
                    ),
                    const SizedBox(height: 12),
                    AppText(
                      'Scancom PLC, more commonly known as MTN Ghana, is a public limited liability company licensed by the NCA as a mobile telecommunications services operator. In November 1994, the company (then known as "Spacefon") launched its GSM mobile cellular services with initial coverage in Accra and Tema. Coverage was expanded to Kumasi and Obuasi in 1997, and to Takoradi, Bibiani, Tarkwa and Cape Coast in 1999.\n\nSince then, MTN has built a robust customer base in Ghana, increasing its subscribers from 2.5 million in 2006 to over 30 million as at June 2025. MTN Ghana revenue lines are airtime and subscription, interconnect and roaming, SMS, data, handset and accessories, mobile money, and value added services.\n\nData and mobile money are expected to be the dominant drivers of revenue due to increased internet use and reliance on mobile money for payments.',
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

              // Company Info Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (context, index) => Divider(
                    color: AppColors.border(context),
                    height: 24,
                    thickness: 0.5,
                  ),
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return _buildInfoItem(
                          context,
                          label: context.localize.dateOfIncorporation,
                          value: 'April 1994',
                        );
                      case 1:
                        return _buildInfoItem(
                          context,
                          label: context.localize.dateOfIpo,
                          value: '3rd September, 2018',
                        );
                      case 2:
                        return _buildInfoItem(
                          context,
                          label: context.localize.sector,
                          value: 'Telecommunications',
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockDetailItem(BuildContext context, int index) {
    final details = [
      (context.localize.previousClose, '3.98'),
      (context.localize.open, '3.97'),
      (context.localize.daysRange, '3.78 - 4.06'),
      (context.localize.volumeTraded, '125,348,479'),
      (context.localize.fiftyTwoWeekRange, '1.78 - 4.02'),
      (context.localize.peRatio, '7.45x'),
      (context.localize.earningsPerShare, '0.55'),
      (context.localize.dividendYield, '1.96%'),
      (context.localize.marketCap, '5,410B'),
      (context.localize.sharesOutstanding, '1,245,890,367,470'),
    ];

    if (index >= details.length) return const SizedBox.shrink();

    return _buildInfoItem(
      context,
      label: details[index].$1,
      value: details[index].$2,
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
}
