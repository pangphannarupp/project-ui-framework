import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_buttonData = ComponentItem(
    name: 'PPButton',
    description: 'Implemented component',
    demoCode: '''Wrap(
  spacing: 12,
  runSpacing: 12,
  children: [
    PPButton(label: 'Primary', variant: PPButtonVariant.primary, onPressed: () {}),
    PPButton(label: 'Secondary', variant: PPButtonVariant.secondary, onPressed: () {}),
    PPButton(label: 'Success', variant: PPButtonVariant.success, onPressed: () {}),
    PPButton(label: 'Danger', variant: PPButtonVariant.danger, onPressed: () {}),
    PPButton(label: 'Outline', variant: PPButtonVariant.outline, onPressed: () {}),
    PPButton(label: 'Outline Danger', variant: PPButtonVariant.outlineDanger, onPressed: () {}),
    PPButton(label: 'Ghost', variant: PPButtonVariant.ghost, onPressed: () {}),
    PPButton(label: 'Gradient', variant: PPButtonVariant.gradient, onPressed: () {}),
    PPButton(label: 'Elevated', variant: PPButtonVariant.elevated, onPressed: () {}),
    PPButton(label: 'Soft', variant: PPButtonVariant.soft, onPressed: () {}),
    PPButton(label: 'Rounded', isRounded: true, onPressed: () {}),
    PPButton(label: 'With Icon', prefixIcon: Icons.add, onPressed: () {}),
    PPButton(label: 'Loading', isLoading: true, onPressed: () {}),
  ],
)''',
    demoBuilder: (context) => Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        PPButton(label: 'Primary', variant: PPButtonVariant.primary, onPressed: () {}),
        PPButton(label: 'Secondary', variant: PPButtonVariant.secondary, onPressed: () {}),
        PPButton(label: 'Success', variant: PPButtonVariant.success, onPressed: () {}),
        PPButton(label: 'Danger', variant: PPButtonVariant.danger, onPressed: () {}),
        PPButton(label: 'Outline', variant: PPButtonVariant.outline, onPressed: () {}),
        PPButton(label: 'Outline Danger', variant: PPButtonVariant.outlineDanger, onPressed: () {}),
        PPButton(label: 'Ghost', variant: PPButtonVariant.ghost, onPressed: () {}),
        PPButton(label: 'Gradient', variant: PPButtonVariant.gradient, onPressed: () {}),
        PPButton(label: 'Elevated', variant: PPButtonVariant.elevated, onPressed: () {}),
        PPButton(label: 'Soft', variant: PPButtonVariant.soft, onPressed: () {}),
        PPButton(label: 'Rounded', isRounded: true, onPressed: () {}),
        PPButton(label: 'With Icon', prefixIcon: Icons.add, onPressed: () {}),
        PPButton(label: 'Loading', isLoading: true, onPressed: () {}),
      ],
    ),
  );


