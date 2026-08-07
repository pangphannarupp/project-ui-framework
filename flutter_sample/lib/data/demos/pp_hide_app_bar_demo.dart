import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

final ComponentItem pp_hide_app_barData = ComponentItem(
  name: 'PPHideAppBar',
  description: 'Hides the app bar when scrolling down and shows it when scrolling up.',
  demoCode: '''PPHideAppBar(
  appBar: PPAppBar(
    title: 'Hide on Scroll',
  ),
  body: ListView.builder(
    itemCount: 50,
    itemBuilder: (context, index) => ListTile(title: Text('Item \$index')),
  ),
)''',
  demoBuilder: (context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: PPHideAppBar(
          appBar: Container(
            height: 60,
            width: double.infinity,
            color: const Color(0xFF007AFF),
            alignment: Alignment.center,
            child: const Text(
              'Scroll Down to Hide',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.only(top: 60), // Add padding for the absolute app bar
            itemCount: 30,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF007AFF).withOpacity(0.1),
                  child: Text('\${index + 1}', style: const TextStyle(color: Color(0xFF007AFF))),
                ),
                title: Text('List Item \${index + 1}'),
                subtitle: const Text('Scroll up or down to see animation'),
              );
            },
          ),
        ),
      ),
    );
  },
);
