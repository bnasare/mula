import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/confetti_success_screen.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';

class TBillBidReviewScreen extends StatelessWidget {
  final String tbillName;
  final String tbillDescription;
  final double purchaseAmount;
  final double interestRate;
  final String bidType;
  final double totalCharges;
  final double netProceeds;
  final double maturityValue;
  final String maturityDate;
  final String broker;
  final double availableCashBalance;

  const TBillBidReviewScreen({
    super.key,
    required this.tbillName,
    required this.tbillDescription,
    required this.purchaseAmount,
    required this.interestRate,
    required this.bidType,
    required this.totalCharges,
    required this.netProceeds,
    required this.maturityValue,
    required this.maturityDate,
    required this.broker,
    required this.availableCashBalance,
  });

  void _handleConfirm(BuildContext context) {
    // Get provider reference before navigating to new route
    final dashboardProvider = context.read<DashboardProvider>();

    NavigationHelper.navigateTo(
      context,
      ConfettiSuccessScreen(
        title: context.localize.orderSuccessful,
        description: context.localize.orderSubmittedBroker,
        primaryButtonText: context.localize.trackInPortfolio,
        onPrimaryButtonTap: () {
          // Switch to Portfolio tab and navigate back to dashboard
          dashboardProvider.changeTab(2);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        secondaryButtonText: context.localize.tradeOtherSecurities,
        onSecondaryButtonTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.reviewOrder,
        showBottomDivider: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.small(
                    context.localize.confirmDetailsBeforeProceeding,
                    color: AppColors.secondaryText(context),
                  ),
                  const SizedBox(height: 16),

                  // T-Bill Info Container
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
                          tbillName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText(context),
                          ),
                        ),
                        const SizedBox(height: 4),
                        AppText.small(
                          tbillDescription,
                          color: AppColors.secondaryText(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Transaction Details
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 9,
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
    switch (index) {
      case 0:
        return _buildDetailRow(
          context,
          context.localize.purchaseAmount,
          'GHS ${purchaseAmount.toStringAsFixed(2)}',
        );
      case 1:
        return _buildDetailRow(
          context,
          context.localize.interestRate,
          '${interestRate.toStringAsFixed(2)}%',
        );
      case 2:
        return _buildDetailRow(context, context.localize.bidType, bidType);
      case 3:
        return _buildDetailRow(
          context,
          context.localize.totalCharges,
          'GHS ${totalCharges.toStringAsFixed(2)}',
        );
      case 4:
        return _buildDetailRow(
          context,
          context.localize.netProceeds,
          'GHS ${netProceeds.toStringAsFixed(2)}',
        );
      case 5:
        return _buildDetailRow(
          context,
          context.localize.maturityValue,
          'GHS ${maturityValue.toStringAsFixed(0)}',
        );
      case 6:
        return _buildDetailRow(
          context,
          context.localize.maturityDate,
          maturityDate,
        );
      case 7:
        return _buildDetailRow(context, context.localize.broker, broker);
      case 8:
        return _buildDetailRow(
          context,
          context.localize.availableCashBalance,
          'GHS ${availableCashBalance.toStringAsFixed(2)}',
        );
      default:
        return const SizedBox.shrink();
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
