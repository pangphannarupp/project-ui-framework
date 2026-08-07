import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_bottom_sheetData = ComponentItem(
  name: 'PPBottomSheet',
  description: 'A versatile bottom sheet container.',
  demoBuilder: (context) => const PPBottomSheetDemo(),
  demoCode: '''
PPBottomSheet.show(
  context: context,
  title: const Text('Settings'),
  content: Column(
    children: [
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Profile'),
      ),
    ],
  ),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Close'),
    ),
  ],
);
''',
);

class PPBottomSheetDemo extends StatelessWidget {
  const PPBottomSheetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Bottom Sheet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              PPBottomSheet.show(
                context: context,
                title: const Text('Settings'),
                content: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profile'),
                      onTap: () => Navigator.pop(context),
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock),
                      title: const Text('Privacy'),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              );
            },
            child: const Text('Show Bottom Sheet'),
          ),
        ],
      ),
    );
  }
}
