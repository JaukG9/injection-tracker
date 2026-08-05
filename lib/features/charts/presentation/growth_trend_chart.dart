import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/date_utils.dart';
import '../../../core/widgets/status_widgets.dart';

/// One point on a trend chart.
class TrendPoint {
  const TrendPoint(this.date, this.value);
  final DateTime date;
  final double value;
}

/// A clean line chart of a measurement over time, built on fl_chart.
///
/// The x-axis is real elapsed days (so spacing reflects time), with first/last
/// date labels; the y-axis auto-ranges with a little padding.
class GrowthTrendChart extends StatelessWidget {
  const GrowthTrendChart({
    super.key,
    required this.points,
    required this.color,
    required this.unitLabel,
    this.height = 200,
  });

  final List<TrendPoint> points;
  final Color color;
  final String unitLabel;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (points.length < 2) {
      return SizedBox(
        height: height,
        child: const Center(
          child: EmptyState(
            message: 'Add 2+ measurements to see a trend.',
            icon: Icons.show_chart,
          ),
        ),
      );
    }

    final sorted = [...points]..sort((a, b) => a.date.compareTo(b.date));
    final first = sorted.first.date;
    final spots = [
      for (final p in sorted)
        FlSpot(AppDates.daysBetween(first, p.date).toDouble(), p.value),
    ];

    final ys = sorted.map((p) => p.value).toList();
    var minY = ys.reduce((a, b) => a < b ? a : b);
    var maxY = ys.reduce((a, b) => a > b ? a : b);
    final pad = (maxY - minY) * 0.15;
    minY -= pad == 0 ? 1 : pad;
    maxY += pad == 0 ? 1 : pad;
    final maxX = spots.last.x;

    final labelStyle = theme.textTheme.bodySmall
        ?.copyWith(color: theme.colorScheme.outline, fontSize: 10);

    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => FlLine(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value == meta.min || value == meta.max) {
                    return const SizedBox.shrink();
                  }
                  return Text(value.toStringAsFixed(0), style: labelStyle);
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                getTitlesWidget: (value, meta) {
                  final df = DateFormat('MMM d');
                  if (value == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(df.format(first), style: labelStyle),
                    );
                  }
                  if (value == maxX) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(df.format(sorted.last.date), style: labelStyle),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (spots) => spots.map((s) {
                final date = first.add(Duration(days: s.x.round()));
                return LineTooltipItem(
                  '${s.y.toStringAsFixed(1)} $unitLabel\n${DateFormat('MMM d, yyyy').format(date)}',
                  TextStyle(
                    color: theme.colorScheme.onInverseSurface,
                    fontSize: 11,
                  ),
                );
              }).toList(),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              color: color,
              barWidth: 2.5,
              dotData: FlDotData(
                getDotPainter: (spot, percent, bar, index) =>
                    FlDotCirclePainter(radius: 3, color: color),
              ),
              belowBarData: BarAreaData(
                show: true,
                color: color.withValues(alpha: 0.08),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
