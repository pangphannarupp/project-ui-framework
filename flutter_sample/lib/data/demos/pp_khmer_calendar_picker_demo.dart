import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class PPKhmerCalendarPickerDemo extends StatelessWidget {
  const PPKhmerCalendarPickerDemo({super.key});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Dialog Picker (Single Date)', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          PPKhmerCalendarPicker(
            label: 'ជ្រើសរើសកាលបរិច្ឆេទ',
            pickerType: PPKhmerCalendarPickerType.dialog,
            selectionMode: PPKhmerCalendarSelectionMode.single,
          ),
          const SizedBox(height: 24),
          const Text('Bottom Sheet Picker (Date Range)', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          PPKhmerCalendarPicker(
            label: 'ជ្រើសរើសចន្លោះពេល',
            pickerType: PPKhmerCalendarPickerType.bottomSheet,
            selectionMode: PPKhmerCalendarSelectionMode.range,
          ),
        ],
      ),
    );
  }
}

final ComponentItem pp_khmer_calendar_pickerData = ComponentItem(
  name: 'PPKhmerCalendarPicker',
  description: 'A form field component for selecting dates using a dialog or bottom sheet Khmer calendar.',
  demoBuilder: (context) => const PPKhmerCalendarPickerDemo(),
  demoCode: '''
PPKhmerCalendarPicker(
  label: 'ជ្រើសរើសកាលបរិច្ឆេទ',
  pickerType: PPKhmerCalendarPickerType.dialog,
  selectionMode: PPKhmerCalendarSelectionMode.single,
)
''',
);
