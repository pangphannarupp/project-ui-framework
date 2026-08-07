import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_checkboxData = ComponentItem(
    name: 'PPCheckbox',
    description: 'A customizable checkbox component that supports both independent use and grouped states.',
    demoCode: '''
// Independent Checkbox
PPCheckbox(
  label: 'Accept Terms & Conditions',
  value: isChecked,
  onChanged: (val) => setState(() => isChecked = val),
)

// Checkbox Group
PPCheckboxGroup(
  values: selectedValues, // List<String>
  onChanged: (newValues) => setState(() => selectedValues = newValues),
  vertical: false, // Set to true for column layout
  children: const [
    PPCheckbox(label: 'Option 1', groupValue: 'opt1'),
    PPCheckbox(label: 'Option 2', groupValue: 'opt2'),
    PPCheckbox(label: 'Option 3', groupValue: 'opt3'),
  ],
)
''',
    demoBuilder: (context) {
      bool singleChecked = false;
      List<String> horizontalGroup = ['opt2'];
      List<String> verticalGroup = ['apple', 'orange'];

      return StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Single Checkbox', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPCheckbox(
                    label: 'I accept the terms and conditions',
                    value: singleChecked,
                    onChanged: (val) => setState(() => singleChecked = val),
                  ),
                  const SizedBox(height: 32),
                  const Text('Horizontal Checkbox Group', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPCheckboxGroup(
                    values: horizontalGroup,
                    onChanged: (newValues) => setState(() => horizontalGroup = newValues.cast<String>()),
                    children: const [
                      PPCheckbox(label: 'Option A', groupValue: 'opt1'),
                      PPCheckbox(label: 'Option B', groupValue: 'opt2'),
                      PPCheckbox(label: 'Option C', groupValue: 'opt3'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text('Vertical Checkbox Group', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPCheckboxGroup(
                    values: verticalGroup,
                    vertical: true,
                    onChanged: (newValues) => setState(() => verticalGroup = newValues.cast<String>()),
                    children: const [
                      PPCheckbox(label: 'Apple', groupValue: 'apple'),
                      PPCheckbox(label: 'Banana', groupValue: 'banana'),
                      PPCheckbox(label: 'Orange', groupValue: 'orange'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );


