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
import '../../../../home/presentation/interface/widgets/asset_tab_button.dart';
import '../../../domain/entities/trade_type.dart';
import 'mutual_fund_review_order_screen.dart';

class MutualFundTradeScreen extends StatefulWidget {
  final TradeType tradeType;
  final String fundCode;
  final String fundName;
  final double currentPrice;
  final double availableCashBalance;
  final double? currentHoldings; // For sell: units user currently holds
  final String orderType; // 'market' or 'limit'

  const MutualFundTradeScreen({
    super.key,
    required this.tradeType,
    required this.fundCode,
    required this.fundName,
    required this.currentPrice,
    required this.availableCashBalance,
    this.currentHoldings,
    required this.orderType,
  });

  @override
  State<MutualFundTradeScreen> createState() => _MutualFundTradeScreenState();
}

class _MutualFundTradeScreenState extends State<MutualFundTradeScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _orderPriceController = TextEditingController();
  int _selectedTab = 0; // 0 = Units, 1 = Amount
  double _units = 0;
  double _amount = 0;
  double _orderPrice = 0;

  @override
  void dispose() {
    _inputController.dispose();
    _orderPriceController.dispose();
    super.dispose();
  }

  double get _effectivePrice {
    // For market orders, use current price; for limit orders, use user's order price
    return widget.orderType == 'market' ? widget.currentPrice : _orderPrice;
  }

  bool get _isFormValid {
    // For limit orders, order price must be entered
    if (widget.orderType == 'limit' && _orderPrice <= 0) return false;

    if (_selectedTab == 0) {
      // Units tab
      if (_units <= 0) return false;

      // For sell, check if units don't exceed holdings
      if (widget.tradeType == TradeType.sell &&
          widget.currentHoldings != null) {
        if (_units > widget.currentHoldings!) return false;
      }

      // For buy, check if net consideration doesn't exceed available balance
      if (widget.tradeType == TradeType.buy) {
        if (_netConsideration > widget.availableCashBalance) return false;
      }
    } else {
      // Amount tab
      if (_amount <= 0) return false;

      // For sell, check if calculated units don't exceed holdings
      if (widget.tradeType == TradeType.sell &&
          widget.currentHoldings != null) {
        final calculatedUnits = _amount / _effectivePrice;
        if (calculatedUnits > widget.currentHoldings!) return false;
      }

      // For buy, check if net consideration doesn't exceed available balance
      if (widget.tradeType == TradeType.buy) {
        if (_netConsideration > widget.availableCashBalance) return false;
      }
    }

    return true;
  }

  double get _grossConsideration {
    if (_selectedTab == 0) {
      // Units tab: Gross = units × order price
      return _units * _effectivePrice;
    } else {
      // Amount tab: Gross = amount entered
      return _amount;
    }
  }

  double get _totalCharges => _grossConsideration * 0.01; // 1%

  double get _netConsideration {
    if (widget.tradeType == TradeType.buy) {
      return _grossConsideration + _totalCharges;
    } else {
      return _grossConsideration - _totalCharges;
    }
  }

  double get _calculatedUnits {
    if (_selectedTab == 0) {
      return _units;
    } else {
      return _amount / _effectivePrice;
    }
  }

  void _handleInputChange(String value) {
    setState(() {
      if (_selectedTab == 0) {
        // Units tab
        _units = double.tryParse(value) ?? 0;
      } else {
        // Amount tab
        _amount = double.tryParse(value) ?? 0;
      }
    });
  }

  void _handleOrderPriceChange(String value) {
    setState(() {
      _orderPrice = double.tryParse(value) ?? 0;
    });
  }

  void _handleTabChange(int index) {
    setState(() {
      _selectedTab = index;
      _inputController.clear();
      _units = 0;
      _amount = 0;
    });
  }

  void _handleReview() {
    NavigationHelper.navigateTo(
      context,
      MutualFundReviewOrderScreen(
        tradeType: widget.tradeType,
        fundCode: widget.fundCode,
        fundName: widget.fundName,
        orderPrice: _effectivePrice,
        units: _calculatedUnits,
        grossConsideration: _grossConsideration,
        totalCharges: _totalCharges,
        netConsideration: _netConsideration,
        fundManager: 'Databank', // TODO: Get from fund data
        availableCashBalance: widget.availableCashBalance,
        orderType: widget.orderType,
      ),
    );
  }

  String get _inputHint {
    if (_selectedTab == 0) {
      return widget.tradeType == TradeType.buy
          ? 'Enter number of units you want to purchase'
          : 'Enter number of units you want to sell';
    } else {
      return widget.tradeType == TradeType.buy
          ? 'Enter the amount you want to purchase'
          : 'Enter the amount you want to sell';
    }
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

                    // Order Type Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppText.smaller(
                        widget.orderType == 'market'
                            ? 'Your order will be executed instantly at the best available price'
                            : 'Your order will be executed if the chosen price is reached',
                        color: AppColors.primaryText(context),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Fund Info
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
                            widget.fundCode,
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
                                widget.fundName,
                                color: AppColors.secondaryText(context),
                              ),
                              AppText.small(
                                'GHS ${widget.currentPrice.toStringAsFixed(4)}',
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

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tab Bar
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.grey(
                                context,
                              ).withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: AssetTabButton(
                                    label: 'Units',
                                    isActive: _selectedTab == 0,
                                    onTap: () => _handleTabChange(0),
                                  ),
                                ),
                                Expanded(
                                  child: AssetTabButton(
                                    label: 'Amount',
                                    isActive: _selectedTab == 1,
                                    onTap: () => _handleTabChange(1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Input Field
                          AppText.small(
                            _inputHint,
                            color: AppColors.secondaryText(context),
                          ),
                          const SizedBox(height: 12),

                          MulaTextField(
                            controller: _inputController,
                            hintText: _selectedTab == 0 ? '0' : '0.00',
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,4}'),
                              ),
                            ],
                            onChanged: _handleInputChange,
                          ),

                          // Order Price Input (only for limit orders)
                          if (widget.orderType == 'limit') ...[
                            const SizedBox(height: 24),
                            AppText.small(
                              'Enter order price',
                              color: AppColors.secondaryText(context),
                            ),
                            const SizedBox(height: 12),
                            MulaTextField(
                              controller: _orderPriceController,
                              hintText: '0.00',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,4}'),
                                ),
                              ],
                              onChanged: _handleOrderPriceChange,
                            ),
                          ],

                          const SizedBox(height: 32),

                          // Details List
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.orderType == 'limit' ? 7 : 6,
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
            Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 32),
              child: AppButton(
                text: context.localize.reviewOrder,
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

  Widget _buildDetailRowByIndex(int index) {
    if (widget.orderType == 'limit') {
      // Limit order: 7 rows with Order Type at top
      switch (index) {
        case 0:
          return _buildDetailRow('Order Type', 'Limit Order');
        case 1:
          return _buildDetailRow(
            'Order Price',
            'GHS ${_effectivePrice.toStringAsFixed(2)}',
          );
        case 2:
          return _buildDetailRow(
            'Gross Consideration',
            'GHS ${_grossConsideration.toStringAsFixed(2)}',
          );
        case 3:
          return _buildDetailRow(
            'Total Charges',
            'GHS ${_totalCharges.toStringAsFixed(2)}',
          );
        case 4:
          return _buildDetailRow(
            'Net Consideration',
            'GHS ${_netConsideration.toStringAsFixed(2)}',
          );
        case 5:
          return _buildDetailRow(
            'Fund Manager',
            'Databank', // TODO: Get from fund data
          );
        case 6:
          return _buildDetailRow(
            'Available Cash balance',
            'GHS ${widget.availableCashBalance.toStringAsFixed(2)}',
          );
        default:
          return const SizedBox.shrink();
      }
    } else {
      // Market order: 6 rows without Order Type
      switch (index) {
        case 0:
          return _buildDetailRow(
            'Current Price',
            'GHS ${_effectivePrice.toStringAsFixed(2)}',
          );
        case 1:
          return _buildDetailRow(
            'Gross Consideration',
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
          );
        case 4:
          return _buildDetailRow(
            'Fund Manager',
            'Databank', // TODO: Get from fund data
          );
        case 5:
          return _buildDetailRow(
            'Available Cash balance',
            'GHS ${widget.availableCashBalance.toStringAsFixed(2)}',
          );
        default:
          return const SizedBox.shrink();
      }
    }
  }

  Widget _buildDetailRow(String label, String value) {
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
