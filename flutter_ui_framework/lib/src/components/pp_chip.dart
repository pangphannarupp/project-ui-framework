import 'package:flutter/material.dart';

enum PPChipColor { primary, secondary, success, warning, danger, info, defaultColor }
enum PPChipVariant { solid, outline, soft }
enum PPChipSize { sm, md, lg }

class PPChip extends StatelessWidget {
  final String label;
  final Widget? icon;
  final PPChipColor color;
  final PPChipVariant variant;
  final PPChipSize size;
  final bool closable;
  final VoidCallback? onTap;
  final VoidCallback? onClose;
  final Color? bgColor;
  final Color? textColor;

  const PPChip({
    super.key,
    required this.label,
    this.icon,
    this.color = PPChipColor.defaultColor,
    this.variant = PPChipVariant.solid,
    this.size = PPChipSize.md,
    this.closable = false,
    this.onTap,
    this.onClose,
    this.bgColor,
    this.textColor,
  });

  Color get _baseColor {
    switch (color) {
      case PPChipColor.primary: return const Color(0xFF3B82F6);
      case PPChipColor.secondary: return const Color(0xFF64748B);
      case PPChipColor.success: return const Color(0xFF10B981);
      case PPChipColor.warning: return const Color(0xFFF59E0B);
      case PPChipColor.danger: return const Color(0xFFEF4444);
      case PPChipColor.info: return const Color(0xFF0EA5E9);
      case PPChipColor.defaultColor: return const Color(0xFF64748B);
    }
  }

  Color get _backgroundColor {
    if (bgColor != null && variant == PPChipVariant.solid) return bgColor!;
    if (variant == PPChipVariant.outline) return Colors.transparent;
    
    if (color == PPChipColor.defaultColor) {
      return variant == PPChipVariant.solid ? const Color(0xFFE2E8F0) : const Color(0xFFF1F5F9);
    }

    if (variant == PPChipVariant.soft) {
      switch (color) {
        case PPChipColor.primary: return const Color(0xFFEFF6FF);
        case PPChipColor.secondary: return const Color(0xFFF1F5F9);
        case PPChipColor.success: return const Color(0xFFECFDF5);
        case PPChipColor.warning: return const Color(0xFFFFFBEB);
        case PPChipColor.danger: return const Color(0xFFFEF2F2);
        case PPChipColor.info: return const Color(0xFFF0F9FF);
        default: return const Color(0xFFF1F5F9);
      }
    }
    return _baseColor;
  }

  Color get _borderColor {
    if (bgColor != null) return bgColor!;
    if (variant == PPChipVariant.soft) return Colors.transparent;
    if (color == PPChipColor.defaultColor) return const Color(0xFFCBD5E1);
    return _baseColor;
  }

  Color get _textColor {
    if (textColor != null) return textColor!;
    if (bgColor != null && variant == PPChipVariant.outline) return bgColor!;
    
    if (color == PPChipColor.defaultColor) return const Color(0xFF475569);

    if (variant == PPChipVariant.solid) return Colors.white;

    switch (color) {
      case PPChipColor.primary: return const Color(0xFF2563EB);
      case PPChipColor.success: return const Color(0xFF059669);
      case PPChipColor.warning: return const Color(0xFFD97706);
      case PPChipColor.danger: return const Color(0xFFDC2626);
      case PPChipColor.info: return const Color(0xFF0284C7);
      default: return _baseColor;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case PPChipSize.sm: return const EdgeInsets.symmetric(horizontal: 8, vertical: 2);
      case PPChipSize.md: return const EdgeInsets.symmetric(horizontal: 12, vertical: 4);
      case PPChipSize.lg: return const EdgeInsets.symmetric(horizontal: 16, vertical: 6);
    }
  }

  double get _height {
    switch (size) {
      case PPChipSize.sm: return 24.0;
      case PPChipSize.md: return 32.0;
      case PPChipSize.lg: return 40.0;
    }
  }

  double get _fontSize {
    switch (size) {
      case PPChipSize.sm: return 12.0;
      case PPChipSize.md: return 14.0;
      case PPChipSize.lg: return 16.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      height: _height,
      padding: _padding,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(color: _textColor, size: _fontSize + 4),
              child: icon!,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: _textColor,
              fontSize: _fontSize,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
          if (closable) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.cancel,
                size: _fontSize + 4,
                color: _textColor.withOpacity(0.7),
              ),
            ),
          ]
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }
}
