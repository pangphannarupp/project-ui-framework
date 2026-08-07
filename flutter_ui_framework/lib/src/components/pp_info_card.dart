import 'package:flutter/material.dart';

enum PPInfoCardType { info, success, warning, error, neutral }
enum PPInfoCardVariant { soft, solid, outline, glass }

class PPInfoCard extends StatelessWidget {
  final PPInfoCardType type;
  final PPInfoCardVariant variant;
  final Widget child;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;

  const PPInfoCard({
    Key? key,
    required this.child,
    this.type = PPInfoCardType.info,
    this.variant = PPInfoCardVariant.soft,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.borderColor,
    this.borderRadius,
  }) : super(key: key);

  Color _getBaseColor() {
    switch (type) {
      case PPInfoCardType.info:
        return const Color(0xFF3B82F6);
      case PPInfoCardType.success:
        return const Color(0xFF10B981);
      case PPInfoCardType.warning:
        return const Color(0xFFF59E0B);
      case PPInfoCardType.error:
        return const Color(0xFFEF4444);
      case PPInfoCardType.neutral:
        return const Color(0xFF6B7280);
    }
  }

  Color _getSoftBgColor() {
    switch (type) {
      case PPInfoCardType.info:
        return const Color(0xFFEFF6FF);
      case PPInfoCardType.success:
        return const Color(0xFFECFDF5);
      case PPInfoCardType.warning:
        return const Color(0xFFFFFBEB);
      case PPInfoCardType.error:
        return const Color(0xFFFEF2F2);
      case PPInfoCardType.neutral:
        return const Color(0xFFF9FAFB);
    }
  }

  Color _getSoftBorderColor() {
    switch (type) {
      case PPInfoCardType.info:
        return const Color(0xFFBFDBFE);
      case PPInfoCardType.success:
        return const Color(0xFFA7F3D0);
      case PPInfoCardType.warning:
        return const Color(0xFFFDE68A);
      case PPInfoCardType.error:
        return const Color(0xFFFECACA);
      case PPInfoCardType.neutral:
        return const Color(0xFFE5E7EB);
    }
  }

  IconData _getDefaultIcon() {
    switch (type) {
      case PPInfoCardType.info:
        return Icons.info_outline;
      case PPInfoCardType.success:
        return Icons.check_circle_outline;
      case PPInfoCardType.warning:
        return Icons.warning_amber_rounded;
      case PPInfoCardType.error:
        return Icons.error_outline;
      case PPInfoCardType.neutral:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = _getBaseColor();
    
    Color bg;
    Color border = Colors.transparent;
    Color text = Colors.black87;
    Color iconC = baseColor;

    switch (variant) {
      case PPInfoCardVariant.soft:
        bg = _getSoftBgColor();
        border = _getSoftBorderColor();
        text = const Color(0xFF374151);
        break;
      case PPInfoCardVariant.solid:
        bg = baseColor;
        text = Colors.white;
        iconC = Colors.white;
        break;
      case PPInfoCardVariant.outline:
        bg = Colors.transparent;
        border = baseColor;
        iconC = baseColor;
        break;
      case PPInfoCardVariant.glass:
        bg = Colors.white.withOpacity(0.2);
        border = Colors.white.withOpacity(0.3);
        iconC = baseColor;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? bg,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: Border.all(color: borderColor ?? border),
        boxShadow: variant == PPInfoCardVariant.glass
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: -5,
                )
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: icon ?? Icon(_getDefaultIcon(), color: iconColor ?? iconC, size: 20),
          ),
          Expanded(
            child: DefaultTextStyle(
              style: TextStyle(color: textColor ?? text, fontSize: 14, height: 1.5),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
