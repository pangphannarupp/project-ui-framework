import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_ratingData = ComponentItem(
    name: 'PPRating',
    description: 'An interactive star rating component with hover effects and readonly support.',
    demoCode: '''
PPRating(
  value: ratingValue,
  max: 5,
  onChanged: (val) => setState(() => ratingValue = val),
)
''',
    demoBuilder: (context) {
      int ratingValue = 3;

      return StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Interactive Rating', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPRating(
                    value: ratingValue,
                    onChanged: (val) => setState(() => ratingValue = val),
                  ),
                  const SizedBox(height: 8),
                  Text('Selected: \$ratingValue / 5', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 32),
                  const Text('Read-Only Rating', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  const PPRating(
                    value: 4,
                    readonly: true,
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );


