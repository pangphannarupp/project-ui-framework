import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PPLineChartSeries {
  final String title;
  final List<double> values;
  final Color color;

  const PPLineChartSeries({
    required this.title,
    required this.values,
    required this.color,
  });
}

class PPLineChart extends StatelessWidget {
  final List<PPLineChartSeries> series;
  final List<String> labels;
  final bool showGrid;
  final bool curved;
  final bool showDots;
  final double height;

  const PPLineChart({
    super.key,
    required this.series,
    required this.labels,
    this.showGrid = true,
    this.curved = true,
    this.showDots = true,
    this.height = 300,
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
    double minY = 0;
    for (var s in series) {
      for (var v in s.values) {
        if (v > maxY) maxY = v;
        if (v < minY) minY = v;
      }
    }

    final range = maxY - minY;
    maxY += range * 0.1;
    if (minY != 0) minY -= range * 0.1;
    if (maxY == minY) {
      maxY += 10;
    }
    
    // Safety check for interval
    double interval = (maxY - minY) / 5;
    if (interval <= 0) interval = 1;

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: showGrid,
              drawVerticalLine: true,
              horizontalInterval: interval,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
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
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    if (index < 0 || index >= labels.length) return const SizedBox.shrink();
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(
                        labels[index],
                        style: const TextStyle(
                          color: Color(0xff68737d),
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
                  interval: interval,
                  reservedSize: 42,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(
                        color: Color(0xff67727d),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d).withOpacity(0.2), width: 1),
            ),
            minX: 0,
            maxX: (labels.length - 1).toDouble(),
            minY: minY,
            maxY: maxY,
            lineBarsData: series.map((s) {
              return LineChartBarData(
                spots: s.values.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                isCurved: curved,
                color: s.color,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(show: showDots),
                belowBarData: BarAreaData(
                  show: true,
                  color: s.color.withOpacity(0.15),
                ),
              );
            }).toList(),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) => Colors.blueGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
