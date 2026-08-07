import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPCollapseDemo extends StatefulWidget {
  const _PPCollapseDemo();

  @override
  State<_PPCollapseDemo> createState() => _PPCollapseDemoState();
}

class _PPCollapseDemoState extends State<_PPCollapseDemo> {
  List<String> _activeNames1 = ['1'];
  List<String> _activeNames2 = ['1'];
  List<String> _activeNames3 = ['1'];
  List<String> _activeNames4 = ['1'];

  Widget _buildDemoSection(String title, Widget collapse) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        collapse,
        const SizedBox(height: 32),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDemoSection(
          'Default Variant (Multiple Expansion)',
          PPCollapse(
            activeNames: _activeNames1,
            onChanged: (val) => setState(() => _activeNames1 = val),
            children: const [
              PPCollapseItem(
                name: '1',
                title: 'Consistency',
                child: Text('Consistent with real life: in line with the process and logic of real life, and comply with languages and habits that the users are used to;\\n\\nConsistent within interface: all elements should be consistent, such as: design style, icons and texts, position of elements, etc.'),
              ),
              PPCollapseItem(
                name: '2',
                title: 'Feedback',
                child: Text('Operation feedback: enable the users to clearly perceive their operations by style updates and interactive effects;\\n\\nVisual feedback: reflect current state by updating or rearranging elements of the page.'),
              ),
              PPCollapseItem(
                name: '3',
                title: 'Efficiency',
                child: Text('Simplify the process: keep operating process simple and intuitive;\\n\\nDefinite and clear: enunciate your intentions clearly so that the users can quickly understand and make decisions;\\n\\nEasy to identify: the interface should be straightforward, which helps the users to identify and frees them from memorizing and recalling.'),
              ),
              PPCollapseItem(
                name: '4',
                title: 'Controllability (Disabled)',
                disabled: true,
                child: Text('Decision making: giving advices about operations is acceptable, but do not make decisions for the users;\\n\\nControlled consequences: users should be granted the freedom to operate, including canceling, aborting or terminating current operation.'),
              ),
            ],
          ),
        ),

        _buildDemoSection(
          'Accordion Mode (Only one open at a time)',
          PPCollapse(
            activeNames: _activeNames2,
            accordion: true,
            onChanged: (val) => setState(() => _activeNames2 = val),
            children: const [
              PPCollapseItem(
                name: '1',
                title: 'Consistency',
                child: Text('Consistent with real life: in line with the process and logic of real life, and comply with languages and habits that the users are used to;'),
              ),
              PPCollapseItem(
                name: '2',
                title: 'Feedback',
                child: Text('Operation feedback: enable the users to clearly perceive their operations by style updates and interactive effects;'),
              ),
              PPCollapseItem(
                name: '3',
                title: 'Efficiency',
                child: Text('Simplify the process: keep operating process simple and intuitive;'),
              ),
            ],
          ),
        ),

        _buildDemoSection(
          'Flush Variant',
          PPCollapse(
            activeNames: _activeNames3,
            variant: PPCollapseVariant.flush,
            onChanged: (val) => setState(() => _activeNames3 = val),
            children: const [
              PPCollapseItem(name: '1', title: 'Panel 1', child: Text('Content for panel 1')),
              PPCollapseItem(name: '2', title: 'Panel 2', child: Text('Content for panel 2')),
              PPCollapseItem(name: '3', title: 'Panel 3', child: Text('Content for panel 3')),
            ],
          ),
        ),

        _buildDemoSection(
          'Separated Variant',
          PPCollapse(
            activeNames: _activeNames4,
            variant: PPCollapseVariant.separated,
            onChanged: (val) => setState(() => _activeNames4 = val),
            children: const [
              PPCollapseItem(name: '1', title: 'Panel 1', child: Text('Content for panel 1')),
              PPCollapseItem(name: '2', title: 'Panel 2', child: Text('Content for panel 2')),
              PPCollapseItem(name: '3', title: 'Panel 3', child: Text('Content for panel 3')),
            ],
          ),
        ),

        _buildDemoSection(
          'Filled Variant',
          PPCollapse(
            activeNames: _activeNames4, // Reuse state
            variant: PPCollapseVariant.filled,
            onChanged: (val) => setState(() => _activeNames4 = val),
            children: const [
              PPCollapseItem(name: '1', title: 'Panel 1', child: Text('Content for panel 1')),
              PPCollapseItem(name: '2', title: 'Panel 2', child: Text('Content for panel 2')),
              PPCollapseItem(name: '3', title: 'Panel 3', child: Text('Content for panel 3')),
            ],
          ),
        ),
      ],
    );
  }
}

final ComponentItem pp_collapseData = ComponentItem(
  name: 'PPCollapse',
  description: 'Use collapse to store and organize information. Supports accordion mode and various visual variants.',
  demoCode: '''PPCollapse(
  activeNames: _activeNames,
  onChanged: (val) => setState(() => _activeNames = val),
  accordion: true,
  variant: PPCollapseVariant.defaultVariant,
  children: const [
    PPCollapseItem(
      name: '1',
      title: 'Panel Title',
      child: Text('Panel content goes here...'),
    ),
  ],
);''',
  demoBuilder: (context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: _PPCollapseDemo(),
    );
  },
);
