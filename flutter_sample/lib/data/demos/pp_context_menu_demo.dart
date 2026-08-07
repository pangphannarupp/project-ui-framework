import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_context_menuData = ComponentItem(
    name: 'PPContextMenu',
    description: 'A context menu that can be triggered by click or right-click.',
    demoCode: '''PPContextMenu(
  triggerMode: PPContextMenuTriggerMode.click,
  items: [
    PPContextMenuItem(label: 'Copy', icon: Icon(Icons.copy)),
    PPContextMenuItem(label: 'Paste', disabled: true),
    PPContextMenuItem(divider: true),
    PPContextMenuItem(label: 'Delete', icon: Icon(Icons.delete, color: Colors.red)),
  ],
  child: PPButton(label: 'Click me', onPressed: () {}),
)''',
    demoBuilder: (context) {
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Click Trigger', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            PPContextMenu(
              triggerMode: PPContextMenuTriggerMode.click,
              items: [
                PPContextMenuItem(label: 'New Tab', icon: const Icon(Icons.tab), action: () {}),
                PPContextMenuItem(label: 'New Window', icon: const Icon(Icons.open_in_new), action: () {}),
                const PPContextMenuItem(divider: true),
                const PPContextMenuItem(label: 'Favorites', icon: Icon(Icons.favorite), children: [
                  PPContextMenuItem(label: 'GitHub', icon: Icon(Icons.code)),
                  PPContextMenuItem(label: 'Flutter', icon: Icon(Icons.flutter_dash)),
                ]),
                const PPContextMenuItem(divider: true),
                const PPContextMenuItem(label: 'Disabled option', disabled: true),
              ],
              child: PPButton(
                label: 'Click to open Menu',
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 32),
            const Text('Right-Click Trigger (Context Menu)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            PPContextMenu(
              triggerMode: PPContextMenuTriggerMode.contextmenu,
              items: [
                PPContextMenuItem(label: 'Copy', icon: const Icon(Icons.copy), action: () {}),
                PPContextMenuItem(label: 'Paste', icon: const Icon(Icons.paste), action: () {}),
                const PPContextMenuItem(divider: true),
                PPContextMenuItem(label: 'Delete', icon: const Icon(Icons.delete, color: Colors.red), action: () {}),
              ],
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text('Right click here'),
              ),
            ),
          ],
        ),
      );
    },
  );


