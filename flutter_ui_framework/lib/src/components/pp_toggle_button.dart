import 'package:flutter/material.dart';

class PPToggleButton extends StatelessWidget {
  final bool isToggled;
  final ValueChanged<bool> onChanged;
  final Widget child;
  final Color? activeColor;

  const PPToggleButton({
    Key? key,
    required this.isToggled,
    required this.onChanged,
    required this.child,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = activeColor ?? theme.primaryColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!isToggled),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isToggled ? color.withOpacity(0.15) : Colors.transparent,
          border: Border.all(
            color: isToggled ? color : Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: isToggled ? color : Colors.black87,
            fontWeight: isToggled ? FontWeight.w600 : FontWeight.normal,
          ),
          child: IconTheme(
            data: IconThemeData(
              color: isToggled ? color : Colors.black54,
              size: 20,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
