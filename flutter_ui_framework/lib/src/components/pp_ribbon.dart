import 'package:flutter/material.dart';

enum PPRibbonButtonSize { large, small }

class PPRibbonButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // Styling constants
    const Color defaultColor = Color(0xFF374151); // Darker, crisper gray
    const Color activeBgColor = Color(0xFFE0E7FF);
    const Color activeBorderColor = Color(0xFFC7D2FE);
    const Color activeColor = Color(0xFF3730A3);
    const Color hoverBgColor = Color(0xFFE5E7EB); // Darker hover since background is now F3F4F6
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: disabled ? null : onPressed,
        borderRadius: BorderRadius.circular(4),
        hoverColor: hoverBgColor,
        splashColor: activeBgColor,
        child: Opacity(
          opacity: disabled ? 0.4 : 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: active ? activeBgColor : Colors.transparent,
              border: Border.all(
                color: active ? activeBorderColor : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: size == PPRibbonButtonSize.large
                ? _buildLargeLayout(defaultColor, activeColor)
                : _buildSmallLayout(defaultColor, activeColor),
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
              child: customIcon ??
                  (icon != null
                      ? Icon(
                          icon,
                          size: 30,
                          color: active ? activeColor : defaultColor,
                        )
                      : const SizedBox.shrink()),
            ),
          ),
          const SizedBox(height: 6),
          if (!hideLabel)
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: active ? activeColor : defaultColor,
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
      padding: EdgeInsets.symmetric(horizontal: hideLabel ? 4 : 8, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (customIcon != null || icon != null)
            SizedBox(
              width: 18,
              height: 18,
              child: Center(
                child: customIcon ??
                    Icon(
                      icon,
                      size: 16,
                      color: active ? activeColor : defaultColor,
                    ),
              ),
            ),
          if (!hideLabel) ...[
            if (customIcon != null || icon != null) const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: active ? activeColor : defaultColor,
                height: 1.1,
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
    return Container(
      padding: const EdgeInsets.only(right: 12),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: Color(0xFFE5E7EB), width: 1),
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
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF6B7280),
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

  @override
  void initState() {
    super.initState();
    _activeTabId = widget.initialActiveTabId ?? (widget.tabs.isNotEmpty ? widget.tabs.first.id : '');
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

    return Container(
      color: const Color(0xFFF3F6FB), // Ribbon backdrop color with a subtle blue tint
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Decorative Header (simulates Word Title Bar)
          Container(
            height: 32,
            color: const Color(0xFF2B579A),
            width: double.infinity,
          ),
          // Header / Tab bar
          Container(
            padding: const EdgeInsets.only(top: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F6), // Inactive tab row background is light grey
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
                color: Colors.white, // Ribbon body is white
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  )
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: activeTab.groups.map((group) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: group,
                    );
                  }).toList(),
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleTabClick(tab.id),
        hoverColor: Colors.grey.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : (isSpecial ? tab.color! : Colors.transparent),
          ),
          margin: EdgeInsets.zero,
          child: Text(
            tab.title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive ? const Color(0xFF2B579A) : (isSpecial ? Colors.white : const Color(0xFF4B5563)),
            ),
          ),
        ),
      ),
    );
  }
}
