import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_phone_inputData = ComponentItem(
    name: 'PPPhoneInput',
    description: 'A specialized input field for phone numbers with country code selection and formatting.',
    demoCode: '''
PPPhoneInput(
  label: 'Phone Number',
  countryCode: '+855',
  format: '## ### ####',
  value: phone,
  onChanged: (val) => print(val),
  onSelectCountry: () {
    // Show country picker modal
  },
)
''',
    demoBuilder: (context) {
      String phoneValue = '';
      String countryCode = '+855';

      return StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PPPhoneInput(
                    label: 'Cambodia Phone Number',
                    placeholder: '## ### ####',
                    value: phoneValue,
                    countryCode: countryCode,
                    format: '## ### ####',
                    onChanged: (val) => setState(() => phoneValue = val),
                    onSelectCountry: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Country selector clicked!')),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  PPPhoneInput(
                    label: 'Filled Variant',
                    placeholder: '## ### ####',
                    value: phoneValue,
                    countryCode: countryCode,
                    format: '## ### ####',
                    variant: PPInputVariant.filled,
                    onChanged: (val) => setState(() => phoneValue = val),
                  ),
                  const SizedBox(height: 24),
                  PPPhoneInput(
                    label: 'Underlined Variant',
                    placeholder: '## ### ####',
                    value: phoneValue,
                    countryCode: countryCode,
                    format: '## ### ####',
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


