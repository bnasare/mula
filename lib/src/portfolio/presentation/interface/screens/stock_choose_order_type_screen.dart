import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/selectable_option_card.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../domain/entities/trade_type.dart';
import 'stock_trade_screen.dart';

class StockChooseOrderTypeScreen extends StatefulWidget {
  final TradeType tradeType;
  final String ticker;
  final String companyName;
  final double currentPrice;
  final double availableCashBalance;
  final double? currentShares; // For sell: shares user currently holds
  final String broker;

  const StockChooseOrderTypeScreen({
    super.key,
    required this.tradeType,
    required this.ticker,
    required this.companyName,
    required this.currentPrice,
    required this.availableCashBalance,
    this.currentShares,
    required this.broker,
  });

  @override
  State<StockChooseOrderTypeScreen> createState() =>
      _StockChooseOrderTypeScreenState();
}

class _StockChooseOrderTypeScreenState
    extends State<StockChooseOrderTypeScreen> {
  String _selectedOrderType = 'market';

  void _handleContinue() {
    NavigationHelper.navigateTo(
      context,
      StockTradeScreen(
        tradeType: widget.tradeType,
        ticker: widget.ticker,
        companyName: widget.companyName,
        currentPrice: widget.currentPrice,
        availableCashBalance: widget.availableCashBalance,
        currentShares: widget.currentShares,
        orderType: _selectedOrderType,
        broker: widget.broker,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(title: context.localize.chooseOrderType),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.small(
                    context.localize.chooseHowExecute,
                    color: AppColors.secondaryText(context),
                  ),
                  const SizedBox(height: 24),

                  // Market Order Option
                  SelectableOptionCard(
                    value: 'market',
                    selectedValue: _selectedOrderType,
                    title: context.localize.marketOrder,
                    description: context.localize.marketOrderDesc,
                    onTap: () {
                      setState(() {
                        _selectedOrderType = 'market';
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Limit Order Option
                  SelectableOptionCard(
                    value: 'limit',
                    selectedValue: _selectedOrderType,
                    title: context.localize.limitOrder,
                    description: context.localize.limitOrderDesc,
                    onTap: () {
                      setState(() {
                        _selectedOrderType = 'limit';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            padding: const EdgeInsets.all(16).copyWith(bottom: 32),
            child: AppButton(
              text: context.localize.continueButton,
              onTap: _handleContinue,
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
}
