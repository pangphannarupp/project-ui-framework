import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:typed_data';
import 'package:desktop_drop/desktop_drop.dart';

enum PPFileUploadStatus { pending, uploading, success, error }

class PPFileItem {
  final String id;
  final String name;
  final int size;
  final double progress;
  final PPFileUploadStatus status;
  final String? errorMessage;
  final dynamic file;
  final String? previewUrl;
  final Uint8List? bytes;

  const PPFileItem({
    required this.id,
    required this.name,
    this.size = 0,
    this.progress = 0.0,
    this.status = PPFileUploadStatus.pending,
    this.errorMessage,
    this.file,
    this.previewUrl,
    this.bytes,
  });
}

class PPFileUpload extends StatelessWidget {
  final List<PPFileItem> files;
  final bool multiple;
  final String? accept;
  final int? maxSize;
  final bool disabled;
  final VoidCallback? onDropzoneTap;
  final ValueChanged<List<dynamic>>? onDrop;
  final ValueChanged<PPFileItem>? onPreview;
  final ValueChanged<String>? onRemove;
  final ValueChanged<String>? onRetry;

  const PPFileUpload({
    Key? key,
    this.files = const [],
    this.multiple = false,
    this.accept,
    this.maxSize,
    this.disabled = false,
    this.onDropzoneTap,
    this.onDrop,
    this.onPreview,
    this.onRemove,
    this.onRetry,
  }) : super(key: key);

  String _formatBytes(int bytes) {
    if (bytes == 0) return '0 B';
    const k = 1024;
    const sizes = ['B', 'KB', 'MB', 'GB', 'TB'];
    final i = (bytes == 0) ? 0 : (bytes.toDouble() > 0 ? (bytes.toDouble().abs().toStringAsFixed(0).length - 1) ~/ 3 : 0);
    // basic approximation for dart
    int idx = 0;
    double val = bytes.toDouble();
    while (val >= k && idx < sizes.length - 1) {
      val /= k;
      idx++;
    }
    return '${val.toStringAsFixed(1)} ${sizes[idx]}';
  }

  bool _isImage(PPFileItem file) {
    if (file.previewUrl != null || file.bytes != null) return true;
    final ext = file.name.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _DropzoneArea(
          disabled: disabled,
          accept: accept,
          maxSize: maxSize,
          onTap: onDropzoneTap,
          onDrop: onDrop,
          formatBytes: _formatBytes,
        ),
        if (files.isNotEmpty) ...[
          const SizedBox(height: 16),
          ...files.map((file) => _FileListItem(
                file: file,
                isImage: _isImage(file),
                formatBytes: _formatBytes,
                onPreview: onPreview,
                onRemove: onRemove,
                onRetry: onRetry,
              )),
        ],
      ],
    );
  }
}

class _DropzoneArea extends StatefulWidget {
  final bool disabled;
  final String? accept;
  final int? maxSize;
  final VoidCallback? onTap;
  final ValueChanged<List<dynamic>>? onDrop;
  final String Function(int) formatBytes;

  const _DropzoneArea({
    Key? key,
    required this.disabled,
    this.accept,
    this.maxSize,
    this.onTap,
    this.onDrop,
    required this.formatBytes,
  }) : super(key: key);

  @override
  State<_DropzoneArea> createState() => _DropzoneAreaState();
}

class _DropzoneAreaState extends State<_DropzoneArea> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.disabled || widget.onTap == null;

    Color borderColor = const Color(0xFFE0E0E0);
    Color bgColor = const Color(0xFFFAFAFA);
    if (isDisabled) {
      bgColor = const Color(0xFFF5F5F5);
    } else if (_isHovering) {
      borderColor = const Color(0xFF003399);
      bgColor = const Color(0xFF003399).withOpacity(0.02);
    }

    return DropTarget(
      onDragEntered: (details) {
        if (isDisabled) return;
        setState(() => _isHovering = true);
      },
      onDragExited: (details) {
        if (isDisabled) return;
        setState(() => _isHovering = false);
      },
      onDragDone: (details) {
        if (isDisabled) return;
        setState(() => _isHovering = false);
        if (widget.onDrop != null) {
          widget.onDrop!(details.files);
        } else if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: MouseRegion(
        onEnter: isDisabled ? null : (_) => setState(() => _isHovering = true),
        onExit: isDisabled ? null : (_) => setState(() => _isHovering = false),
        cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
        child: GestureDetector(
          onTap: isDisabled ? null : widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: borderColor,
                width: _isHovering ? 2 : 1,
                style: _isHovering ? BorderStyle.solid : BorderStyle.none,
              ),
            ),
            child: CustomPaint(
              painter: _isHovering ? null : _DashedBorderPainter(color: borderColor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.upload_file,
                    size: 32,
                    color: isDisabled ? const Color(0xFFBDBDBD) : const Color(0xFF003399),
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        color: isDisabled ? const Color(0xFF9E9E9E) : const Color(0xFF333333),
                      ),
                      children: [
                        TextSpan(
                          text: 'Click to upload',
                          style: TextStyle(
                            color: isDisabled ? const Color(0xFF9E9E9E) : const Color(0xFF003399),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(text: ' or drag and drop'),
                      ],
                    ),
                  ),
                  if (widget.accept != null || widget.maxSize != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      () {
                        final acceptStr = widget.accept?.replaceAll(',', ', ') ?? '';
                        if (widget.accept != null && widget.maxSize != null) {
                          return '$acceptStr (Max: ${widget.formatBytes(widget.maxSize!)})';
                        } else if (widget.maxSize != null) {
                          return 'Max: ${widget.formatBytes(widget.maxSize!)}';
                        } else {
                          return acceptStr;
                        }
                      }(),
                      style: TextStyle(
                        fontSize: 12,
                        color: isDisabled ? const Color(0xFFBDBDBD) : const Color(0xFF757575),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;

  _DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(8)));

    final dashPath = Path();
    const dashWidth = 10.0;
    const dashSpace = 6.0;
    var distance = 0.0;

    for (final pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
      distance = 0.0;
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _FileListItem extends StatelessWidget {
  final PPFileItem file;
  final bool isImage;
  final String Function(int) formatBytes;
  final ValueChanged<PPFileItem>? onPreview;
  final ValueChanged<String>? onRemove;
  final ValueChanged<String>? onRetry;

  const _FileListItem({
    required this.file,
    required this.isImage,
    required this.formatBytes,
    this.onPreview,
    this.onRemove,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final bool isError = file.status == PPFileUploadStatus.error;
    final bool isUploading = file.status == PPFileUploadStatus.uploading;
    final bool isSuccess = file.status == PPFileUploadStatus.success;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isError ? const Color(0xFFFEEBEE) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isError ? const Color(0xFFF44336).withOpacity(0.3) : const Color(0xFFE0E0E0),
        ),
      ),
      child: InkWell(
        onTap: onPreview != null ? () => onPreview!(file) : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon or Image
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: (isImage && (file.previewUrl != null || file.bytes != null)) ? Colors.transparent : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(6),
                ),
                clipBehavior: Clip.antiAlias,
                child: (isImage && (file.previewUrl != null || file.bytes != null))
                    ? (file.bytes != null
                        ? Image.memory(file.bytes!, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.insert_drive_file, color: Color(0xFF9E9E9E)))
                        : Image.network(file.previewUrl!, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.insert_drive_file, color: Color(0xFF9E9E9E))))
                    : const Icon(Icons.insert_drive_file, color: Color(0xFF9E9E9E)),
              ),
              const SizedBox(width: 12),
              
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            file.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isError ? const Color(0xFFD32F2F) : const Color(0xFF333333),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isUploading ? '\${file.progress.round()}%' : formatBytes(file.size),
                          style: const TextStyle(fontSize: 12, color: Color(0xFF757575)),
                        ),
                      ],
                    ),
                    if (isUploading) ...[
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: file.progress / 100,
                        backgroundColor: const Color(0xFFE0E0E0),
                        color: const Color(0xFF003399),
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                    if (isError && file.errorMessage != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        file.errorMessage!,
                        style: const TextStyle(fontSize: 12, color: Color(0xFFD32F2F)),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              
              // Actions
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isError && onRetry != null)
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Color(0xFF757575), size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashRadius: 20,
                      onPressed: () => onRetry!(file.id),
                    ),
                  if (isSuccess)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 20),
                    ),
                  if (onRemove != null)
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF757575), size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashRadius: 20,
                      onPressed: () => onRemove!(file.id),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
