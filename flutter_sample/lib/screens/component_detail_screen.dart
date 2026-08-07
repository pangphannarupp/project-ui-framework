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

  Widget _buildCodeSnippet(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: Colors.greenAccent,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (componentName == 'Installation') {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Installation & Usage'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Framework Usage Guide',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 16),
              const Text(
                'This library provides a set of highly customizable Flutter components designed to match the Aura Portal design system.',
                style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
              ),
              const SizedBox(height: 32),
              const Text(
                '1. Add Dependency',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 12),
              const Text(
                'Include the framework in your pubspec.yaml file by pointing to its local path or git repository.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildCodeSnippet('''dependencies:
  flutter:
    sdk: flutter
  flutter_ui_framework:
    path: ../flutter_ui_framework'''),
              const SizedBox(height: 32),
              const Text(
                '2. Import and Use',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 12),
              const Text(
                'Import the package in your dart files and start using the components.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildCodeSnippet('''import 'package:flutter_ui_framework/flutter_ui_framework.dart';

// Example Usage
PPButton(
  label: 'Get Started',
  onPressed: () {},
);'''),
            ],
          ),
        ),
      );
    }

    // Find the component data
    final item = componentData.firstWhere(
      (c) => c.name == componentName,
      orElse: () => ComponentItem(name: componentName),
    );

    final code = item.demoCode ?? 'const Placeholder(fallbackHeight: 50, fallbackWidth: 100)';
    final demoWidget = item.demoBuilder?.call(context) ?? const Placeholder(fallbackHeight: 50, fallbackWidth: 100);

    return Scaffold(
      appBar: AppBar(
        title: Text(componentName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: Colors.grey[100],
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Center(child: demoWidget),
              ),
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
