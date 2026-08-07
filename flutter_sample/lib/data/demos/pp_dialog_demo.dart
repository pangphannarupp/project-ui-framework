import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_dialogData = ComponentItem(
  name: 'PPDialog',
  description: 'A styled alert dialog component.',
  demoBuilder: (context) => const PPDialogDemo(),
  demoCode: '''
PPDialog.show(
  context: context,
  title: const Text('Confirm Action'),
  content: const Text('Are you sure you want to proceed?'),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Cancel'),
    ),
    ElevatedButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Proceed'),
    ),
  ],
);
''',
);

class PPDialogDemo extends StatelessWidget {
  const PPDialogDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Dialog',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              PPDialog.show(
                context: context,
                title: const Text('Confirm Action'),
                content: const Text('Are you sure you want to proceed?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Proceed'),
                  ),
                ],
              );
            },
            child: const Text('Show Dialog'),
          ),
        ],
      ),
    );
  }
}
