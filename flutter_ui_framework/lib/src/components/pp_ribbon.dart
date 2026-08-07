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
    const Color defaultColor = Color(0xFF4B5563);
    const Color activeBgColor = Color(0xFFE0E7FF);
    const Color activeBorderColor = Color(0xFFC7D2FE);
    const Color activeColor = Color(0xFF3730A3);
    const Color hoverBgColor = Color(0xFFF3F4F6);
    
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
      height: 70,
      constraints: const BoxConstraints(minWidth: 56),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 32,
            child: Center(
              child: customIcon ??
                  (icon != null
                      ? Icon(
                          icon,
                          size: 28,
                          color: active ? activeColor : defaultColor,
                        )
                      : const SizedBox.shrink()),
            ),
          ),
          const SizedBox(height: 4),
          if (!hideLabel)
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
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
      height: 22,
      padding: EdgeInsets.symmetric(horizontal: hideLabel ? 4 : 6, vertical: 2),
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
                      size: 18,
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
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              height: 70, // Fits exactly 3 small buttons (22*3 + 4 spacing = 70) or 1 large button (70)
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
            bottom: 2,
            left: 0,
            right: 0,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF9CA3AF),
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

  const PPRibbon({
    Key? key,
    this.initialActiveTabId,
    this.collapsible = true,
    required this.tabs,
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
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabs.isEmpty) return const SizedBox.shrink();

    final activeTab = widget.tabs.firstWhere((t) => t.id == _activeTabId, orElse: () => widget.tabs.first);

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header / Tab bar
          Container(
            padding: const EdgeInsets.only(top: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
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
                color: Colors.white,
                border: Border(
                  top: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
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

    return GestureDetector(
      onTap: () => _handleTabClick(tab.id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : (isSpecial ? tab.color!.withOpacity(0.1) : Colors.transparent),
          // Using a unified border definition to bypass a known Flutter Web rendering glitch
          border: isActive 
              ? const Border(
                  top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                  left: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                  right: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                )
              : const Border(
                  bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
        margin: const EdgeInsets.only(left: 4),
        child: Text(
          tab.title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600, // Reverting to Semi-Bold
            color: isActive ? const Color(0xFF111827) : (isSpecial ? tab.color! : const Color(0xFF6B7280)),
          ),
        ),
      ),
    );
  }
}
