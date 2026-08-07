import 'package:flutter/material.dart';

class PPCheckboxGroupData extends InheritedWidget {
  final List<dynamic> values;
  final void Function(dynamic value, bool checked) onUpdate;

  const PPCheckboxGroupData({
    Key? key,
    required this.values,
    required this.onUpdate,
    required Widget child,
  }) : super(key: key, child: child);

  static PPCheckboxGroupData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PPCheckboxGroupData>();
  }

  @override
  bool updateShouldNotify(PPCheckboxGroupData oldWidget) {
    return values != oldWidget.values || onUpdate != oldWidget.onUpdate;
  }
}

class PPCheckboxGroup extends StatelessWidget {
  final List<dynamic> values;
  final ValueChanged<List<dynamic>>? onChanged;
  final bool vertical;
  final List<Widget> children;

  const PPCheckboxGroup({
    Key? key,
    this.values = const [],
    this.onChanged,
    this.vertical = false,
    required this.children,
  }) : super(key: key);

  void _handleUpdate(dynamic value, bool checked) {
    if (onChanged == null) return;
    
    final newValues = List<dynamic>.from(values);
    if (checked) {
      if (!newValues.contains(value)) {
        newValues.add(value);
      }
    } else {
      newValues.remove(value);
    }
    onChanged!(newValues);
  }

  @override
  Widget build(BuildContext context) {
    final groupData = PPCheckboxGroupData(
      values: values,
      onUpdate: _handleUpdate,
      child: vertical
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < children.length; i++) ...[
                  children[i],
                  if (i < children.length - 1) const SizedBox(height: 12),
                ],
              ],
            )
          : Wrap(
              spacing: 16.0,
              runSpacing: 12.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: children,
            ),
    );

    return groupData;
  }
}
