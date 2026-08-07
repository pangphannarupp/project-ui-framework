import 'package:flutter/material.dart';
import 'pp_calendar.dart';
import 'pp_calendar_dialog.dart';
import 'pp_calendar_bottom_sheet.dart';

enum PPCalendarPickerType {
  dialog,
  bottomSheet,
}

class PPCalendarPicker extends StatefulWidget {
  final String label;
  final PPCalendarPickerType pickerType;
  final PPCalendarSelectionMode selectionMode;
  final DateTime? initialDate;
  final DateTime? initialRangeStart;
  final DateTime? initialRangeEnd;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final int minRangeLength;
  final int? maxRangeLength;
  final Color primaryColor;
  final int firstDayOfWeek;
  final String? placeholder;

  /// Called when selection changes. 
  /// For single mode, returns a single DateTime.
  /// For range/week mode, returns a List<DateTime> with exactly 2 elements (start and end).
  final ValueChanged<dynamic>? onChanged;

  const PPCalendarPicker({
    super.key,
    this.label = 'Select Date',
    this.pickerType = PPCalendarPickerType.dialog,
    this.selectionMode = PPCalendarSelectionMode.single,
    this.initialDate,
    this.initialRangeStart,
    this.initialRangeEnd,
    this.firstDate,
    this.lastDate,
    this.minRangeLength = 1,
    this.maxRangeLength,
    this.primaryColor = const Color(0xFF3B82F6),
    this.firstDayOfWeek = 1,
    this.placeholder,
    this.onChanged,
  });

  @override
  State<PPCalendarPicker> createState() => _PPCalendarPickerState();
}

class _PPCalendarPickerState extends State<PPCalendarPicker> {
  DateTime? _selectedDate;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _rangeStart = widget.initialRangeStart;
    _rangeEnd = widget.initialRangeEnd;
  }

  String get _displayText {
    if (widget.selectionMode == PPCalendarSelectionMode.single) {
      if (_selectedDate == null) return widget.placeholder ?? 'Choose a date';
      return '${_selectedDate!.year.toString().padLeft(4, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}';
    } else {
      if (_rangeStart == null || _rangeEnd == null) return widget.placeholder ?? 'Choose a date range';
      final start = '${_rangeStart!.year.toString().padLeft(4, '0')}-${_rangeStart!.month.toString().padLeft(2, '0')}-${_rangeStart!.day.toString().padLeft(2, '0')}';
      final end = '${_rangeEnd!.year.toString().padLeft(4, '0')}-${_rangeEnd!.month.toString().padLeft(2, '0')}-${_rangeEnd!.day.toString().padLeft(2, '0')}';
      return '$start to $end';
    }
  }

  Future<void> _showPicker() async {
    dynamic result;
    if (widget.pickerType == PPCalendarPickerType.dialog) {
      result = await showPPCalendarDialog(
        context: context,
        selectionMode: widget.selectionMode,
        initialDate: _selectedDate,
        initialRangeStart: _rangeStart,
        initialRangeEnd: _rangeEnd,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        minRangeLength: widget.minRangeLength,
        maxRangeLength: widget.maxRangeLength,
        primaryColor: widget.primaryColor,
        firstDayOfWeek: widget.firstDayOfWeek,
      );
    } else {
      result = await showPPCalendarBottomSheet(
        context: context,
        selectionMode: widget.selectionMode,
        initialDate: _selectedDate,
        initialRangeStart: _rangeStart,
        initialRangeEnd: _rangeEnd,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        minRangeLength: widget.minRangeLength,
        maxRangeLength: widget.maxRangeLength,
        primaryColor: widget.primaryColor,
        firstDayOfWeek: widget.firstDayOfWeek,
      );
    }

    if (result != null) {
      setState(() {
        if (widget.selectionMode == PPCalendarSelectionMode.single) {
          _selectedDate = result as DateTime;
        } else {
          final range = result as List<DateTime>;
          _rangeStart = range[0];
          _rangeEnd = range[1];
        }
      });
      widget.onChanged?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 8),
        ],
        InkWell(
          onTap: _showPicker,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD1D5DB)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _displayText,
                  style: TextStyle(
                    fontSize: 16,
                    color: (_selectedDate != null || _rangeStart != null) 
                        ? const Color(0xFF1F2937) 
                        : const Color(0xFF9CA3AF),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: const Color(0xFF6B7280),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
