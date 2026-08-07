import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class PPCalendarPickerDemo extends StatelessWidget {
  const PPCalendarPickerDemo({super.key});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Dialog Picker (Single Date)', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          PPCalendarPicker(
            label: 'Birth Date',
            pickerType: PPCalendarPickerType.dialog,
            selectionMode: PPCalendarSelectionMode.single,
          ),
          const SizedBox(height: 24),
          const Text('Bottom Sheet Picker (Date Range)', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          PPCalendarPicker(
            label: 'Vacation Period',
            pickerType: PPCalendarPickerType.bottomSheet,
            selectionMode: PPCalendarSelectionMode.range,
          ),
        ],
      ),
    );
  }
}

final ComponentItem pp_calendar_pickerData = ComponentItem(
  name: 'PPCalendarPicker',
  description: 'A form field component for selecting dates using a dialog or bottom sheet calendar.',
  demoBuilder: (context) => const PPCalendarPickerDemo(),
  demoCode: '''
PPCalendarPicker(
  label: 'Birth Date',
  pickerType: PPCalendarPickerType.dialog,
  selectionMode: PPCalendarSelectionMode.single,
)
''',
);
