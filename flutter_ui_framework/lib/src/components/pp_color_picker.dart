import 'package:flutter/material.dart';

class PPColorPicker extends StatelessWidget {
  final List<Color> colors;
  final Color? selectedColor;
  final ValueChanged<Color>? onChanged;
  final double size;
  final double spacing;

  const PPColorPicker({
    super.key,
    required this.colors,
    this.selectedColor,
    this.onChanged,
    this.size = 40.0,
    this.spacing = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: colors.map((color) {
        final isSelected = color == selectedColor;
        
        return GestureDetector(
          onTap: () {
            if (onChanged != null) {
              onChanged!(color);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            width: isSelected ? size * 1.1 : size,
            height: isSelected ? size * 1.1 : size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
              border: Border.all(
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                width: isSelected ? 3 : 1,
              ),
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    color: color.computeLuminance() > 0.5 ? Colors.black87 : Colors.white,
                    size: size * 0.5,
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }
}
