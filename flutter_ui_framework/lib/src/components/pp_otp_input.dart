import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PPOtpInput extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool obscureText;
  final double fieldWidth;
  final double fieldHeight;

  const PPOtpInput({
    Key? key,
    this.length = 6,
    this.onChanged,
    this.onCompleted,
    this.obscureText = false,
    this.fieldWidth = 48,
    this.fieldHeight = 56,
  }) : super(key: key);

  @override
  State<PPOtpInput> createState() => _PPOtpInputState();
}

class _PPOtpInputState extends State<PPOtpInput> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _controllers = List.generate(widget.length, (index) => TextEditingController());
    
    for (int i = 0; i < widget.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _enforceFocus(i);
          
          // Auto-select existing text so typing overwrites it
          if (_controllers[i].text.isNotEmpty) {
            _controllers[i].selection = TextSelection(
              baseOffset: 0,
              extentOffset: _controllers[i].text.length,
            );
          }
        }
      });
    }
  }

  void _enforceFocus(int focusedIndex) {
    int firstEmptyIndex = _controllers.indexWhere((c) => c.text.isEmpty);
    
    // The only allowed focus index is the first empty box (or the very last box if full)
    int targetFocus = firstEmptyIndex == -1 ? widget.length - 1 : firstEmptyIndex;
    
    // If the user tapped ANY box other than the target, redirect them.
    // This strictly enforces "delete from last only" and prevents middle edits.
    if (focusedIndex != targetFocus) {
      Future.microtask(() {
        if (mounted) _focusNodes[targetFocus].requestFocus();
      });
    }
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    _syncDigits();
  }

  void _syncDigits() {
    String allDigits = _controllers.map((c) => c.text).join('').replaceAll(RegExp(r'[^0-9]'), '');
    
    if (allDigits.length > widget.length) {
      allDigits = allDigits.substring(0, widget.length);
    }

    for (int i = 0; i < widget.length; i++) {
      if (i < allDigits.length) {
        if (_controllers[i].text != allDigits[i]) {
          _controllers[i].text = allDigits[i];
        }
      } else {
        if (_controllers[i].text.isNotEmpty) {
          _controllers[i].text = '';
        }
      }
    }

    int firstEmpty = allDigits.length;
    if (firstEmpty < widget.length) {
      Future.microtask(() {
        if (mounted) _focusNodes[firstEmpty].requestFocus();
      });
    } else {
      Future.microtask(() {
        if (mounted) _focusNodes.last.unfocus();
      });
    }
    
    _triggerChanged();
  }

  void _triggerChanged() {
    String currentCode = _controllers.map((c) => c.text).join('');
    if (widget.onChanged != null) {
      widget.onChanged!(currentCode);
    }
    if (currentCode.length == widget.length && widget.onCompleted != null) {
      widget.onCompleted!(currentCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: widget.fieldWidth,
          height: widget.fieldHeight,
          child: Focus(
            onKeyEvent: (node, event) {
              if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                if (_controllers[index].text.isEmpty && index > 0) {
                  _controllers[index - 1].clear();
                  _syncDigits();
                  return KeyEventResult.handled;
                }
              }
              return KeyEventResult.ignored;
            },
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              obscureText: widget.obscureText,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: const TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
              decoration: InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
                ),
              ),
              onChanged: (val) => _onChanged(val, index),
            ),
          ),
        );
      }),
    );
  }
}
