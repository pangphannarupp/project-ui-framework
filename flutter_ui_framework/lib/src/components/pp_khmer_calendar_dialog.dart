import 'package:flutter/material.dart';
import 'pp_khmer_calendar.dart';
import 'pp_dialog.dart';

Future<dynamic> showPPKhmerCalendarDialog({
  required BuildContext context,
  PPKhmerCalendarSelectionMode selectionMode = PPKhmerCalendarSelectionMode.single,
  DateTime? initialDate,
  DateTime? initialRangeStart,
  DateTime? initialRangeEnd,
  DateTime? firstDate,
  DateTime? lastDate,
  int minRangeLength = 1,
  int? maxRangeLength,
  Color primaryColor = const Color(0xFFE53935),
  int firstDayOfWeek = 1,
  bool useKhmer = true,
}) async {
  DateTime? selectedDate = initialDate;
  DateTime? rangeStart = initialRangeStart;
  DateTime? rangeEnd = initialRangeEnd;

  return PPDialog.show<dynamic>(
    context: context,
    content: SizedBox(
      width: 380,
      child: PPKhmerCalendar(
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
        useKhmer: useKhmer,
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
        child: const Text('បោះបង់', style: TextStyle(color: Colors.grey, fontFamily: 'Khmer OS Battambang')), // Cancel
      ),
      ElevatedButton(
        onPressed: () {
          if (selectionMode == PPKhmerCalendarSelectionMode.single) {
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('យល់ព្រម', style: TextStyle(fontFamily: 'Khmer OS Battambang')), // Confirm
      ),
    ],
  );
}

