import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';

/// Portfolio Summary screen showing detailed investment metrics
class PortfolioSummaryScreen extends StatelessWidget {
  const PortfolioSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: 'GHS ',
      decimalDigits: 2,
    );

    return Scaffold(
      backgroundColor: AppColors.offWhite(context),
      appBar: MulaAppBar(title: context.localize.portfolioSummary),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 6,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.border(context),
          height: 32,
          thickness: 0.5,
        ),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return _buildSummaryItem(
                context,
                label: context.localize.totalInvestmentValue,
                value: currencyFormat.format(5304.05),
              );
            case 1:
              return _buildSummaryItem(
                context,
                label: context.localize.totalDeposit,
                value: currencyFormat.format(4800.00),
              );
            case 2:
              return _buildSummaryItem(
                context,
                label: context.localize.totalWithdrawal,
                value: currencyFormat.format(0.00),
              );
            case 3:
              return _buildSummaryItem(
                context,
                label: context.localize.realizedIncome,
                value: currencyFormat.format(0.00),
              );
            case 4:
              return _buildSummaryItem(
                context,
                label: context.localize.unrealizedIncome,
                value: currencyFormat.format(504.05),
              );
            case 5:
              return _buildSummaryItem(
                context,
                label: context.localize.cumulativeReturn,
                value: '12.5%',
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildSummaryItem(
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
        const SizedBox(height: 8),
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
