import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPPullToRefreshDemo extends StatefulWidget {
  const _PPPullToRefreshDemo();

  @override
  State<_PPPullToRefreshDemo> createState() => _PPPullToRefreshDemoState();
}

class _PPPullToRefreshDemoState extends State<_PPPullToRefreshDemo> {
  final List<String> _items = List.generate(5, (index) => 'Item \${index + 1}');

  Future<void> _handleRefresh() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _items.insert(0, 'New Item \${_items.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      clipBehavior: Clip.antiAlias,
      child: PPPullToRefresh(
        onRefresh: _handleRefresh,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(_items[index]),
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE2E8F0),
                  child: Icon(Icons.description, color: Color(0xFF64748B)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

final ComponentItem pp_pull_to_refreshData = ComponentItem(
  name: 'PPPullToRefresh',
  description: 'A wrapper component that provides pull-to-refresh functionality.',
  demoCode: '''PPPullToRefresh(
  onRefresh: () async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
  },
  child: ListView.builder(
    physics: AlwaysScrollableScrollPhysics(), // Important for short lists!
    itemCount: items.length,
    itemBuilder: (context, index) => ListTile(title: Text(items[index])),
  ),
)''',
  demoBuilder: (context) {
    return const _PPPullToRefreshDemo();
  },
);
