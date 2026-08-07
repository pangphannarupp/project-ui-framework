import 'package:flutter/material.dart';

class PPMonthYearPicker extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onMonthYearSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color primaryColor;
  final bool hasDecoration;
  final bool useKhmer;

  const PPMonthYearPicker({
    super.key,
    this.initialDate,
    this.onMonthYearSelected,
    this.firstDate,
    this.lastDate,
    this.primaryColor = const Color(0xFFE53935),
    this.hasDecoration = true,
    this.useKhmer = true,
  });

  @override
  State<PPMonthYearPicker> createState() => _PPMonthYearPickerState();
}

class _PPMonthYearPickerState extends State<PPMonthYearPicker> {
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _yearController;

  late int _selectedMonth; // 1-12
  late int _selectedYear;
  
  late int _startYear;
  late int _endYear;

  final List<String> _khmerMonths = [
    'មករា', 'កុម្ភៈ', 'មីនា', 'មេសា', 'ឧសភា', 'មិថុនា',
    'កក្កដា', 'សីហា', 'កញ្ញា', 'តុលា', 'វិច្ឆិកា', 'ធ្នូ'
  ];

  final List<String> _westernMonths = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  @override
  void initState() {
    super.initState();
    final initial = widget.initialDate ?? DateTime.now();
    _selectedMonth = initial.month;
    _selectedYear = initial.year;
    
    _startYear = widget.firstDate?.year ?? 1900;
    _endYear = widget.lastDate?.year ?? 2100;

    // Use loop for months, so initialItem can be large
    int initialMonthItem = 1000 * 12 + (_selectedMonth - 1);
    int initialYearItem = _selectedYear - _startYear;

    _monthController = FixedExtentScrollController(initialItem: initialMonthItem);
    _yearController = FixedExtentScrollController(initialItem: initialYearItem);
  }

  @override
  void dispose() {
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  String _toKhmerNum(int number) {
    if (!widget.useKhmer) return number.toString();
    const khmerDigits = ['០', '១', '២', '៣', '៤', '៥', '៦', '៧', '៨', '៩'];
    return number.toString().split('').map((e) => khmerDigits[int.parse(e)]).join();
  }

  void _onDateChanged() {
    widget.onMonthYearSelected?.call(DateTime(_selectedYear, _selectedMonth, 1));
  }

  Widget _buildWheel({
    required FixedExtentScrollController controller,
    required int itemCount,
    required Widget Function(int) builder,
    required void Function(int) onChanged,
    bool loop = true,
  }) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 40,
        perspective: 0.005,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onChanged,
        childDelegate: loop
            ? ListWheelChildBuilderDelegate(
                builder: (context, index) => builder(index % itemCount),
              )
            : ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  if (index < 0 || index >= itemCount) return null;
                  return builder(index);
                },
                childCount: itemCount,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalYears = _endYear - _startYear + 1;
    final months = widget.useKhmer ? _khmerMonths : _westernMonths;

    return Container(
      width: 320,
      height: 240,
      padding: widget.hasDecoration ? const EdgeInsets.all(16.0) : EdgeInsets.zero,
      decoration: widget.hasDecoration ? BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ) : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Selection Indicator
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: widget.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Month Wheel
              _buildWheel(
                controller: _monthController,
                itemCount: 12,
                onChanged: (index) {
                  setState(() {
                    _selectedMonth = (index % 12) + 1;
                  });
                  _onDateChanged();
                },
                builder: (index) {
                  bool isSelected = (index + 1) == _selectedMonth;
                  return Center(
                    child: Text(
                      months[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? widget.primaryColor : const Color(0xFF374151),
                        fontFamily: widget.useKhmer ? 'Khmer OS Battambang' : null,
                      ),
                    ),
                  );
                },
              ),
              // Year Wheel
              _buildWheel(
                controller: _yearController,
                itemCount: totalYears,
                loop: false,
                onChanged: (index) {
                  setState(() {
                    _selectedYear = _startYear + index;
                  });
                  _onDateChanged();
                },
                builder: (index) {
                  int year = _startYear + index;
                  bool isSelected = year == _selectedYear;
                  return Center(
                    child: Text(
                      _toKhmerNum(year),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? widget.primaryColor : const Color(0xFF374151),
                        fontFamily: widget.useKhmer ? 'Khmer OS Battambang' : null,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
