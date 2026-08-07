import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_bottom_navData = ComponentItem(
    name: 'PPBottomNav',
    description: 'Implemented component',
    demoCode: '''Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    PPBottomNav(variant: 'material', value: '0', ...),
    PPBottomNav(variant: 'classic', value: '0', ...),
    PPBottomNav(variant: 'floating', value: '0', ...),
    PPBottomNav(variant: 'shift', value: '0', ...),
    PPBottomNav(variant: 'bubble', value: '0', ...),
  ],
)''',
    demoBuilder: (context) {
      final items = const [
        PPBottomNavItem(label: 'Home', value: '0', icon: Icons.home),
        PPBottomNavItem(label: 'Search', value: '1', icon: Icons.search),
        PPBottomNavItem(label: 'Settings', value: '2', icon: Icons.settings),
      ];
      final cutoutItems = const [
        PPBottomNavItem(label: 'Home', value: '0', icon: Icons.home),
        PPBottomNavItem(label: 'Add', value: '1', icon: Icons.add, isAction: true),
        PPBottomNavItem(label: 'Settings', value: '2', icon: Icons.settings),
      ];
      String selectedValue = '0';
      return StatefulBuilder(
        builder: (context, setState) {
          void handleChange(String val) {
            setState(() => selectedValue = val);
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Material Variant'),
                PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'material'),
                const SizedBox(height: 16),
                const Text('Classic Variant'),
                PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'classic'),
                const SizedBox(height: 16),
                const Text('Floating Variant'),
                PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'floating'),
                const SizedBox(height: 16),
                const Text('Shift Variant'),
                PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'shift'),
                const SizedBox(height: 16),
                const Text('Bubble Variant'),
                PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'bubble'),
                const SizedBox(height: 16),
                const Text('Dot Variant'),
                PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'dot'),
                const SizedBox(height: 16),
                const Text('Magic Line Variant'),
                PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'magic-line'),
                const SizedBox(height: 16),
                const Text('Curved Variant'),
                PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'curved'),
                const SizedBox(height: 16),
                const Text('Pill Slide Variant'),
                PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'pill-slide'),
                const SizedBox(height: 16),
                const Text('Cutout Variant'),
                PPBottomNav(value: selectedValue, onChanged: handleChange, items: cutoutItems, variant: 'cutout'),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      );
    },
  );


