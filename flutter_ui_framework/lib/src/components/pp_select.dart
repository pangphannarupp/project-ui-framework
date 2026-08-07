import 'package:flutter/material.dart';

class PPSelectOption {
  final String label;
  final String value;
  
  const PPSelectOption({required this.label, required this.value});
}

enum PPSelectVariant { outlined, filled, flushed, soft }

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = activeColor ?? theme.primaryColor;

    InputBorder getEnabledBorder() {
      switch (variant) {
        case PPSelectVariant.outlined:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
          );
        case PPSelectVariant.filled:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent),
          );
        case PPSelectVariant.flushed:
          return const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFCCCCCC)),
          );
        case PPSelectVariant.soft:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent),
          );
      }
    }

    InputBorder getFocusedBorder() {
      switch (variant) {
        case PPSelectVariant.outlined:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: color, width: 2),
          );
        case PPSelectVariant.filled:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: color, width: 2),
          );
        case PPSelectVariant.flushed:
          return UnderlineInputBorder(
            borderSide: BorderSide(color: color, width: 2),
          );
        case PPSelectVariant.soft:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: color.withOpacity(0.5), width: 2),
          );
      }
    }

    Color getFillColor() {
      if (disabled) return const Color(0xFFF5F5F5);
      switch (variant) {
        case PPSelectVariant.outlined:
        case PPSelectVariant.flushed:
          return Colors.white;
        case PPSelectVariant.filled:
          return const Color(0xFFF5F5F5);
        case PPSelectVariant.soft:
          return color.withOpacity(0.1);
      }
    }

    final field = DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      items: options.map((opt) {
        return DropdownMenuItem(
          value: opt.value,
          child: Text(
            opt.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: getEnabledBorder(),
        focusedBorder: getFocusedBorder(),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
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
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
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
