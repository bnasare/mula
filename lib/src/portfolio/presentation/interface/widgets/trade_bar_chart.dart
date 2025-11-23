import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../domain/entities/price_bar.dart';

class TradeBarChart extends StatefulWidget {
  final List<PriceBar> data;
  final double currentPrice;

  const TradeBarChart({
    super.key,
    required this.data,
    required this.currentPrice,
  });

  @override
  State<TradeBarChart> createState() => _TradeBarChartState();
}

class _TradeBarChartState extends State<TradeBarChart> {
  int? touchedIndex;
  double minX = 0;
  double maxX = 59;
  double? minY;
  double? maxY;

  @override
  void initState() {
    super.initState();
    _calculateYBounds();
  }

  void _calculateYBounds() {
    if (widget.data.isEmpty) return;

    double min = widget.data.first.low;
    double max = widget.data.first.high;

    for (final bar in widget.data) {
      if (bar.low < min) min = bar.low;
      if (bar.high > max) max = bar.high;
    }

    // Add 2% padding
    final padding = (max - min) * 0.02;
    minY = min - padding;
    maxY = max + padding;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return GestureDetector(
      onScaleUpdate: (details) {
        if (details.scale != 1.0) {
          setState(() {
            final scaleDelta = 1 - (details.scale - 1);
            final range = maxX - minX;
            final newRange = (range * scaleDelta).clamp(10.0, widget.data.length.toDouble());
            final center = (maxX + minX) / 2;
            minX = (center - newRange / 2).clamp(0, widget.data.length - newRange);
            maxX = (minX + newRange).clamp(newRange, widget.data.length.toDouble());
          });
        }
      },
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          minY: minY,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => AppColors.surface(context),
              tooltipBorder: BorderSide(color: AppColors.border(context)),
              tooltipPadding: const EdgeInsets.all(8),
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final bar = widget.data[group.x.toInt()];
                final dateFormat = DateFormat('MMM dd, yyyy');
                final priceFormat = NumberFormat('#,##0.00000');

                return BarTooltipItem(
                  '${dateFormat.format(bar.timestamp)}\n',
                  TextStyle(
                    color: AppColors.primaryText(context),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: 'Open: ${priceFormat.format(bar.open)}\n',
                      style: TextStyle(
                        color: AppColors.secondaryText(context),
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: 'High: ${priceFormat.format(bar.high)}\n',
                      style: TextStyle(
                        color: AppColors.secondaryText(context),
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: 'Low: ${priceFormat.format(bar.low)}\n',
                      style: TextStyle(
                        color: AppColors.secondaryText(context),
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: 'Close: ${priceFormat.format(bar.close)}',
                      style: TextStyle(
                        color: bar.isPositive
                            ? AppColors.activitySuccess
                            : AppColors.activityError,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  touchedIndex = null;
                  return;
                }
                touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              });
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  if (value.toInt() >= widget.data.length) return const SizedBox();

                  // Show date every 10 bars
                  if (value.toInt() % 10 != 0) return const SizedBox();

                  final bar = widget.data[value.toInt()];
                  final dateFormat = DateFormat('dd/MM/yy');
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      dateFormat.format(bar.timestamp),
                      style: TextStyle(
                        color: AppColors.secondaryText(context),
                        fontSize: 10,
                      ),
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    value.toStringAsFixed(5),
                    style: TextStyle(
                      color: AppColors.secondaryText(context),
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: AppColors.border(context).withOpacity(0.3),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            horizontalInterval: (maxY! - minY!) / 5,
            getDrawingHorizontalLine: (value) {
              // Draw special line for current price
              if ((value - widget.currentPrice).abs() < 0.0001) {
                return FlLine(
                  color: AppColors.primaryText(context).withOpacity(0.6),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                );
              }
              return FlLine(
                color: AppColors.border(context).withOpacity(0.2),
                strokeWidth: 0.5,
              );
            },
          ),
          barGroups: _buildBarGroups(),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: widget.currentPrice,
                color: AppColors.primaryText(context).withOpacity(0.6),
                strokeWidth: 1,
                dashArray: [5, 5],
                label: HorizontalLineLabel(
                  show: true,
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(right: 5, bottom: 5),
                  style: TextStyle(
                    color: AppColors.primaryText(context),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    backgroundColor: AppColors.surface(context),
                  ),
                  labelResolver: (line) => widget.currentPrice.toStringAsFixed(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return widget.data.asMap().entries.map((entry) {
      final index = entry.key;
      final bar = entry.value;
      final isTouched = index == touchedIndex;

      // Candlestick body width
      final bodyWidth = isTouched ? 8.0 : 6.0;
      // Wick (thin line) width
      final wickWidth = isTouched ? 2.0 : 1.5;

      final candleColor = bar.isPositive
          ? AppColors.activitySuccess
          : AppColors.activityError;

      return BarChartGroupData(
        x: index,
        barRods: [
          // Lower wick (from low to body)
          BarChartRodData(
            toY: bar.open < bar.close ? bar.open : bar.close,
            fromY: bar.low,
            width: wickWidth,
            color: candleColor,
            borderRadius: BorderRadius.zero,
          ),
          // Candle body
          BarChartRodData(
            toY: bar.open > bar.close ? bar.open : bar.close,
            fromY: bar.open < bar.close ? bar.open : bar.close,
            width: bodyWidth,
            color: bar.isPositive ? candleColor : candleColor,
            borderRadius: BorderRadius.zero,
          ),
          // Upper wick (from body to high)
          BarChartRodData(
            toY: bar.high,
            fromY: bar.open > bar.close ? bar.open : bar.close,
            width: wickWidth,
            color: candleColor,
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    }).toList();
  }
}
