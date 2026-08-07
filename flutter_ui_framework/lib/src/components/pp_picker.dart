import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PPPicker<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T> onChanged;
  final double itemExtent;
  final Widget Function(T item) itemBuilder;

  const PPPicker({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.itemExtent = 40.0,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    int initialIndex = selectedItem != null ? items.indexOf(selectedItem as T) : 0;
    if (initialIndex == -1) initialIndex = 0;

    return SizedBox(
      height: 200,
      child: CupertinoPicker.builder(
        scrollController: FixedExtentScrollController(initialItem: initialIndex),
        itemExtent: itemExtent,
        onSelectedItemChanged: (index) {
          onChanged(items[index]);
        },
        childCount: items.length,
        itemBuilder: (context, index) {
          return Center(
            child: itemBuilder(items[index]),
          );
        },
      ),
    );
  }
}
