import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_number_spinnerData = ComponentItem(
    name: 'PPNumberSpinner',
    description: 'A numeric input component with increment and decrement buttons, supporting min, max, and custom step values.',
    demoCode: '''
PPNumberSpinner(
  value: quantity,
  min: 1,
  max: 10,
  step: 1,
  onChanged: (val) => setState(() => quantity = val),
)
''',
    demoBuilder: (context) {
      double quantity = 1.0;
      double decimalValue = 0.5;

      return StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Standard Spinner (1 to 10)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPNumberSpinner(
                    value: quantity,
                    min: 1,
                    max: 10,
                    step: 1,
                    onChanged: (val) => setState(() => quantity = val),
                  ),
                  const SizedBox(height: 32),
                  const Text('Decimal Steps (0.5)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPNumberSpinner(
                    value: decimalValue,
                    min: 0,
                    max: 5,
                    step: 0.5,
                    onChanged: (val) => setState(() => decimalValue = val),
                  ),
                  const SizedBox(height: 32),
                  const Text('Disabled Spinner', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  const PPNumberSpinner(
                    value: 5,
                    disabled: true,
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );


