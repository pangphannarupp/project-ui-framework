import 'package:flutter/material.dart';
import 'pp_pie_chart.dart';

class PPDonutChart extends StatelessWidget {
  final List<PPPieChartDataItem> data;
  final double height;
  final bool showLabels;
  final double donutHoleRadius;

  const PPDonutChart({
    super.key,
    required this.data,
    this.height = 300,
    this.showLabels = true,
    this.donutHoleRadius = 50,
  });

  @override
  Widget build(BuildContext context) {
    return PPPieChart(
      data: data,
      height: height,
      showLabels: showLabels,
      isDonut: true,
      donutHoleRadius: donutHoleRadius,
    );
  }
}
