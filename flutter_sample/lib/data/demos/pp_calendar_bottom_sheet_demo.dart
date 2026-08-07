import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_calendar_bottom_sheetData = ComponentItem(
  name: 'PPCalendarBottomSheet',
  description: 'A calendar component presented as a bottom sheet.',
  demoBuilder: (context) => const PPCalendarBottomSheetDemo(),
  demoCode: '''
showPPCalendarBottomSheet(
  context: context,
  selectionMode: PPCalendarSelectionMode.single,
).then((date) {
  if (date != null) print(date);
});
''',
);

class PPCalendarBottomSheetDemo extends StatefulWidget {
  const PPCalendarBottomSheetDemo({super.key});

  @override
  State<PPCalendarBottomSheetDemo> createState() => _PPCalendarBottomSheetDemoState();
}

class _PPCalendarBottomSheetDemoState extends State<PPCalendarBottomSheetDemo> {
  DateTime? _selectedDate;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Calendar Bottom Sheet', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final date = await showPPCalendarBottomSheet(
                context: context,
                selectionMode: PPCalendarSelectionMode.single,
              );
              if (date != null) {
                setState(() => _selectedDate = date as DateTime);
              }
            },
            child: const Text('Show Bottom Sheet Calendar'),
          ),
          const SizedBox(height: 16),
          if (_selectedDate != null)
            Text('Selected: \${_selectedDate.toString().split(' ')[0]}'),
        ],
      ),
    );
  }
}
