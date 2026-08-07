import 'package:flutter/material.dart';
import 'pp_checkbox.dart';

class PPTransferOption {
  final String key;
  final String label;
  final bool disabled;

  const PPTransferOption({
    required this.key,
    required this.label,
    this.disabled = false,
  });
}

enum PPTransferVariant { outlined, filled, soft, elevated }
enum PPTransferDirection { horizontal, vertical }

class PPTransferList extends StatefulWidget {
  final List<String> value;
  final List<PPTransferOption> data;
  final ValueChanged<List<String>>? onChanged;
  final List<String> titles;
  final PPTransferVariant variant;
  final PPTransferDirection direction;
  final bool disabled;

  const PPTransferList({
    Key? key,
    required this.value,
    required this.data,
    this.onChanged,
    this.titles = const ['Source', 'Target'],
    this.variant = PPTransferVariant.outlined,
    this.direction = PPTransferDirection.horizontal,
    this.disabled = false,
  }) : super(key: key);

  @override
  State<PPTransferList> createState() => _PPTransferListState();
}

class _PPTransferListState extends State<PPTransferList> {
  final Set<String> _leftChecked = {};
  final Set<String> _rightChecked = {};

  List<PPTransferOption> get _leftData {
    return widget.data.where((item) => !widget.value.contains(item.key)).toList();
  }

  List<PPTransferOption> get _rightData {
    return widget.data.where((item) => widget.value.contains(item.key)).toList();
  }

  void _moveToRight() {
    if (widget.disabled || _leftChecked.isEmpty) return;
    final newValue = List<String>.from(widget.value)..addAll(_leftChecked);
    widget.onChanged?.call(newValue);
    setState(() {
      _leftChecked.clear();
    });
  }

  void _moveToLeft() {
    if (widget.disabled || _rightChecked.isEmpty) return;
    final newValue = widget.value.where((key) => !_rightChecked.contains(key)).toList();
    widget.onChanged?.call(newValue);
    setState(() {
      _rightChecked.clear();
    });
  }

  BoxDecoration _getPanelDecoration(ThemeData theme) {
    switch (widget.variant) {
      case PPTransferVariant.outlined:
        return BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(12),
        );
      case PPTransferVariant.filled:
        return BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        );
      case PPTransferVariant.soft:
        return BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(12),
        );
      case PPTransferVariant.elevated:
        return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              offset: Offset(0, 4),
              blurRadius: 20,
            ),
          ],
        );
    }
  }

  Widget _buildPanel({
    required String title,
    required List<PPTransferOption> items,
    required Set<String> checkedSet,
    required ThemeData theme,
  }) {
    final activeCount = items.where((i) => !i.disabled).length;
    final allChecked = activeCount > 0 && checkedSet.length == activeCount;
    final indeterminate = checkedSet.isNotEmpty && checkedSet.length < activeCount;
    final isSoft = widget.variant == PPTransferVariant.soft;

    return Container(
      width: widget.direction == PPTransferDirection.horizontal ? 200 : double.infinity,
      height: widget.direction == PPTransferDirection.horizontal ? 320 : 250,
      decoration: _getPanelDecoration(theme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSoft ? const Color(0xFFDBEAFE) : Colors.transparent,
              border: isSoft ? null : const Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: Row(
              children: [
                PPCheckbox(
                  value: allChecked,
                  // We don't have indeterminate on PPCheckbox usually, so just use standard checkbox styling or custom
                  onChanged: (val) {
                    if (widget.disabled || activeCount == 0) return;
                    setState(() {
                      if (val == true) {
                        checkedSet.addAll(items.where((i) => !i.disabled).map((i) => i.key));
                      } else {
                        checkedSet.clear();
                      }
                    });
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSoft ? const Color(0xFF1E3A8A) : const Color(0xFF111827),
                    ),
                  ),
                ),
                Text(
                  '${checkedSet.length} / ${items.length}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.layers_outlined, color: Color(0xFF9CA3AF), size: 32),
                        SizedBox(height: 8),
                        Text('No Data', style: TextStyle(color: Color(0xFF9CA3AF))),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isChecked = checkedSet.contains(item.key);
                      final itemDisabled = widget.disabled || item.disabled;

                      return InkWell(
                        onTap: itemDisabled
                            ? null
                            : () {
                                setState(() {
                                  if (isChecked) {
                                    checkedSet.remove(item.key);
                                  } else {
                                    checkedSet.add(item.key);
                                  }
                                });
                              },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          color: isSoft && isChecked ? const Color(0x1A3B82F6) : Colors.transparent,
                          child: Row(
                            children: [
                              PPCheckbox(
                                value: isChecked,
                                onChanged: itemDisabled
                                    ? null
                                    : (val) {
                                        setState(() {
                                          if (val == true) {
                                            checkedSet.add(item.key);
                                          } else {
                                            checkedSet.remove(item.key);
                                          }
                                        });
                                      },
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.label,
                                  style: TextStyle(
                                    color: itemDisabled
                                        ? const Color(0xFF9CA3AF)
                                        : (isSoft ? const Color(0xFF1E40AF) : const Color(0xFF374151)),
                                  ),
                                ),
                              ),
                            ],
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHorizontal = widget.direction == PPTransferDirection.horizontal;
    
    Widget actions = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isHorizontal ? 16 : 0,
        vertical: isHorizontal ? 0 : 16,
      ),
      child: isHorizontal
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActionBtn(Icons.chevron_right, _leftChecked.isNotEmpty, _moveToRight, theme),
                const SizedBox(height: 12),
                _buildActionBtn(Icons.chevron_left, _rightChecked.isNotEmpty, _moveToLeft, theme),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActionBtn(Icons.expand_more, _leftChecked.isNotEmpty, _moveToRight, theme),
                const SizedBox(width: 12),
                _buildActionBtn(Icons.expand_less, _rightChecked.isNotEmpty, _moveToLeft, theme),
              ],
            ),
    );

    if (isHorizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPanel(
            title: widget.titles.isNotEmpty ? widget.titles[0] : 'Source',
            items: _leftData,
            checkedSet: _leftChecked,
            theme: theme,
          ),
          actions,
          _buildPanel(
            title: widget.titles.length > 1 ? widget.titles[1] : 'Target',
            items: _rightData,
            checkedSet: _rightChecked,
            theme: theme,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildPanel(
            title: widget.titles.isNotEmpty ? widget.titles[0] : 'Source',
            items: _leftData,
            checkedSet: _leftChecked,
            theme: theme,
          ),
          actions,
          _buildPanel(
            title: widget.titles.length > 1 ? widget.titles[1] : 'Target',
            items: _rightData,
            checkedSet: _rightChecked,
            theme: theme,
          ),
        ],
      );
    }
  }

  Widget _buildActionBtn(IconData icon, bool active, VoidCallback onPressed, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: active ? theme.primaryColor : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: active ? Colors.white : const Color(0xFFD1D5DB)),
        onPressed: widget.disabled || !active ? null : onPressed,
      ),
    );
  }
}
