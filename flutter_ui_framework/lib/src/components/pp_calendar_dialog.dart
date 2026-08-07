import 'package:flutter/material.dart';
import 'pp_calendar.dart';
import 'pp_dialog.dart';

Future<dynamic> showPPCalendarDialog({
  required BuildContext context,
  PPCalendarSelectionMode selectionMode = PPCalendarSelectionMode.single,
  DateTime? initialDate,
  DateTime? initialRangeStart,
  DateTime? initialRangeEnd,
  DateTime? firstDate,
  DateTime? lastDate,
  int minRangeLength = 1,
  int? maxRangeLength,
  Color primaryColor = const Color(0xFF3B82F6),
  int firstDayOfWeek = 1,
}) async {
  DateTime? selectedDate = initialDate;
  DateTime? rangeStart = initialRangeStart;
  DateTime? rangeEnd = initialRangeEnd;

  return PPDialog.show<dynamic>(
    context: context,
    content: SizedBox(
      width: 320,
      child: PPCalendar(
        selectionMode: selectionMode,
        initialDate: initialDate,
        initialRangeStart: initialRangeStart,
        initialRangeEnd: initialRangeEnd,
        firstDate: firstDate,
        lastDate: lastDate,
        minRangeLength: minRangeLength,
        maxRangeLength: maxRangeLength,
        primaryColor: primaryColor,
        firstDayOfWeek: firstDayOfWeek,
        hasDecoration: false,
        onDateSelected: (date) {
          selectedDate = date;
        },
        onRangeSelected: (start, end) {
          rangeStart = start;
          rangeEnd = end;
        },
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
      ),
      ElevatedButton(
        onPressed: () {
          if (selectionMode == PPCalendarSelectionMode.single) {
            Navigator.of(context).pop(selectedDate);
          } else {
            if (rangeStart != null && rangeEnd != null) {
              Navigator.of(context).pop([rangeStart, rangeEnd]);
            } else {
              // Invalid range
              Navigator.of(context).pop();
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Confirm'),
      ),
    ],
  );
}

