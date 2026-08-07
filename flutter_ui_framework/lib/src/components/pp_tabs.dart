import 'package:flutter/material.dart';

enum PPTabsVariant { standard, pills, segmented, outlined, minimal }

class PPTabsContext extends InheritedWidget {
  final dynamic activeTab;
  final ValueChanged<dynamic> setActiveTab;
  final PPTabsVariant variant;

  const PPTabsContext({
    super.key,
    required this.activeTab,
    required this.setActiveTab,
    required this.variant,
    required super.child,
  });

  static PPTabsContext? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PPTabsContext>();
  }

  @override
  bool updateShouldNotify(PPTabsContext oldWidget) {
    return activeTab != oldWidget.activeTab || variant != oldWidget.variant;
  }
}

class PPTabs extends StatelessWidget {
  final dynamic value;
  final ValueChanged<dynamic> onChanged;
  final PPTabsVariant variant;
  final Widget child;

  const PPTabs({
    super.key,
    required this.value,
    required this.onChanged,
    this.variant = PPTabsVariant.standard,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PPTabsContext(
      activeTab: value,
      setActiveTab: onChanged,
      variant: variant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [child],
      ),
    );
  }
}

class PPTabList extends StatelessWidget {
  final bool scrollable;
  final List<Widget> children;

  const PPTabList({
    super.key,
    this.scrollable = false,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final tabsContext = PPTabsContext.of(context);
    final isSegmented = tabsContext?.variant == PPTabsVariant.segmented;

    Widget list;
    if (isSegmented) {
      // In segmented variant, tabs should expand equally
      list = Row(
        mainAxisSize: MainAxisSize.max,
        children: children.map((c) => Expanded(child: c)).toList(),
      );
    } else {
      list = Wrap(
        spacing: 8,
        runSpacing: 8,
        children: children,
      );
    }

    if (scrollable && !isSegmented) {
      list = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: children.map((c) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: c,
          )).toList(),
        ),
      );
    }
    
    // Add bottom padding/border if standard
    if (tabsContext?.variant == PPTabsVariant.standard) {
      list = Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
        ),
        child: list,
      );
    }

    // Segmented container background
    if (isSegmented) {
      list = Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: list,
      );
    }

    return SizedBox(
      width: double.infinity,
      child: list,
    );
  }
}

class PPTab extends StatefulWidget {
  final dynamic value;
  final Widget child;

  const PPTab({
    super.key,
    required this.value,
    required this.child,
  });

  @override
  State<PPTab> createState() => _PPTabState();
}

class _PPTabState extends State<PPTab> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final tabsContext = PPTabsContext.of(context);
    final isActive = tabsContext?.activeTab == widget.value;
    final variant = tabsContext?.variant ?? PPTabsVariant.standard;

    BoxDecoration decoration;
    TextStyle textStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Color(0xFF6B7280),
    );

    // Primary Variant Color
    const Color primaryColor = Color(0xFF1A2A5E);

    switch (variant) {
      case PPTabsVariant.standard:
        decoration = BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        );
        if (isActive) {
          textStyle = textStyle.copyWith(color: primaryColor);
        } else if (_isHovering) {
          textStyle = textStyle.copyWith(color: const Color(0xFF374151));
        }
        break;

      case PPTabsVariant.pills:
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isActive ? primaryColor : (_isHovering ? const Color(0xFFF3F4F6) : Colors.transparent),
          boxShadow: isActive ? [const BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 2))] : null,
        );
        if (isActive) {
          textStyle = textStyle.copyWith(color: Colors.white);
        } else if (_isHovering) {
          textStyle = textStyle.copyWith(color: const Color(0xFF374151));
        }
        break;

      case PPTabsVariant.segmented:
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? Colors.white : (_isHovering ? const Color(0x0D000000) : Colors.transparent),
          boxShadow: isActive ? [const BoxShadow(color: Color(0x1A000000), blurRadius: 3, offset: Offset(0, 1))] : null,
        );
        if (isActive) {
          textStyle = textStyle.copyWith(color: primaryColor);
        }
        break;

      case PPTabsVariant.outlined:
        decoration = BoxDecoration(
          border: Border.all(
            color: isActive ? primaryColor : (_isHovering ? const Color(0xFF9CA3AF) : const Color(0xFFD1D5DB)),
          ),
          borderRadius: BorderRadius.circular(20),
          color: isActive ? const Color(0xFFEFF6FF) : Colors.transparent,
        );
        if (isActive) {
          textStyle = textStyle.copyWith(color: primaryColor);
        } else if (_isHovering) {
          textStyle = textStyle.copyWith(color: const Color(0xFF374151));
        }
        break;

      case PPTabsVariant.minimal:
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? const Color(0xFFF3F4F6) : Colors.transparent,
        );
        textStyle = textStyle.copyWith(
          fontWeight: FontWeight.w600,
          color: isActive ? const Color(0xFF111827) : (_isHovering ? const Color(0xFF4B5563) : const Color(0xFF9CA3AF)),
        );
        break;
    }

    Widget inner = DefaultTextStyle(
      style: textStyle,
      child: widget.child,
    );

    if (variant == PPTabsVariant.segmented) {
      inner = Center(child: inner);
    }

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: decoration,
      padding: variant == PPTabsVariant.segmented || variant == PPTabsVariant.minimal
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: inner,
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          tabsContext?.setActiveTab(widget.value);
        },
        child: content,
      ),
    );
  }
}

class PPTabPanels extends StatelessWidget {
  final List<Widget> children;

  const PPTabPanels({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

class PPTabPanel extends StatefulWidget {
  final dynamic value;
  final Widget child;

  const PPTabPanel({
    super.key,
    required this.value,
    required this.child,
  });

  @override
  State<PPTabPanel> createState() => _PPTabPanelState();
}

class _PPTabPanelState extends State<PPTabPanel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabsContext = PPTabsContext.of(context);
    final isActive = tabsContext?.activeTab == widget.value;

    if (isActive) {
      if (_controller.status != AnimationStatus.completed) {
        _controller.forward(from: 0);
      }
      return FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _slide,
          child: widget.child,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
