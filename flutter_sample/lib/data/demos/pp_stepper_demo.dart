import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPStepperDemo extends StatefulWidget {
  const _PPStepperDemo();

  @override
  State<_PPStepperDemo> createState() => _PPStepperDemoState();
}

class _PPStepperDemoState extends State<_PPStepperDemo> {
  int _activeStep = 1;

  @override
  Widget build(BuildContext context) {
    final steps = [
      PPStepperStep(title: 'Account Setup', description: 'Create your credentials'),
      PPStepperStep(title: 'Personal Info', description: 'Address and details'),
      PPStepperStep(title: 'Payment', description: 'Add credit card'),
      PPStepperStep(title: 'Review', description: 'Confirm your order'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Horizontal (Clickable)', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
        const SizedBox(height: 24),
        PPStepper(
          steps: steps,
          activeStep: _activeStep,
          orientation: Axis.horizontal,
          onStepTapped: (index) {
            setState(() {
              _activeStep = index;
            });
          },
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: _activeStep > 0
                  ? () => setState(() => _activeStep--)
                  : null,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Previous', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _activeStep < steps.length - 1
                  ? () => setState(() => _activeStep++)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Next', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
        
        const Divider(height: 64),
        
        const Text('Vertical', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
        const SizedBox(height: 24),
        PPStepper(
          steps: steps,
          activeStep: _activeStep,
          orientation: Axis.vertical,
          onStepTapped: (index) {
            setState(() {
              _activeStep = index;
            });
          },
        ),
      ],
    );
  }
}

final ComponentItem pp_stepperData = ComponentItem(
  name: 'PPStepper',
  description: 'A component that displays progress through a sequence of logical steps.',
  demoCode: '''PPStepper(
  activeStep: 1,
  steps: [
    PPStepperStep(title: 'Step 1', description: 'First step'),
    PPStepperStep(title: 'Step 2', description: 'Second step'),
    PPStepperStep(title: 'Step 3', description: 'Final step'),
  ],
  onStepTapped: (index) => print('Tapped \$index'),
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
      child: const _PPStepperDemo(),
    );
  },
);
