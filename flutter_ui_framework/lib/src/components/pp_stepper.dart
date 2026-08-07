import 'package:flutter/material.dart';

class PPStepperStep {
  final String title;
  final String? description;
  final Widget? icon;

  PPStepperStep({
    required this.title,
    this.description,
    this.icon,
  });
}

class PPStepper extends StatelessWidget {
  final List<PPStepperStep> steps;
  final int activeStep;
  final Axis orientation;
  final ValueChanged<int>? onStepTapped;

  const PPStepper({
    super.key,
    required this.steps,
    this.activeStep = 0,
    this.orientation = Axis.horizontal,
    this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (orientation == Axis.horizontal) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length, (index) {
          final isLast = index == steps.length - 1;
          return Expanded(
            flex: isLast ? 0 : 1,
            child: _buildStep(index, isLast: isLast),
          );
        }),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length, (index) {
          final isLast = index == steps.length - 1;
          return _buildStep(index, isLast: isLast);
        }),
      );
    }
  }

  Widget _buildStep(int index, {required bool isLast}) {
    final isCompleted = index < activeStep;
    final isActive = index == activeStep;
    final step = steps[index];
    final isHorizontal = orientation == Axis.horizontal;

    final primaryColor = const Color(0xFF3B82F6);
    final disabledColor = const Color(0xFFE2E8F0);
    final titleColor = (isActive || isCompleted) ? const Color(0xFF1E293B) : const Color(0xFF64748B);
    final descColor = const Color(0xFF94A3B8);

    Color iconBgColor;
    Color iconBorderColor;
    Color iconColor;

    if (isActive) {
      iconBgColor = primaryColor;
      iconBorderColor = primaryColor;
      iconColor = Colors.white;
    } else if (isCompleted) {
      iconBgColor = Colors.white;
      iconBorderColor = primaryColor;
      iconColor = primaryColor;
    } else {
      iconBgColor = const Color(0xFFF1F5F9);
      iconBorderColor = disabledColor;
      iconColor = const Color(0xFF64748B);
    }

    Widget iconWidget = Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: iconBgColor,
        shape: BoxShape.circle,
        border: Border.all(color: iconBorderColor, width: 2),
      ),
      child: Center(
        child: isCompleted
            ? Icon(Icons.check, size: 16, color: iconColor)
            : (step.icon ??
                Text(
                  '\${index + 1}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: iconColor,
                  ),
                )),
      ),
    );

    if (onStepTapped != null) {
      iconWidget = GestureDetector(
        onTap: () => onStepTapped!(index),
        child: iconWidget,
      );
    }

    Widget contentWidget = Column(
      crossAxisAlignment: isHorizontal ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onStepTapped != null ? () => onStepTapped!(index) : null,
          child: Text(
            step.title,
            textAlign: isHorizontal ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: titleColor,
            ),
          ),
        ),
        if (step.description != null) ...[
          const SizedBox(height: 4),
          Text(
            step.description!,
            textAlign: isHorizontal ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              fontSize: 12,
              color: descColor,
            ),
          ),
        ]
      ],
    );

    if (isHorizontal) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          if (!isLast)
          if (!isLast)
            Positioned(
              top: 13,
              left: 0,
              right: -1000, // Extend way past the right bound
              child: Align(
                alignment: Alignment.centerLeft,
                // Use a FractionallySizedBox to shift it by 50% of the parent width? No.
                // The parent is the Stack. We want to start at center of Stack and extend exactly 100% of Stack width.
                // It's much easier to just draw a line from center to right edge of THIS container, 
                // AND another line from left edge to center of the NEXT container!
                // But wait, the standard way in Flutter is:
              ),
            ),
          
          if (!isLast)
            Positioned(
              top: 13,
              left: 0,
              right: -5000,
              child: Row(
                children: [
                  // This spacer pushes the line to start exactly at the center (since Expanded makes the Stack width X, but here we don't know X).
                ],
              ),
            ),
            
          // Let's use the simplest, most robust trick for Stepper lines:
          // A Positioned.fill with a CustomPaint. Or just a Positioned with LayoutBuilder.
          // Wait, LayoutBuilder CAN return a Positioned? No, Positioned MUST be a DIRECT child of Stack.
          // So we put Positioned first, THEN LayoutBuilder!
          if (!isLast)
            Positioned(
              top: 13,
              left: 0,
              right: -5000, // allow overflow
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Wait, if it's positioned with right: -5000, constraints.maxWidth is huge.
                  // We can't do that.
                  return const SizedBox.shrink();
                }
              ),
            ),

          // Proper way:
          if (!isLast)
            Positioned(
              top: 13,
              left: 0,
              right: 0, // Fill the whole width of this step
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Transform.translate(
                    offset: Offset(constraints.maxWidth / 2, 0),
                    child: Container(
                      width: constraints.maxWidth, // Exactly 1 step width
                      height: 2,
                      color: isCompleted ? primaryColor : disabledColor,
                      alignment: Alignment.centerLeft,
                    ),
                  );
                },
              ),
            ),

          Column(
            children: [
              iconWidget,
              const SizedBox(height: 12),
              contentWidget,
            ],
          ),
        ],
      );
    } else {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                iconWidget,
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isCompleted ? primaryColor : disabledColor,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 24.0, top: 4),
                child: contentWidget,
              ),
            ),
          ],
        ),
      );
    }
  }
}
