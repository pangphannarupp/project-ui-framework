import 'package:flutter/material.dart';

class PPSelectOption {
  final String label;
  final String value;
  
  const PPSelectOption({required this.label, required this.value});
}

enum PPSelectVariant { outlined, filled, flushed, soft }
enum PPSelectSize { sm, md, lg }

class PPSelect extends StatelessWidget {
  final String? value;
  final List<PPSelectOption> options;
  final ValueChanged<String?>? onChanged;
  final String? label;
  final String? placeholder;
  final PPSelectVariant variant;
  final bool disabled;
  final String? error;
  final String? helperText;
  final bool isRequired;
  final IconData? prefixIcon;
  final Color? activeColor;
  final PPSelectSize size;
  final double borderRadius;

  const PPSelect({
    Key? key,
    this.value,
    required this.options,
    this.onChanged,
    this.label,
    this.placeholder,
    this.variant = PPSelectVariant.outlined,
    this.disabled = false,
    this.error,
    this.helperText,
    this.isRequired = false,
    this.prefixIcon,
    this.activeColor,
    this.size = PPSelectSize.md,
    this.borderRadius = 6.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = activeColor ?? theme.primaryColor;

    InputBorder getEnabledBorder() {
      switch (variant) {
        case PPSelectVariant.outlined:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: isDark ? const Color(0xFF555555) : const Color(0xFFCCCCCC)),
          );
        case PPSelectVariant.filled:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.transparent),
          );
        case PPSelectVariant.flushed:
          return UnderlineInputBorder(
            borderSide: BorderSide(color: isDark ? const Color(0xFF555555) : const Color(0xFFCCCCCC)),
          );
        case PPSelectVariant.soft:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.transparent),
          );
      }
    }

    InputBorder getFocusedBorder() {
      switch (variant) {
        case PPSelectVariant.outlined:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: color, width: 2),
          );
        case PPSelectVariant.filled:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: color, width: 2),
          );
        case PPSelectVariant.flushed:
          return UnderlineInputBorder(
            borderSide: BorderSide(color: color, width: 2),
          );
        case PPSelectVariant.soft:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: color.withOpacity(0.5), width: 2),
          );
      }
    }

    Color getFillColor() {
      if (disabled) return isDark ? const Color(0xFF333333) : const Color(0xFFF5F5F5);
      switch (variant) {
        case PPSelectVariant.outlined:
        case PPSelectVariant.flushed:
          return isDark ? const Color(0xFF1E1E1E) : Colors.white;
        case PPSelectVariant.filled:
          return isDark ? const Color(0xFF252526) : const Color(0xFFF5F5F5);
        case PPSelectVariant.soft:
          return color.withOpacity(0.1);
      }
    }

    EdgeInsetsGeometry getContentPadding() {
      switch (size) {
        case PPSelectSize.sm:
          return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        case PPSelectSize.md:
          return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
        case PPSelectSize.lg:
          return const EdgeInsets.symmetric(horizontal: 16, vertical: 20);
      }
    }

    final field = DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      dropdownColor: isDark ? const Color(0xFF333333) : Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
      items: options.map((opt) {
        return DropdownMenuItem(
          value: opt.value,
          child: Text(
            opt.label,
            style: TextStyle(
              fontSize: size == PPSelectSize.sm ? 12 : 14,
              fontWeight: FontWeight.w400,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        );
      }).toList(),
      onChanged: disabled ? null : onChanged,
      icon: const Icon(Icons.expand_more, color: Color(0xFF666666)),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: Color(0xFF999999)),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: const Color(0xFF666666)) : null,
        filled: true,
        fillColor: getFillColor(),
        contentPadding: getContentPadding(),
        isDense: size == PPSelectSize.sm,
        enabledBorder: getEnabledBorder(),
        focusedBorder: getFocusedBorder(),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(
                fontSize: size == PPSelectSize.sm ? 12 : 14,
                fontWeight: FontWeight.w500,
                color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF333333),
              ),
              children: [
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
        ],
        field,
        if (error != null || helperText != null) ...[
          const SizedBox(height: 6),
          Text(
            error ?? helperText!,
            style: TextStyle(
              fontSize: 12,
              color: error != null ? Colors.red : const Color(0xFF666666),
            ),
          ),
        ],
      ],
    );
  }
}
