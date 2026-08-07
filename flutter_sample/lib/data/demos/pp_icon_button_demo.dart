import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_icon_buttonData = ComponentItem(
    name: 'PPIconButton',
    description: 'A simple icon button component.',
    demoCode: '''Wrap(
  spacing: 16,
  children: [
    PPIconButton(
      icon: Icons.favorite,
      backgroundColor: Colors.red.withOpacity(0.1),
      color: Colors.red,
      onPressed: () {},
    ),
    PPIconButton(
      icon: Icons.share,
      backgroundColor: Colors.blue.withOpacity(0.1),
      color: Colors.blue,
      onPressed: () {},
    ),
  ],
)''',
    demoBuilder: (context) => Wrap(
      spacing: 16,
      children: [
        PPIconButton(
          icon: Icons.favorite,
          backgroundColor: Colors.red.withOpacity(0.1),
          color: Colors.red,
          onPressed: () {},
        ),
        PPIconButton(
          icon: Icons.share,
          backgroundColor: Colors.blue.withOpacity(0.1),
          color: Colors.blue,
          onPressed: () {},
        ),
      ],
    ),
  );


