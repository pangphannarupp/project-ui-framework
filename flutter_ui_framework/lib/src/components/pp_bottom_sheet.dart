import 'package:flutter/material.dart';

class PPBottomSheet extends StatelessWidget {
  final Widget? title;
  final Widget content;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;

  const PPBottomSheet({
    super.key,
    this.title,
    required this.content,
    this.actions,
    this.padding = const EdgeInsets.all(16.0),
  });

  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    required Widget content,
    List<Widget>? actions,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    bool isScrollControlled = true,
    double? maxWidth,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.white,
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth) : null,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: PPBottomSheet(
              title: title,
              content: content,
              actions: actions,
              padding: padding,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          if (title != null) ...[
            DefaultTextStyle(
              style: Theme.of(context).textTheme.titleLarge ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              child: title!,
            ),
            const SizedBox(height: 16),
          ],
          Flexible(
            child: SingleChildScrollView(
              child: content,
            ),
          ),
          if (actions != null && actions!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions!,
            ),
          ],
        ],
      ),
    );
  }
}
