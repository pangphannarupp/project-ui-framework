import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_transfer_listData = ComponentItem(
    name: 'PPTransferList',
    description: 'A component for moving items between two lists. Supports horizontal and vertical orientations, along with multiple styles.',
    demoCode: '''PPTransferList(
  value: selectedKeys,
  data: const [
    PPTransferOption(key: '1', label: 'Item 1'),
    PPTransferOption(key: '2', label: 'Item 2'),
  ],
  onChanged: (newValues) {
    setState(() => selectedKeys = newValues);
  },
)''',
    demoBuilder: (context) {
      List<String> horizontalKeys = ['2', '4'];
      List<String> verticalKeys = [];
      List<String> softKeys = ['1'];
      return StatefulBuilder(
        builder: (context, setState) {
          final options = List.generate(8, (i) => PPTransferOption(
            key: '${i + 1}',
            label: 'Option ${i + 1}',
            disabled: i == 4,
          ));
          
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Horizontal (Default)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                PPTransferList(
                  value: horizontalKeys,
                  data: options,
                  onChanged: (val) => setState(() => horizontalKeys = val),
                ),
                
                const SizedBox(height: 32),
                const Text('Soft Variant', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                PPTransferList(
                  value: softKeys,
                  data: options,
                  variant: PPTransferVariant.soft,
                  onChanged: (val) => setState(() => softKeys = val),
                ),

                const SizedBox(height: 32),
                const Text('Vertical Orientation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                PPTransferList(
                  value: verticalKeys,
                  data: options,
                  direction: PPTransferDirection.vertical,
                  variant: PPTransferVariant.filled,
                  titles: const ['Available', 'Selected'],
                  onChanged: (val) => setState(() => verticalKeys = val),
                ),
              ],
            ),
          );
        },
      );
    },
  );


