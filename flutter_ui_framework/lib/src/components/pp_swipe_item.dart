import 'package:flutter/material.dart';

class PPSwipeAction extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const PPSwipeAction({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

class PPSwipeItem extends StatefulWidget {
  final Widget child;
  final List<PPSwipeAction>? leftActions;
  final List<PPSwipeAction>? rightActions;
  final double actionWidth;
  final bool closeOnActionTap;

  const PPSwipeItem({
    super.key,
    required this.child,
    this.leftActions,
    this.rightActions,
    this.actionWidth = 80.0,
    this.closeOnActionTap = true,
  });

  @override
  State<PPSwipeItem> createState() => PPSwipeItemState();
}

class PPSwipeItemState extends State<PPSwipeItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _dragExtent = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _controller.addListener(() {
      setState(() {
        _dragExtent = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void close() {
    _animation = Tween<double>(begin: _dragExtent, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut)
    );
    _controller.forward(from: 0.0);
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragExtent += details.delta.dx;
      
      final hasLeft = widget.leftActions != null && widget.leftActions!.isNotEmpty;
      final hasRight = widget.rightActions != null && widget.rightActions!.isNotEmpty;
      
      final maxLeft = hasLeft ? widget.leftActions!.length * widget.actionWidth : 0.0;
      final maxRight = hasRight ? widget.rightActions!.length * widget.actionWidth : 0.0;

      if (_dragExtent > 0 && !hasLeft) {
        _dragExtent = _dragExtent * 0.1; // heavy resistance
      } else if (_dragExtent < 0 && !hasRight) {
        _dragExtent = _dragExtent * 0.1;
      } else {
        if (_dragExtent > maxLeft) {
          _dragExtent = maxLeft + (_dragExtent - maxLeft) * 0.2;
        } else if (_dragExtent < -maxRight) {
          _dragExtent = -maxRight + (_dragExtent + maxRight) * 0.2;
        }
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final hasLeft = widget.leftActions != null && widget.leftActions!.isNotEmpty;
    final hasRight = widget.rightActions != null && widget.rightActions!.isNotEmpty;
    final maxLeft = hasLeft ? widget.leftActions!.length * widget.actionWidth : 0.0;
    final maxRight = hasRight ? widget.rightActions!.length * widget.actionWidth : 0.0;
    
    final threshold = 40.0;
    double targetExtent = 0.0;
    
    if (details.primaryVelocity! > 300 && hasLeft) {
      targetExtent = maxLeft;
    } else if (details.primaryVelocity! < -300 && hasRight) {
      targetExtent = -maxRight;
    } else {
      if (_dragExtent > threshold && hasLeft) {
        targetExtent = maxLeft;
      } else if (_dragExtent < -threshold && hasRight) {
        targetExtent = -maxRight;
      }
    }
    
    _animation = Tween<double>(begin: _dragExtent, end: targetExtent).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut)
    );
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F5F8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (widget.leftActions != null && widget.leftActions!.isNotEmpty)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.leftActions!.map((action) {
                    return SizedBox(
                      width: widget.actionWidth,
                      child: PPSwipeAction(
                        backgroundColor: action.backgroundColor,
                        onTap: () {
                          if (widget.closeOnActionTap) close();
                          if (action.onTap != null) action.onTap!();
                        },
                        child: action.child,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          
          if (widget.rightActions != null && widget.rightActions!.isNotEmpty)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.rightActions!.map((action) {
                    return SizedBox(
                      width: widget.actionWidth,
                      child: PPSwipeAction(
                        backgroundColor: action.backgroundColor,
                        onTap: () {
                          if (widget.closeOnActionTap) close();
                          if (action.onTap != null) action.onTap!();
                        },
                        child: action.child,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            
          GestureDetector(
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            child: Transform.translate(
              offset: Offset(_dragExtent, 0),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
