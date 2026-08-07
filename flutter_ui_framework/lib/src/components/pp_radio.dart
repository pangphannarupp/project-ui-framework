import 'package:flutter/material.dart';
import 'pp_radio_group.dart';

class PPRadio extends StatelessWidget {
  final dynamic value; // Represents the value in a group, or its own state
  final dynamic selectedValue; // Used if independent
  final String? label;
  final Widget? labelWidget;
  final ValueChanged<dynamic>? onChanged;

  const PPRadio({
    Key? key,
    required this.value,
    this.selectedValue,
    this.label,
    this.labelWidget,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupData = PPRadioGroupData.of(context);
    final bool isGrouped = groupData != null;
    
    final bool isChecked = isGrouped 
        ? groupData.value == value
        : selectedValue == value;

    void handleTap() {
      if (isGrouped) {
        groupData.onUpdate(value);
      } else {
        onChanged?.call(value);
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
              shape: BoxShape.circle,
              border: Border.all(
                color: isChecked ? const Color(0xFF1A2A5E) : const Color(0xFFCCCCCC),
                width: 1.5,
              ),
              color: Colors.white,
            ),
            child: Center(
              child: AnimatedScale(
                scale: isChecked ? 1.0 : 0.5,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                child: AnimatedOpacity(
                  opacity: isChecked ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1A2A5E),
                    ),
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
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF333333),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}
