import 'package:flutter/material.dart';

class PPScrollSegmentButton<T> {
  final T value;
  final String label;
  final Widget? icon;

  PPScrollSegmentButton({
    required this.value,
    required this.label,
    this.icon,
  });
}

class PPScrollSegment<T> extends StatefulWidget {
  final T value;
  final List<PPScrollSegmentButton<T>> items;
  final ValueChanged<T> onChanged;

  const PPScrollSegment({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  State<PPScrollSegment<T>> createState() => _PPScrollSegmentState<T>();
}

class _PPScrollSegmentState<T> extends State<PPScrollSegment<T>> {
  final ScrollController _scrollController = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkScroll());
  }

  @override
  void didUpdateWidget(covariant PPScrollSegment<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkScroll());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _checkScroll() {
    if (!_scrollController.hasClients) return;
    
    final canScrollLeft = _scrollController.position.pixels > 0;
    final canScrollRight = _scrollController.position.pixels < _scrollController.position.maxScrollExtent;
    
    if (canScrollLeft != _canScrollLeft || canScrollRight != _canScrollRight) {
      setState(() {
        _canScrollLeft = canScrollLeft;
        _canScrollRight = canScrollRight;
      });
    }
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      (_scrollController.offset - 150).clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      (_scrollController.offset + 150).clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        NotificationListener<ScrollMetricsNotification>(
          onNotification: (notification) {
            WidgetsBinding.instance.addPostFrameCallback((_) => _checkScroll());
            return false;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.items.map((item) {
                final isActive = item.value == widget.value;
                return Padding(
                  padding: EdgeInsets.only(right: item == widget.items.last ? 0 : 12),
                  child: InkWell(
                    onTap: () => widget.onChanged(item.value),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFF1A2A5E) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isActive ? const Color(0xFF1A2A5E) : const Color(0xFFEAEAEA),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.icon != null) ...[
                            IconTheme(
                              data: IconThemeData(
                                color: isActive ? Colors.white : const Color(0xFF3B63CC),
                                size: 14,
                              ),
                              child: item.icon!,
                            ),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            item.label,
                            style: TextStyle(
                              color: isActive ? Colors.white : const Color(0xFF3B63CC),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        
        if (_canScrollLeft)
          Positioned(
            left: 0,
            child: _buildArrowButton(Icons.chevron_left, _scrollLeft),
          ),
          
        if (_canScrollRight)
          Positioned(
            right: 0,
            child: _buildArrowButton(Icons.chevron_right, _scrollRight),
          ),
      ],
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onTap) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color(0x26000000), blurRadius: 8, offset: Offset(0, 2))
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Icon(icon, size: 20, color: const Color(0xFF666666)),
        ),
      ),
    );
  }
}
