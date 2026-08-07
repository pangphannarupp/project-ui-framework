import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_sidebar_navigationData = ComponentItem(
    name: 'PPSidebarNavigation',
    description: 'Implemented component',
    demoCode: '''String activeTab = 'home';
bool isCollapsed = false;

PPSidebarNavigation(
  modelValue: activeTab,
  onModelValueChanged: (value) => setState(() => activeTab = value),
  collapsed: isCollapsed,
  theme: 'dark',
  variant: 'pill',
  header: const Padding(
    padding: EdgeInsets.all(16.0),
    child: Text('Logo', style: TextStyle(fontSize: 20, color: Colors.white)),
  ),
  items: const [
    PPSidebarGroup(
      groupLabel: 'Main',
      items: [
        PPSidebarItem(id: 'home', label: 'Dashboard', icon: Icons.home_outlined),
        PPSidebarItem(id: 'settings', label: 'Settings', icon: Icons.settings_outlined),
      ],
    ),
  ],
)''',
    demoBuilder: (context) {
      String _theme = 'dark';
      String _variant = 'indicator';
      bool _collapsed = false;

      return StatefulBuilder(builder: (context, setState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => _theme = _theme == 'dark' ? 'light' : 'dark'),
                    child: Text('Toggle Theme (\$_theme)'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _collapsed = !_collapsed),
                    child: Text('Toggle Collapse (\$_collapsed)'),
                  ),
                  DropdownButton<String>(
                    value: _variant,
                    items: ['indicator', 'flat', 'pill', 'm3-rail']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _variant = val);
                    },
                  )
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    PPSidebarNavigation(
                      theme: _theme,
                      variant: _variant,
                      collapsed: _collapsed,
                      header: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: _collapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                          children: [
                            Icon(Icons.widgets, color: _theme == 'dark' ? Colors.white : Colors.black),
                            if (!_collapsed) ...[
                              const SizedBox(width: 12),
                              Text(
                                'UI Framework',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: _theme == 'dark' ? Colors.white : Colors.black,
                                ),
                              )
                            ]
                          ],
                        ),
                      ),
                      items: [
                        PPSidebarGroup(
                          groupLabel: 'Overview',
                          items: [
                            PPSidebarItem(id: 'dashboard', label: 'Dashboard', icon: Icons.dashboard),
                            PPSidebarItem(id: 'analytics', label: 'Analytics', icon: Icons.bar_chart),
                          ],
                        ),
                        PPSidebarGroup(
                          groupLabel: 'Management',
                          items: [
                            PPSidebarItem(
                              id: 'users',
                              label: 'Users',
                              icon: Icons.people,
                              children: [
                                PPSidebarItem(id: 'list', label: 'User List'),
                                PPSidebarItem(id: 'roles', label: 'Roles & Permissions'),
                              ],
                            ),
                            PPSidebarItem(
                              id: 'settings',
                              label: 'Settings',
                              icon: Icons.settings,
                              children: [
                                PPSidebarItem(id: 'general', label: 'General'),
                                PPSidebarItem(id: 'billing', label: 'Billing'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        color: _theme == 'dark' ? Colors.grey[900] : Colors.grey[100],
                        child: Center(
                          child: Text(
                            'Content Area',
                            style: TextStyle(
                              color: _theme == 'dark' ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
    },
  );


