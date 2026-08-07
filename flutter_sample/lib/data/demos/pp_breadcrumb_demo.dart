import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_breadcrumbData = ComponentItem(
  name: 'PPBreadcrumb',
  description: 'A navigation trail for multi-level pages.',
  demoCode: '''PPBreadcrumb(
  items: [
    PPBreadcrumbItem(label: 'Home', icon: const Icon(Icons.home)),
    PPBreadcrumbItem(label: 'Library'),
    PPBreadcrumbItem(label: 'Data'),
  ],
)''',
  demoBuilder: (context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('With Icons (Default)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          PPBreadcrumb(
            separatorIcon: const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
            items: [
              PPBreadcrumbItem(label: 'Library', icon: const Icon(Icons.folder_outlined), onTap: () {}),
              PPBreadcrumbItem(label: 'Images', icon: const Icon(Icons.image_outlined), onTap: () {}),
              PPBreadcrumbItem(label: 'Vacation 2026', icon: const Icon(Icons.photo_library_outlined)),
            ],
          ),
          
          const Divider(height: 48),
          
          const Text('Text Only (Standard Slash)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          PPBreadcrumb(
            items: [
              PPBreadcrumbItem(label: 'Home', onTap: () {}),
              PPBreadcrumbItem(label: 'Components', onTap: () {}),
              PPBreadcrumbItem(label: 'Breadcrumb'),
            ],
          ),

          const Divider(height: 48),
          
          const Text('Custom String Separator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          PPBreadcrumb(
            separator: '>',
            items: [
              PPBreadcrumbItem(label: 'Settings', onTap: () {}),
              PPBreadcrumbItem(label: 'Account', onTap: () {}),
              PPBreadcrumbItem(label: 'Security'),
            ],
          ),
        ],
      ),
    );
  },
);
