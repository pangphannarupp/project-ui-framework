import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_color_pickerData = ComponentItem(
  name: 'PPColorPicker',
  description: 'A premium, animated color selection palette.',
  demoBuilder: (context) => const PPColorPickerDemo(),
);

class PPColorPickerDemo extends StatefulWidget {
  const PPColorPickerDemo({super.key});

  @override
  State<PPColorPickerDemo> createState() => _PPColorPickerDemoState();
}

class _PPColorPickerDemoState extends State<PPColorPickerDemo> {
  Color _selectedColor1 = const Color(0xFF3B82F6); // Blue
  Color _selectedColor2 = const Color(0xFF10B981); // Emerald

  final List<Color> _brandColors = const [
    Color(0xFF3B82F6), // Blue
    Color(0xFF8B5CF6), // Violet
    Color(0xFFEC4899), // Pink
    Color(0xFFEF4444), // Red
    Color(0xFFF59E0B), // Amber
    Color(0xFF10B981), // Emerald
    Color(0xFF111827), // Dark
    Color(0xFFF3F4F6), // Light
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Color Picker',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 16),
          PPColorPicker(
            colors: _brandColors,
            selectedColor: _selectedColor1,
            onChanged: (color) {
              setState(() {
                _selectedColor1 = color;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Selected: #${_selectedColor1.value.toRadixString(16).substring(2).toUpperCase()}',
            style: const TextStyle(color: Color(0xFF6B7280)),
          ),
          
          const SizedBox(height: 48),
          
          const Text(
            'Small Variant',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 16),
          PPColorPicker(
            colors: _brandColors,
            selectedColor: _selectedColor2,
            size: 28,
            spacing: 8,
            onChanged: (color) {
              setState(() {
                _selectedColor2 = color;
              });
            },
          ),
        ],
      ),
    );
  }
}
