import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PPHideAppBar extends StatefulWidget {
  final Widget appBar;
  final Widget body;
  final Duration animationDuration;

  const PPHideAppBar({
    super.key,
    required this.appBar,
    required this.body,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<PPHideAppBar> createState() => _PPHideAppBarState();
}

class _PPHideAppBarState extends State<PPHideAppBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: 1.0,
    );
  }

  bool _handleScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.pixels <= notification.metrics.minScrollExtent) {
        if (_controller.status != AnimationStatus.forward && _controller.status != AnimationStatus.completed) {
          _controller.forward();
        }
      } else if (notification.scrollDelta != null) {
        if (notification.scrollDelta! > 0) {
          // Scrolling down -> hide
          if (_controller.status != AnimationStatus.reverse && _controller.status != AnimationStatus.dismissed) {
            _controller.reverse();
          }
        } else if (notification.scrollDelta! < 0) {
          // Scrolling up -> show
          if (_controller.status != AnimationStatus.forward && _controller.status != AnimationStatus.completed) {
            _controller.forward();
          }
        }
      }
    }
    return false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScroll,
      child: Stack(
      children: [
        widget.body,
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
              )),
              child: child,
            );
          },
          child: widget.appBar,
        ),
      ],
      ),
    );
  }
}
