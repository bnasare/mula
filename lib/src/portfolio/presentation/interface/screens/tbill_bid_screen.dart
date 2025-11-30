import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/single_category_selector.dart';
import '../../../../../shared/presentation/widgets/snackbar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../authentication/presentation/interface/widgets/mula_text_field.dart';
import 'tbill_bid_review_screen.dart';

class TBillBidScreen extends StatefulWidget {
  final String tbillName;
  final String tbillDescription;
  final double interestRate;
  final String maturityDate;
  final double availableCashBalance;

  const TBillBidScreen({
    super.key,
    required this.tbillName,
    required this.tbillDescription,
    required this.interestRate,
    required this.maturityDate,
    required this.availableCashBalance,
  });

  @override
  State<TBillBidScreen> createState() => _TBillBidScreenState();
}

class _TBillBidScreenState extends State<TBillBidScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  double _amount = 0;
  double _customRate = 0;
  String? _selectedBidType;
  String? _selectedBroker;

  static const List<String> _bidTypes = ['Non Competitive', 'Competitive'];
  static const List<String> _brokers = [
    'Databank',
    'EDC Stockbrokers',
    'SAS Investment Management',
    'CAL Brokers',
    'First Atlantic Brokers',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  bool get _isCompetitive => _selectedBidType == 'Competitive';

  double get _effectiveRate {
    if (_isCompetitive) {
      return _customRate;
    }
    return widget.interestRate;
  }

  bool get _isFormValid {
    if (_amount <= 0) return false;
    if (_selectedBidType == null) return false;
    if (_selectedBroker == null) return false;
    if (_isCompetitive && _customRate <= 0) return false;
    return true;
  }

  bool get _hasInsufficientFunds =>
      _amount > 0 && _amount > widget.availableCashBalance;

  double get _estimatedProceeds => _amount;

  double get _totalCharges => _amount * 0.01; // 1%

  double get _netProceeds => _estimatedProceeds - _totalCharges;

  double get _maturityValue {
    // Simple calculation: principal + interest
    return _amount * (1 + _effectiveRate / 100);
  }

  void _handleAmountChange(String value) {
    setState(() {
      _amount = double.tryParse(value) ?? 0;
    });
  }

  void _handleRateChange(String value) {
    setState(() {
      _customRate = double.tryParse(value) ?? 0;
    });
  }

  void _handleBidTypeChange(String? value) {
    setState(() {
      _selectedBidType = value;
      // Clear custom rate when switching to non-competitive
      if (value != 'Competitive') {
        _rateController.clear();
        _customRate = 0;
      }
    });
  }

  void _handleBrokerChange(String? value) {
    setState(() {
      _selectedBroker = value;
    });
  }

  void _handleReviewTap() {
    if (_hasInsufficientFunds) {
      SnackBarHelper.showErrorSnackBar(
        context,
        'Insufficient funds. Please deposit more to continue.',
      );
      return;
    }
    _handleReview();
  }

  void _handleReview() {
    NavigationHelper.navigateTo(
      context,
      TBillBidReviewScreen(
        tbillName: widget.tbillName,
        tbillDescription: widget.tbillDescription,
        purchaseAmount: _amount,
        interestRate: _effectiveRate,
        bidType: _selectedBidType!,
        totalCharges: _totalCharges,
        netProceeds: _netProceeds,
        maturityValue: _maturityValue,
        maturityDate: widget.maturityDate,
        broker: _selectedBroker!,
        availableCashBalance: widget.availableCashBalance,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: MulaAppBar(title: context.localize.bid),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // T-Bill Info Header
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
                            widget.tbillName,
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
                            context.localize.whatAmountBidFor,
                            color: AppColors.secondaryText(context),
                          ),
                          const SizedBox(height: 12),
                          MulaTextField(
                            controller: _amountController,
                            hintText: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}'),
                              ),
                            ],
                            onChanged: _handleAmountChange,
                          ),
                          const SizedBox(height: 24),

                          // Bid Type Dropdown
                          SingleCategorySelector(
                            title: context.localize.bidType,
                            hintText: context.localize.selectType,
                            options: _bidTypes,
                            selectedOption: _selectedBidType,
                            onSelectionChanged: _handleBidTypeChange,
                          ),
                          const SizedBox(height: 24),

                          // Conditional Rate Field
                          if (_selectedBidType != null) ...[
                            if (_isCompetitive) ...[
                              // Enter Rate input for Competitive
                              AppText.small(
                                context.localize.enterRate,
                                color: AppColors.secondaryText(context),
                              ),
                              const SizedBox(height: 12),
                              MulaTextField(
                                controller: _rateController,
                                hintText: context.localize.enterYourRate,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}'),
                                  ),
                                ],
                                onChanged: _handleRateChange,
                              ),
                            ] else ...[
                              // Previous Rate display for Non-Competitive
                              _buildDetailRow(
                                context.localize.previousRate,
                                '${widget.interestRate.toStringAsFixed(2)}%',
                              ),
                            ],
                            const SizedBox(height: 24),
                          ],

                          // Calculations
                          _buildDetailRow(
                            context.localize.estimatedProceeds,
                            'GHS ${_estimatedProceeds.toStringAsFixed(2)}',
                          ),
                          const SizedBox(height: 16),
                          Divider(color: AppColors.border(context), height: 1),
                          const SizedBox(height: 16),
                          _buildDetailRow(
                            context.localize.totalCharges,
                            'GHS ${_totalCharges.toStringAsFixed(2)}',
                          ),
                          const SizedBox(height: 16),
                          Divider(color: AppColors.border(context), height: 1),
                          const SizedBox(height: 16),
                          _buildDetailRow(
                            context.localize.netProceeds,
                            'GHS ${_netProceeds.toStringAsFixed(2)}',
                          ),
                          const SizedBox(height: 24),

                          // Broker Dropdown
                          SingleCategorySelector(
                            title: context.localize.broker,
                            hintText: context.localize.selectBroker,
                            options: _brokers,
                            selectedOption: _selectedBroker,
                            onSelectionChanged: _handleBrokerChange,
                          ),
                          const SizedBox(height: 24),

                          // Available Cash Balance
                          _buildDetailRow(
                            context.localize.availableCashBalance,
                            'GHS ${widget.availableCashBalance.toStringAsFixed(2)}',
                          ),

                          // Insufficient funds warning
                          if (_hasInsufficientFunds) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 14,
                                  color: AppColors.activityError,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: AppText.smallest(
                                    'Insufficient funds. Please deposit more to continue.',
                                    color: AppColors.activityError,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
              child: AppButton(
                text: context.localize.reviewOrder,
                onTap: _isFormValid ? _handleReviewTap : null,
                backgroundColor: _isFormValid
                    ? AppColors.appPrimary
                    : AppColors.border(context),
                textColor: AppColors.white(context),
                borderRadius: 12,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
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
