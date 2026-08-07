import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_fabData = ComponentItem(
    name: 'PPFab',
    description: 'A customizable Floating Action Button supporting extended labels, different styles, and a Speed Dial mode with actions.',
    demoCode: '''// Standard
PPFab(
  icon: Icons.add,
  onPressed: () {},
)

// Extended
PPFab(
  icon: Icons.navigation,
  label: 'Navigate',
  extended: true,
  onPressed: () {},
)

// Speed Dial
PPFab(
  icon: Icons.menu,
  color: PPFabColor.secondary,
  actions: [
    PPFabAction(
      icon: Icons.share,
      label: 'Share',
      onPressed: () {},
    ),
    PPFabAction(
      icon: Icons.copy,
      label: 'Copy Link',
      onPressed: () {},
    ),
  ],
)''',
    demoBuilder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Standard', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  PPFab(
                    icon: Icons.add,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(width: 32),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Extended', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  PPFab(
                    icon: Icons.navigation,
                    label: 'Navigate',
                    extended: true,
                    variant: PPFabVariant.soft,
                    color: PPFabColor.primary,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(width: 32),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Speed Dial', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  PPFab(
                    icon: Icons.share,
                    color: PPFabColor.secondary,
                    actions: [
                      PPFabAction(
                        icon: Icons.email,
                        label: 'Email',
                        onPressed: () {},
                      ),
                      PPFabAction(
                        icon: Icons.link,
                        label: 'Copy Link',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );


