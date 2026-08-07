import 'package:flutter/material.dart';

class ComponentItem {
  final String name;
  final String description;
  final String? demoCode;
  final WidgetBuilder? demoBuilder;

  const ComponentItem({
    required this.name,
    this.description = 'Boilerplate component',
    this.demoCode,
    this.demoBuilder,
  });
}
