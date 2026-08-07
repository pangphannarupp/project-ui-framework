import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPScrollSegmentDemo extends StatefulWidget {
  const _PPScrollSegmentDemo();

  @override
  State<_PPScrollSegmentDemo> createState() => _PPScrollSegmentDemoState();
}

class _PPScrollSegmentDemoState extends State<_PPScrollSegmentDemo> {
  String _selectedValue = 'all';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          // We wrap the segment in a constrained box to ensure it overflows and shows the scroll arrows
          SizedBox(
            width: 300,
            child: PPScrollSegment<String>(
              value: _selectedValue,
              onChanged: (val) => setState(() => _selectedValue = val),
              items: [
                PPScrollSegmentButton(value: 'all', label: 'All Categories'),
                PPScrollSegmentButton(value: 'design', label: 'Design', icon: const Icon(Icons.brush)),
                PPScrollSegmentButton(value: 'development', label: 'Development', icon: const Icon(Icons.code)),
                PPScrollSegmentButton(value: 'marketing', label: 'Marketing', icon: const Icon(Icons.campaign)),
                PPScrollSegmentButton(value: 'business', label: 'Business', icon: const Icon(Icons.business)),
                PPScrollSegmentButton(value: 'photography', label: 'Photography', icon: const Icon(Icons.camera_alt)),
                PPScrollSegmentButton(value: 'music', label: 'Music', icon: const Icon(Icons.music_note)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text('Selected Category: \$_selectedValue', style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

final ComponentItem pp_scroll_segmentData = ComponentItem(
  name: 'PPScrollSegment',
  description: 'A horizontally scrollable segment control, perfect for many categories. Shows navigation arrows when overflow occurs.',
  demoCode: '''PPScrollSegment<String>(
  value: selectedValue,
  onChanged: (val) => setState(() => selectedValue = val),
  items: [
    PPScrollSegmentButton(value: 'all', label: 'All Categories'),
    PPScrollSegmentButton(value: 'design', label: 'Design', icon: Icon(Icons.brush)),
    // Add as many as you want...
  ],
)''',
  demoBuilder: (context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: _PPScrollSegmentDemo(),
    );
  },
);
