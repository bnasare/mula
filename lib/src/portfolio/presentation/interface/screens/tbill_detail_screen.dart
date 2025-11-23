import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../dashboard/presentation/interface/widgets/performance_chart.dart';

/// T-Bill Detail screen showing comprehensive treasury bill information
class TBillDetailScreen extends StatelessWidget {
  final String tbillCode;
  final String description;
  final double currentRate;
  final double change;

  const TBillDetailScreen({
    super.key,
    required this.tbillCode,
    required this.description,
    required this.currentRate,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: 'GHS ',
      decimalDigits: 2,
    );
    final isPositive = change >= 0;

    return Scaffold(
      backgroundColor: AppColors.offWhite(context),
      appBar: const MulaAppBar(
        title: 'Treasury Bill',
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
                        // Left: T-Bill Code and Description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.large(
                                tbillCode,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              AppText.small(
                                description,
                                color: AppColors.secondaryText(context),
                              ),
                            ],
                          ),
                        ),
                        // Right: Rate and Change
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppText.large(
                              '${currentRate.toStringAsFixed(2)}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPositive
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  size: 12,
                                  color: isPositive
                                      ? AppColors.appPrimary
                                      : Colors.red,
                                ),
                                const SizedBox(width: 2),
                                AppText.small(
                                  '${change.abs().toStringAsFixed(1)}%',
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

              // Performance Chart
              const PerformanceChart(),

              const SizedBox(height: 32),

              // T-Bill Details Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (context, index) => Divider(
                    color: AppColors.border(context),
                    height: 24,
                    thickness: 0.5,
                  ),
                  itemBuilder: (context, index) {
                    return _buildTBillDetailItem(context, index);
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
                                label: 'Purchase Interest Rate',
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
                                label: 'Quantity',
                                value: '10,000',
                              ),
                              const SizedBox(height: 16),
                              _buildInvestmentItem(
                                context,
                                label: 'Accrued Interest',
                                value: currencyFormat.format(25.50),
                              ),
                              const SizedBox(height: 16),
                              _buildInvestmentItem(
                                context,
                                label: 'Capital Gains/(Losses)',
                                value: currencyFormat.format(2475.00),
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
                      'Treasury Bills are safe, short-term investments offered by the Government of Ghana. You invest for 91, 182, or 364 days, and earn a return when they mature.',
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

              // Additional Info Grid (2x2)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Left Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoItem(
                            context,
                            label: 'Type',
                            value: 'Treasury\nBill',
                          ),
                          const SizedBox(height: 24),
                          _buildInfoItem(
                            context,
                            label: 'Issuer',
                            value: 'Government of\nGhana',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    // Right Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoItem(
                            context,
                            label: 'Currency',
                            value: 'GHS',
                          ),
                          const SizedBox(height: 24),
                          _buildInfoItem(
                            context,
                            label: 'Maturity Date',
                            value: '27-\nOCT-25',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTBillDetailItem(BuildContext context, int index) {
    final Map<String, String> details = {
      'Current Rate': '10.83%',
      'Maturity Rate': '15.49%',
      'Issue Date': 'July 30, 2025',
      'Maturity Date': 'October 27, 2025',
      'Coupon Rate': 'N/A',
    };

    final keys = details.keys.toList();
    if (index >= keys.length) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          keys[index],
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryText(context),
          ),
        ),
        AppText(
          details[keys[index]]!,
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

  Widget _buildInfoItem(
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText(context),
          ),
        ),
      ],
    );
  }
}
