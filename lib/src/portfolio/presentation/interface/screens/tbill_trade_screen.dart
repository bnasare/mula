import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/market_status_indicator.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../authentication/presentation/interface/widgets/mula_text_field.dart';
import '../../../domain/entities/trade_type.dart';
import 'tbill_review_order_screen.dart';

class TBillTradeScreen extends StatefulWidget {
  final TradeType tradeType;
  final String tbillCode;
  final String tbillDescription;
  final double interestRate;
  final double availableCashBalance;
  final double? currentHoldings; // For sell: amount user currently holds

  const TBillTradeScreen({
    super.key,
    required this.tradeType,
    required this.tbillCode,
    required this.tbillDescription,
    required this.interestRate,
    required this.availableCashBalance,
    this.currentHoldings,
  });

  @override
  State<TBillTradeScreen> createState() => _TBillTradeScreenState();
}

class _TBillTradeScreenState extends State<TBillTradeScreen> {
  final TextEditingController _amountController = TextEditingController();
  double _amount = 0;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    if (_amount <= 0) return false;

    // For sell, check if amount doesn't exceed holdings
    if (widget.tradeType == TradeType.sell && widget.currentHoldings != null) {
      if (_amount > widget.currentHoldings!) return false;
    }

    // For buy, check if net consideration doesn't exceed available balance
    if (widget.tradeType == TradeType.buy) {
      if (_netConsideration > widget.availableCashBalance) return false;
    }

    return true;
  }

  double get _grossConsideration => _amount;

  double get _totalCharges => _grossConsideration * 0.025; // 2.5%

  double get _netConsideration {
    if (widget.tradeType == TradeType.buy) {
      return _grossConsideration + _totalCharges;
    } else {
      return _grossConsideration - _totalCharges;
    }
  }

  double get _estimatedMaturityValue {
    // Simple calculation: gross + interest
    return _grossConsideration * (1 + widget.interestRate / 100);
  }

  void _handleAmountChange(String value) {
    setState(() {
      _amount = double.tryParse(value) ?? 0;
    });
  }

  void _handlePercentageTap(double percentage) {
    final double baseAmount;

    if (widget.tradeType == TradeType.sell) {
      // For sell, calculate from current holdings
      baseAmount = widget.currentHoldings ?? 0;
    } else {
      // For buy, calculate from available cash (minus charges)
      // Work backwards: if user wants to use X% of cash, what can they buy?
      final availableForPercentage = widget.availableCashBalance * percentage;
      // net = gross + charges, where charges = gross * 0.025
      // net = gross * 1.025
      // gross = net / 1.025
      baseAmount = availableForPercentage / 1.025;
    }

    final amount = baseAmount * percentage;
    _amountController.text = amount.toStringAsFixed(2);
    _handleAmountChange(_amountController.text);
  }

  void _handleReview() {
    NavigationHelper.navigateTo(
      context,
      TBillReviewOrderScreen(
        tradeType: widget.tradeType,
        tbillCode: widget.tbillCode,
        tbillDescription: widget.tbillDescription,
        interestRate: widget.interestRate,
        grossConsideration: _grossConsideration,
        totalCharges: _totalCharges,
        netConsideration: _netConsideration,
        estimatedMaturityValue: _estimatedMaturityValue,
        availableCashBalance: widget.availableCashBalance,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: MulaAppBar(title: widget.tradeType.displayName),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Market Status
                  const MarketStatusIndicator(),
                  const SizedBox(height: 16),

                  // T-Bill Info
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite(context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium(
                          widget.tbillCode,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText(context),
                          ),
                        ),
                        const SizedBox(height: 4),
                        AppText.small(
                          widget.tbillDescription,
                          color: AppColors.secondaryText(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Amount Input
                        AppText.small(
                          widget.tradeType.questionText,
                          color: AppColors.secondaryText(context),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            AppText.medium(
                              'GHS ',
                              style: TextStyle(
                                color: AppColors.primaryText(context),
                              ),
                            ),
                            Expanded(
                              child: MulaTextField(
                                controller: _amountController,
                                hintText: '0.00',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}'),
                                  ),
                                ],
                                onChanged: _handleAmountChange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Percentage Buttons
                        Row(
                          children: [
                            _buildPercentageButton('25%', 0.25),
                            const SizedBox(width: 8),
                            _buildPercentageButton('50%', 0.50),
                            const SizedBox(width: 8),
                            _buildPercentageButton('75%', 0.75),
                            const SizedBox(width: 8),
                            _buildPercentageButton('100%', 1.0),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Calculation Details
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          separatorBuilder: (context, index) => Divider(
                            color: AppColors.border(context),
                            height: 24,
                          ),
                          itemBuilder: (context, index) {
                            return _buildDetailRowByIndex(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            padding: const EdgeInsets.all(16).copyWith(bottom: 32),
            decoration: BoxDecoration(),
            child: AppButton(
              text: context.localize.review,
              onTap: _isFormValid ? _handleReview : null,
              backgroundColor: _isFormValid
                  ? AppColors.appPrimary
                  : AppColors.border(context),
              textColor: Colors.white,
              borderRadius: 12,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildPercentageButton(String label, double percentage) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _handlePercentageTap(percentage),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.background(context),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border(context)),
          ),
          child: Center(
            child: AppText.small(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRowByIndex(int index) {
    switch (index) {
      case 0:
        return _buildDetailRow(
          context.localize.interestRate,
          '${widget.interestRate.toStringAsFixed(2)}%',
        );
      case 1:
        return _buildDetailRow(
          context.localize.grossConsideration,
          'GHS ${_grossConsideration.toStringAsFixed(2)}',
        );
      case 2:
        return _buildDetailRow(
          'Total Charges',
          'GHS ${_totalCharges.toStringAsFixed(2)}',
        );
      case 3:
        return _buildDetailRow(
          'Net Consideration',
          'GHS ${_netConsideration.toStringAsFixed(2)}',
          isHighlighted: true,
        );
      case 4:
        return _buildDetailRow(
          'Estimated Maturity Value',
          'GHS ${_estimatedMaturityValue.toStringAsFixed(2)}',
        );
      case 5:
        return _buildDetailRow(
          'Available Cash Balance',
          'GHS ${widget.availableCashBalance.toStringAsFixed(2)}',
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.small(label, color: AppColors.secondaryText(context)),
        AppText.small(
          value,
          style: TextStyle(
            fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
            color: AppColors.primaryText(context),
          ),
        ),
      ],
    );
  }
}
