import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _CollapsingToolbarDemo extends StatefulWidget {
  const _CollapsingToolbarDemo();

  @override
  State<_CollapsingToolbarDemo> createState() => _CollapsingToolbarDemoState();
}

class _CollapsingToolbarDemoState extends State<_CollapsingToolbarDemo> {
  int _usageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 4 Usages
    final usages = [
      'Profile Layout',
      'Basic (Title Only)',
      'Solid Background',
      'Image Only',
    ];

    Widget buildBody() {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 24, bottom: 24),
        itemCount: 20,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Usage Mode:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(usages.length, (i) {
                      final isSelected = _usageIndex == i;
                      return ActionChip(
                        backgroundColor: isSelected ? Colors.teal : Colors.grey.shade200,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        label: Text(usages[i]),
                        onPressed: () {
                          setState(() {
                            _usageIndex = i;
                          });
                        },
                      );
                    }),
                  ),
                  const Divider(height: 32),
                ],
              ),
            );
          }
          
          return ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '\$index',
                  style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            title: Text('Scrollable Content \$index'),
            subtitle: const Text('Scroll up to collapse the header'),
          );
        },
      );
    }

    final actions = [
      const Icon(Icons.search, color: Colors.white),
      const SizedBox(width: 16),
      const Icon(Icons.more_vert, color: Colors.white),
      const SizedBox(width: 8),
    ];
    
    final leading = const Icon(Icons.arrow_back, color: Colors.white);
    
    final background = Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://picsum.photos/800/400?image=1050',
          fit: BoxFit.cover,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, 0.5),
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
            ),
          ),
        ),
      ],
    );

    // Profile Layout
    if (_usageIndex == 0) {
      return PPCollapsingToolbar(
        expandedHeight: 220,
        title: 'John Doe',
        profile: const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
        ),
        background: background,
        leading: leading,
        actions: actions,
        body: buildBody(),
      );
    } 
    // Basic (Title Only)
    else if (_usageIndex == 1) {
      return PPCollapsingToolbar(
        expandedHeight: 180,
        title: 'Mountain Retreat',
        centerTitleOnCollapse: true,
        background: background,
        leading: leading,
        actions: actions,
        body: buildBody(),
      );
    }
    // Solid Background
    else if (_usageIndex == 2) {
      return PPCollapsingToolbar(
        expandedHeight: 160,
        title: 'Settings',
        centerTitleOnCollapse: false,
        backgroundColor: Colors.indigo, // Solid color, no background image
        leading: leading,
        body: buildBody(),
      );
    }
    // Image Only
    else {
      return PPCollapsingToolbar(
        expandedHeight: 250,
        title: '', // No title
        background: background,
        leading: leading,
        actions: actions,
        body: buildBody(),
      );
    }
  }
}

final ComponentItem pp_collapsing_toolbarData = ComponentItem(
  name: 'PPCollapsingToolbar',
  description: 'An app bar that collapses as you scroll down the page. Matches the web UI framework style.',
  demoCode: '''// Usage 1: Profile Layout
PPCollapsingToolbar(
  title: 'John Doe',
  profile: CircleAvatar(backgroundImage: NetworkImage('...')),
  background: Image.network('...'),
  body: ListView(...),
)

// Usage 2: Basic Title
PPCollapsingToolbar(
  title: 'Mountain Retreat',
  centerTitleOnCollapse: true,
  background: Image.network('...'),
  body: ListView(...),
)

// Usage 3: Solid Color
PPCollapsingToolbar(
  title: 'Settings',
  backgroundColor: Colors.indigo,
  body: ListView(...),
)''',
  demoBuilder: (context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: const _CollapsingToolbarDemo(),
      ),
    );
  },
);
