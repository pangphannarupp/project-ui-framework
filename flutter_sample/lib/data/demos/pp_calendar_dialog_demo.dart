import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_calendar_dialogData = ComponentItem(
  name: 'PPCalendarDialog',
  description: 'A calendar component presented as a dialog.',
  demoBuilder: (context) => const PPCalendarDialogDemo(),
  demoCode: '''
showPPCalendarDialog(
  context: context,
  selectionMode: PPCalendarSelectionMode.single,
).then((date) {
  if (date != null) print(date);
});
''',
);

class PPCalendarDialogDemo extends StatefulWidget {
  const PPCalendarDialogDemo({super.key});

  @override
  State<PPCalendarDialogDemo> createState() => _PPCalendarDialogDemoState();
}

class _PPCalendarDialogDemoState extends State<PPCalendarDialogDemo> {
  DateTime? _selectedDate;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Calendar Dialog', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final date = await showPPCalendarDialog(
                context: context,
                selectionMode: PPCalendarSelectionMode.single,
              );
              if (date != null) {
                setState(() => _selectedDate = date as DateTime);
              }
            },
            child: const Text('Show Dialog Calendar'),
          ),
          const SizedBox(height: 16),
          if (_selectedDate != null)
            Text('Selected: \${_selectedDate.toString().split(' ')[0]}'),
        ],
      ),
    );
  }
}
