import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PPInputVariant { outline, filled, underlined }
enum PPInputSize { sm, md, lg }

class PPInput extends StatefulWidget {
  final String value;
  final ValueChanged<String>? onChanged;
  final String? label;
  final String? placeholder;
  final PPInputVariant variant;
  final PPInputSize size;
  final bool rounded;
  final bool clearable;
  final bool isPassword;
  final Widget? iconLeft;
  final Widget? iconRight;
  final int? maxLength;
  final bool numberOnly;
  final String? format;
  final double? min;
  final double? max;
  final FocusNode? focusNode;

  const PPInput({
    Key? key,
    this.value = '',
    this.onChanged,
    this.label,
    this.placeholder,
    this.variant = PPInputVariant.outline,
    this.size = PPInputSize.md,
    this.rounded = false,
    this.clearable = false,
    this.isPassword = false,
    this.iconLeft,
    this.iconRight,
    this.maxLength,
    this.numberOnly = false,
    this.format,
    this.min,
    this.max,
    this.focusNode,
  }) : super(key: key);

  @override
  State<PPInput> createState() => _PPInputState();
}

class _PPInputState extends State<PPInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatInitialValue(widget.value));
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(PPInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      final formatted = _formatInitialValue(widget.value);
      if (_controller.text != formatted) {
        _controller.text = formatted;
      }
    }
    if (widget.focusNode != oldWidget.focusNode) {
      if (oldWidget.focusNode == null) _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  String _formatInitialValue(String val) {
    if (widget.format != null) {
      return _applyFormat(val, widget.format!);
    }
    return val;
  }

  String _applyFormat(String val, String formatStr) {
    if (val.isEmpty) return '';
    final digits = val.replaceAll(RegExp(r'\D'), '');
    if (formatStr.isEmpty) return digits;

    String formatted = '';
    int digitIndex = 0;
    
    final maskChar = formatStr.contains('#') ? '#' : (formatStr.contains('8') ? '8' : (formatStr.contains('X') ? 'X' : 'x'));
    if (!['#', '8', 'X', 'x'].contains(maskChar)) return digits;

    for (int i = 0; i < formatStr.length; i++) {
      if (digitIndex >= digits.length) break;
      if (formatStr[i] == maskChar) {
        formatted += digits[digitIndex];
        digitIndex++;
      } else {
        formatted += formatStr[i];
      }
    }
    return formatted;
  }

  void _handleChanged(String val) {
    String processed = val;
    
    if (widget.numberOnly || widget.format != null) {
      processed = processed.replaceAll(RegExp(r'\D'), '');
    }

    if (widget.maxLength != null && processed.length > widget.maxLength! && widget.format == null) {
      processed = processed.substring(0, widget.maxLength);
    }

    if (widget.min != null || widget.max != null) {
      final numVal = double.tryParse(processed);
      if (numVal != null) {
        if (widget.min != null && numVal < widget.min!) processed = widget.min.toString();
        if (widget.max != null && numVal > widget.max!) processed = widget.max.toString();
      }
    }

    if (widget.format != null) {
      final formatted = _applyFormat(processed, widget.format!);
      if (val != formatted) {
        _controller.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    } else {
      if (val != processed) {
        _controller.value = TextEditingValue(
          text: processed,
          selection: TextSelection.collapsed(offset: processed.length),
        );
      }
    }

    widget.onChanged?.call(processed);
  }

  double get _height {
    switch (widget.size) {
      case PPInputSize.sm:
        return 32.0;
      case PPInputSize.md:
        return 40.0;
      case PPInputSize.lg:
        return 48.0;
    }
  }

  BorderRadius get _borderRadius {
    if (widget.variant == PPInputVariant.underlined) return BorderRadius.zero;
    return widget.rounded ? BorderRadius.circular(100.0) : BorderRadius.circular(6.0);
  }

  BoxBorder get _border {
    if (widget.variant == PPInputVariant.underlined) {
      return Border(
        bottom: BorderSide(
          color: _isFocused ? const Color(0xFF1A2A5E) : const Color(0xFFE0E0E0),
          width: 2.0,
        ),
      );
    }

    if (widget.variant == PPInputVariant.filled) {
      return Border.all(
        color: _isFocused ? const Color(0xFF1A2A5E) : Colors.transparent,
        width: 1.0,
      );
    }

    // Outline variant
    return Border.all(
      color: _isFocused ? const Color(0xFF1A2A5E) : const Color(0xFFCCCCCC),
      width: 1.0,
    );
  }

  Color get _backgroundColor {
    if (widget.variant == PPInputVariant.underlined) return Colors.transparent;
    if (widget.variant == PPInputVariant.filled) {
      return _isFocused ? const Color(0xFFE9ECEF) : const Color(0xFFF1F3F5);
    }
    return Colors.white; // outline
  }

  List<BoxShadow>? get _boxShadow {
    if (widget.variant == PPInputVariant.outline && _isFocused) {
      return [
        BoxShadow(
          color: const Color(0xFF1A2A5E).withOpacity(0.1),
          blurRadius: 0,
          spreadRadius: 2.0,
        ),
      ];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final bool showClear = widget.clearable && _controller.text.isNotEmpty;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
        ],
        Container(
          height: _height,
          padding: widget.variant == PPInputVariant.underlined
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: _borderRadius,
            border: _border,
            boxShadow: _boxShadow,
          ),
          child: Row(
            children: [
              if (widget.iconLeft != null) ...[
                IconTheme(
                  data: const IconThemeData(color: Color(0xFF999999), size: 20),
                  child: widget.iconLeft!,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: _handleChanged,
                  obscureText: widget.isPassword && !_isPasswordVisible,
                  keyboardType: widget.numberOnly ? TextInputType.number : TextInputType.text,
                  inputFormatters: [
                    if (widget.numberOnly) FilteringTextInputFormatter.digitsOnly,
                    if (widget.maxLength != null && widget.format == null) LengthLimitingTextInputFormatter(widget.maxLength),
                  ],
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: const TextStyle(color: Color(0xFF999999), fontSize: 16),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 16,
                  ),
                ),
              ),
              if (showClear || widget.isPassword || widget.iconRight != null) ...[
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showClear)
                      GestureDetector(
                        onTap: () {
                          _controller.clear();
                          _handleChanged('');
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(Icons.close, color: Color(0xFF999999), size: 20),
                        ),
                      ),
                    if (widget.isPassword)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(
                            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF999999),
                            size: 20,
                          ),
                        ),
                      ),
                    if (widget.iconRight != null) ...[
                      if (showClear || widget.isPassword) const SizedBox(width: 4),
                      IconTheme(
                        data: const IconThemeData(color: Color(0xFF999999), size: 20),
                        child: widget.iconRight!,
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
