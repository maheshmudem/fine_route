import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../domain/entities/weekly_summary.dart';

class WeeklyTrendChartSection extends StatelessWidget {
  final List<WeeklySummary> weeklySummary;

  const WeeklyTrendChartSection({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
    if (weeklySummary.isEmpty) {
      return const SizedBox.shrink();
    }

    final maxY = weeklySummary
        .map((e) => e.amountCollected)
        .fold(0.0, (max, e) => e > max ? e : max);
        
    final spots = weeklySummary.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.amountCollected);
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText.bodyLarge('Weekly Collection Trend', color: AppColors.textHeading),
          const SizedBox(height: 4),
          const AppText.labelSmall('Amount collected per day (Mon - Sun)', color: AppColors.textBody),
          const SizedBox(height: 24),
          SizedBox(
            height: 160,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxY == 0 ? 1 : maxY / 4,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.border.withValues(alpha: 0.3),
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < weeklySummary.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: AppText.bodySmall(
                              weeklySummary[value.toInt()].dayName,
                              color: AppColors.textBody,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: maxY == 0 ? 1 : maxY / 4,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        return AppText.bodySmall(
                          '₹${(value / 1000).toStringAsFixed(0)}k',
                          color: AppColors.textBody,
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.4)),
                    left: BorderSide(color: AppColors.border.withValues(alpha: 0.4)),
                  ),
                ),
                minX: 0,
                maxX: weeklySummary.length.toDouble() - 1,
                minY: 0,
                maxY: maxY == 0 ? 1 : maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withValues(alpha: 0.15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
