import 'package:flutter/material.dart';

enum PPCollapseVariant { defaultVariant, flush, filled, separated }

class PPCollapse extends StatelessWidget {
  final List<String> activeNames;
  final bool accordion;
  final PPCollapseVariant variant;
  final ValueChanged<List<String>>? onChanged;
  final List<Widget> children;

  const PPCollapse({
    super.key,
    this.activeNames = const [],
    this.accordion = false,
    this.variant = PPCollapseVariant.defaultVariant,
    this.onChanged,
    required this.children,
  });

  void _handleItemTap(String name) {
    if (accordion) {
      if (activeNames.contains(name)) {
        onChanged?.call([]);
      } else {
        onChanged?.call([name]);
      }
    } else {
      final newNames = List<String>.from(activeNames);
      if (newNames.contains(name)) {
        newNames.remove(name);
      } else {
        newNames.add(name);
      }
      onChanged?.call(newNames);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PPCollapseScope(
      activeNames: activeNames,
      variant: variant,
      onItemTap: _handleItemTap,
      child: _buildContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildChildren(),
        ),
      ),
    );
  }

  List<Widget> _buildChildren() {
    if (variant == PPCollapseVariant.separated || variant == PPCollapseVariant.filled) {
      final List<Widget> spacedChildren = [];
      for (int i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1) {
          spacedChildren.add(SizedBox(height: variant == PPCollapseVariant.separated ? 12 : 8));
        }
      }
      return spacedChildren;
    }
    
    final List<Widget> dividedChildren = [];
    for (int i = 0; i < children.length; i++) {
      dividedChildren.add(
        _PPCollapseItemContext(
          isLast: i == children.length - 1,
          child: children[i],
        ),
      );
    }
    return dividedChildren;
  }

  Widget _buildContainer({required Widget child}) {
    switch (variant) {
      case PPCollapseVariant.defaultVariant:
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E2EC)),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: child,
        );
      case PPCollapseVariant.flush:
      case PPCollapseVariant.separated:
      case PPCollapseVariant.filled:
        return child;
    }
  }
}

class PPCollapseScope extends InheritedWidget {
  final List<String> activeNames;
  final PPCollapseVariant variant;
  final ValueChanged<String> onItemTap;

  const PPCollapseScope({
    super.key,
    required this.activeNames,
    required this.variant,
    required this.onItemTap,
    required super.child,
  });

  static PPCollapseScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PPCollapseScope>();
  }

  @override
  bool updateShouldNotify(PPCollapseScope oldWidget) {
    return activeNames != oldWidget.activeNames || variant != oldWidget.variant;
  }
}

class _PPCollapseItemContext extends InheritedWidget {
  final bool isLast;

  const _PPCollapseItemContext({
    super.key,
    required this.isLast,
    required super.child,
  });

  static bool isLastItem(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_PPCollapseItemContext>()?.isLast ?? false;
  }

  @override
  bool updateShouldNotify(_PPCollapseItemContext oldWidget) => isLast != oldWidget.isLast;
}

class PPCollapseItem extends StatefulWidget {
  final String name;
  final String? title;
  final Widget? titleWidget;
  final Widget? icon;
  final bool disabled;
  final Widget child;

  const PPCollapseItem({
    super.key,
    required this.name,
    this.title,
    this.titleWidget,
    this.icon,
    this.disabled = false,
    required this.child,
  });

  @override
  State<PPCollapseItem> createState() => _PPCollapseItemState();
}

class _PPCollapseItemState extends State<PPCollapseItem> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final scope = PPCollapseScope.of(context);
    final isActive = scope?.activeNames.contains(widget.name) ?? false;
    final variant = scope?.variant ?? PPCollapseVariant.defaultVariant;
    final isLast = _PPCollapseItemContext.isLastItem(context);

    BoxDecoration? decoration;
    if (variant == PPCollapseVariant.separated) {
      decoration = BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E2EC)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      );
    } else if (variant == PPCollapseVariant.filled) {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF3F4F6),
      );
    }

    final hasBottomBorder = !isLast && (variant == PPCollapseVariant.defaultVariant || variant == PPCollapseVariant.flush);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: decoration,
      clipBehavior: decoration != null ? Clip.antiAlias : Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: widget.disabled ? null : () => scope?.onItemTap(widget.name),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: hasBottomBorder
                    ? const Border(bottom: BorderSide(color: Color(0xFFE0E2EC)))
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: widget.disabled ? const Color(0xFFC4C7C5) : const Color(0xFF1A1B21),
                      ),
                      child: widget.titleWidget ?? Text(widget.title ?? ''),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isActive ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: widget.icon ??
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: widget.disabled ? const Color(0xFFC4C7C5) : const Color(0xFF44474F),
                        ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: isActive
                ? Container(
                    width: double.infinity,
                    color: variant == PPCollapseVariant.filled ? Colors.white : Colors.transparent,
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        color: Color(0xFF44474F),
                        fontSize: 14,
                        height: 1.5,
                      ),
                      child: widget.child,
                    ),
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
    );
  }
}
