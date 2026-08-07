import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_toggle_buttonData = ComponentItem(
    name: 'PPToggleButton',
    description: 'A button that toggles its active state.',
    demoCode: '''StatefulBuilder(
  builder: (context, setState) {
    bool isToggled = false;
    return PPToggleButton(
      isToggled: isToggled,
      onChanged: (val) => setState(() => isToggled = val),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bookmark),
          SizedBox(width: 8),
          Text('Save'),
        ],
      ),
    );
  },
)''',
    demoBuilder: (context) {
      bool isToggled = false;
      return StatefulBuilder(
        builder: (context, setState) {
          return PPToggleButton(
            isToggled: isToggled,
            onChanged: (val) => setState(() => isToggled = val),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bookmark),
                SizedBox(width: 8),
                Text('Save'),
              ],
            ),
          );
        },
      );
    },
  );


