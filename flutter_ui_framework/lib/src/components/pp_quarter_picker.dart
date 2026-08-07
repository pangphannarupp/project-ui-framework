import 'package:flutter/material.dart';

class PPQuarterPicker extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onQuarterSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color primaryColor;
  final bool hasDecoration;
  final bool useKhmer;

  const PPQuarterPicker({
    super.key,
    this.initialDate,
    this.onQuarterSelected,
    this.firstDate,
    this.lastDate,
    this.primaryColor = const Color(0xFFE53935),
    this.hasDecoration = true,
    this.useKhmer = true,
  });

  @override
  State<PPQuarterPicker> createState() => _PPQuarterPickerState();
}

class _PPQuarterPickerState extends State<PPQuarterPicker> {
  late DateTime _currentDate;
  late int _selectedYear;

  final List<String> _khmerQuarters = [
    'ត្រីមាសទី១', 'ត្រីមាសទី២', 'ត្រីមាសទី៣', 'ត្រីមាសទី៤'
  ];

  final List<String> _westernQuarters = [
    'Q1', 'Q2', 'Q3', 'Q4'
  ];

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialDate ?? DateTime.now();
    _selectedYear = _currentDate.year;
  }

  String _toKhmerNum(int number) {
    if (!widget.useKhmer) return number.toString();
    const khmerDigits = ['០', '១', '២', '៣', '៤', '៥', '៦', '៧', '៨', '៩'];
    return number.toString().split('').map((e) => khmerDigits[int.parse(e)]).join();
  }

  void _previousYear() {
    if (widget.firstDate != null && _selectedYear <= widget.firstDate!.year) return;
    setState(() {
      _selectedYear--;
    });
  }

  void _nextYear() {
    if (widget.lastDate != null && _selectedYear >= widget.lastDate!.year) return;
    setState(() {
      _selectedYear++;
    });
  }

  bool _isQuarterSelectable(int quarter) {
    int month = (quarter - 1) * 3 + 1; // 1, 4, 7, 10
    if (widget.firstDate != null) {
      if (_selectedYear < widget.firstDate!.year) return false;
      if (_selectedYear == widget.firstDate!.year && month < widget.firstDate!.month) return false;
    }
    if (widget.lastDate != null) {
      if (_selectedYear > widget.lastDate!.year) return false;
      if (_selectedYear == widget.lastDate!.year && month > widget.lastDate!.month) return false;
    }
    return true;
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _previousYear,
            splashRadius: 24,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            color: const Color(0xFF4B5563),
          ),
          PopupMenuButton<int>(
            initialValue: _selectedYear,
            constraints: const BoxConstraints(maxHeight: 300),
            onSelected: (year) {
              setState(() {
                _selectedYear = year;
              });
            },
            itemBuilder: (context) {
              int startYear = widget.firstDate?.year ?? 1900;
              int endYear = widget.lastDate?.year ?? 2100;
              return List.generate(endYear - startYear + 1, (index) {
                return PopupMenuItem(
                  value: startYear + index,
                  child: Text(_toKhmerNum(startYear + index)),
                );
              });
            },
            child: Row(
              children: [
                Text(
                  _toKhmerNum(_selectedYear),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                ),
                const Icon(Icons.arrow_drop_down, color: Color(0xFF1F2937), size: 20),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _nextYear,
            splashRadius: 24,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            color: const Color(0xFF4B5563),
          ),
        ],
      ),
    );
  }

  Widget _buildQuarterGrid() {
    final quarters = widget.useKhmer ? _khmerQuarters : _westernQuarters;
    int currentQuarter = ((_currentDate.month - 1) / 3).floor() + 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.0,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        final quarterNumber = index + 1;
        final isSelectable = _isQuarterSelectable(quarterNumber);
        final isSelected = _currentDate.year == _selectedYear && currentQuarter == quarterNumber;
        
        Color textColor;
        if (isSelected) {
          textColor = Colors.white;
        } else if (!isSelectable) {
          textColor = const Color(0xFFD1D5DB);
        } else {
          textColor = const Color(0xFF374151);
        }

        return GestureDetector(
          onTap: isSelectable ? () {
            setState(() {
              int startMonth = (quarterNumber - 1) * 3 + 1;
              _currentDate = DateTime(_selectedYear, startMonth, 1);
            });
            widget.onQuarterSelected?.call(_currentDate);
          } : null,
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? widget.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                quarters[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: textColor,
                  fontFamily: widget.useKhmer ? 'Khmer OS Battambang' : null,
                ),
              ),
            ),
          ),
        );
      },
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildQuarterGrid(),
        ],
      ),
    );
  }
}
