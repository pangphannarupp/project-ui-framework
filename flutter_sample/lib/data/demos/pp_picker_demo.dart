import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_pickerData = ComponentItem(
  name: 'PPPicker',
  description: 'A generic wheel picker.',
  demoBuilder: (context) => const PPPickerDemo(),
  demoCode: '''
PPPicker<String>(
  items: ['Apple', 'Banana', 'Cherry'],
  selectedItem: 'Apple',
  onChanged: (value) {
    print(value);
  },
  itemBuilder: (item) => Text(
    item,
    style: const TextStyle(fontSize: 18),
  ),
);
''',
);

class PPPickerDemo extends StatefulWidget {
  const PPPickerDemo({super.key});

  @override
  State<PPPickerDemo> createState() => _PPPickerDemoState();
}

class _PPPickerDemoState extends State<PPPickerDemo> {
  final List<String> _items = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
  String _selectedItem = 'Apple';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Picker',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: PPPicker<String>(
              items: _items,
              selectedItem: _selectedItem,
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
              },
              itemBuilder: (item) => Text(
                item,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Selected: $_selectedItem',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
