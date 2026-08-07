import 'package:flutter/material.dart';
import 'pp_calendar.dart';
import 'pp_bottom_sheet.dart';

Future<dynamic> showPPCalendarBottomSheet({
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

  return PPBottomSheet.show<dynamic>(
    context: context,
    isScrollControlled: true,
    maxWidth: 440,
    title: const SizedBox.shrink(),
    padding: const EdgeInsets.only(bottom: 16.0, top: 8.0, left: 16.0, right: 16.0),
    content: PPCalendar(
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
    actions: [
      Expanded(
        child: OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            if (selectionMode == PPCalendarSelectionMode.single) {
              Navigator.of(context).pop(selectedDate);
            } else {
              if (rangeStart != null && rangeEnd != null) {
                Navigator.of(context).pop([rangeStart, rangeEnd]);
              } else {
                Navigator.of(context).pop();
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Confirm'),
        ),
      ),
    ],
  );
}

