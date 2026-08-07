import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_khmer_calendar_dialogData = ComponentItem(
  name: 'PPKhmerCalendarDialog',
  description: 'A Khmer calendar component presented as a dialog.',
  demoBuilder: (context) => const PPKhmerCalendarDialogDemo(),
  demoCode: '''
showPPKhmerCalendarDialog(
  context: context,
  selectionMode: PPKhmerCalendarSelectionMode.single,
).then((date) {
  if (date != null) print(date);
});
''',
);

class PPKhmerCalendarDialogDemo extends StatefulWidget {
  const PPKhmerCalendarDialogDemo({super.key});

  @override
  State<PPKhmerCalendarDialogDemo> createState() => _PPKhmerCalendarDialogDemoState();
}

class _PPKhmerCalendarDialogDemoState extends State<PPKhmerCalendarDialogDemo> {
  DateTime? _selectedDate;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Khmer Calendar Dialog', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final date = await showPPKhmerCalendarDialog(
                context: context,
                selectionMode: PPKhmerCalendarSelectionMode.single,
              );
              if (date != null) {
                setState(() => _selectedDate = date as DateTime);
              }
            },
            child: const Text('Show Khmer Dialog Calendar'),
          ),
          const SizedBox(height: 16),
          if (_selectedDate != null)
            Text('Selected: \${_selectedDate.toString().split(' ')[0]}'),
        ],
      ),
    );
  }
}
