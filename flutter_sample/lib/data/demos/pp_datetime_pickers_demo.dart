import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_datetimePickersData = ComponentItem(
  name: 'Date & Time Pickers',
  description: 'Various pickers for month, year, quarter, and time.',
  demoBuilder: (context) => const PPDateTimePickersDemo(),
  demoCode: '''
// Month Picker
PPMonthPicker(
  initialDate: DateTime.now(),
  onMonthSelected: (date) => print(date),
)

// Year Picker
PPYearPicker(
  initialDate: DateTime.now(),
  onYearSelected: (date) => print(date),
)

// Month & Year Picker
PPMonthYearPicker(
  initialDate: DateTime.now(),
  onMonthYearSelected: (date) => print(date),
)

// Quarter Picker
PPQuarterPicker(
  initialDate: DateTime.now(),
  onQuarterSelected: (date) => print(date),
)

// Time Picker
PPTimePicker(
  initialTime: TimeOfDay.now(),
  onTimeSelected: (time) => print(time),
)
''',
);

class PPDateTimePickersDemo extends StatefulWidget {
  const PPDateTimePickersDemo({super.key});

  @override
  State<PPDateTimePickersDemo> createState() => _PPDateTimePickersDemoState();
}

class _PPDateTimePickersDemoState extends State<PPDateTimePickersDemo> {
  bool _useKhmer = true;

  void _showInDialog(BuildContext context, Widget child, String title) {
    PPDialog.show<dynamic>(
      context: context,
      content: SizedBox(
        width: 380,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  void _showInBottomSheet(BuildContext context, Widget child, String title) {
    PPBottomSheet.show<dynamic>(
      context: context,
      content: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            child,
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Use Khmer Language & Numerals', style: TextStyle(fontSize: 16)),
              Switch(
                value: _useKhmer,
                onChanged: (val) => setState(() => _useKhmer = val),
                activeColor: const Color(0xFFE53935),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Month Picker
          const Text('Month Picker', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: PPButton(
                  label: 'Show in Dialog',
                  onPressed: () {
                    _showInDialog(
                      context,
                      PPMonthPicker(
                        useKhmer: _useKhmer,
                        hasDecoration: false,
                        onMonthSelected: (date) {
                          print('Month selected: $date');
                          Navigator.pop(context);
                        },
                      ),
                      'Select Month'
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PPButton(
                  label: 'Show in Bottom Sheet',
                  onPressed: () {
                    _showInBottomSheet(
                      context,
                      PPMonthPicker(
                        useKhmer: _useKhmer,
                        hasDecoration: false,
                        onMonthSelected: (date) {
                          print('Month selected: $date');
                          Navigator.pop(context);
                        },
                      ),
                      'Select Month'
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Year Picker
          const Text('Year Picker', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: PPButton(
                  label: 'Show in Dialog',
                  onPressed: () {
                    _showInDialog(
                      context,
                      PPYearPicker(
                        useKhmer: _useKhmer,
                        hasDecoration: false,
                        onYearSelected: (date) {
                          print('Year selected: $date');
                          Navigator.pop(context);
                        },
                      ),
                      'Select Year'
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PPButton(
                  label: 'Show in Bottom Sheet',
                  onPressed: () {
                    _showInBottomSheet(
                      context,
                      PPYearPicker(
                        useKhmer: _useKhmer,
                        hasDecoration: false,
                        onYearSelected: (date) {
                          print('Year selected: $date');
                          Navigator.pop(context);
                        },
                      ),
                      'Select Year'
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Month Year Picker
          const Text('Month & Year Picker', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: PPButton(
                  label: 'Show in Dialog',
                  onPressed: () {
                    _showInDialog(
                      context,
                      PPMonthYearPicker(
                        useKhmer: _useKhmer,
                        hasDecoration: false,
                        onMonthYearSelected: (date) {
                          print('Month Year selected: $date');
                        },
                      ),
                      'Select Month & Year'
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PPButton(
                  label: 'Show in Bottom Sheet',
                  onPressed: () {
                    _showInBottomSheet(
                      context,
                      PPMonthYearPicker(
                        useKhmer: _useKhmer,
                        hasDecoration: false,
                        onMonthYearSelected: (date) {
                          print('Month Year selected: $date');
                        },
                      ),
                      'Select Month & Year'
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Quarter Picker
          const Text('Quarter Picker', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: PPButton(
                  label: 'Show in Dialog',
                  onPressed: () {
                    _showInDialog(
                      context,
                      PPQuarterPicker(
                        useKhmer: _useKhmer,
                        hasDecoration: false,
                        onQuarterSelected: (date) {
                          print('Quarter selected: $date');
                          Navigator.pop(context);
                        },
                      ),
                      'Select Quarter'
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PPButton(
                  label: 'Show in Bottom Sheet',
                  onPressed: () {
                    _showInBottomSheet(
                      context,
                      PPQuarterPicker(
                        useKhmer: _useKhmer,
                        hasDecoration: false,
                        onQuarterSelected: (date) {
                          print('Quarter selected: $date');
                          Navigator.pop(context);
                        },
                      ),
                      'Select Quarter'
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Time Picker
          const Text('Time Picker', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: PPButton(
                  label: 'Show in Dialog',
                  onPressed: () {
                    _showInDialog(
                      context,
                      PPTimePicker(
                        useKhmer: _useKhmer,
                        hasDecoration: false,
                        onTimeSelected: (time) {
                          print('Time selected: $time');
                        },
                      ),
                      'Select Time'
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PPButton(
                  label: 'Show in Bottom Sheet',
                  onPressed: () {
                    _showInBottomSheet(
                      context,
                      PPTimePicker(
                        useKhmer: _useKhmer,
                        hasDecoration: false,
                        onTimeSelected: (time) {
                          print('Time selected: $time');
                        },
                      ),
                      'Select Time'
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
