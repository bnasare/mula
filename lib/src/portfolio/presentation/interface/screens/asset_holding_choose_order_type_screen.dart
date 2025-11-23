import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/selectable_option_card.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../domain/entities/trade_type.dart';
import 'asset_holding_trade_screen.dart';

class AssetHoldingChooseOrderTypeScreen extends StatefulWidget {
  final TradeType tradeType;
  final String ticker;
  final String companyName;
  final double currentPrice;
  final double availableCashBalance;
  final double? currentShares; // For sell: shares user currently holds
  final String broker;

  const AssetHoldingChooseOrderTypeScreen({
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
  State<AssetHoldingChooseOrderTypeScreen> createState() =>
      _AssetHoldingChooseOrderTypeScreenState();
}

class _AssetHoldingChooseOrderTypeScreenState
    extends State<AssetHoldingChooseOrderTypeScreen> {
  String _selectedOrderType = 'market';

  void _handleContinue() {
    NavigationHelper.navigateTo(
      context,
      AssetHoldingTradeScreen(
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
      backgroundColor: AppColors.background(context),
      appBar: const MulaAppBar(title: 'Choose Order Type'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.small(
                    'Choose how you want your order to be executed',
                    color: AppColors.secondaryText(context),
                  ),
                  const SizedBox(height: 24),

                  // Market Order Option
                  SelectableOptionCard(
                    value: 'market',
                    selectedValue: _selectedOrderType,
                    title: 'Market Order',
                    description:
                        'Execute immediately at the best available price',
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
                    title: 'Limit Order',
                    description:
                        'Set your own price. The order only executes if the chosen price is reached',
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
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.border(context),
                  width: 1,
                ),
              ),
            ),
            child: AppButton(
              text: 'Continue',
              onTap: _handleContinue,
              backgroundColor: AppColors.appPrimary,
              textColor: Colors.white,
              borderRadius: 12,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
