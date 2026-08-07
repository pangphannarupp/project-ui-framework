import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class PPCalendarDemo extends StatefulWidget {
  const PPCalendarDemo({super.key});

  @override
  State<PPCalendarDemo> createState() => _PPCalendarDemoState();
}

class _PPCalendarDemoState extends State<PPCalendarDemo> {
  // State for Demo 1: Single Date
  DateTime? _singleSelectedDate;

  // State for Demo 2: Single Date with constraints
  DateTime? _constrainedSelectedDate;

  // State for Demo 3: Start on Sunday
  DateTime? _sundayStartDate;

  // State for Demo 4: Range Selection (Restricted)
  DateTime? _rangeStart = DateTime.now();
  DateTime? _rangeEnd = DateTime.now().add(const Duration(days: 4));

  // State for Demo 5: Quick Range Presets
  DateTime? _presetStart;
  DateTime? _presetEnd;

  // State for Demo 6: Week Selection
  DateTime? _weekStart;
  DateTime? _weekEnd;

  void _setPresetRange(int daysOffset) {
    setState(() {
      final now = DateTime.now();
      if (daysOffset < 0) {
        _presetStart = now.add(Duration(days: daysOffset));
        _presetEnd = now;
      } else {
        _presetStart = now;
        _presetEnd = now.add(Duration(days: daysOffset));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSectionTitle('1. Single Date Selection'),
        const Text(
          'Standard date picker mode with no constraints.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 16),
        Center(
          child: PPCalendar(
            selectionMode: PPCalendarSelectionMode.single,
            initialDate: _singleSelectedDate ?? DateTime.now(),
            onDateSelected: (date) {
              setState(() {
                _singleSelectedDate = date;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        if (_singleSelectedDate != null)
          Center(
            child: Text(
              'Selected: \${_singleSelectedDate.toString().split(" ")[0]}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        const Divider(height: 48),

        _buildSectionTitle('2. Min/Max Date Constraints'),
        const Text(
          'Restricts selection to a specific range (e.g., from today to 30 days from now).',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 16),
        Center(
          child: PPCalendar(
            selectionMode: PPCalendarSelectionMode.single,
            firstDate: DateTime.now(), // Min date is today
            lastDate: DateTime.now().add(const Duration(days: 30)), // Max date is 30 days from today
            initialDate: _constrainedSelectedDate ?? DateTime.now(),
            onDateSelected: (date) {
              setState(() {
                _constrainedSelectedDate = date;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        if (_constrainedSelectedDate != null)
          Center(
            child: Text(
              'Selected: \${_constrainedSelectedDate.toString().split(" ")[0]}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        const Divider(height: 48),

        _buildSectionTitle('3. Start on Sunday'),
        const Text(
          'Configured to start the week on Sunday instead of the default Monday.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 16),
        Center(
          child: PPCalendar(
            selectionMode: PPCalendarSelectionMode.single,
            firstDayOfWeek: 7, // 7 = Sunday
            primaryColor: Colors.deepOrange,
            initialDate: _sundayStartDate ?? DateTime.now(),
            onDateSelected: (date) {
              setState(() {
                _sundayStartDate = date;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        if (_sundayStartDate != null)
          Center(
            child: Text(
              'Selected: \${_sundayStartDate.toString().split(" ")[0]}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        const Divider(height: 48),

        _buildSectionTitle('4. Range Selection (Restricted)'),
        const Text(
          'Allows selecting a start and end date. Restricted to 2-7 days.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 16),
        Center(
          child: PPCalendar(
            selectionMode: PPCalendarSelectionMode.range,
            primaryColor: Colors.deepPurple,
            initialRangeStart: _rangeStart,
            initialRangeEnd: _rangeEnd,
            minRangeLength: 2,
            maxRangeLength: 7,
            onRangeSelected: (start, end) {
              setState(() {
                _rangeStart = start;
                _rangeEnd = end;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        if (_rangeStart != null)
          Center(
            child: Text(
              'Range: \${_rangeStart.toString().split(" ")[0]} to \${_rangeEnd != null ? _rangeEnd!.toString().split(" ")[0] : "..."}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        const Divider(height: 48),

        _buildSectionTitle('5. Quick Presets (Before/After weeks)'),
        const Text(
          'Use external buttons to quickly set calendar ranges.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => _setPresetRange(-7),
              child: const Text('Past 1 Week'),
            ),
            ElevatedButton(
              onPressed: () => _setPresetRange(-14),
              child: const Text('Past 2 Weeks'),
            ),
            ElevatedButton(
              onPressed: () => _setPresetRange(7),
              child: const Text('Next 1 Week'),
            ),
            ElevatedButton(
              onPressed: () => _setPresetRange(14),
              child: const Text('Next 2 Weeks'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: PPCalendar(
            selectionMode: PPCalendarSelectionMode.range,
            primaryColor: Colors.teal,
            initialRangeStart: _presetStart,
            initialRangeEnd: _presetEnd,
            onRangeSelected: (start, end) {
              setState(() {
                _presetStart = start;
                _presetEnd = end;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        if (_presetStart != null)
          Center(
            child: Text(
              'Range: \${_presetStart.toString().split(" ")[0]} to \${_presetEnd != null ? _presetEnd!.toString().split(" ")[0] : "..."}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        const Divider(height: 48),

        _buildSectionTitle('6. Week Selection'),
        const Text(
          'Automatically selects the entire week (Mon-Sun) containing the tapped date.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 16),
        Center(
          child: PPCalendar(
            selectionMode: PPCalendarSelectionMode.week,
            primaryColor: Colors.pink,
            initialRangeStart: _weekStart,
            initialRangeEnd: _weekEnd,
            onRangeSelected: (start, end) {
              setState(() {
                _weekStart = start;
                _weekEnd = end;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        if (_weekStart != null && _weekEnd != null)
          Center(
            child: Text(
              'Week: \${_weekStart.toString().split(" ")[0]} to \${_weekEnd!.toString().split(" ")[0]}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        const SizedBox(height: 48),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
        ),
      ),
    );
  }
}

final ComponentItem pp_calendarData = ComponentItem(
  name: 'PPCalendar',
  description: 'A premium, custom-built calendar component with single, range, and week selection modes.',
  demoBuilder: (context) => const PPCalendarDemo(),
  demoCode: '''
// 1. Single Selection
PPCalendar(
  selectionMode: PPCalendarSelectionMode.single,
  onDateSelected: (date) => print(date),
)

// 2. Min/Max Constraints
PPCalendar(
  firstDate: DateTime.now(), // Min date
  lastDate: DateTime.now().add(const Duration(days: 30)), // Max date
  onDateSelected: (date) => print(date),
)

// 3. Start on Sunday
PPCalendar(
  firstDayOfWeek: 7, // 7 = Sunday
  onDateSelected: (date) => print(date),
)

// 4. Range Selection
PPCalendar(
  selectionMode: PPCalendarSelectionMode.range,
  minRangeLength: 2,
  maxRangeLength: 7,
  onRangeSelected: (start, end) => print('\$start to \$end'),
)

// 5. Week Selection
PPCalendar(
  selectionMode: PPCalendarSelectionMode.week,
  onRangeSelected: (start, end) => print('\$start to \$end'),
)
''',
);
