import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PPPieChartDataItem {
  final String title;
  final double value;
  final Color color;

  const PPPieChartDataItem({
    required this.title,
    required this.value,
    required this.color,
  });
}

class PPPieChart extends StatefulWidget {
  final List<PPPieChartDataItem> data;
  final double height;
  final bool showLabels;
  final bool isDonut;
  final double donutHoleRadius;

  const PPPieChart({
    super.key,
    required this.data,
    this.height = 300,
    this.showLabels = true,
    this.isDonut = false,
    this.donutHoleRadius = 40,
  });

  @override
  State<PPPieChart> createState() => _PPPieChartState();
}

class _PPPieChartState extends State<PPPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: Text('No data available')),
      );
    }

    return SizedBox(
      height: widget.height,
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
                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(show: false),
          sectionsSpace: widget.isDonut ? 2 : 0,
          centerSpaceRadius: widget.isDonut ? widget.donutHoleRadius : 0,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 12.0;
      final radius = widget.isDonut 
        ? (isTouched ? 60.0 : 50.0)
        : (isTouched ? 110.0 : 100.0);
      final item = widget.data[i];

      return PieChartSectionData(
        color: item.color,
        value: item.value,
        title: widget.showLabels ? '${item.value.toInt()}%' : '',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: const [Shadow(color: Colors.black26, blurRadius: 2)],
        ),
      );
    });
  }
}
