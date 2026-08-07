import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_inputData = ComponentItem(
    name: 'PPInput',
    description: 'A versatile text input field that supports various states, variants, and decorators.',
    demoCode: '''
PPInput(
  label: 'Username',
  placeholder: 'Enter your username',
  variant: PPInputVariant.outline,
  clearable: true,
  onChanged: (val) => print(val),
)

// Password Input
PPInput(
  label: 'Password',
  placeholder: 'Enter password',
  isPassword: true,
)

// Number with format
PPInput(
  label: 'Phone Number',
  placeholder: 'xxx-xxx-xxxx',
  format: '###-###-####',
  numberOnly: true,
)
''',
    demoBuilder: (context) {
      String basicValue = '';
      String passwordValue = '';
      String phoneValue = '';

      return StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PPInput(
                    label: 'Basic Outline Input',
                    placeholder: 'Type something...',
                    value: basicValue,
                    clearable: true,
                    onChanged: (val) => setState(() => basicValue = val),
                    iconLeft: const Icon(Icons.person_outline),
                  ),
                  const SizedBox(height: 24),
                  PPInput(
                    label: 'Password Input (Filled)',
                    placeholder: 'Enter password',
                    value: passwordValue,
                    isPassword: true,
                    variant: PPInputVariant.filled,
                    onChanged: (val) => setState(() => passwordValue = val),
                    iconLeft: const Icon(Icons.lock_outline),
                  ),
                  const SizedBox(height: 24),
                  PPInput(
                    label: 'Formatted Number (Underlined)',
                    placeholder: 'Phone: ###-###-####',
                    value: phoneValue,
                    format: '###-###-####',
                    numberOnly: true,
                    variant: PPInputVariant.underlined,
                    onChanged: (val) => setState(() => phoneValue = val),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );


