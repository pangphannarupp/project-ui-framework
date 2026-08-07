import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPKeyboardsDemo extends StatefulWidget {
  const _PPKeyboardsDemo();

  @override
  State<_PPKeyboardsDemo> createState() => _PPKeyboardsDemoState();
}

class _PPKeyboardsDemoState extends State<_PPKeyboardsDemo> {
  String _secureText = '';
  String _khmerText = '';

  void _onSecurePress(String key) {
    setState(() {
      if (key == 'backspace') {
        if (_secureText.isNotEmpty) {
          _secureText = _secureText.substring(0, _secureText.length - 1);
        }
      } else if (key == 'enter') {
        _secureText += '\\n';
      } else if (key == 'emoji') {
        _secureText += '😊';
      } else {
        _secureText += key;
      }
    });
  }

  void _onKhmerPress(String key) {
    setState(() {
      if (key == 'backspace') {
        if (_khmerText.isNotEmpty) {
          _khmerText = _khmerText.substring(0, _khmerText.length - 1);
        }
      } else if (key == 'enter') {
        _khmerText += '\\n';
      } else if (key == 'emoji') {
        _khmerText += '😊';
      } else {
        _khmerText += key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Secure Keyboard',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'A full QWERTY keyboard that randomly shifts the position of the keys by inserting a shield. This prevents shoulder surfing and screen recording analysis.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            _secureText.isEmpty ? 'Type something...' : _secureText,
            style: TextStyle(
              fontSize: 16,
              color: _secureText.isEmpty ? Colors.grey : Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: PPSecureKeyboard(
              onPress: _onSecurePress,
            ),
          ),
        ),

        const SizedBox(height: 48),

        const Text(
          'Khmer Keyboard',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'A full custom Khmer keyboard with shift states and standard layout. Includes small sub-character hints just like the native iOS/Android Khmer keyboards.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            _khmerText.isEmpty ? 'វាយបញ្ចូលអត្ថបទទីនេះ...' : _khmerText,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Suwannaphum',
              color: _khmerText.isEmpty ? Colors.grey : Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.only(top: 60), // Space for popup
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.none, // Allow popup to overflow
            child: PPKhmerKeyboard(
              onPress: _onKhmerPress,
            ),
          ),
        ),
      ],
    );
  }
}

final ComponentItem pp_keyboardsData = ComponentItem(
  name: 'Secure & Khmer Keyboards',
  description: 'Custom on-screen keyboards for high-security environments and localized Khmer input.',
  demoCode: '''PPSecureKeyboard(
  onPress: (key) {
    if (key == 'backspace') {
      // delete
    } else {
      // append
    }
  },
)

PPKhmerKeyboard(
  onPress: (key) {
    // Handle input
  },
)''',
  demoBuilder: (context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: _PPKeyboardsDemo(),
    );
  },
);
