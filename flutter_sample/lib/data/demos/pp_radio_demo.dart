import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_radioData = ComponentItem(
    name: 'PPRadio',
    description: 'A customizable radio button component that supports both independent use and grouped states.',
    demoCode: '''
// Independent Radio
PPRadio(
  label: 'Option A',
  value: 'optA',
  selectedValue: currentSelected,
  onChanged: (val) => setState(() => currentSelected = val),
)

// Radio Group
PPRadioGroup(
  value: selectedValue, // String
  onChanged: (newValue) => setState(() => selectedValue = newValue),
  vertical: false, // Set to true for column layout
  children: const [
    PPRadio(label: 'Option 1', value: 'opt1'),
    PPRadio(label: 'Option 2', value: 'opt2'),
    PPRadio(label: 'Option 3', value: 'opt3'),
  ],
)
''',
    demoBuilder: (context) {
      String? singleSelected = 'optA';
      String horizontalGroup = 'opt2';
      String verticalGroup = 'apple';

      return StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Independent Radios', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      PPRadio(
                        label: 'Option A',
                        value: 'optA',
                        selectedValue: singleSelected,
                        onChanged: (val) => setState(() => singleSelected = val),
                      ),
                      const SizedBox(width: 16),
                      PPRadio(
                        label: 'Option B',
                        value: 'optB',
                        selectedValue: singleSelected,
                        onChanged: (val) => setState(() => singleSelected = val),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text('Horizontal Radio Group', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPRadioGroup(
                    value: horizontalGroup,
                    onChanged: (newValue) => setState(() => horizontalGroup = newValue),
                    children: const [
                      PPRadio(label: 'Option 1', value: 'opt1'),
                      PPRadio(label: 'Option 2', value: 'opt2'),
                      PPRadio(label: 'Option 3', value: 'opt3'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text('Vertical Radio Group', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPRadioGroup(
                    value: verticalGroup,
                    vertical: true,
                    onChanged: (newValue) => setState(() => verticalGroup = newValue),
                    children: const [
                      PPRadio(label: 'Apple', value: 'apple'),
                      PPRadio(label: 'Banana', value: 'banana'),
                      PPRadio(label: 'Orange', value: 'orange'),
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


