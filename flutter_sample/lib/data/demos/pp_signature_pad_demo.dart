import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_signature_padData = ComponentItem(
  name: 'PPSignaturePad',
  description: 'A touch-friendly pad for capturing user signatures.',
  demoBuilder: (context) => const PPSignaturePadDemo(),
);

class PPSignaturePadDemo extends StatefulWidget {
  const PPSignaturePadDemo({super.key});

  @override
  State<PPSignaturePadDemo> createState() => _PPSignaturePadDemoState();
}

class _PPSignaturePadDemoState extends State<PPSignaturePadDemo> {
  final PPSignaturePadController _controller = PPSignaturePadController();

  void _submitSignature() async {
    final bytes = await _controller.toPngBytes();
    if (bytes != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signature saved! (${bytes.length} bytes)'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Signature Pad',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Allow users to digitally sign documents with a smooth drawing experience.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please sign below',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                PPSignaturePad(
                  controller: _controller,
                  penColor: Colors.black87,
                  backgroundColor: const Color(0xFFF9FAFB),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: PPButton(
                    label: 'Submit Signature',
                    onPressed: _submitSignature,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
