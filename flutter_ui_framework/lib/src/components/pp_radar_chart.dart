import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PPRadarChartSeries {
  final String title;
  final List<double> values;
  final Color color;

  const PPRadarChartSeries({
    required this.title,
    required this.values,
    required this.color,
  });
}

class PPRadarChart extends StatelessWidget {
  final List<PPRadarChartSeries> series;
  final List<String> features;
  final double height;

  const PPRadarChart({
    super.key,
    required this.series,
    required this.features,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    if (series.isEmpty || features.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(child: Text('No data available')),
      );
    }

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RadarChart(
          RadarChartData(
            dataSets: series.map((s) {
              return RadarDataSet(
                fillColor: s.color.withOpacity(0.2),
                borderColor: s.color,
                entryRadius: 3,
                dataEntries: s.values.map((v) => RadarEntry(value: v)).toList(),
                borderWidth: 2,
              );
            }).toList(),
            radarBackgroundColor: Colors.transparent,
            borderData: FlBorderData(show: false),
            radarBorderData: const BorderSide(color: Colors.transparent),
            titlePositionPercentageOffset: 0.2,
            tickCount: 5,
            ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 10),
            tickBorderData: const BorderSide(color: Colors.grey, width: 0.5),
            gridBorderData: const BorderSide(color: Colors.grey, width: 0.5),
            getTitle: (index, angle) {
              if (index < 0 || index >= features.length) {
                return const RadarChartTitle(text: '');
              }
              return RadarChartTitle(
                text: features[index],
                angle: angle,
                positionPercentageOffset: 0.2,
              );
            },
          ),
        ),
      ),
    );
  }
}
