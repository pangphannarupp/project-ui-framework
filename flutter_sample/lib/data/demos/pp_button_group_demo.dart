import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_button_groupData = ComponentItem(
    name: 'PPButtonGroup',
    description: 'A segmented group of buttons.',
    demoCode: '''StatefulBuilder(
  builder: (context, setState) {
    int selectedHorizontal = 0;
    int selectedVertical = 0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PPButtonGroup(
          labels: const ['Day', 'Week', 'Month'],
          selectedIndex: selectedHorizontal,
          activeColor: Colors.blue,
          onSelected: (idx) => setState(() => selectedHorizontal = idx),
        ),
        const SizedBox(width: 32),
        PPButtonGroup(
          labels: const ['Top', 'Middle', 'Bottom'],
          selectedIndex: selectedVertical,
          direction: Axis.vertical,
          activeColor: Colors.teal,
          onSelected: (idx) => setState(() => selectedVertical = idx),
        ),
      ],
    );
  },
)''',
    demoBuilder: (context) {
      int selectedHorizontal = 0;
      int selectedVertical = 0;
      return StatefulBuilder(
        builder: (context, setState) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PPButtonGroup(
                labels: const ['Day', 'Week', 'Month'],
                selectedIndex: selectedHorizontal,
                activeColor: Colors.blue,
                onSelected: (idx) => setState(() => selectedHorizontal = idx),
              ),
              const SizedBox(width: 32),
              PPButtonGroup(
                labels: const ['Top', 'Middle', 'Bottom'],
                selectedIndex: selectedVertical,
                direction: Axis.vertical,
                activeColor: Colors.teal,
                onSelected: (idx) => setState(() => selectedVertical = idx),
              ),
            ],
          );
        },
      );
    },
  );


