import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pp_input.dart'; // To reuse PPInputVariant and PPInputSize

class PPPhoneInput extends StatefulWidget {
  final String value;
  final ValueChanged<String>? onChanged;
  final String countryCode;
  final VoidCallback? onSelectCountry;
  final String? label;
  final String? placeholder;
  final bool clearable;
  final String? format;
  final PPInputVariant variant;
  final PPInputSize size;
  final bool rounded;
  final FocusNode? focusNode;

  const PPPhoneInput({
    Key? key,
    this.value = '',
    this.onChanged,
    this.countryCode = '+855',
    this.onSelectCountry,
    this.label,
    this.placeholder,
    this.clearable = true,
    this.format,
    this.variant = PPInputVariant.outline,
    this.size = PPInputSize.md,
    this.rounded = false,
    this.focusNode,
  }) : super(key: key);

  @override
  State<PPPhoneInput> createState() => _PPPhoneInputState();
}

class _PPPhoneInputState extends State<PPPhoneInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatInitialValue(widget.value));
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(PPPhoneInput oldWidget) {
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
    if (widget.format != null && widget.format!.isNotEmpty) {
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
    String digits = val.replaceAll(RegExp(r'\D'), '');

    if (widget.format != null && widget.format!.isNotEmpty) {
      final formatted = _applyFormat(digits, widget.format!);
      if (val != formatted) {
        _controller.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    }

    widget.onChanged?.call(digits);
  }

  double get _height {
    switch (widget.size) {
      case PPInputSize.sm:
        return 40.0;
      case PPInputSize.md:
        return 50.0;
      case PPInputSize.lg:
        return 64.0;
    }
  }

  BorderRadius get _borderRadius {
    if (widget.variant == PPInputVariant.underlined) return BorderRadius.zero;
    return widget.rounded ? BorderRadius.circular(100.0) : BorderRadius.circular(12.0);
  }

  BoxBorder get _border {
    if (widget.variant == PPInputVariant.underlined) {
      return Border(
        bottom: BorderSide(
          color: _isFocused ? const Color(0xFF0066CC) : const Color(0xFFE0E0E0),
          width: 2.0,
        ),
      );
    }

    if (widget.variant == PPInputVariant.filled) {
      return Border.all(
        color: _isFocused ? const Color(0xFF0066CC) : Colors.transparent,
        width: 1.0,
      );
    }

    // Outline variant
    return Border.all(
      color: _isFocused ? const Color(0xFF0066CC) : const Color(0xFFCCCCCC),
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
          color: const Color(0xFF0066CC).withOpacity(0.1),
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
        if (widget.label != null && widget.label!.isNotEmpty) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: _height,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: _borderRadius,
            border: _border,
            boxShadow: _boxShadow,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: widget.onSelectCountry,
                borderRadius: widget.variant != PPInputVariant.underlined
                    ? BorderRadius.horizontal(left: Radius.circular(widget.rounded ? 100.0 : 12.0))
                    : BorderRadius.zero,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.countryCode,
                        style: const TextStyle(
                          color: Color(0xFF1A2A5E),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.expand_more,
                        color: Color(0xFF1A2A5E),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 24,
                color: const Color(0xFFE0E0E0),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onChanged: _handleChanged,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-\(\)]')),
                    ],
                    decoration: InputDecoration(
                      hintText: widget.placeholder,
                      hintStyle: const TextStyle(color: Color(0xFF1A2A5E), fontSize: 15, fontWeight: FontWeight.w600),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(
                      color: Color(0xFF1A2A5E),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              if (showClear) ...[
                GestureDetector(
                  onTap: () {
                    _controller.clear();
                    _handleChanged('');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.close, color: Color(0xFFA0A0A0), size: 16),
                  ),
                ),
              ] else ...[
                const SizedBox(width: 16),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
