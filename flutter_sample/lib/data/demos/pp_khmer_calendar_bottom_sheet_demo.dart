import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_khmer_calendar_bottom_sheetData = ComponentItem(
  name: 'PPKhmerCalendarBottomSheet',
  description: 'A Khmer calendar component presented as a bottom sheet.',
  demoBuilder: (context) => const PPKhmerCalendarBottomSheetDemo(),
  demoCode: '''
showPPKhmerCalendarBottomSheet(
  context: context,
  selectionMode: PPKhmerCalendarSelectionMode.single,
).then((date) {
  if (date != null) print(date);
});
''',
);

class PPKhmerCalendarBottomSheetDemo extends StatefulWidget {
  const PPKhmerCalendarBottomSheetDemo({super.key});

  @override
  State<PPKhmerCalendarBottomSheetDemo> createState() => _PPKhmerCalendarBottomSheetDemoState();
}

class _PPKhmerCalendarBottomSheetDemoState extends State<PPKhmerCalendarBottomSheetDemo> {
  DateTime? _selectedDate;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Khmer Calendar Bottom Sheet', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final date = await showPPKhmerCalendarBottomSheet(
                context: context,
                selectionMode: PPKhmerCalendarSelectionMode.single,
              );
              if (date != null) {
                setState(() => _selectedDate = date as DateTime);
              }
            },
            child: const Text('Show Khmer Bottom Sheet Calendar'),
          ),
          const SizedBox(height: 16),
          if (_selectedDate != null)
            Text('Selected: \${_selectedDate.toString().split(' ')[0]}'),
        ],
      ),
    );
  }
}
