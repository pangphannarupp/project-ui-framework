import 'package:flutter/material.dart';

class PPDialog extends StatelessWidget {
  final Widget? title;
  final Widget content;
  final List<Widget>? actions;
  final ShapeBorder? shape;
  final double elevation;

  const PPDialog({
    super.key,
    this.title,
    required this.content,
    this.actions,
    this.shape,
    this.elevation = 24.0,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    required Widget content,
    List<Widget>? actions,
    ShapeBorder? shape,
    double elevation = 24.0,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return PPDialog(
          title: title,
          content: content,
          actions: actions,
          shape: shape,
          elevation: elevation,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
      shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: elevation,
    );
  }
}
