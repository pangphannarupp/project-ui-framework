import 'package:flutter/material.dart';

class PPSidebarItem {
  final String id;
  final String label;
  final IconData? icon;
  final List<PPSidebarItem>? children;
  final bool disabled;

  const PPSidebarItem({
    required this.id,
    required this.label,
    this.icon,
    this.children,
    this.disabled = false,
  });
}

class PPSidebarGroup {
  final String? groupLabel;
  final List<PPSidebarItem> items;

  const PPSidebarGroup({
    this.groupLabel,
    required this.items,
  });
}

class PPSidebarNavigation extends StatefulWidget {
  final String? modelValue;
  final List<String>? expandedItems;
  final List<PPSidebarGroup> items;
  final String theme; // 'light' or 'dark'
  final String variant; // 'pill', 'indicator', 'flat', 'm3-rail'
  final bool collapsed;
  final double width;
  final double collapsedWidth;
  final ValueChanged<String>? onModelValueChanged;
  final ValueChanged<List<String>>? onExpandedItemsChanged;
  final Widget? header;
  final Widget? footer;

  const PPSidebarNavigation({
    Key? key,
    this.modelValue,
    this.expandedItems,
    required this.items,
    this.theme = 'dark',
    this.variant = 'indicator',
    this.collapsed = false,
    this.width = 260,
    this.collapsedWidth = 80,
    this.onModelValueChanged,
    this.onExpandedItemsChanged,
    this.header,
    this.footer,
  }) : super(key: key);

  @override
  State<PPSidebarNavigation> createState() => _PPSidebarNavigationState();
}

class _PPSidebarNavigationState extends State<PPSidebarNavigation> {
  late List<String> _expandedItems;
  late String? _modelValue;

  @override
  void initState() {
    super.initState();
    _expandedItems = List.from(widget.expandedItems ?? []);
    _modelValue = widget.modelValue;
    _expandParentsIfNeeded();
  }

  @override
  void didUpdateWidget(covariant PPSidebarNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expandedItems != null &&
        widget.expandedItems != oldWidget.expandedItems) {
      _expandedItems = List.from(widget.expandedItems!);
    }
    if (widget.modelValue != oldWidget.modelValue) {
      _modelValue = widget.modelValue;
      _expandParentsIfNeeded();
    }
  }

  void _expandParentsIfNeeded() {
    if (_modelValue == null) return;
    for (final group in widget.items) {
      for (final item in group.items) {
        if (item.children != null &&
            item.children!.any((child) => child.id == _modelValue)) {
          if (!_expandedItems.contains(item.id)) {
            _expandedItems.add(item.id);
            widget.onExpandedItemsChanged?.call(_expandedItems);
          }
        }
      }
    }
  }

  bool _isItemActive(PPSidebarItem item) {
    if (_modelValue == item.id) return true;
    if (item.children != null &&
        item.children!.any((child) => child.id == _modelValue)) {
      return true;
    }
    return false;
  }

  void _handleItemClick(PPSidebarItem item) {
    if (item.disabled) return;
    if (item.children != null && item.children!.isNotEmpty) {
      setState(() {
        if (_expandedItems.contains(item.id)) {
          _expandedItems.remove(item.id);
        } else {
          _expandedItems.add(item.id);
        }
      });
      widget.onExpandedItemsChanged?.call(_expandedItems);
    } else {
      setState(() {
        _modelValue = item.id;
      });
      widget.onModelValueChanged?.call(item.id);
    }
  }

  void _handleSubItemClick(PPSidebarItem sub) {
    if (sub.disabled) return;
    setState(() {
      _modelValue = sub.id;
    });
    widget.onModelValueChanged?.call(sub.id);
  }

  Color get _bgColor {
    if (widget.variant == 'm3-rail') {
      return widget.theme == 'dark' ? const Color(0xFF141218) : const Color(0xFFFDFBFF);
    }
    return widget.theme == 'dark' ? const Color(0xFF1C2434) : const Color(0xFFFFFFFF);
  }

  Color get _textColor {
    if (widget.variant == 'm3-rail') {
      return widget.theme == 'dark' ? const Color(0xFFCAC4D0) : const Color(0xFF49454F);
    }
    return widget.theme == 'dark' ? const Color(0xFF8A99AF) : const Color(0xFF64748B);
  }

  Color get _textActiveColor {
    if (widget.variant == 'm3-rail') {
      return widget.theme == 'dark' ? const Color(0xFFE6E0E9) : const Color(0xFF1D192B);
    }
    return widget.theme == 'dark' ? const Color(0xFFFFFFFF) : const Color(0xFF0F172A);
  }

  Color get _titleColor {
    return widget.theme == 'dark' ? const Color(0xFF0DCAF0) : const Color(0xFF94A3B8);
  }

  Color get _bgHover {
    if (widget.variant == 'm3-rail') {
      return widget.theme == 'dark'
          ? const Color(0xFFE6E0E9).withOpacity(0.08)
          : const Color(0xFF1D192B).withOpacity(0.08);
    }
    return widget.theme == 'dark'
        ? Colors.white.withOpacity(0.05)
        : const Color(0xFFF1F5F9);
  }

  Color get _bgActive {
    if (widget.variant == 'm3-rail') {
      return widget.theme == 'dark' ? const Color(0xFF4A4458) : const Color(0xFFE8DEF8);
    }
    return widget.theme == 'dark'
        ? const Color(0xFF0DCAF0).withOpacity(0.1)
        : const Color(0xFFEFF6FF);
  }

  Color get _accentColor {
    if (widget.variant == 'm3-rail') {
      return widget.theme == 'dark' ? const Color(0xFFE8DEF8) : const Color(0xFF1D192B);
    }
    return widget.theme == 'dark' ? const Color(0xFF0DCAF0) : const Color(0xFF3B82F6);
  }

  Color get _borderColor {
    return widget.theme == 'dark'
        ? Colors.white.withOpacity(0.05)
        : const Color(0xFFE2E8F0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.collapsed ? widget.collapsedWidth : widget.width,
      decoration: BoxDecoration(
        color: _bgColor,
        border: widget.variant == 'm3-rail'
            ? null
            : Border(right: BorderSide(color: _borderColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.header != null)
            Padding(
              padding: EdgeInsets.all(widget.collapsed ? 16.0 : 24.0),
              child: Align(
                alignment: widget.collapsed ? Alignment.center : Alignment.centerLeft,
                child: widget.header!,
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return _buildGroup(widget.items[index]);
              },
            ),
          ),
          if (widget.footer != null)
            Container(
              padding: EdgeInsets.all(widget.collapsed ? 16.0 : 16.0),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: _borderColor)),
              ),
              child: Align(
                alignment: widget.collapsed ? Alignment.center : Alignment.centerLeft,
                child: widget.footer!,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGroup(PPSidebarGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (group.groupLabel != null && !widget.collapsed && widget.variant != 'm3-rail')
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 8),
            child: Text(
              group.groupLabel!.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: _titleColor,
              ),
            ),
          ),
        ...group.items.map((item) => _buildItemWrapper(item)),
      ],
    );
  }

  Widget _buildItemWrapper(PPSidebarItem item) {
    final isActive = _isItemActive(item);
    final isExpanded = _expandedItems.contains(item.id);
    final hasChildren = item.children != null && item.children!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildItem(item, isActive, hasChildren, isExpanded),
        if (hasChildren && !widget.collapsed && isExpanded && widget.variant != 'm3-rail')
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: item.children!
                .map((sub) => _buildSubItem(sub, _modelValue == sub.id))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildItem(
      PPSidebarItem item, bool isActive, bool hasChildren, bool isExpanded) {
    final isM3Rail = widget.variant == 'm3-rail';
    final isPill = widget.variant == 'pill';

    EdgeInsetsGeometry padding = widget.collapsed
        ? const EdgeInsets.symmetric(vertical: 12)
        : const EdgeInsets.symmetric(vertical: 12, horizontal: 24);

    if (isM3Rail) {
      padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 4);
    } else if (isPill) {
      padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 12);
    }

    EdgeInsetsGeometry margin = EdgeInsets.zero;
    if (isM3Rail) {
      margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 4);
    } else if (isPill) {
      margin = EdgeInsets.symmetric(horizontal: widget.collapsed ? 8 : 12);
    }

    return Opacity(
      opacity: item.disabled ? 0.5 : 1.0,
      child: IgnorePointer(
        ignoring: item.disabled,
        child: Container(
          margin: margin,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _handleItemClick(item),
              hoverColor: _bgHover,
              borderRadius: isPill || isM3Rail ? BorderRadius.circular(isM3Rail ? 16 : 8) : null,
              child: Container(
                padding: padding,
                decoration: _getItemDecoration(isActive, isPill, isM3Rail),
                child: Row(
                  mainAxisAlignment: widget.collapsed || isM3Rail
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    if (isM3Rail)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                            decoration: BoxDecoration(
                              color: isActive ? _bgActive : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              item.icon,
                              size: 24,
                              color: isActive ? _accentColor : _textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isActive ? _textActiveColor : _textColor,
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.icon != null) ...[
                            Icon(
                              item.icon,
                              size: widget.collapsed ? 24 : 20,
                              color: isActive
                                  ? (isPill ? Colors.white : _accentColor)
                                  : _textColor,
                            ),
                            if (!widget.collapsed) const SizedBox(width: 12),
                          ],
                          if (!widget.collapsed)
                            Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isActive
                                    ? (isPill ? Colors.white : _textActiveColor)
                                    : _textColor,
                              ),
                            ),
                        ],
                      ),
                    if (hasChildren && !widget.collapsed && !isM3Rail)
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right,
                        size: 16,
                        color: _textColor.withOpacity(0.5),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubItem(PPSidebarItem sub, bool isActive) {
    final isPill = widget.variant == 'pill';

    return Opacity(
      opacity: sub.disabled ? 0.5 : 1.0,
      child: IgnorePointer(
        ignoring: sub.disabled,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _handleSubItemClick(sub),
            hoverColor: _bgHover,
            child: Container(
              padding: EdgeInsets.only(
                left: isPill ? 56 : 56,
                top: 8,
                bottom: 8,
                right: 24,
              ),
              child: Text(
                sub.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isActive ? _accentColor : _textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration? _getItemDecoration(bool isActive, bool isPill, bool isM3Rail) {
    if (!isActive) return null;

    if (isM3Rail) {
      return null; // Inner container handles the active bg
    }
    if (isPill) {
      return BoxDecoration(
        color: _accentColor,
        borderRadius: BorderRadius.circular(8),
      );
    }
    if (widget.variant == 'flat') {
      return BoxDecoration(
        color: _bgActive,
        border: Border(right: BorderSide(color: _accentColor, width: 3)),
      );
    }
    if (widget.variant == 'indicator') {
      return BoxDecoration(
        color: _bgHover,
        border: Border(left: BorderSide(color: _accentColor, width: 3)),
      );
    }
    return null;
  }
}
