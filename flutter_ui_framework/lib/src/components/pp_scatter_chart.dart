import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PPScatterChartDataPoint {
  final double x;
  final double y;
  final double radius;
  final Color color;

  const PPScatterChartDataPoint({
    required this.x,
    required this.y,
    this.radius = 6,
    required this.color,
  });
}

class PPScatterChart extends StatelessWidget {
  final List<PPScatterChartDataPoint> data;
  final double height;
  final bool showGrid;

  const PPScatterChart({
    super.key,
    required this.data,
    this.height = 300,
    this.showGrid = true,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(child: Text('No data available')),
      );
    }

    double maxX = 0;
    double minX = 0;
    double maxY = 0;
    double minY = 0;
    
    if (data.isNotEmpty) {
      maxX = data[0].x;
      minX = data[0].x;
      maxY = data[0].y;
      minY = data[0].y;
    }

    for (var p in data) {
      if (p.x > maxX) maxX = p.x;
      if (p.x < minX) minX = p.x;
      if (p.y > maxY) maxY = p.y;
      if (p.y < minY) minY = p.y;
    }
    
    // Add some padding
    final rangeX = maxX - minX;
    final rangeY = maxY - minY;
    
    maxX += rangeX * 0.1;
    if (minX != 0) minX -= rangeX * 0.1;
    if (maxX == minX) maxX += 10;
    
    maxY += rangeY * 0.1;
    if (minY != 0) minY -= rangeY * 0.1;
    if (maxY == minY) maxY += 10;

    double intervalY = (maxY - minY) / 5;
    if (intervalY <= 0) intervalY = 1;
    
    double intervalX = (maxX - minX) / 5;
    if (intervalX <= 0) intervalX = 1;

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
        child: ScatterChart(
          ScatterChartData(
            scatterSpots: data.map((p) {
              return ScatterSpot(
                p.x,
                p.y,
                dotPainter: FlDotCirclePainter(
                  radius: p.radius,
                  color: p.color,
                  strokeWidth: 0,
                ),
              );
            }).toList(),
            minX: minX,
            maxX: maxX,
            minY: minY,
            maxY: maxY,
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d).withOpacity(0.2), width: 1),
            ),
            gridData: FlGridData(
              show: showGrid,
              drawHorizontalLine: true,
              drawVerticalLine: true,
              horizontalInterval: intervalY,
              verticalInterval: intervalX,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              ),
              getDrawingVerticalLine: (value) => FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: intervalX,
                  getTitlesWidget: (value, meta) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        value.toInt().toString(),
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
                  interval: intervalY,
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
            scatterTouchData: ScatterTouchData(
              enabled: true,
              touchTooltipData: ScatterTouchTooltipData(
                getTooltipColor: (spot) => Colors.blueGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
