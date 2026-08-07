import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_otp_inputData = ComponentItem(
  name: 'PPOtpInput',
  description: 'A customizable OTP (One Time Password) input component with auto-focus and paste support.',
  demoBuilder: (context) => const PPOtpInputDemo(),
  demoCode: '''
import 'package:flutter_ui_framework/flutter_ui_framework.dart';

PPOtpInput(
  length: 6,
  onCompleted: (code) {
    print("OTP Entered: \$code");
  },
)
  ''',
);

class PPOtpInputDemo extends StatefulWidget {
  const PPOtpInputDemo({Key? key}) : super(key: key);

  @override
  State<PPOtpInputDemo> createState() => _PPOtpInputDemoState();
}

class _PPOtpInputDemoState extends State<PPOtpInputDemo> {
  String _otpValue = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic OTP Input',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          PPOtpInput(
            length: 6,
            onChanged: (val) {
              setState(() {
                _otpValue = val;
              });
            },
            onCompleted: (val) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('OTP Completed: \$val')),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Current Value: $_otpValue',
            style: const TextStyle(color: Colors.grey),
          ),
          
          const SizedBox(height: 48),
          
          const Text(
            'Secure / Obscured OTP',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const PPOtpInput(
            length: 4,
            obscureText: true,
            fieldWidth: 64,
            fieldHeight: 64,
          ),
        ],
      ),
    );
  }
}
