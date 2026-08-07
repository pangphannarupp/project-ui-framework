import 'package:flutter/material.dart';

class PPTimePicker extends StatefulWidget {
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final bool is24HourFormat;
  final Color primaryColor;
  final bool hasDecoration;
  final bool useKhmer;

  const PPTimePicker({
    super.key,
    this.initialTime,
    this.onTimeSelected,
    this.is24HourFormat = false,
    this.primaryColor = const Color(0xFFE53935),
    this.hasDecoration = true,
    this.useKhmer = true,
  });

  @override
  State<PPTimePicker> createState() => _PPTimePickerState();
}

class _PPTimePickerState extends State<PPTimePicker> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _periodController;

  late int _selectedHour; // 0-23 internally
  late int _selectedMinute;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialTime ?? TimeOfDay.now();
    _selectedHour = initial.hour;
    _selectedMinute = initial.minute;

    int displayHour = widget.is24HourFormat ? _selectedHour : (_selectedHour % 12 == 0 ? 12 : _selectedHour % 12);
    int periodIndex = _selectedHour >= 12 ? 1 : 0;

    // We use a large initial item to allow infinite scrolling in both directions
    int initialHourItem = 1000 * (widget.is24HourFormat ? 24 : 12) + (widget.is24HourFormat ? displayHour : displayHour - 1);
    int initialMinuteItem = 1000 * 60 + _selectedMinute;

    _hourController = FixedExtentScrollController(initialItem: initialHourItem);
    _minuteController = FixedExtentScrollController(initialItem: initialMinuteItem);
    _periodController = FixedExtentScrollController(initialItem: periodIndex);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  String _toKhmerNum(int number) {
    String numStr = number.toString().padLeft(2, '0');
    if (!widget.useKhmer) return numStr;
    const khmerDigits = ['០', '១', '២', '៣', '៤', '៥', '៦', '៧', '៨', '៩'];
    return numStr.split('').map((e) => khmerDigits[int.parse(e)]).join();
  }

  void _onTimeChanged() {
    widget.onTimeSelected?.call(TimeOfDay(hour: _selectedHour, minute: _selectedMinute));
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
              // Hours Wheel
              _buildWheel(
                controller: _hourController,
                itemCount: widget.is24HourFormat ? 24 : 12,
                onChanged: (index) {
                  setState(() {
                    int h = index % (widget.is24HourFormat ? 24 : 12);
                    if (!widget.is24HourFormat) {
                      h = h + 1; // 1-12
                      bool isPM = _selectedHour >= 12;
                      if (h == 12) {
                        _selectedHour = isPM ? 12 : 0;
                      } else {
                        _selectedHour = isPM ? h + 12 : h;
                      }
                    } else {
                      _selectedHour = h;
                    }
                  });
                  _onTimeChanged();
                },
                builder: (index) {
                  int displayHour = widget.is24HourFormat ? index : index + 1;
                  bool isSelected = widget.is24HourFormat 
                      ? displayHour == _selectedHour
                      : (displayHour == (_selectedHour % 12 == 0 ? 12 : _selectedHour % 12));
                      
                  return Center(
                    child: Text(
                      _toKhmerNum(displayHour),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? widget.primaryColor : const Color(0xFF374151),
                        fontFamily: widget.useKhmer ? 'Khmer OS Battambang' : null,
                      ),
                    ),
                  );
                },
              ),
              const Text(':', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF374151))),
              // Minutes Wheel
              _buildWheel(
                controller: _minuteController,
                itemCount: 60,
                onChanged: (index) {
                  setState(() {
                    _selectedMinute = index % 60;
                  });
                  _onTimeChanged();
                },
                builder: (index) {
                  bool isSelected = index == _selectedMinute;
                  return Center(
                    child: Text(
                      _toKhmerNum(index),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? widget.primaryColor : const Color(0xFF374151),
                        fontFamily: widget.useKhmer ? 'Khmer OS Battambang' : null,
                      ),
                    ),
                  );
                },
              ),
              // AM/PM Wheel
              if (!widget.is24HourFormat)
                _buildWheel(
                  controller: _periodController,
                  itemCount: 2,
                  loop: false,
                  onChanged: (index) {
                    setState(() {
                      bool isPM = index == 1;
                      if (isPM && _selectedHour < 12) {
                        _selectedHour += 12;
                      } else if (!isPM && _selectedHour >= 12) {
                        _selectedHour -= 12;
                      }
                    });
                    _onTimeChanged();
                  },
                  builder: (index) {
                    bool isSelected = (index == 1 && _selectedHour >= 12) || (index == 0 && _selectedHour < 12);
                    String text = widget.useKhmer 
                        ? (index == 0 ? 'ព្រឹក' : 'ល្ងាច') 
                        : (index == 0 ? 'AM' : 'PM');
                    return Center(
                      child: Text(
                        text,
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
