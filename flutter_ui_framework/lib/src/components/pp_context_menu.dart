import 'package:flutter/material.dart';

enum PPContextMenuTriggerMode { click, contextmenu }

class PPContextMenuItem {
  final String? label;
  final Widget? icon;
  final bool divider;
  final bool disabled;
  final List<PPContextMenuItem>? children;
  final VoidCallback? action;

  const PPContextMenuItem({
    this.label,
    this.icon,
    this.divider = false,
    this.disabled = false,
    this.children,
    this.action,
  });
}

class PPContextMenu extends StatelessWidget {
  final List<PPContextMenuItem> items;
  final Widget child;
  final PPContextMenuTriggerMode triggerMode;

  const PPContextMenu({
    Key? key,
    required this.items,
    required this.child,
    this.triggerMode = PPContextMenuTriggerMode.click,
  }) : super(key: key);

  List<Widget> _buildMenuItems(List<PPContextMenuItem> items) {
    final buttonStyle = ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
      minimumSize: const WidgetStatePropertyAll(Size(0, 32)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
          return const Color(0xFFF3F4F6);
        }
        return Colors.transparent;
      }),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      splashFactory: NoSplash.splashFactory, // Removes material ripple to match web
      mouseCursor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.forbidden;
        }
        return SystemMouseCursors.click;
      }),
    );

    return items.map((item) {
      if (item.divider) {
        return const Divider(
          height: 9, // 4px margin top + 4px margin bottom + 1px height
          thickness: 1,
          color: Color(0xFFE5E7EB),
        );
      }

      final hasChildren = item.children != null && item.children!.isNotEmpty;
      final childLabel = Text(
        item.label ?? '',
        style: const TextStyle(
          color: Color(0xFF374151),
          fontSize: 14,
        ),
      );

      final childIcon = item.icon != null
          ? Container(
              width: 20,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 12.0),
              child: IconTheme(
                data: const IconThemeData(
                  color: Color(0xFF6B7280),
                  size: 18,
                ),
                child: item.icon!,
              ),
            )
          : null;

      Widget content = Opacity(
        opacity: item.disabled ? 0.5 : 1.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (childIcon != null) childIcon,
            childLabel,
          ],
        ),
      );

      if (hasChildren) {
        return SubmenuButton(
          style: buttonStyle,
          menuChildren: _buildMenuItems(item.children!),
          trailingIcon: const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF), size: 16),
          menuStyle: const MenuStyle(
            minimumSize: WidgetStatePropertyAll(Size(220, 0)),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 4)),
            elevation: WidgetStatePropertyAll(2),
            shadowColor: WidgetStatePropertyAll(Colors.black26),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              side: BorderSide(color: Color(0xFFD1D5DB)),
            )),
          ),
          child: content,
        );
      }

      return MenuItemButton(
        style: buttonStyle,
        onPressed: item.disabled ? null : item.action,
        child: content,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: const MenuStyle(
        minimumSize: WidgetStatePropertyAll(Size(220, 0)),
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 4)),
        elevation: WidgetStatePropertyAll(2),
        shadowColor: WidgetStatePropertyAll(Colors.black26),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          side: BorderSide(color: Color(0xFFD1D5DB)),
        )),
      ),
      builder: (BuildContext context, MenuController controller, Widget? widgetChild) {
        return Listener(
          onPointerDown: (event) {
            if (triggerMode == PPContextMenuTriggerMode.click && (event.buttons & 1) != 0) {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            } else if (triggerMode == PPContextMenuTriggerMode.contextmenu && (event.buttons & 2) != 0) {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            }
          },
          child: child,
        );
      },
      menuChildren: _buildMenuItems(items),
    );
  }
}
