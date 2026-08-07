import 'package:flutter/material.dart';

enum PPCalendarSelectionMode {
  single,
  range,
  week,
}

/// A premium, standalone calendar component.
class PPCalendar extends StatefulWidget {
  /// The selection mode (single, range, or week).
  final PPCalendarSelectionMode selectionMode;

  /// The currently selected date (for single mode).
  final DateTime? initialDate;

  /// The currently selected range start (for range/week modes).
  final DateTime? initialRangeStart;

  /// The currently selected range end (for range/week modes).
  final DateTime? initialRangeEnd;

  /// The earliest date the user is permitted to pick.
  final DateTime? firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime? lastDate;

  /// Called when the user selects a date (single mode).
  final ValueChanged<DateTime>? onDateSelected;

  /// Called when the user selects a range (range/week modes).
  final void Function(DateTime start, DateTime? end)? onRangeSelected;

  /// Minimum range length (inclusive). Default is 1.
  final int minRangeLength;

  /// Maximum range length (inclusive). null means unlimited.
  final int? maxRangeLength;

  /// The primary color used for the selected date and header.
  final Color primaryColor;

  /// The first day of the week. 1 = Monday, 7 = Sunday.
  final int firstDayOfWeek;

  /// Whether the calendar should draw its own card decoration (shadow, border).
  final bool hasDecoration;

  const PPCalendar({
    super.key,
    this.selectionMode = PPCalendarSelectionMode.single,
    this.initialDate,
    this.initialRangeStart,
    this.initialRangeEnd,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.onRangeSelected,
    this.minRangeLength = 1,
    this.maxRangeLength,
    this.primaryColor = const Color(0xFF3B82F6), // Tailwind Blue 500
    this.firstDayOfWeek = 1,
    this.hasDecoration = true,
  });

  @override
  State<PPCalendar> createState() => _PPCalendarState();
}

class _PPCalendarState extends State<PPCalendar> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  
  int _slideDirection = 1;

  final List<String> _baseWeekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  
  List<String> get _weekdays {
    int shift = (widget.firstDayOfWeek - 1) % 7;
    return [..._baseWeekdays.sublist(shift), ..._baseWeekdays.sublist(0, shift)];
  }

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _rangeStart = widget.initialRangeStart;
    _rangeEnd = widget.initialRangeEnd;
    
    DateTime initial = widget.initialDate ?? widget.initialRangeStart ?? DateTime.now();
    _currentMonth = DateTime(initial.year, initial.month, 1);
  }

  @override
  void didUpdateWidget(covariant PPCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectionMode == PPCalendarSelectionMode.single) {
      if (widget.initialDate != oldWidget.initialDate && widget.initialDate != _selectedDate) {
        _selectedDate = widget.initialDate;
        if (_selectedDate != null) {
          _currentMonth = DateTime(_selectedDate!.year, _selectedDate!.month, 1);
        }
      }
    } else {
      if (widget.initialRangeStart != oldWidget.initialRangeStart || widget.initialRangeEnd != oldWidget.initialRangeEnd) {
        _rangeStart = widget.initialRangeStart;
        _rangeEnd = widget.initialRangeEnd;
        if (_rangeStart != null) {
          _currentMonth = DateTime(_rangeStart!.year, _rangeStart!.month, 1);
        }
      }
    }
  }

  int get _daysInMonth => DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
  
  int get _firstWeekdayOffset {
    int offset = _currentMonth.weekday - widget.firstDayOfWeek;
    if (offset < 0) offset += 7;
    return offset;
  }
  
  int get _daysInPreviousMonth => DateTime(_currentMonth.year, _currentMonth.month, 0).day;

  void _previousMonth() {
    setState(() {
      _slideDirection = -1;
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _slideDirection = 1;
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  void _selectDate(DateTime date) {
    if (!_isDateWithinMinMaxConstraints(date)) return;

    setState(() {
      if (widget.selectionMode == PPCalendarSelectionMode.single) {
        _selectedDate = date;
        widget.onDateSelected?.call(date);
      } else if (widget.selectionMode == PPCalendarSelectionMode.week) {
        // Find Monday and Sunday of that week
        int diffToMonday = date.weekday - 1;
        int diffToSunday = 7 - date.weekday;
        
        DateTime start = date.subtract(Duration(days: diffToMonday));
        DateTime end = date.add(Duration(days: diffToSunday));
        
        _rangeStart = start;
        _rangeEnd = end;
        widget.onRangeSelected?.call(start, end);
      } else if (widget.selectionMode == PPCalendarSelectionMode.range) {
        if (_rangeStart == null || (_rangeStart != null && _rangeEnd != null)) {
          // Start new range
          _rangeStart = date;
          _rangeEnd = null;
        } else {
          // Complete range
          if (date.isBefore(_rangeStart!)) {
            _rangeEnd = _rangeStart;
            _rangeStart = date;
          } else {
            _rangeEnd = date;
          }
          
          // Apply length constraints
          int diff = _rangeEnd!.difference(_rangeStart!).inDays + 1;
          if (widget.maxRangeLength != null && diff > widget.maxRangeLength!) {
            _rangeEnd = _rangeStart!.add(Duration(days: widget.maxRangeLength! - 1));
          }
          if (diff < widget.minRangeLength) {
            _rangeEnd = _rangeStart!.add(Duration(days: widget.minRangeLength - 1));
          }
          
          widget.onRangeSelected?.call(_rangeStart!, _rangeEnd);
        }
      }
    });
  }

  bool _isDateWithinMinMaxConstraints(DateTime date) {
    if (widget.firstDate != null && date.isBefore(DateTime(widget.firstDate!.year, widget.firstDate!.month, widget.firstDate!.day))) {
      return false;
    }
    if (widget.lastDate != null && date.isAfter(DateTime(widget.lastDate!.year, widget.lastDate!.month, widget.lastDate!.day))) {
      return false;
    }
    
    return true;
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isToday(DateTime date) {
    return _isSameDate(date, DateTime.now());
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PopupMenuButton<int>(
                    initialValue: _currentMonth.month,
                    onSelected: (month) {
                      setState(() {
                        _slideDirection = month > _currentMonth.month ? 1 : -1;
                        _currentMonth = DateTime(_currentMonth.year, month, 1);
                      });
                    },
                    itemBuilder: (context) => List.generate(12, (index) {
                      return PopupMenuItem(
                        value: index + 1,
                        child: Text(_months[index]),
                      );
                    }),
                    child: Row(
                      children: [
                        Text(
                          '${_months[_currentMonth.month - 1]} ',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Color(0xFF1F2937), size: 20),
                      ],
                    ),
                  ),
                  PopupMenuButton<int>(
                    initialValue: _currentMonth.year,
                    constraints: const BoxConstraints(maxHeight: 300),
                    onSelected: (year) {
                      setState(() {
                        _slideDirection = year > _currentMonth.year ? 1 : -1;
                        _currentMonth = DateTime(year, _currentMonth.month, 1);
                      });
                    },
                    itemBuilder: (context) {
                      int startYear = widget.firstDate?.year ?? 1900;
                      int endYear = widget.lastDate?.year ?? 2100;
                      return List.generate(endYear - startYear + 1, (index) {
                        return PopupMenuItem(
                          value: startYear + index,
                          child: Text('${startYear + index}'),
                        );
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          '${_currentMonth.year}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Color(0xFF1F2937), size: 20),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _previousMonth,
                    splashRadius: 24,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: const Color(0xFF4B5563),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: _nextMonth,
                    splashRadius: 24,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: const Color(0xFF4B5563),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  DateTime now = DateTime.now();
                  setState(() {
                    _slideDirection = now.isAfter(_currentMonth) ? 1 : -1;
                    _currentMonth = DateTime(now.year, now.month, 1);
                  });
                  if (widget.selectionMode == PPCalendarSelectionMode.single) {
                    _selectDate(now);
                  }
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text('Today', style: TextStyle(color: widget.primaryColor, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWeekdays() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _weekdays.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDaysGrid({Key? key}) {
    List<Widget> dayWidgets = [];

    // Previous month days
    for (int i = _firstWeekdayOffset - 1; i >= 0; i--) {
      int day = _daysInPreviousMonth - i;
      DateTime date = DateTime(_currentMonth.year, _currentMonth.month - 1, day);
      dayWidgets.add(_buildDayCell(date, isOutsideMonth: true));
    }

    // Current month days
    for (int i = 1; i <= _daysInMonth; i++) {
      DateTime date = DateTime(_currentMonth.year, _currentMonth.month, i);
      dayWidgets.add(_buildDayCell(date, isOutsideMonth: false));
    }

    // Next month days to complete the grid (6 rows of 7 days = 42 cells)
    int remainingCells = 42 - dayWidgets.length;
    for (int i = 1; i <= remainingCells; i++) {
      DateTime date = DateTime(_currentMonth.year, _currentMonth.month + 1, i);
      dayWidgets.add(_buildDayCell(date, isOutsideMonth: true));
    }

    return GridView.count(
      key: key,
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 4,
      crossAxisSpacing: 0,
      children: dayWidgets,
    );
  }

  Widget _buildDayCell(DateTime date, {required bool isOutsideMonth}) {
    bool isSelectable = _isDateWithinMinMaxConstraints(date);
    bool isToday = _isToday(date);
    
    bool isSingleSelected = widget.selectionMode == PPCalendarSelectionMode.single && 
                           _selectedDate != null && 
                           _isSameDate(date, _selectedDate!);

    bool isRangeStart = widget.selectionMode != PPCalendarSelectionMode.single &&
                        _rangeStart != null && 
                        _isSameDate(date, _rangeStart!);
                        
    bool isRangeEnd = widget.selectionMode != PPCalendarSelectionMode.single &&
                      _rangeEnd != null && 
                      _isSameDate(date, _rangeEnd!);
                      
    bool isWithinRange = widget.selectionMode != PPCalendarSelectionMode.single &&
                         _rangeStart != null && 
                         _rangeEnd != null && 
                         (date.isAfter(_rangeStart!) || _isSameDate(date, _rangeStart!)) && 
                         (date.isBefore(_rangeEnd!) || _isSameDate(date, _rangeEnd!)) &&
                         !isRangeStart && !isRangeEnd;

    // Is it a singleton selection in range mode? (Start selected, end not selected yet, OR start==end)
    bool isSingletonRange = isRangeStart && (_rangeEnd == null || _isSameDate(_rangeStart!, _rangeEnd!));

    Color textColor;
    if (isSingleSelected || isRangeStart || isRangeEnd) {
      textColor = Colors.white;
    } else if (isWithinRange) {
      textColor = widget.primaryColor.withOpacity(0.9);
    } else if (!isSelectable) {
      textColor = const Color(0xFFD1D5DB);
    } else if (isOutsideMonth) {
      textColor = const Color(0xFF9CA3AF);
    } else if (isToday) {
      textColor = widget.primaryColor;
    } else {
      textColor = const Color(0xFF374151);
    }

    // Determine the background shapes based on range position
    BoxDecoration decoration;
    
    if (isSingleSelected || isSingletonRange) {
      decoration = BoxDecoration(
        color: widget.primaryColor,
        shape: BoxShape.circle,
      );
    } else if (isRangeStart) {
      decoration = BoxDecoration(
        color: widget.primaryColor,
        shape: BoxShape.circle,
      );
    } else if (isRangeEnd) {
      decoration = BoxDecoration(
        color: widget.primaryColor,
        shape: BoxShape.circle,
      );
    } else if (isWithinRange) {
      decoration = const BoxDecoration(
        color: Colors.transparent,
      );
    } else {
      decoration = const BoxDecoration(
        color: Colors.transparent,
      );
    }

    return GestureDetector(
      onTap: isSelectable ? () => _selectDate(date) : null,
      child: Container(
        decoration: (isRangeStart || isRangeEnd || isWithinRange) && !isSingletonRange
            ? BoxDecoration(
                color: widget.primaryColor.withOpacity(0.15),
                borderRadius: isRangeStart
                    ? const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
                    : isRangeEnd
                        ? const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                        : BorderRadius.zero,
              )
            : const BoxDecoration(color: Colors.transparent),
        child: Container(
          margin: (isSingleSelected || isSingletonRange || isRangeStart || isRangeEnd) 
              ? const EdgeInsets.all(2) 
              : EdgeInsets.zero,
          decoration: decoration,
          child: Center(
            child: Text(
              '${date.day}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: (isSingleSelected || isRangeStart || isRangeEnd || isToday) ? FontWeight.bold : FontWeight.normal,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
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
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            _previousMonth();
          } else if (details.primaryVelocity! < 0) {
            _nextMonth();
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            _buildWeekdays(),
            const SizedBox(height: 12),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final bool isIncoming = child.key == ValueKey(_currentMonth);
                final offsetMultiplier = isIncoming ? _slideDirection : -_slideDirection;
                
                final inAnimation = Tween<Offset>(
                  begin: Offset(offsetMultiplier * 0.2, 0.0),
                  end: Offset.zero,
                ).animate(animation);
                
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: inAnimation,
                    child: child,
                  ),
                );
              },
              child: _buildDaysGrid(key: ValueKey(_currentMonth)),
            ),
          ],
        ),
      ),
    );
  }
}
