import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPPinSecurityDemo extends StatefulWidget {
  const _PPPinSecurityDemo();

  @override
  State<_PPPinSecurityDemo> createState() => _PPPinSecurityDemoState();
}

class _PPPinSecurityDemoState extends State<_PPPinSecurityDemo> {
  String _pin = '';
  bool _error = false;
  bool _success = false;

  void _onKeyPress(String key) {
    setState(() {
      if (key == 'backspace') {
        if (_pin.isNotEmpty) {
          _pin = _pin.substring(0, _pin.length - 1);
        }
        _error = false;
        _success = false;
      } else {
        if (_pin.length < 6) {
          _pin += key;
        }
        
        // Auto-validate on 6 digits
        if (_pin.length == 6) {
          if (_pin == '123456') {
            _success = true;
            _error = false;
          } else {
            _error = true;
            _success = false;
          }
        } else {
          _error = false;
          _success = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        const Text('Enter your 6-digit PIN', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('(Try 123456 for success)', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 32),
        
        PPPinDots(
          length: 6,
          value: _pin,
          error: _error,
          success: _success,
          errorText: 'Incorrect PIN. Try again.',
        ),
        
        const SizedBox(height: 64),
        
        // We wrap it in a constrained box so it doesn't take up the whole screen in web
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: PPSecureKeypad(
            onPress: _onKeyPress,
          ),
        ),
      ],
    );
  }
}

final ComponentItem pp_pin_securityData = ComponentItem(
  name: 'PPPinDots & Keypad',
  description: 'A secure, randomized numeric keypad and dot indicator for entering PINs and OTPs with success and error animations.',
  demoCode: '''PPPinDots(
  length: 6,
  value: _pin,
  error: _hasError,
  success: _hasSuccess,
);

PPSecureKeypad(
  onPress: (key) {
    if (key == 'backspace') {
      // Handle backspace
    } else {
      // Handle digit entry
    }
  },
);''',
  demoBuilder: (context) {
    return const _PPPinSecurityDemo();
  },
);
