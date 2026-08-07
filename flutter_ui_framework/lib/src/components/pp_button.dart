import 'package:flutter/material.dart';

enum PPButtonVariant {
  primary,
  secondary,
  success,
  danger,
  outline,
  outlineDanger,
  ghost,
  gradient,
  elevated,
  soft,
}

enum PPButtonSize { sm, md, lg }

class PPButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final PPButtonVariant variant;
  final PPButtonSize size;
  final Color? color;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isLoading;
  final bool isFullWidth;
  final bool isRounded;

  const PPButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.variant = PPButtonVariant.primary,
    this.size = PPButtonSize.md,
    this.color,
    this.prefixIcon,
    this.suffixIcon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.isRounded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = color ?? theme.primaryColor;
    final isDisabled = onPressed == null || isLoading;

    EdgeInsets padding;
    double fontSize;
    switch (size) {
      case PPButtonSize.sm:
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        fontSize = 14;
        break;
      case PPButtonSize.md:
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
        fontSize = 16;
        break;
      case PPButtonSize.lg:
        padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 20);
        fontSize = 18;
        break;
    }

    final borderRadius = BorderRadius.circular(isRounded ? 9999 : 12);

    Color getTextColor() {
      switch (variant) {
        case PPButtonVariant.primary:
        case PPButtonVariant.success:
        case PPButtonVariant.danger:
        case PPButtonVariant.gradient:
          return Colors.white;
        case PPButtonVariant.secondary:
          return const Color(0xFF334155);
        case PPButtonVariant.outline:
        case PPButtonVariant.ghost:
          return baseColor;
        case PPButtonVariant.outlineDanger:
          return Colors.red;
        case PPButtonVariant.elevated:
          return const Color(0xFF0F172A);
        case PPButtonVariant.soft:
          return baseColor;
      }
    }

    final textColor = getTextColor();

    Widget content = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: fontSize,
            height: fontSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(textColor),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (prefixIcon != null) ...[
          Icon(prefixIcon, size: fontSize + 2),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: textColor,
          ),
        ),
        if (suffixIcon != null && !isLoading) ...[
          const SizedBox(width: 8),
          Icon(suffixIcon, size: fontSize + 2),
        ],
      ],
    );

    ButtonStyle getElevatedStyle(Color bg, Color fg, {double elevation = 0}) {
      return ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: elevation,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        disabledBackgroundColor: bg.withOpacity(0.5),
        disabledForegroundColor: fg.withOpacity(0.5),
        shadowColor: elevation > 0 ? Colors.black26 : Colors.transparent,
      );
    }

    ButtonStyle getOutlinedStyle(Color fg, {Color? borderColor}) {
      return OutlinedButton.styleFrom(
        foregroundColor: fg,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        side: BorderSide(color: (borderColor ?? fg).withOpacity(isDisabled ? 0.3 : 1)),
        disabledForegroundColor: fg.withOpacity(0.5),
      );
    }
    
    ButtonStyle getTextButtonStyle(Color fg, {Color? bg}) {
      return TextButton.styleFrom(
        foregroundColor: fg,
        backgroundColor: bg ?? Colors.transparent,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        disabledForegroundColor: fg.withOpacity(0.5),
      );
    }

    switch (variant) {
      case PPButtonVariant.primary:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: getElevatedStyle(baseColor, Colors.white),
          child: content,
        );
      case PPButtonVariant.secondary:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: getElevatedStyle(const Color(0xFFF1F5F9), const Color(0xFF334155)),
          child: content,
        );
      case PPButtonVariant.success:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: getElevatedStyle(const Color(0xFF10B981), Colors.white),
          child: content,
        );
      case PPButtonVariant.danger:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: getElevatedStyle(Colors.red, Colors.white),
          child: content,
        );
      case PPButtonVariant.outline:
        return OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: getOutlinedStyle(baseColor, borderColor: const Color(0xFFCBD5E1)),
          child: content,
        );
      case PPButtonVariant.outlineDanger:
        return OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: getOutlinedStyle(Colors.red, borderColor: Colors.red.shade200),
          child: content,
        );
      case PPButtonVariant.ghost:
        return TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: getTextButtonStyle(baseColor),
          child: content,
        );
      case PPButtonVariant.soft:
        return TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: getTextButtonStyle(baseColor, bg: baseColor.withOpacity(0.1)),
          child: content,
        );
      case PPButtonVariant.elevated:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: getElevatedStyle(Colors.white, const Color(0xFF0F172A), elevation: 4),
          child: content,
        );
      case PPButtonVariant.gradient:
        return Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: isDisabled ? null : const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: isDisabled ? Colors.grey.shade300 : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: isDisabled ? null : onPressed,
              child: Padding(
                padding: padding,
                child: DefaultTextStyle(
                  style: TextStyle(color: textColor),
                  child: content,
                ),
              ),
            ),
          ),
        );
    }
  }
}
