import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_autocompleteData = ComponentItem(
    name: 'PPAutocomplete',
    description: 'An autocomplete input field that filters a list of options as you type.',
    demoCode: '''
PPAutocomplete<String>(
  label: 'Select a Country',
  placeholder: 'Type to search...',
  options: const ['Cambodia', 'Thailand', 'Vietnam', 'Singapore', 'Malaysia', 'Indonesia', 'Philippines'],
  value: selectedCountry,
  onChanged: (val) => setState(() => selectedCountry = val),
)
''',
    demoBuilder: (context) {
      String? selectedCountry;
      return StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PPAutocomplete<String>(
                    label: 'Select a Country',
                    placeholder: 'Type to search...',
                    iconLeft: const Icon(Icons.public),
                    options: const [
                      'Cambodia',
                      'Thailand',
                      'Vietnam',
                      'Singapore',
                      'Malaysia',
                      'Indonesia',
                      'Philippines',
                      'Japan',
                      'South Korea',
                      'China'
                    ],
                    value: selectedCountry,
                    onChanged: (val) {
                      setState(() {
                        selectedCountry = val;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Selected: \${selectedCountry ?? "None"}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );


