import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_selectData = ComponentItem(
    name: 'PPSelect',
    description: 'A customizable select dropdown component supporting different visual variants, icons, and error states.',
    demoCode: '''PPSelect(
  label: 'Choose Country',
  placeholder: 'Select a country',
  options: const [
    PPSelectOption(label: 'Cambodia', value: 'kh'),
    PPSelectOption(label: 'Thailand', value: 'th'),
    PPSelectOption(label: 'Vietnam', value: 'vn'),
  ],
  onChanged: (val) {},
)''',
    demoBuilder: (context) {
      String? val1;
      String? val2;
      String? val3;
      String? val4;
      String? valError;
      return StatefulBuilder(
        builder: (context, setState) {
          final options = const [
            PPSelectOption(label: 'Option 1', value: '1'),
            PPSelectOption(label: 'Option 2', value: '2'),
            PPSelectOption(label: 'Option 3', value: '3'),
          ];
          
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Variants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                PPSelect(
                  label: 'Outlined (Default)',
                  placeholder: 'Select an option',
                  value: val1,
                  options: options,
                  onChanged: (v) => setState(() => val1 = v),
                ),
                const SizedBox(height: 16),
                PPSelect(
                  label: 'Filled',
                  placeholder: 'Select an option',
                  variant: PPSelectVariant.filled,
                  value: val2,
                  options: options,
                  onChanged: (v) => setState(() => val2 = v),
                ),
                const SizedBox(height: 16),
                PPSelect(
                  label: 'Flushed',
                  placeholder: 'Select an option',
                  variant: PPSelectVariant.flushed,
                  value: val3,
                  options: options,
                  onChanged: (v) => setState(() => val3 = v),
                ),
                const SizedBox(height: 16),
                PPSelect(
                  label: 'Soft (Tonal)',
                  placeholder: 'Select an option',
                  variant: PPSelectVariant.soft,
                  value: val4,
                  options: options,
                  onChanged: (v) => setState(() => val4 = v),
                ),
                
                const SizedBox(height: 32),
                const Text('States & Validation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                PPSelect(
                  label: 'Error State',
                  placeholder: 'Invalid selection',
                  error: 'Please select a valid option.',
                  isRequired: true,
                  value: valError,
                  options: options,
                  onChanged: (v) => setState(() => valError = v),
                ),
                const SizedBox(height: 16),
                PPSelect(
                  label: 'Disabled State',
                  placeholder: 'Cannot select',
                  disabled: true,
                  options: options,
                  onChanged: (v) {},
                ),
              ],
            ),
          );
        },
      );
    },
  );


