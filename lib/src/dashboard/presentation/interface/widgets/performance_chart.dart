import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

/// Performance chart showing portfolio growth over time
class PerformanceChart extends StatefulWidget {
  const PerformanceChart({super.key});

  @override
  State<PerformanceChart> createState() => _PerformanceChartState();
}

class _PerformanceChartState extends State<PerformanceChart> {
  TimePeriod _selectedPeriod = TimePeriod.oneMonth;

  @override
  Widget build(BuildContext context) {
    final data = _getDataForPeriod(_selectedPeriod);

    return Column(
      children: [
        // Line chart
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: 250,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: data.maxY / 4,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.border(context),
                      strokeWidth: 1,
                    );
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
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: data.maxY / 4,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: AppText.smallest(
                            '\$${(value / 1000).toStringAsFixed(0)}k',
                            color: AppColors.secondaryText(context),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: data.labels.length > 1
                          ? (data.spots.length - 1) / (data.labels.length - 1)
                          : 1,
                      getTitlesWidget: (value, meta) {
                        // Map the x-axis value to the correct label index
                        final labelInterval = data.labels.length > 1
                            ? (data.spots.length - 1) / (data.labels.length - 1)
                            : 1;
                        final labelIndex = (value / labelInterval).round();

                        if (labelIndex >= 0 &&
                            labelIndex < data.labels.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: AppText.smallest(
                              data.labels[labelIndex],
                              color: AppColors.secondaryText(context),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: (data.spots.length - 1).toDouble(),
                minY: data.minY,
                maxY: data.maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: data.spots,
                    isCurved: true,
                    color: AppColors.activitySuccess,
                    barWidth: 1,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.activitySuccess.withValues(alpha: 0.3),
                          AppColors.activitySuccess.withValues(alpha: 0.1),
                          AppColors.activitySuccess.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Time period selector
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildTimePeriodSelector(),
        ),
      ],
    );
  }

  Widget _buildTimePeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.offWhite(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: TimePeriod.values.map((period) {
          final isSelected = _selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedPeriod = period),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.white(context) : AppColors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: AppText.smallest(
                    period.label,
                    color: isSelected
                        ? AppColors.primaryText(context)
                        : AppColors.secondaryText(context),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  ChartData _getDataForPeriod(TimePeriod period) {
    switch (period) {
      case TimePeriod.oneDay:
        return ChartData(
          spots: _generateDummyData(24, 12500, 12900),
          labels: ['00', '06', '12', '18'],
          minY: 12400,
          maxY: 13000,
        );
      case TimePeriod.oneMonth:
        return ChartData(
          spots: _generateDummyData(30, 11000, 12900),
          labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
          minY: 10500,
          maxY: 13500,
        );
      case TimePeriod.sixMonths:
        return ChartData(
          spots: _generateDummyData(26, 8000, 12900),
          labels: ['Jan', 'Mar', 'May', 'Jul'],
          minY: 7500,
          maxY: 13500,
        );
      case TimePeriod.ytd:
        return ChartData(
          spots: _generateDummyData(12, 9000, 12900),
          labels: ['Jan', 'Apr', 'Jul', 'Oct'],
          minY: 8500,
          maxY: 13500,
        );
      case TimePeriod.oneYear:
        return ChartData(
          spots: _generateDummyData(12, 8500, 12900),
          labels: ['Jan', 'Apr', 'Jul', 'Oct'],
          minY: 8000,
          maxY: 13500,
        );
      case TimePeriod.fiveYears:
        return ChartData(
          spots: _generateDummyData(60, 5000, 12900),
          labels: ['2020', '2021', '2022', '2023'],
          minY: 4500,
          maxY: 13500,
        );
      case TimePeriod.tenYears:
        return ChartData(
          spots: _generateDummyData(120, 2000, 12900),
          labels: ['2015', '2018', '2021', '2024'],
          minY: 1500,
          maxY: 13500,
        );
      case TimePeriod.all:
        return ChartData(
          spots: _generateDummyData(150, 1000, 12900),
          labels: ['2010', '2015', '2020', '2024'],
          minY: 500,
          maxY: 13500,
        );
    }
  }

  List<FlSpot> _generateDummyData(
    int points,
    double startValue,
    double endValue,
  ) {
    // TODO: Replace with real API data
    final spots = <FlSpot>[];
    final increment = (endValue - startValue) / points;
    final range = endValue - startValue;

    for (int i = 0; i < points; i++) {
      // Create more irregular, realistic looking data
      final baseValue = startValue + (increment * i);

      // Use sine and cosine waves for natural-looking fluctuations
      final wave1 = (range * 0.08) * (i % 7 - 3.5) / 3.5;
      final wave2 = (range * 0.05) * (i % 5 - 2.5) / 2.5;
      final wave3 = (range * 0.03) * (i % 3 - 1.5) / 1.5;

      spots.add(FlSpot(i.toDouble(), baseValue + wave1 + wave2 + wave3));
    }

    return spots;
  }
}

class ChartData {
  final List<FlSpot> spots;
  final List<String> labels;
  final double minY;
  final double maxY;

  ChartData({
    required this.spots,
    required this.labels,
    required this.minY,
    required this.maxY,
  });
}

enum TimePeriod {
  oneDay,
  oneMonth,
  sixMonths,
  ytd,
  oneYear,
  fiveYears,
  tenYears,
  all;

  String get label {
    switch (this) {
      case TimePeriod.oneDay:
        return '1D';
      case TimePeriod.oneMonth:
        return '1M';
      case TimePeriod.sixMonths:
        return '6M';
      case TimePeriod.ytd:
        return 'YTD';
      case TimePeriod.oneYear:
        return '1Y';
      case TimePeriod.fiveYears:
        return '5Y';
      case TimePeriod.tenYears:
        return '10Y';
      case TimePeriod.all:
        return 'ALL';
    }
  }
}
