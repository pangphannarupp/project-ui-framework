import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PPNumberSpinner extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double? min;
  final double? max;
  final double step;
  final bool disabled;

  const PPNumberSpinner({
    Key? key,
    required this.value,
    this.onChanged,
    this.min,
    this.max,
    this.step = 1.0,
    this.disabled = false,
  }) : super(key: key);

  @override
  State<PPNumberSpinner> createState() => _PPNumberSpinnerState();
}

class _PPNumberSpinnerState extends State<PPNumberSpinner> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatValue(widget.value));
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(covariant PPNumberSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && !_focusNode.hasFocus) {
      _controller.text = _formatValue(widget.value);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  String _formatValue(double val) {
    // Determine if we should show decimals based on step
    if (widget.step % 1 == 0) {
      return val.toInt().toString();
    }
    return val.toStringAsFixed(2).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _commitValue(_controller.text);
    }
  }

  void _commitValue(String text) {
    if (widget.disabled || widget.onChanged == null) return;
    
    double? parsed = double.tryParse(text);
    if (parsed != null) {
      _updateValue(parsed);
    } else {
      // Revert on invalid input
      _controller.text = _formatValue(widget.value);
    }
  }

  void _updateValue(double newValue) {
    double clamped = newValue;
    if (widget.min != null && clamped < widget.min!) clamped = widget.min!;
    if (widget.max != null && clamped > widget.max!) clamped = widget.max!;
    
    _controller.text = _formatValue(clamped);
    if (clamped != widget.value) {
      widget.onChanged!(clamped);
    }
  }

  void _increment() {
    if (widget.disabled || widget.onChanged == null) return;
    _updateValue(widget.value + widget.step);
  }

  void _decrement() {
    if (widget.disabled || widget.onChanged == null) return;
    _updateValue(widget.value - widget.step);
  }

  @override
  Widget build(BuildContext context) {
    final bool canDecrement = !widget.disabled && (widget.min == null || widget.value > widget.min!);
    final bool canIncrement = !widget.disabled && (widget.max == null || widget.value < widget.max!);

    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(
          color: _focusNode.hasFocus ? const Color(0xFF1A2A5E) : const Color(0xFFE0E0E0),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: widget.disabled ? const Color(0xFFF5F5F5) : Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SpinnerButton(
            icon: Icons.remove,
            onPressed: canDecrement ? _decrement : null,
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: const Color(0xFFE0E0E0),
          ),
          SizedBox(
            width: 60,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: !widget.disabled,
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*\.?[0-9]*')),
              ],
              onSubmitted: _commitValue,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: const Color(0xFFE0E0E0),
          ),
          _SpinnerButton(
            icon: Icons.add,
            onPressed: canIncrement ? _increment : null,
          ),
        ],
      ),
    );
  }
}

class _SpinnerButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _SpinnerButton({required this.icon, this.onPressed});

  @override
  State<_SpinnerButton> createState() => _SpinnerButtonState();
}

class _SpinnerButtonState extends State<_SpinnerButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.onPressed == null;
    Color bgColor = Colors.transparent;
    
    if (!isDisabled) {
      if (_isPressed) {
        bgColor = const Color(0xFFE0E0E0);
      } else if (_isHovering) {
        bgColor = const Color(0xFFF0F0F0);
      }
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed?.call();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          width: 48,
          height: double.infinity,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.horizontal(
              left: widget.icon == Icons.remove ? const Radius.circular(7) : Radius.zero,
              right: widget.icon == Icons.add ? const Radius.circular(7) : Radius.zero,
            ),
          ),
          child: Center(
            child: Icon(
              widget.icon,
              size: 16,
              color: isDisabled ? const Color(0xFFBDBDBD) : const Color(0xFF333333),
            ),
          ),
        ),
      ),
    );
  }
}
