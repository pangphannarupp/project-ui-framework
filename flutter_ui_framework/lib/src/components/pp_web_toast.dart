import 'package:flutter/material.dart';
import 'dart:async';

enum PPWebToastType { success, error, warning, info }
enum PPWebToastPosition { topRight, topLeft, bottomRight, bottomLeft, topCenter, bottomCenter }

class PPWebToast {
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    PPWebToastType type = PPWebToastType.info,
    PPWebToastPosition position = PPWebToastPosition.topRight,
    Duration duration = const Duration(milliseconds: 3000),
    bool closable = true,
  }) {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;
    
    overlayEntry = OverlayEntry(
      builder: (context) {
        return _PPWebToastWidget(
          message: message,
          title: title,
          type: type,
          position: position,
          duration: duration,
          closable: closable,
          onClose: () {
            overlayEntry.remove();
          },
        );
      },
    );

    overlayState.insert(overlayEntry);
  }
}

class _PPWebToastWidget extends StatefulWidget {
  final String message;
  final String? title;
  final PPWebToastType type;
  final PPWebToastPosition position;
  final Duration duration;
  final bool closable;
  final VoidCallback onClose;

  const _PPWebToastWidget({
    required this.message,
    this.title,
    required this.type,
    required this.position,
    required this.duration,
    required this.closable,
    required this.onClose,
  });

  @override
  State<_PPWebToastWidget> createState() => _PPWebToastWidgetState();
}

class _PPWebToastWidgetState extends State<_PPWebToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  Timer? _timer;
  bool _isClosing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    Offset beginOffset;
    if (widget.position == PPWebToastPosition.topRight || widget.position == PPWebToastPosition.topLeft || widget.position == PPWebToastPosition.topCenter) {
      beginOffset = const Offset(0, -0.5);
    } else {
      beginOffset = const Offset(0, 0.5);
    }
    
    _slide = Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    if (widget.duration.inMilliseconds > 0) {
      _timer = Timer(widget.duration, _close);
    }
  }

  void _close() {
    if (_isClosing) return;
    _isClosing = true;
    _timer?.cancel();
    if (mounted) {
      _controller.reverse().then((_) {
        if (mounted) widget.onClose();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color typeColor;
    IconData typeIcon;
    
    switch (widget.type) {
      case PPWebToastType.success:
        typeColor = const Color(0xFF4CAF50);
        typeIcon = Icons.check_circle_outline;
        break;
      case PPWebToastType.error:
        typeColor = const Color(0xFFF44336);
        typeIcon = Icons.error_outline;
        break;
      case PPWebToastType.warning:
        typeColor = const Color(0xFFFF9800);
        typeIcon = Icons.warning_amber_rounded;
        break;
      case PPWebToastType.info:
      default:
        typeColor = const Color(0xFF0066CC);
        typeIcon = Icons.info_outline;
        break;
    }

    Alignment alignment;
    switch (widget.position) {
      case PPWebToastPosition.topRight:
        alignment = Alignment.topRight;
        break;
      case PPWebToastPosition.topLeft:
        alignment = Alignment.topLeft;
        break;
      case PPWebToastPosition.bottomRight:
        alignment = Alignment.bottomRight;
        break;
      case PPWebToastPosition.bottomLeft:
        alignment = Alignment.bottomLeft;
        break;
      case PPWebToastPosition.topCenter:
        alignment = Alignment.topCenter;
        break;
      case PPWebToastPosition.bottomCenter:
        alignment = Alignment.bottomCenter;
        break;
    }

    return SafeArea(
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SlideTransition(
            position: _slide,
            child: FadeTransition(
              opacity: _opacity,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(color: Color(0x1F000000), blurRadius: 24, offset: Offset(0, 8))
                    ],
                    border: Border(left: BorderSide(color: typeColor, width: 4)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(typeIcon, color: typeColor, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.title != null) ...[
                              Text(
                                widget.title!,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFF333333)),
                              ),
                              const SizedBox(height: 4),
                            ],
                            Text(
                              widget.message,
                              style: const TextStyle(fontSize: 14, color: Color(0xFF666666), height: 1.4),
                            ),
                          ],
                        ),
                      ),
                      if (widget.closable) ...[
                        const SizedBox(width: 12),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _close,
                            child: const Icon(Icons.close, color: Color(0xFF999999), size: 20),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
