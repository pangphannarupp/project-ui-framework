import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPSwipeItemDemo extends StatefulWidget {
  const _PPSwipeItemDemo();

  @override
  State<_PPSwipeItemDemo> createState() => _PPSwipeItemDemoState();
}

class _PPSwipeItemDemoState extends State<_PPSwipeItemDemo> {
  final List<String> _items = List.generate(5, (index) => 'Message \${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _items.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = _items[index];
          return PPSwipeItem(
            key: ValueKey(item),
            leftActions: [
              PPSwipeAction(
                backgroundColor: Colors.blue,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Marked \$item as unread')),
                  );
                },
                child: const Icon(Icons.mark_email_unread, color: Colors.white),
              ),
            ],
            rightActions: [
              PPSwipeAction(
                backgroundColor: Colors.orange,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Archived \$item')),
                  );
                },
                child: const Icon(Icons.archive, color: Colors.white),
              ),
              PPSwipeAction(
                backgroundColor: Colors.red,
                onTap: () {
                  setState(() {
                    _items.removeAt(index);
                  });
                },
                child: const Icon(Icons.delete, color: Colors.white),
              ),
            ],
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(item, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Swipe left or right to see actions...'),
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.person, color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}

final ComponentItem pp_swipe_itemData = ComponentItem(
  name: 'PPSwipeItem',
  description: 'A list item that can be swiped horizontally to reveal actions.',
  demoCode: '''PPSwipeItem(
  leftActions: [
    PPSwipeAction(
      backgroundColor: Colors.blue,
      onTap: () => print('Read'),
      child: const Icon(Icons.mark_email_read, color: Colors.white),
    ),
  ],
  rightActions: [
    PPSwipeAction(
      backgroundColor: Colors.red,
      onTap: () => print('Delete'),
      child: const Icon(Icons.delete, color: Colors.white),
    ),
  ],
  child: ListTile(title: Text('Swipe me!')),
)''',
  demoBuilder: (context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: _PPSwipeItemDemo(),
    );
  },
);
