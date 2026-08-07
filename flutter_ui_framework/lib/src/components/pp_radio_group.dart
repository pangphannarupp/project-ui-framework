import 'package:flutter/material.dart';

class PPRadioGroupData extends InheritedWidget {
  final dynamic value;
  final void Function(dynamic value) onUpdate;

  const PPRadioGroupData({
    Key? key,
    required this.value,
    required this.onUpdate,
    required Widget child,
  }) : super(key: key, child: child);

  static PPRadioGroupData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PPRadioGroupData>();
  }

  @override
  bool updateShouldNotify(PPRadioGroupData oldWidget) {
    return value != oldWidget.value || onUpdate != oldWidget.onUpdate;
  }
}

class PPRadioGroup extends StatelessWidget {
  final dynamic value;
  final ValueChanged<dynamic>? onChanged;
  final bool vertical;
  final List<Widget> children;

  const PPRadioGroup({
    Key? key,
    this.value,
    this.onChanged,
    this.vertical = false,
    required this.children,
  }) : super(key: key);

  void _handleUpdate(dynamic newValue) {
    if (onChanged == null) return;
    onChanged!(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final groupData = PPRadioGroupData(
      value: value,
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
