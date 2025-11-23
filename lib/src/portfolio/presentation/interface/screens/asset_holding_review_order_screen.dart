import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/confetti_success_screen.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../domain/entities/trade_type.dart';

class AssetHoldingReviewOrderScreen extends StatelessWidget {
  final TradeType tradeType;
  final String ticker;
  final String companyName;
  final double orderPrice;
  final double shares;
  final double grossConsideration;
  final double totalCharges;
  final double netConsideration;
  final String broker;
  final double availableCashBalance;
  final String orderType;

  const AssetHoldingReviewOrderScreen({
    super.key,
    required this.tradeType,
    required this.ticker,
    required this.companyName,
    required this.orderPrice,
    required this.shares,
    required this.grossConsideration,
    required this.totalCharges,
    required this.netConsideration,
    required this.broker,
    required this.availableCashBalance,
    required this.orderType,
  });

  void _handleConfirm(BuildContext context) {
    NavigationHelper.navigateTo(
      context,
      ConfettiSuccessScreen(
        title: context.localize.orderSuccessful,
        description: context.localize.orderSubmittedBroker,
        primaryButtonText: context.localize.trackInPortfolio,
        onPrimaryButtonTap: () {
          // Navigate back to dashboard
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        secondaryButtonText: context.localize.tradeOtherStocks,
        onSecondaryButtonTap: () {
          // Pop back to dashboard
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(title: context.localize.reviewOrder, showBottomDivider: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.small(
                    tradeType == TradeType.buy
                        ? context.localize.confirmDetailsBeforeBuy
                        : context.localize.confirmDetailsBeforeSell,
                    color: AppColors.secondaryText(context),
                  ),
                  const SizedBox(height: 16),

                  // Stock Info Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite(context),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border(context)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium(
                          ticker,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText(context),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText.small(
                              companyName,
                              color: AppColors.secondaryText(context),
                            ),
                            AppText.small(
                              'GHS ${orderPrice.toStringAsFixed(4)}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Transaction Details
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderType == 'limit' ? 8 : 7,
                    separatorBuilder: (context, index) =>
                        Divider(color: AppColors.border(context), height: 24),
                    itemBuilder: (context, index) {
                      return _buildDetailRowByIndex(context, index);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom Confirm Button
          Container(
            padding: const EdgeInsets.all(16).copyWith(bottom: 32),
            child: AppButton(
              text: context.localize.confirm,
              onTap: () => _handleConfirm(context),
              backgroundColor: AppColors.appPrimary,
              textColor: AppColors.white(context),
              borderRadius: 12,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRowByIndex(BuildContext context, int index) {
    if (orderType == 'limit') {
      // Limit order: 8 rows with Order Type at top
      switch (index) {
        case 0:
          return _buildDetailRow(context, context.localize.orderType, context.localize.limitOrder);
        case 1:
          return _buildDetailRow(
            context,
            context.localize.orderPrice,
            'GHS ${orderPrice.toStringAsFixed(2)}',
          );
        case 2:
          return _buildDetailRow(
            context,
            context.localize.numberOfShares,
            shares.toStringAsFixed(4),
          );
        case 3:
          return _buildDetailRow(
            context,
            context.localize.grossConsideration,
            'GHS ${grossConsideration.toStringAsFixed(2)}',
          );
        case 4:
          return _buildDetailRow(
            context,
            context.localize.totalCharges,
            'GHS ${totalCharges.toStringAsFixed(2)}',
          );
        case 5:
          return _buildDetailRow(
            context,
            context.localize.netConsideration,
            'GHS ${netConsideration.toStringAsFixed(2)}',
          );
        case 6:
          return _buildDetailRow(context, context.localize.broker, broker);
        case 7:
          return _buildDetailRow(
            context,
            context.localize.availableCashBalance,
            'GHS ${availableCashBalance.toStringAsFixed(2)}',
          );
        default:
          return const SizedBox.shrink();
      }
    } else {
      // Market order: 7 rows without Order Type
      switch (index) {
        case 0:
          return _buildDetailRow(
            context,
            context.localize.currentPrice,
            'GHS ${orderPrice.toStringAsFixed(2)}',
          );
        case 1:
          return _buildDetailRow(
            context,
            context.localize.numberOfShares,
            shares.toStringAsFixed(4),
          );
        case 2:
          return _buildDetailRow(
            context,
            context.localize.grossConsideration,
            'GHS ${grossConsideration.toStringAsFixed(2)}',
          );
        case 3:
          return _buildDetailRow(
            context,
            context.localize.totalCharges,
            'GHS ${totalCharges.toStringAsFixed(2)}',
          );
        case 4:
          return _buildDetailRow(
            context,
            context.localize.netConsideration,
            'GHS ${netConsideration.toStringAsFixed(2)}',
          );
        case 5:
          return _buildDetailRow(context, context.localize.broker, broker);
        case 6:
          return _buildDetailRow(
            context,
            context.localize.availableCashBalance,
            'GHS ${availableCashBalance.toStringAsFixed(2)}',
          );
        default:
          return const SizedBox.shrink();
      }
    }
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.small(label, color: AppColors.secondaryText(context)),
        AppText.small(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.primaryText(context),
          ),
        ),
      ],
    );
  }
}
