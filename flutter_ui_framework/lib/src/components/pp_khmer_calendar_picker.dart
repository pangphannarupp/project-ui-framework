import 'package:flutter/material.dart';
import 'pp_khmer_calendar.dart';
import 'pp_khmer_calendar_dialog.dart';
import 'pp_khmer_calendar_bottom_sheet.dart';

enum PPKhmerCalendarPickerType {
  dialog,
  bottomSheet,
}

class PPKhmerCalendarPicker extends StatefulWidget {
  final String label;
  final PPKhmerCalendarPickerType pickerType;
  final PPKhmerCalendarSelectionMode selectionMode;
  final DateTime? initialDate;
  final DateTime? initialRangeStart;
  final DateTime? initialRangeEnd;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final int minRangeLength;
  final int? maxRangeLength;
  final Color primaryColor;
  final int firstDayOfWeek;
  final bool useKhmer;
  final String? placeholder;

  /// Called when selection changes. 
  /// For single mode, returns a single DateTime.
  /// For range/week mode, returns a List<DateTime> with exactly 2 elements (start and end).
  final ValueChanged<dynamic>? onChanged;

  const PPKhmerCalendarPicker({
    super.key,
    this.label = 'ជ្រើសរើសកាលបរិច្ឆេទ',
    this.pickerType = PPKhmerCalendarPickerType.dialog,
    this.selectionMode = PPKhmerCalendarSelectionMode.single,
    this.initialDate,
    this.initialRangeStart,
    this.initialRangeEnd,
    this.firstDate,
    this.lastDate,
    this.minRangeLength = 1,
    this.maxRangeLength,
    this.primaryColor = const Color(0xFFE53935),
    this.firstDayOfWeek = 1,
    this.useKhmer = true,
    this.placeholder,
    this.onChanged,
  });

  @override
  State<PPKhmerCalendarPicker> createState() => _PPKhmerCalendarPickerState();
}

class _PPKhmerCalendarPickerState extends State<PPKhmerCalendarPicker> {
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

  String _toKhmerNum(String input) {
    if (!widget.useKhmer) return input;
    const khmerNumbers = ['០', '១', '២', '៣', '៤', '៥', '៦', '៧', '៨', '៩'];
    return input.replaceAllMapped(RegExp(r'[0-9]'), (match) {
      return khmerNumbers[int.parse(match.group(0)!)];
    });
  }

  String _formatDate(DateTime date) {
    final str = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().padLeft(4, '0')}';
    return _toKhmerNum(str);
  }

  String get _displayText {
    if (widget.selectionMode == PPKhmerCalendarSelectionMode.single) {
      if (_selectedDate == null) return widget.placeholder ?? 'ជ្រើសរើសកាលបរិច្ឆេទ';
      return _formatDate(_selectedDate!);
    } else {
      if (_rangeStart == null || _rangeEnd == null) return widget.placeholder ?? 'ជ្រើសរើសចន្លោះកាលបរិច្ឆេទ';
      return '${_formatDate(_rangeStart!)} ដល់ ${_formatDate(_rangeEnd!)}';
    }
  }

  Future<void> _showPicker() async {
    dynamic result;
    if (widget.pickerType == PPKhmerCalendarPickerType.dialog) {
      result = await showPPKhmerCalendarDialog(
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
        useKhmer: widget.useKhmer,
      );
    } else {
      result = await showPPKhmerCalendarBottomSheet(
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
        useKhmer: widget.useKhmer,
      );
    }

    if (result != null) {
      setState(() {
        if (widget.selectionMode == PPKhmerCalendarSelectionMode.single) {
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
              fontFamily: 'Khmer OS Battambang',
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
                    fontFamily: 'Khmer OS Battambang',
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
