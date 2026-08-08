import 'package:flutter/material.dart';

enum PPRibbonButtonSize { large, small }

class PPRibbonButton extends StatefulWidget {
  final String label;
  final bool hideLabel;
  final IconData? icon;
  final Widget? customIcon;
  final PPRibbonButtonSize size;
  final bool active;
  final bool disabled;
  final VoidCallback? onPressed;

  const PPRibbonButton({
    Key? key,
    required this.label,
    this.hideLabel = false,
    this.icon,
    this.customIcon,
    this.size = PPRibbonButtonSize.large,
    this.active = false,
    this.disabled = false,
    this.onPressed,
  }) : super(key: key);

  @override
  State<PPRibbonButton> createState() => _PPRibbonButtonState();
}

class _PPRibbonButtonState extends State<PPRibbonButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Styling constants
    final Color defaultColor = isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151);
    final Color activeBgColor = isDark ? const Color(0xFF3E3E42) : const Color(0xFFE2E8F0); // Flat subtle background
    const Color activeBorderColor = Colors.transparent; // No border for a flat look
    final Color activeColor = isDark ? Colors.white : const Color(0xFF185ABD); // Word Blue
    final Color hoverBgColor = isDark ? const Color(0xFF3E3E42) : const Color(0xFFE2E8F0); // Flat subtle hover
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.disabled ? null : widget.onPressed,
        onTapDown: widget.disabled ? null : (_) => setState(() => _isPressed = true),
        onTapUp: widget.disabled ? null : (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        borderRadius: BorderRadius.circular(4),
        hoverColor: hoverBgColor,
        splashColor: activeBgColor,
        child: AnimatedScale(
          scale: _isPressed && !widget.disabled ? 0.90 : 1.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: Opacity(
            opacity: widget.disabled ? 0.4 : 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: widget.active ? activeBgColor : Colors.transparent,
                border: Border.all(
                  color: widget.active ? activeBorderColor : Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: widget.size == PPRibbonButtonSize.large
                  ? _buildLargeLayout(defaultColor, activeColor)
                  : _buildSmallLayout(defaultColor, activeColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLargeLayout(Color defaultColor, Color activeColor) {
    return Container(
      height: 76,
      constraints: const BoxConstraints(minWidth: 64),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 34,
            child: Center(
              child: widget.customIcon ??
                  (widget.icon != null
                      ? Icon(
                          widget.icon,
                          size: 30,
                          color: widget.active ? activeColor : defaultColor,
                        )
                      : const SizedBox.shrink()),
            ),
          ),
          const SizedBox(height: 6),
          if (!widget.hideLabel)
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: widget.active ? activeColor : defaultColor,
                height: 1.1,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSmallLayout(Color defaultColor, Color activeColor) {
    return Container(
      height: 24,
      padding: EdgeInsets.symmetric(horizontal: widget.hideLabel ? 4 : 8, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.customIcon != null || widget.icon != null)
            SizedBox(
              width: 18,
              height: 18,
              child: Center(
                child: widget.customIcon ??
                    Icon(
                      widget.icon,
                      size: 16,
                      color: widget.active ? activeColor : defaultColor,
                    ),
              ),
            ),
          if (!widget.hideLabel) ...[
            if (widget.customIcon != null || widget.icon != null) const SizedBox(width: 6),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                color: widget.active ? activeColor : defaultColor,
                height: 1.1,
                fontWeight: widget.active ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class PPRibbonGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const PPRibbonGroup({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: isDark ? const Color(0xFF3E3E42) : const Color(0xFFE5E7EB), width: 1),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: SizedBox(
              height: 76, // Fits 1 large (76) or 3 small (24*3 + 4 spacing = 76)
              child: Wrap(
                direction: Axis.vertical,
                spacing: 2,
                runSpacing: 2,
                alignment: WrapAlignment.start,
                children: children.map((w) => Padding(padding: const EdgeInsets.symmetric(horizontal: 1), child: w)).toList(),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            left: 0,
            right: 0,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PPRibbonTab {
  final String id;
  final String title;
  final Color? color;
  final List<PPRibbonGroup> groups;

  const PPRibbonTab({
    required this.id,
    required this.title,
    this.color,
    required this.groups,
  });
}

class PPRibbon extends StatefulWidget {
  final String? initialActiveTabId;
  final bool collapsible;
  final List<PPRibbonTab> tabs;
  final ValueChanged<String>? onTabChanged;

  const PPRibbon({
    Key? key,
    this.initialActiveTabId,
    this.collapsible = true,
    required this.tabs,
    this.onTabChanged,
  }) : super(key: key);

  @override
  State<PPRibbon> createState() => _PPRibbonState();
}

class _PPRibbonState extends State<PPRibbon> {
  late String _activeTabId;
  bool _isCollapsed = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _activeTabId = widget.initialActiveTabId ?? (widget.tabs.isNotEmpty ? widget.tabs.first.id : '');
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleTabClick(String id) {
    setState(() {
      if (_activeTabId == id && widget.collapsible) {
        _isCollapsed = !_isCollapsed;
      } else {
        _activeTabId = id;
        _isCollapsed = false;
      }
    });
    if (widget.onTabChanged != null) {
      widget.onTabChanged!(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabs.isEmpty) return const SizedBox.shrink();

    final activeTab = widget.tabs.firstWhere((t) => t.id == _activeTabId, orElse: () => widget.tabs.first);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white, 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header / Tab bar
          Container(
            padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF185ABD), // Modern Word Blue
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: widget.tabs.map((tab) => _buildTabHeader(tab)).toList(),
                    ),
                  ),
                ),
                if (widget.collapsible)
                  InkWell(
                    onTap: () => setState(() => _isCollapsed = !_isCollapsed),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        _isCollapsed ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                        size: 16,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Body (Ribbon Content)
          if (!_isCollapsed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF252526) : const Color(0xFFF3F6FB), // Little blue and flat or dark
                border: Border(
                  bottom: BorderSide(color: isDark ? const Color(0xFF3E3E42) : const Color(0xFFE2E8F0), width: 1)
                ),
              ),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: activeTab.groups.map((group) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 8),
                        child: group,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabHeader(PPRibbonTab tab) {
    final isActive = _activeTabId == tab.id;
    final isSpecial = tab.color != null;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleTabClick(tab.id),
        hoverColor: Colors.white.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? (isDark ? const Color(0xFF252526) : const Color(0xFFF3F6FB)) : (isSpecial ? tab.color! : Colors.transparent),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
          margin: const EdgeInsets.only(right: 2),
          child: Text(
            tab.title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? (isDark ? Colors.white : const Color(0xFF185ABD)) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
