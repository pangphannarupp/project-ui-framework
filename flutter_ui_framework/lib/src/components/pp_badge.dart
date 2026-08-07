import 'package:flutter/material.dart';

enum PPBadgeColor { primary, secondary, success, warning, danger, info }
enum PPBadgePlacement { topRight, topLeft, bottomRight, bottomLeft }

class PPBadge extends StatelessWidget {
  final Widget child;
  final String? value;
  final int? max;
  final bool dot;
  final PPBadgeColor color;
  final PPBadgePlacement placement;
  final bool hidden;
  final bool bordered;
  final Color? bgColor;
  final Color? textColor;

  const PPBadge({
    super.key,
    required this.child,
    this.value,
    this.max,
    this.dot = false,
    this.color = PPBadgeColor.danger,
    this.placement = PPBadgePlacement.topRight,
    this.hidden = false,
    this.bordered = true,
    this.bgColor,
    this.textColor,
  });

  Color get _badgeColor {
    if (bgColor != null) return bgColor!;
    switch (color) {
      case PPBadgeColor.primary: return const Color(0xFF3B82F6);
      case PPBadgeColor.secondary: return const Color(0xFF64748B);
      case PPBadgeColor.success: return const Color(0xFF10B981);
      case PPBadgeColor.warning: return const Color(0xFFF59E0B);
      case PPBadgeColor.danger: return const Color(0xFFEF4444);
      case PPBadgeColor.info: return const Color(0xFF0EA5E9);
    }
  }

  String get _displayValue {
    if (max != null && value != null) {
      int? numValue = int.tryParse(value!);
      if (numValue != null && numValue > max!) {
        return '\$max+';
      }
    }
    return value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (!hidden)
          Positioned(
            top: placement == PPBadgePlacement.topRight || placement == PPBadgePlacement.topLeft ? -10 : null,
            bottom: placement == PPBadgePlacement.bottomRight || placement == PPBadgePlacement.bottomLeft ? -10 : null,
            left: placement == PPBadgePlacement.topLeft || placement == PPBadgePlacement.bottomLeft ? -10 : null,
            right: placement == PPBadgePlacement.topRight || placement == PPBadgePlacement.bottomRight ? -10 : null,
            child: IgnorePointer(
              child: dot ? _buildDot() : _buildBadge(),
            ),
          ),
      ],
    );
  }

  Widget _buildDot() {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: _badgeColor,
        shape: BoxShape.circle,
        border: bordered ? Border.all(color: Colors.white, width: 2) : null,
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      height: 20,
      constraints: const BoxConstraints(minWidth: 20),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: _badgeColor,
        borderRadius: BorderRadius.circular(9999),
        border: bordered ? Border.all(color: Colors.white, width: 2) : null,
      ),
      alignment: Alignment.center,
      child: Text(
        _displayValue,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
    );
  }
}
