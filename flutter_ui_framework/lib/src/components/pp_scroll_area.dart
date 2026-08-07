import 'package:flutter/material.dart';

enum PPScrollAreaDirection { horizontal, vertical, both }
enum PPScrollAreaScrollbar { defaultScrollbar, thin, mac, none }

class PPScrollArea extends StatefulWidget {
  final PPScrollAreaDirection direction;
  final PPScrollAreaScrollbar scrollbar;
  final bool hideScrollbar;
  final Widget child;

  const PPScrollArea({
    super.key,
    this.direction = PPScrollAreaDirection.vertical,
    this.scrollbar = PPScrollAreaScrollbar.defaultScrollbar,
    this.hideScrollbar = false,
    required this.child,
  });

  @override
  State<PPScrollArea> createState() => _PPScrollAreaState();
}

class _PPScrollAreaState extends State<PPScrollArea> {
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  Widget _buildScrollbar(Widget child, ScrollController controller, bool isVertical) {
    if (widget.hideScrollbar || widget.scrollbar == PPScrollAreaScrollbar.none) {
      return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: child,
      );
    }

    double thickness = 6;
    Radius radius = const Radius.circular(20);
    Color color = const Color(0xFFD1D5DB);
    double crossAxisMargin = 0;
    
    switch (widget.scrollbar) {
      case PPScrollAreaScrollbar.thin:
        thickness = 2;
        radius = Radius.zero;
        color = const Color(0x33000000);
        break;
      case PPScrollAreaScrollbar.mac:
        thickness = 6;
        radius = const Radius.circular(10);
        color = const Color(0x26000000);
        crossAxisMargin = 2;
        break;
      case PPScrollAreaScrollbar.defaultScrollbar:
        break;
      default:
        break;
    }

    return RawScrollbar(
      controller: controller,
      thumbColor: color,
      thickness: thickness,
      radius: radius,
      crossAxisMargin: crossAxisMargin,
      interactive: true,
      thumbVisibility: true,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = widget.child;

    if (widget.direction == PPScrollAreaDirection.both || widget.direction == PPScrollAreaDirection.horizontal) {
      content = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _horizontalController,
        child: content,
      );
      content = _buildScrollbar(content, _horizontalController, false);
    }

    if (widget.direction == PPScrollAreaDirection.both || widget.direction == PPScrollAreaDirection.vertical) {
      content = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _verticalController,
        child: content,
      );
      content = _buildScrollbar(content, _verticalController, true);
    }

    return content;
  }
}
