import 'package:flutter/material.dart';

class PPFunnelChartDataItem {
  final String title;
  final double value;
  final Color color;

  const PPFunnelChartDataItem({
    required this.title,
    required this.value,
    required this.color,
  });
}

class PPFunnelChart extends StatelessWidget {
  final List<PPFunnelChartDataItem> data;
  final double height;
  final bool showLabels;

  const PPFunnelChart({
    super.key,
    required this.data,
    this.height = 300,
    this.showLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(child: Text('No data available')),
      );
    }

    // Sort data descending by value
    final sortedData = List<PPFunnelChartDataItem>.from(data)
      ..sort((a, b) => b.value.compareTo(a.value));

    final maxValue = sortedData.first.value;

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _FunnelPainter(data: sortedData, maxValue: maxValue, showLabels: showLabels),
        child: Container(),
      ),
    );
  }
}

class _FunnelPainter extends CustomPainter {
  final List<PPFunnelChartDataItem> data;
  final double maxValue;
  final bool showLabels;

  _FunnelPainter({
    required this.data,
    required this.maxValue,
    required this.showLabels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final double sectionHeight = size.height / data.length;
    final double maxHalfWidth = size.width / 2;
    
    // We want the top width to be based on value, relative to maxValue
    // So the top block is full width (if it's the max).

    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      final paint = Paint()..color = item.color;
      
      final double topY = i * sectionHeight;
      final double bottomY = (i + 1) * sectionHeight;

      // Width at top of this section
      final double topWidthRatio = item.value / maxValue;
      final double topHalfWidth = maxHalfWidth * topWidthRatio;
      
      // Width at bottom of this section
      // If there's a next item, use its width, else make it 30% of this one
      double bottomHalfWidth;
      if (i < data.length - 1) {
        bottomHalfWidth = maxHalfWidth * (data[i + 1].value / maxValue);
      } else {
        bottomHalfWidth = topHalfWidth * 0.3; // slightly tapered at the very bottom
      }

      final Path path = Path()
        ..moveTo(maxHalfWidth - topHalfWidth, topY) // Top Left
        ..lineTo(maxHalfWidth + topHalfWidth, topY) // Top Right
        ..lineTo(maxHalfWidth + bottomHalfWidth, bottomY) // Bottom Right
        ..lineTo(maxHalfWidth - bottomHalfWidth, bottomY) // Bottom Left
        ..close();

      // Add a slight gap between sections
      if (i > 0) {
        path.shift(const Offset(0, 2));
      }

      canvas.drawPath(path, paint);

      if (showLabels) {
        final textSpan = TextSpan(
          text: '${item.title}\n${item.value.toInt()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black26, blurRadius: 2)],
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        
        final double textY = topY + (sectionHeight - textPainter.height) / 2;
        final double textX = maxHalfWidth - (textPainter.width / 2);
        
        textPainter.paint(canvas, Offset(textX, textY));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _FunnelPainter oldDelegate) {
    return true; // Simple rebuild
  }
}
