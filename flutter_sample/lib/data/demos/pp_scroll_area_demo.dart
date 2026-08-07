import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPScrollAreaDemo extends StatelessWidget {
  const _PPScrollAreaDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Default Scrollbar (Vertical)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: PPScrollArea(
            direction: PPScrollAreaDirection.vertical,
            scrollbar: PPScrollAreaScrollbar.defaultScrollbar,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(20, (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text('Item ${index + 1} - This is a long list of items to demonstrate scrolling.'),
                )),
              ),
            ),
          ),
        ),

        const Divider(height: 48),

        const Text('Thin Scrollbar (Horizontal)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: PPScrollArea(
            direction: PPScrollAreaDirection.horizontal,
            scrollbar: PPScrollAreaScrollbar.thin,
            child: Row(
              children: List.generate(20, (index) => Container(
                width: 150,
                height: 80,
                margin: const EdgeInsets.all(8),
                color: Colors.blue.withOpacity((index % 10) / 10 + 0.1),
                child: Center(child: Text('Block $index')),
              )),
            ),
          ),
        ),

        const Divider(height: 48),

        const Text('Mac-style Scrollbar (Both Directions)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Container(
          height: 250,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: PPScrollArea(
            direction: PPScrollAreaDirection.both,
            scrollbar: PPScrollAreaScrollbar.mac,
            child: Container(
              width: 800,
              height: 600,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Text(
                  'Scroll me in any direction!',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),

        const Divider(height: 48),

        const Text('Hidden Scrollbar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: PPScrollArea(
            direction: PPScrollAreaDirection.vertical,
            hideScrollbar: true,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(20, (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text('Hidden Scrollbar Item ${index + 1}'),
                )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final ComponentItem pp_scroll_areaData = ComponentItem(
  name: 'PPScrollArea',
  description: 'A customizable scrollable area that supports custom scrollbars (default, thin, mac, or hidden) and 2D scrolling.',
  demoCode: '''PPScrollArea(
  direction: PPScrollAreaDirection.both,
  scrollbar: PPScrollAreaScrollbar.mac,
  child: Container(
    width: 1000,
    height: 1000,
    child: Text('Huge Content'),
  ),
);''',
  demoBuilder: (context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: _PPScrollAreaDemo(),
    );
  },
);
