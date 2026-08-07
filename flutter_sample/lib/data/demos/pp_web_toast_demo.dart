import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPWebToastDemo extends StatelessWidget {
  const _PPWebToastDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Toast Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {
                PPWebToast.show(
                  context,
                  title: 'Success!',
                  message: 'Your profile has been updated successfully.',
                  type: PPWebToastType.success,
                );
              },
              child: const Text('Success Toast'),
            ),
            ElevatedButton(
              onPressed: () {
                PPWebToast.show(
                  context,
                  title: 'Error',
                  message: 'Failed to connect to the server. Please try again.',
                  type: PPWebToastType.error,
                );
              },
              child: const Text('Error Toast'),
            ),
            ElevatedButton(
              onPressed: () {
                PPWebToast.show(
                  context,
                  title: 'Warning',
                  message: 'Your subscription will expire in 3 days.',
                  type: PPWebToastType.warning,
                );
              },
              child: const Text('Warning Toast'),
            ),
            ElevatedButton(
              onPressed: () {
                PPWebToast.show(
                  context,
                  title: 'Information',
                  message: 'A new software update is available for download.',
                  type: PPWebToastType.info,
                );
              },
              child: const Text('Info Toast'),
            ),
          ],
        ),

        const Divider(height: 48),

        const Text('Toast Positions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            OutlinedButton(
              onPressed: () {
                PPWebToast.show(
                  context,
                  message: 'This toast appears at the Top Right!',
                  position: PPWebToastPosition.topRight,
                );
              },
              child: const Text('Top Right'),
            ),
            OutlinedButton(
              onPressed: () {
                PPWebToast.show(
                  context,
                  message: 'This toast appears at the Top Center!',
                  position: PPWebToastPosition.topCenter,
                );
              },
              child: const Text('Top Center'),
            ),
            OutlinedButton(
              onPressed: () {
                PPWebToast.show(
                  context,
                  message: 'This toast appears at the Top Left!',
                  position: PPWebToastPosition.topLeft,
                );
              },
              child: const Text('Top Left'),
            ),
            OutlinedButton(
              onPressed: () {
                PPWebToast.show(
                  context,
                  message: 'This toast appears at the Bottom Right!',
                  position: PPWebToastPosition.bottomRight,
                );
              },
              child: const Text('Bottom Right'),
            ),
            OutlinedButton(
              onPressed: () {
                PPWebToast.show(
                  context,
                  message: 'This toast appears at the Bottom Center!',
                  position: PPWebToastPosition.bottomCenter,
                );
              },
              child: const Text('Bottom Center'),
            ),
            OutlinedButton(
              onPressed: () {
                PPWebToast.show(
                  context,
                  message: 'This toast appears at the Bottom Left!',
                  position: PPWebToastPosition.bottomLeft,
                );
              },
              child: const Text('Bottom Left'),
            ),
          ],
        ),
      ],
    );
  }
}

final ComponentItem pp_web_toastData = ComponentItem(
  name: 'PPWebToast',
  description: 'A global floating toast notification system inspired by web design.',
  demoCode: '''PPWebToast.show(
  context,
  title: 'Success!',
  message: 'Your profile has been updated.',
  type: PPWebToastType.success,
  position: PPWebToastPosition.topRight,
  duration: const Duration(seconds: 3),
);''',
  demoBuilder: (context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: _PPWebToastDemo(),
    );
  },
);
