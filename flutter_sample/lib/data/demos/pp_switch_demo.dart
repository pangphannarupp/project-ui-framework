import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_switchData = ComponentItem(
    name: 'PPSwitch',
    description: 'A customizable switch toggle component supporting different visual variants like standard, Material 3, and icon-based.',
    demoCode: '''
// Standard Switch
PPSwitch(
  label: 'Enable notifications',
  value: isStandardOn,
  onChanged: (val) => setState(() => isStandardOn = val),
)

// Material 3 Switch
PPSwitch(
  label: 'Dark mode',
  variant: PPSwitchVariant.m3,
  value: isM3On,
  onChanged: (val) => setState(() => isM3On = val),
)

// Icon Switch
PPSwitch(
  label: 'Sync data',
  variant: PPSwitchVariant.icon,
  value: isIconOn,
  onChanged: (val) => setState(() => isIconOn = val),
)
''',
    demoBuilder: (context) {
      bool isStandardOn = true;
      bool isM3On = false;
      bool isIconOn = true;

      return StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Standard Switch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPSwitch(
                    label: 'Enable notifications',
                    value: isStandardOn,
                    onChanged: (val) => setState(() => isStandardOn = val),
                  ),
                  const SizedBox(height: 12),
                  const PPSwitch(
                    label: 'Disabled Standard',
                    value: false,
                    disabled: true,
                  ),
                  const SizedBox(height: 32),
                  const Text('Material 3 Switch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPSwitch(
                    label: 'Dark mode',
                    variant: PPSwitchVariant.m3,
                    value: isM3On,
                    onChanged: (val) => setState(() => isM3On = val),
                  ),
                  const SizedBox(height: 12),
                  const PPSwitch(
                    label: 'Disabled M3',
                    variant: PPSwitchVariant.m3,
                    value: true,
                    disabled: true,
                  ),
                  const SizedBox(height: 32),
                  const Text('Icon Switch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPSwitch(
                    label: 'Sync data',
                    variant: PPSwitchVariant.icon,
                    value: isIconOn,
                    onChanged: (val) => setState(() => isIconOn = val),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );


