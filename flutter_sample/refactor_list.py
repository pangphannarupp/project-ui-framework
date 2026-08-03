import re

file_path = 'lib/screens/home_screen.dart'

with open(file_path, 'r') as f:
    content = f.read()

# Extract component names
matches = re.findall(r"title: Text\('([^']+)'\)", content)
if not matches:
    # Try the old format just in case it wasn't successfully changed before
    matches = re.findall(r"title: const Text\('([^']+)'\)", content)

# Remove duplicates while preserving order
components = []
for m in matches:
    if m not in components and m != 'Boilerplate component':
        components.append(m)

# If still no matches, maybe they are already ComponentItem(name: '...')
with open('lib/data/component_data.dart', 'r') as f:
    old_data = f.read()
matches = re.findall(r"ComponentItem\(name: '([^']+)'", old_data)
for m in matches:
    if m not in components and m != 'Boilerplate component':
        components.append(m)


# Generate component_data.dart
data_dart = """import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';

class ComponentItem {
  final String name;
  final String description;
  final String? demoCode;
  final WidgetBuilder? demoBuilder;

  const ComponentItem({
    required this.name,
    this.description = 'Boilerplate component',
    this.demoCode,
    this.demoBuilder,
  });
}

final List<ComponentItem> componentData = [
"""

for c in components:
    desc = 'Boilerplate component'
    demoCode = 'null'
    demoBuilder = 'null'
    
    if c == 'PPButton':
        desc = 'Implemented component'
        demoCode = """'''PPButton(
  text: 'Click Me',
  onPressed: () {},
)'''"""
        demoBuilder = """(context) => PPButton(text: 'Click Me', onPressed: () {})"""
        
    elif c == 'PPBottomNav':
        desc = 'Implemented component'
        demoCode = """'''Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    PPBottomNav(variant: 'material', value: '0', ...),
    PPBottomNav(variant: 'classic', value: '0', ...),
    PPBottomNav(variant: 'floating', value: '0', ...),
    PPBottomNav(variant: 'shift', value: '0', ...),
    PPBottomNav(variant: 'bubble', value: '0', ...),
  ],
)'''"""
        demoBuilder = """(context) {
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
    }"""

    data_dart += f"  ComponentItem(\n    name: '{c}',\n    description: '{desc}',\n    demoCode: {demoCode},\n    demoBuilder: {demoBuilder},\n  ),\n"

data_dart += "];\n"

with open('lib/data/component_data.dart', 'w') as f:
    f.write(data_dart)
    print(f"Updated component_data.dart with {len(components)} items.")
