import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../domain/entities/asset.dart';

/// Donut chart displaying asset distribution
class AssetDonutChart extends StatefulWidget {
  final List<Asset> assets;

  const AssetDonutChart({super.key, required this.assets});

  @override
  State<AssetDonutChart> createState() => _AssetDonutChartState();
}

class _AssetDonutChartState extends State<AssetDonutChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chart
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: 220,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 2,
                centerSpaceRadius: 60,
                sections: _getSections(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Legend
        _buildLegend(),
      ],
    );
  }

  List<PieChartSectionData> _getSections() {
    return widget.assets.asMap().entries.map((entry) {
      final index = entry.key;
      final asset = entry.value;
      final isTouched = index == touchedIndex;
      final radius = isTouched ? 55.0 : 50.0;
      final fontSize = isTouched ? 16.0 : 14.0;

      return PieChartSectionData(
        color: asset.type.color,
        value: asset.percentage,
        title: '${asset.percentage.toInt()}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildLegend() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: widget.assets.asMap().entries.map((entry) {
            final asset = entry.value;
            final isLast = entry.key == widget.assets.length - 1;
            return Padding(
              padding: EdgeInsets.only(right: isLast ? 0 : 16),
              child: _LegendItem(
                color: asset.type.color,
                name: asset.name,
                percentage: asset.percentage,
                value: asset.value,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Legend item for the chart
class _LegendItem extends StatelessWidget {
  final Color color;
  final String name;
  final double percentage;
  final double value;

  const _LegendItem({
    required this.color,
    required this.name,
    required this.percentage,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: 'GHS ',
      decimalDigits: 0,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border(context), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Color indicator
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),

          // Name and percentage
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.smallest(name, color: AppColors.primaryText(context)),
              AppText.smallest(
                '${percentage.toInt()}% (${currencyFormat.format(value)})',
                color: AppColors.secondaryText(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
