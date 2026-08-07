import 'package:flutter/material.dart';
import 'pp_fab_action.dart';

enum PPFabVariant { solid, soft, outline }
enum PPFabColor { primary, secondary, danger }
enum PPFabShape { circle, rounded, square }

class PPFab extends StatefulWidget {
  final IconData? icon;
  final String? label;
  final VoidCallback? onPressed;
  final PPFabVariant variant;
  final PPFabColor color;
  final PPFabShape shape;
  final bool extended;
  final List<PPFabAction> actions;

  const PPFab({
    Key? key,
    this.icon,
    this.label,
    this.onPressed,
    this.variant = PPFabVariant.solid,
    this.color = PPFabColor.primary,
    this.shape = PPFabShape.circle,
    this.extended = false,
    this.actions = const [],
  }) : super(key: key);

  @override
  State<PPFab> createState() => _PPFabState();
}

class _PPFabState extends State<PPFab> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  Color _getBackgroundColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (widget.variant) {
      case PPFabVariant.solid:
        return widget.color == PPFabColor.primary
            ? theme.primaryColor
            : widget.color == PPFabColor.danger
                ? Colors.red
                : Colors.grey.shade800;
      case PPFabVariant.soft:
        return widget.color == PPFabColor.primary
            ? theme.primaryColor.withOpacity(0.15)
            : widget.color == PPFabColor.danger
                ? Colors.red.withOpacity(0.15)
                : Colors.grey.withOpacity(0.15);
      case PPFabVariant.outline:
        return Colors.white;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (widget.variant) {
      case PPFabVariant.solid:
        return Colors.white;
      case PPFabVariant.soft:
      case PPFabVariant.outline:
        return widget.color == PPFabColor.primary
            ? theme.primaryColor
            : widget.color == PPFabColor.danger
                ? Colors.red
                : Colors.grey.shade800;
    }
  }

  OutlinedBorder _getShape(Color fgColor) {
    final radius = widget.shape == PPFabShape.circle
        ? 28.0
        : widget.shape == PPFabShape.square
            ? 8.0
            : 16.0;

    if (widget.variant == PPFabVariant.outline) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: fgColor, width: 2),
      );
    }
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getBackgroundColor(context);
    final fgColor = _getForegroundColor(context);
    final isSpeedDial = widget.actions.isNotEmpty;
    final shape = _getShape(fgColor);

    final Widget iconWidget = isSpeedDial
        ? AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animationController.value * 0.785398, // 45 degrees
                child: Icon(widget.icon ?? Icons.add),
              );
            },
          )
        : (widget.icon != null ? Icon(widget.icon) : const SizedBox.shrink());

    Widget fab;
    if (widget.extended && widget.label != null) {
      fab = FloatingActionButton.extended(
        heroTag: null,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: widget.variant == PPFabVariant.solid ? 4 : 0,
        highlightElevation: widget.variant == PPFabVariant.solid ? 8 : 0,
        hoverElevation: widget.variant == PPFabVariant.solid ? 6 : 0,
        focusElevation: widget.variant == PPFabVariant.solid ? 6 : 0,
        disabledElevation: 0,
        shape: shape,
        onPressed: isSpeedDial ? _toggle : widget.onPressed,
        icon: iconWidget,
        label: Text(widget.label!, style: const TextStyle(fontWeight: FontWeight.w600)),
      );
    } else {
      fab = FloatingActionButton(
        heroTag: null,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: widget.variant == PPFabVariant.solid ? 4 : 0,
        highlightElevation: widget.variant == PPFabVariant.solid ? 8 : 0,
        hoverElevation: widget.variant == PPFabVariant.solid ? 6 : 0,
        focusElevation: widget.variant == PPFabVariant.solid ? 6 : 0,
        disabledElevation: 0,
        shape: shape,
        onPressed: isSpeedDial ? _toggle : widget.onPressed,
        child: iconWidget,
      );
    }

    if (!isSpeedDial) {
      return fab;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizeTransition(
          sizeFactor: _expandAnimation,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: widget.actions,
            ),
          ),
        ),
        fab,
      ],
    );
  }
}
