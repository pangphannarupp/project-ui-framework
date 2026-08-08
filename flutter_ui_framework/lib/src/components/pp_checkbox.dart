import 'package:flutter/material.dart';
import 'pp_checkbox_group.dart';

class PPCheckbox extends StatelessWidget {
  final bool? value; // Represents checked state if used independently
  final dynamic groupValue; // Represents the value in a group
  final String? label;
  final Widget? labelWidget;
  final ValueChanged<bool>? onChanged;

  const PPCheckbox({
    Key? key,
    this.value,
    this.groupValue,
    this.label,
    this.labelWidget,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupData = PPCheckboxGroupData.of(context);
    final bool isGrouped = groupData != null && groupValue != null;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final bool isChecked = isGrouped 
        ? groupData.values.contains(groupValue) 
        : (value ?? false);

    void handleTap() {
      if (isGrouped) {
        groupData.onUpdate(groupValue, !isChecked);
      } else {
        onChanged?.call(!isChecked);
      }
    }

    return GestureDetector(
      onTap: handleTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease,
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: isChecked ? Theme.of(context).colorScheme.primary : (isDark ? const Color(0xFF555555) : const Color(0xFFCCCCCC)),
                width: 1.5,
              ),
              color: isChecked ? Theme.of(context).colorScheme.primary : (isDark ? const Color(0xFF1E1E1E) : Colors.white),
            ),
            child: Center(
              child: AnimatedScale(
                scale: isChecked ? 1.0 : 0.5,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                child: AnimatedOpacity(
                  opacity: isChecked ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            ),
          ),
          if (label != null || labelWidget != null) ...[
            const SizedBox(width: 8),
            labelWidget ??
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF333333),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}
