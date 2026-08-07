import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPSegmentDemo extends StatefulWidget {
  const _PPSegmentDemo();

  @override
  State<_PPSegmentDemo> createState() => _PPSegmentDemoState();
}

class _PPSegmentDemoState extends State<_PPSegmentDemo> {
  String _selectedValue1 = 'daily';
  String _selectedValue2 = 'tab1';
  String _selectedValue3 = 'left';
  String _selectedValue4 = 'system';
  String _selectedValue5 = 'flight';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Variant: Pill (Default)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        PPSegment<String>(
          value: _selectedValue1,
          onChanged: (val) => setState(() => _selectedValue1 = val),
          items: [
            PPSegmentButton(value: 'daily', label: 'Daily'),
            PPSegmentButton(value: 'weekly', label: 'Weekly'),
            PPSegmentButton(value: 'monthly', label: 'Monthly'),
          ],
        ),

        const Divider(height: 64),

        const Text('Variant: Underline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        PPSegment<String>(
          value: _selectedValue2,
          variant: PPSegmentVariant.underline,
          onChanged: (val) => setState(() => _selectedValue2 = val),
          items: [
            PPSegmentButton(value: 'tab1', label: 'Overview', icon: const Icon(Icons.pie_chart_outline)),
            PPSegmentButton(value: 'tab2', label: 'Activity', icon: const Icon(Icons.bar_chart)),
            PPSegmentButton(value: 'tab3', label: 'Settings', icon: const Icon(Icons.settings_outlined)),
          ],
        ),

        const Divider(height: 64),

        const Text('Variant: Block', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        PPSegment<String>(
          value: _selectedValue3,
          variant: PPSegmentVariant.block,
          onChanged: (val) => setState(() => _selectedValue3 = val),
          items: [
            PPSegmentButton(value: 'left', label: 'Left', icon: const Icon(Icons.format_align_left)),
            PPSegmentButton(value: 'center', label: 'Center', icon: const Icon(Icons.format_align_center)),
            PPSegmentButton(value: 'right', label: 'Right', icon: const Icon(Icons.format_align_right)),
          ],
        ),

        const Divider(height: 64),

        const Text('Variant: Material 3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        PPSegment<String>(
          value: _selectedValue4,
          variant: PPSegmentVariant.material3,
          onChanged: (val) => setState(() => _selectedValue4 = val),
          items: [
            PPSegmentButton(value: 'light', label: 'Light', icon: const Icon(Icons.light_mode_outlined)),
            PPSegmentButton(value: 'system', label: 'System', icon: const Icon(Icons.computer_outlined)),
            PPSegmentButton(value: 'dark', label: 'Dark', icon: const Icon(Icons.dark_mode_outlined)),
          ],
        ),

        const Divider(height: 64),

        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1579546929518-9e396f3cc809'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Variant: iOS Liquid Glass', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              const SizedBox(height: 24),
              PPSegment<String>(
                value: _selectedValue5,
                variant: PPSegmentVariant.iosGlass,
                onChanged: (val) => setState(() => _selectedValue5 = val),
                items: [
                  PPSegmentButton(value: 'flight', label: 'Flight', icon: const Icon(Icons.flight)),
                  PPSegmentButton(value: 'hotel', label: 'Hotel', icon: const Icon(Icons.hotel)),
                  PPSegmentButton(value: 'car', label: 'Car', icon: const Icon(Icons.directions_car)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final ComponentItem pp_segmentData = ComponentItem(
  name: 'PPSegment',
  description: 'A segmented control component with multiple aesthetic variants.',
  demoCode: '''PPSegment<String>(
  value: selectedValue,
  variant: PPSegmentVariant.pill,
  onChanged: (val) => setState(() => selectedValue = val),
  items: [
    PPSegmentButton(value: 'daily', label: 'Daily'),
    PPSegmentButton(value: 'weekly', label: 'Weekly'),
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
      child: const _PPSegmentDemo(),
    );
  },
);
