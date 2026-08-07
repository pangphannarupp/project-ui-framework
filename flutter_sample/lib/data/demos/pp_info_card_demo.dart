import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_info_cardData = ComponentItem(
    name: 'PPInfoCard',
    description: 'A stylized card used for displaying informational messages, alerts, and feedback states with customizable variants and icons.',
    demoCode: '''PPInfoCard(
  type: PPInfoCardType.info,
  variant: PPInfoCardVariant.soft,
  child: Text('This is an informational message. It highlights important context for the user.'),
)''',
    demoBuilder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Variants', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const PPInfoCard(
              type: PPInfoCardType.info,
              variant: PPInfoCardVariant.soft,
              child: Text('Soft Variant (Default): Ideal for subtle inline messages and general information.'),
            ),
            const SizedBox(height: 16),
            const PPInfoCard(
              type: PPInfoCardType.info,
              variant: PPInfoCardVariant.solid,
              child: Text('Solid Variant: Draws immediate attention, best used sparingly.'),
            ),
            const SizedBox(height: 16),
            const PPInfoCard(
              type: PPInfoCardType.info,
              variant: PPInfoCardVariant.outline,
              child: Text('Outline Variant: Good for clear, distinct boundaries without heavy background colors.'),
            ),
            const SizedBox(height: 32),
            const Text('Semantic Types', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const PPInfoCard(
              type: PPInfoCardType.success,
              child: Text('Success: Your action was completed successfully!'),
            ),
            const SizedBox(height: 16),
            const PPInfoCard(
              type: PPInfoCardType.warning,
              child: Text('Warning: Please review your settings before proceeding.'),
            ),
            const SizedBox(height: 16),
            const PPInfoCard(
              type: PPInfoCardType.error,
              child: Text('Error: Something went wrong while saving your data.'),
            ),
            const SizedBox(height: 16),
            const PPInfoCard(
              type: PPInfoCardType.neutral,
              child: Text('Neutral: Additional information about the current page.'),
            ),
          ],
        ),
      );
    },
  );


