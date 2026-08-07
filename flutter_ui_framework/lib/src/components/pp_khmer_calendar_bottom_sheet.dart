import 'package:flutter/material.dart';
import 'pp_khmer_calendar.dart';
import 'pp_bottom_sheet.dart';

Future<dynamic> showPPKhmerCalendarBottomSheet({
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

  return PPBottomSheet.show<dynamic>(
    context: context,
    maxWidth: 440,
    isScrollControlled: true,
    padding: const EdgeInsets.only(bottom: 16.0, top: 8.0, left: 16.0, right: 16.0),
    content: PPKhmerCalendar(
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
    actions: [
      Expanded(
        child: OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('បោះបង់', style: TextStyle(color: Colors.grey, fontFamily: 'Khmer OS Battambang')),
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: ElevatedButton(
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
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('យល់ព្រម', style: TextStyle(fontFamily: 'Khmer OS Battambang')),
        ),
      ),
    ],
  );
}

