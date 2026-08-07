import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'dart:typed_data';

/// A premium signature pad component that allows users to draw their signature.
class PPSignaturePad extends StatefulWidget {
  /// The color of the pen stroke.
  final Color penColor;

  /// The width of the pen stroke.
  final double penStrokeWidth;

  /// The background color of the signature pad.
  final Color backgroundColor;

  /// Callback when the signature changes (useful for enabling/disabling submit buttons).
  final VoidCallback? onChanged;

  /// The text for the clear button.
  final String clearButtonText;

  /// Controller to manipulate the signature pad externally (clear, get image).
  final PPSignaturePadController? controller;

  const PPSignaturePad({
    super.key,
    this.penColor = Colors.black,
    this.penStrokeWidth = 3.0,
    this.backgroundColor = const Color(0xFFF3F4F6),
    this.onChanged,
    this.clearButtonText = 'Clear',
    this.controller,
  });

  @override
  State<PPSignaturePad> createState() => _PPSignaturePadState();
}

class _PPSignaturePadState extends State<PPSignaturePad> {
  final _SignatureData _data = _SignatureData();
  final GlobalKey _repaintBoundaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(this);
    _data.addListener(_onDataChanged);
  }

  @override
  void didUpdateWidget(covariant PPSignaturePad oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?._detach();
      widget.controller?._attach(this);
    }
  }

  @override
  void dispose() {
    _data.removeListener(_onDataChanged);
    _data.dispose();
    widget.controller?._detach();
    super.dispose();
  }

  void _onDataChanged() {
    // Only call widget.onChanged when strokes are finalized (undo/clear/end of pan).
  }

  void _clear() {
    _data.clear();
    widget.onChanged?.call();
  }

  void _undo() {
    _data.undo();
    widget.onChanged?.call();
  }

  bool get _isEmpty => _data.isEmpty;

  Future<Uint8List?> _toPngBytes() async {
    try {
      final boundary = _repaintBoundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error converting signature to image: $e');
      return null;
    }
  }

  void _onPanStart(DragDownDetails details) {
    RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      Offset localPosition = box.globalToLocal(details.globalPosition);
      _data.startStroke(localPosition);
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      Offset localPosition = box.globalToLocal(details.globalPosition);
      _data.updateStroke(localPosition);
    }
  }

  void _onPanEnd(DragEndDetails details) {
    _data.endStroke();
    widget.onChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: RepaintBoundary(
              key: _repaintBoundaryKey,
              child: Container(
                color: widget.backgroundColor, // Ensure background is captured in PNG
                child: GestureDetector(
                  onPanDown: _onPanStart,
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: AnimatedBuilder(
                    animation: _data,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: _SignaturePainter(
                          data: _data,
                          penColor: widget.penColor,
                          penStrokeWidth: widget.penStrokeWidth,
                        ),
                        size: Size.infinite,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _data,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: _data.isEmpty ? null : _undo,
                  icon: const Icon(Icons.undo, size: 16),
                  label: const Text('Undo'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: _data.isEmpty ? null : _clear,
                  icon: const Icon(Icons.clear, size: 16),
                  label: Text(widget.clearButtonText),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red.shade400,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SignatureData extends ChangeNotifier {
  List<List<Offset>> strokes = [];
  List<Offset> currentStroke = [];

  void startStroke(Offset point) {
    currentStroke = [point];
    notifyListeners();
  }

  void updateStroke(Offset point) {
    currentStroke.add(point);
    notifyListeners();
  }

  void endStroke() {
    if (currentStroke.isNotEmpty) {
      strokes.add(List.from(currentStroke));
      currentStroke.clear();
      notifyListeners();
    }
  }

  void clear() {
    strokes.clear();
    currentStroke.clear();
    notifyListeners();
  }

  void undo() {
    if (strokes.isNotEmpty) {
      strokes.removeLast();
      notifyListeners();
    }
  }

  bool get isEmpty => strokes.isEmpty && currentStroke.isEmpty;
}

class _SignaturePainter extends CustomPainter {
  final _SignatureData data;
  final Color penColor;
  final double penStrokeWidth;

  _SignaturePainter({
    required this.data,
    required this.penColor,
    required this.penStrokeWidth,
  }) : super(repaint: data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = penColor
      ..strokeWidth = penStrokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (final stroke in data.strokes) {
      _drawStroke(canvas, stroke, paint);
    }
    
    if (data.currentStroke.isNotEmpty) {
      _drawStroke(canvas, data.currentStroke, paint);
    }
  }

  void _drawStroke(Canvas canvas, List<Offset> points, Paint paint) {
    if (points.length == 1) {
      canvas.drawPoints(ui.PointMode.points, points, paint);
    } else {
      final path = Path();
      path.moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        // Use quadratic bezier for smoother lines (optional, but standard lineTo is usually fine if sampling is high)
        path.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter oldDelegate) {
    return oldDelegate.penColor != penColor ||
           oldDelegate.penStrokeWidth != penStrokeWidth;
  }
}

/// Controller for [PPSignaturePad] to programmatically control it.
class PPSignaturePadController {
  _PPSignaturePadState? _state;

  void _attach(_PPSignaturePadState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  /// Clears the signature pad.
  void clear() {
    _state?._clear();
  }

  /// Undoes the last stroke.
  void undo() {
    _state?._undo();
  }

  /// Returns true if the signature pad has no drawings.
  bool get isEmpty => _state?._isEmpty ?? true;

  /// Returns the signature as PNG bytes.
  Future<Uint8List?> toPngBytes() async {
    return await _state?._toPngBytes();
  }
}
