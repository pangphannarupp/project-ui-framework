import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PPBarChartSeries {
  final String title;
  final List<double> values;
  final Color color;

  const PPBarChartSeries({
    required this.title,
    required this.values,
    required this.color,
  });
}

class PPBarChart extends StatelessWidget {
  final List<PPBarChartSeries> series;
  final List<String> labels;
  final bool showGrid;
  final double height;
  final bool stacked;
  final double barWidth;

  const PPBarChart({
    super.key,
    required this.series,
    required this.labels,
    this.showGrid = true,
    this.height = 300,
    this.stacked = false,
    this.barWidth = 16,
  });

  @override
  Widget build(BuildContext context) {
    if (series.isEmpty || labels.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(child: Text('No data available')),
      );
    }

    double maxY = 0;
    if (stacked) {
      for (int i = 0; i < labels.length; i++) {
        double sum = 0;
        for (var s in series) {
          if (i < s.values.length) sum += s.values[i];
        }
        if (sum > maxY) maxY = sum;
      }
    } else {
      for (var s in series) {
        for (var v in s.values) {
          if (v > maxY) maxY = v;
        }
      }
    }
    
    maxY += maxY * 0.1;
    if (maxY == 0) maxY = 10;
    
    double interval = maxY / 5;
    if (interval <= 0) interval = 1;

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: maxY,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (group) => Colors.transparent,
                tooltipPadding: EdgeInsets.zero,
                tooltipMargin: 8,
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.toY.round().toString(),
                    const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    int index = value.toInt();
                    if (index < 0 || index >= labels.length) return const SizedBox.shrink();
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(
                        labels[index],
                        style: const TextStyle(
                          color: Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: interval,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(
                        color: Color(0xff7589a2),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(
              show: showGrid,
              checkToShowHorizontalLine: (value) => value % interval == 0,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              ),
              drawVerticalLine: false,
            ),
            borderData: FlBorderData(show: false),
            barGroups: List.generate(labels.length, (i) {
              if (stacked) {
                double currentY = 0;
                List<BarChartRodStackItem> stackItems = [];
                for (var s in series) {
                  if (i < s.values.length) {
                    double val = s.values[i];
                    stackItems.add(BarChartRodStackItem(currentY, currentY + val, s.color));
                    currentY += val;
                  }
                }
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: currentY,
                      width: barWidth,
                      borderRadius: BorderRadius.circular(4),
                      rodStackItems: stackItems,
                    ),
                  ],
                );
              } else {
                List<BarChartRodData> rods = [];
                for (var s in series) {
                  if (i < s.values.length) {
                    rods.add(BarChartRodData(
                      toY: s.values[i],
                      color: s.color,
                      width: barWidth,
                      borderRadius: BorderRadius.circular(4),
                    ));
                  }
                }
                return BarChartGroupData(
                  x: i,
                  barRods: rods,
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
