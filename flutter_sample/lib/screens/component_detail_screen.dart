import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../data/component_data.dart';

class ComponentDetailScreen extends StatelessWidget {
  final String componentName;

  const ComponentDetailScreen({
    super.key,
    required this.componentName,
  });

  @override
  Widget build(BuildContext context) {
    // Find the component data
    final item = componentData.firstWhere(
      (c) => c.name == componentName,
      orElse: () => ComponentItem(name: componentName),
    );

    final code = item.demoCode ?? 'const Placeholder(fallbackHeight: 50, fallbackWidth: 100)';
    final demoWidget = item.demoBuilder?.call(context) ?? const Placeholder(fallbackHeight: 50, fallbackWidth: 100);

    return Scaffold(
      appBar: AppBar(title: Text(componentName)),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: Colors.grey[100],
              child: Center(child: demoWidget),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF1E1E1E),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Usage', style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.copy, color: Colors.white70, size: 20),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: code));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Code copied to clipboard!')),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        code,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          color: Colors.greenAccent,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
