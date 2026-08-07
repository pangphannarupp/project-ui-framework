import 'package:flutter/material.dart';

class PPButtonGroup extends StatefulWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final Color? activeColor;
  final Axis direction;

  const PPButtonGroup({
    Key? key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.activeColor,
    this.direction = Axis.horizontal,
  }) : super(key: key);

  @override
  State<PPButtonGroup> createState() => _PPButtonGroupState();
}

class _PPButtonGroupState extends State<PPButtonGroup> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = widget.activeColor ?? theme.primaryColor;
    final isHorizontal = widget.direction == Axis.horizontal;
    
    Widget flexContent = Flex(
      direction: widget.direction,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isHorizontal ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
      children: List.generate(widget.labels.length, (index) {
        final isSelected = index == widget.selectedIndex;
        final isFirst = index == 0;
        final isLast = index == widget.labels.length - 1;
        
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => widget.onSelected(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? color : Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: isFirst ? const Radius.circular(7) : Radius.zero,
                topRight: isHorizontal
                    ? (isLast ? const Radius.circular(7) : Radius.zero)
                    : (isFirst ? const Radius.circular(7) : Radius.zero),
                bottomLeft: isHorizontal
                    ? (isFirst ? const Radius.circular(7) : Radius.zero)
                    : (isLast ? const Radius.circular(7) : Radius.zero),
                bottomRight: isLast ? const Radius.circular(7) : Radius.zero,
              ),
              border: Border(
                right: isHorizontal && !isLast && !isSelected 
                    ? BorderSide(color: Colors.grey.shade300) 
                    : BorderSide.none,
                bottom: !isHorizontal && !isLast && !isSelected
                    ? BorderSide(color: Colors.grey.shade300)
                    : BorderSide.none,
              ),
            ),
            child: Text(
              widget.labels[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }),
    );

    if (!isHorizontal) {
      flexContent = IntrinsicWidth(child: flexContent);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: flexContent,
    );
  }
}
