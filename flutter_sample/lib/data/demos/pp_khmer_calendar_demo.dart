import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class PPKhmerCalendarDemo extends StatefulWidget {
  const PPKhmerCalendarDemo({super.key});

  @override
  State<PPKhmerCalendarDemo> createState() => _PPKhmerCalendarDemoState();
}

class _PPKhmerCalendarDemoState extends State<PPKhmerCalendarDemo> {
  DateTime? _selectedDate;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime? _weekStart;
  DateTime? _weekEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'ប្រតិទិនខ្មែរ (Khmer Calendar)',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
            fontFamily: 'Khmer OS Battambang',
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Fully localized into Khmer language with numbers, weekdays, and months.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 24),
        
        const Text('1. Single Date Selection (Monday Start)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Center(
          child: PPKhmerCalendar(
            selectionMode: PPKhmerCalendarSelectionMode.single,
            firstDayOfWeek: 1, // Monday
            initialDate: _selectedDate ?? DateTime.now(),
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),
        ),
        if (_selectedDate != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Selected: ${_selectedDate.toString().split(" ")[0]}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ),
          
        const SizedBox(height: 32),
        
        const Text('2. Min/Max Constraints (Sunday Start)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Can only select between 5 days ago and 10 days from now.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 12),
        Center(
          child: PPKhmerCalendar(
            selectionMode: PPKhmerCalendarSelectionMode.single,
            firstDayOfWeek: 7, // Sunday
            firstDate: DateTime.now().subtract(const Duration(days: 5)),
            lastDate: DateTime.now().add(const Duration(days: 10)),
            onDateSelected: (date) {},
          ),
        ),
        
        const SizedBox(height: 32),
        
        const Text('3. Range Selection (Max 14 days)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Center(
          child: PPKhmerCalendar(
            selectionMode: PPKhmerCalendarSelectionMode.range,
            firstDayOfWeek: 1,
            maxRangeLength: 14,
            initialRangeStart: _rangeStart,
            initialRangeEnd: _rangeEnd,
            primaryColor: Colors.purple,
            onRangeSelected: (start, end) {
              setState(() {
                _rangeStart = start;
                _rangeEnd = end;
              });
            },
          ),
        ),
        if (_rangeStart != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Range: ${_rangeStart.toString().split(" ")[0]} to ${_rangeEnd != null ? _rangeEnd.toString().split(" ")[0] : "..."}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
              ),
            ),
          ),
          
        const SizedBox(height: 32),
        
        const Text('4. Week Selection', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Center(
          child: PPKhmerCalendar(
            selectionMode: PPKhmerCalendarSelectionMode.week,
            firstDayOfWeek: 1,
            primaryColor: Colors.teal,
            onRangeSelected: (start, end) {
              setState(() {
                _weekStart = start;
                _weekEnd = end;
              });
            },
          ),
        ),
        if (_weekStart != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Week: ${_weekStart.toString().split(" ")[0]} to ${_weekEnd != null ? _weekEnd.toString().split(" ")[0] : "..."}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
              ),
            ),
          ),
          
      ],
    );
  }
}

final ComponentItem pp_khmer_calendarData = ComponentItem(
  name: 'PPKhmerCalendar',
  description: 'A beautifully localized Khmer calendar component supporting single, range, and week selections.',
  demoBuilder: (context) => const PPKhmerCalendarDemo(),
  demoCode: '''
// 1. Single Selection
PPKhmerCalendar(
  selectionMode: PPKhmerCalendarSelectionMode.single,
  firstDayOfWeek: 1, // Monday Start
  onDateSelected: (date) { ... },
)

// 2. Min/Max constraints & Sunday Start
PPKhmerCalendar(
  selectionMode: PPKhmerCalendarSelectionMode.single,
  firstDayOfWeek: 7, // Sunday Start
  firstDate: DateTime.now().subtract(const Duration(days: 5)),
  lastDate: DateTime.now().add(const Duration(days: 10)),
)

// 3. Range Selection (max 14 days)
PPKhmerCalendar(
  selectionMode: PPKhmerCalendarSelectionMode.range,
  maxRangeLength: 14,
  onRangeSelected: (start, end) { ... },
)

// 4. Week Selection
PPKhmerCalendar(
  selectionMode: PPKhmerCalendarSelectionMode.week,
  onRangeSelected: (start, end) { ... },
)
''',
);
