import 'package:flutter/material.dart';

class PPRating extends StatefulWidget {
  final int value;
  final int max;
  final bool readonly;
  final ValueChanged<int>? onChanged;
  final double size;

  const PPRating({
    Key? key,
    this.value = 0,
    this.max = 5,
    this.readonly = false,
    this.onChanged,
    this.size = 24.0,
  }) : super(key: key);

  @override
  State<PPRating> createState() => _PPRatingState();
}

class _PPRatingState extends State<PPRating> {
  int _hoverValue = 0;

  int get _displayValue => _hoverValue > 0 ? _hoverValue : widget.value;

  void _handleTap(int index) {
    if (widget.readonly || widget.onChanged == null) return;
    widget.onChanged!(index);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (_) {
        if (!widget.readonly) {
          setState(() => _hoverValue = 0);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.max, (index) {
          final starValue = index + 1;
          final bool isActive = starValue <= _displayValue;

          return MouseRegion(
            onEnter: (_) {
              if (!widget.readonly) {
                setState(() => _hoverValue = starValue);
              }
            },
            cursor: widget.readonly ? SystemMouseCursors.basic : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _handleTap(starValue),
              // We could use an animated scale, but a simple icon swap is close to the original
              child: AnimatedScale(
                scale: (_hoverValue == starValue && !widget.readonly) ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    isActive ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: widget.size,
                    color: isActive ? const Color(0xFFFFC107) : const Color(0xFFE0E0E0),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
