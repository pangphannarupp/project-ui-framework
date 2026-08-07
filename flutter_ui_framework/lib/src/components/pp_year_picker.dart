import 'package:flutter/material.dart';

class PPYearPicker extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onYearSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color primaryColor;
  final bool hasDecoration;
  final bool useKhmer;

  const PPYearPicker({
    super.key,
    this.initialDate,
    this.onYearSelected,
    this.firstDate,
    this.lastDate,
    this.primaryColor = const Color(0xFFE53935),
    this.hasDecoration = true,
    this.useKhmer = true,
  });

  @override
  State<PPYearPicker> createState() => _PPYearPickerState();
}

class _PPYearPickerState extends State<PPYearPicker> {
  late int _selectedYear;
  late int _startYear;
  late int _endYear;
  
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialDate?.year ?? DateTime.now().year;
    _startYear = widget.firstDate?.year ?? 1900;
    _endYear = widget.lastDate?.year ?? 2100;
    
    // Calculate initial scroll offset
    // 4 columns, each row is 50px high, plus spacing. Let's just estimate roughly
    int rowCount = ((_selectedYear - _startYear) / 4).floor();
    _scrollController = ScrollController(initialScrollOffset: rowCount * 60.0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _toKhmerNum(int number) {
    if (!widget.useKhmer) return number.toString();
    const khmerDigits = ['០', '១', '២', '៣', '៤', '៥', '៦', '៧', '៨', '៩'];
    return number.toString().split('').map((e) => khmerDigits[int.parse(e)]).join();
  }

  @override
  Widget build(BuildContext context) {
    int totalYears = _endYear - _startYear + 1;
    
    return Container(
      width: 320,
      height: 380, // Fixed height for scrolling
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
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              widget.useKhmer ? 'ជ្រើសរើសឆ្នាំ' : 'Select Year',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F2937),
                fontFamily: widget.useKhmer ? 'Khmer OS Battambang' : null,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: totalYears,
              itemBuilder: (context, index) {
                final year = _startYear + index;
                final isSelected = year == _selectedYear;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedYear = year;
                    });
                    DateTime current = widget.initialDate ?? DateTime.now();
                    widget.onYearSelected?.call(DateTime(year, current.month, current.day));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? widget.primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        _toKhmerNum(year),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : const Color(0xFF374151),
                          fontFamily: widget.useKhmer ? 'Khmer OS Battambang' : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
