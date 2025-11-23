import 'package:flutter/material.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../domain/entities/price_bar.dart';
import '../widgets/trade_bar_chart.dart';

class AdvancedChartScreen extends StatefulWidget {
  final String ticker;
  final String companyName;
  final double currentPrice;
  final double change;
  final double changePercentage;

  const AdvancedChartScreen({
    super.key,
    required this.ticker,
    required this.companyName,
    required this.currentPrice,
    required this.change,
    required this.changePercentage,
  });

  @override
  State<AdvancedChartScreen> createState() => _AdvancedChartScreenState();
}

class _AdvancedChartScreenState extends State<AdvancedChartScreen> {
  late List<PriceBar> chartData;

  @override
  void initState() {
    super.initState();
    chartData = PriceBar.generateMockData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Back to chart',
            style: TextStyle(
              color: AppColors.primaryText(context),
              fontSize: 14,
            ),
          ),
        ),
        leadingWidth: 120,
        title: Text(
          widget.ticker,
          style: TextStyle(
            color: AppColors.primaryText(context),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.analytics_outlined,
              color: AppColors.primaryText(context),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.functions,
              color: AppColors.primaryText(context),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: AppColors.primaryText(context),
            ),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.primaryText(context),
            ),
            position: PopupMenuPosition.under,
            onSelected: (value) {
              // Handle menu item selection
              if (value == 'limit') {
                // TODO: Handle Limit Market
              } else if (value == 'market') {
                // TODO: Handle Market Order
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'limit',
                child: Text('Limit Market'),
              ),
              const PopupMenuItem<String>(
                value: 'market',
                child: Text('Market Order'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Current price display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.currentPrice.toStringAsFixed(5),
                  style: const TextStyle(
                    color: Colors.teal,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          // Chart section - takes up most of the screen
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TradeBarChart(
                data: chartData,
                currentPrice: widget.currentPrice,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
