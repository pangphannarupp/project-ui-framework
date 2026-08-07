import 'package:flutter/material.dart';

class PPBreadcrumbItem {
  final String label;
  final Widget? icon;
  final VoidCallback? onTap;

  PPBreadcrumbItem({
    required this.label,
    this.icon,
    this.onTap,
  });
}

class PPBreadcrumb extends StatelessWidget {
  final List<PPBreadcrumbItem> items;
  final String separator;
  final Widget? separatorIcon;
  final TextStyle? defaultStyle;
  final TextStyle? activeStyle;

  const PPBreadcrumb({
    super.key,
    required this.items,
    this.separator = '/',
    this.separatorIcon,
    this.defaultStyle,
    this.activeStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final defStyle = defaultStyle ??
        const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        );
        
    final actStyle = activeStyle ??
        const TextStyle(
          color: Color(0xFF1E293B),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        );

    final separatorColor = const Color(0xFF94A3B8);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(items.length * 2 - 1, (index) {
        if (index.isOdd) {
          // Separator
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: separatorIcon ??
                Text(
                  separator,
                  style: TextStyle(color: separatorColor, fontSize: 14),
                ),
          );
        }

        final itemIndex = index ~/ 2;
        final item = items[itemIndex];
        final isLast = itemIndex == items.length - 1;
        final style = isLast ? actStyle : defStyle;

        Widget content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  size: 16,
                  color: style.color,
                ),
                child: item.icon!,
              ),
              const SizedBox(width: 4),
            ],
            Text(item.label, style: style),
          ],
        );

        if (!isLast && item.onTap != null) {
          return InkWell(
            onTap: item.onTap,
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
              child: content,
            ),
          );
        }

        return content;
      }),
    );
  }
}
