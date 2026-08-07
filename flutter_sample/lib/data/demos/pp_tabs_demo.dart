import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPTabsDemo extends StatefulWidget {
  const _PPTabsDemo();

  @override
  State<_PPTabsDemo> createState() => _PPTabsDemoState();
}

class _PPTabsDemoState extends State<_PPTabsDemo> {
  String _activeTab1 = 'tab1';
  String _activeTab2 = 'tab1';
  String _activeTab3 = 'tab1';
  String _activeTab4 = 'tab1';
  String _activeTab5 = 'tab1';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Standard Tabs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        PPTabs(
          value: _activeTab1,
          onChanged: (val) => setState(() => _activeTab1 = val),
          variant: PPTabsVariant.standard,
          child: Column(
            children: [
              PPTabList(
                children: const [
                  PPTab(value: 'tab1', child: Text('Account')),
                  PPTab(value: 'tab2', child: Text('Password')),
                  PPTab(value: 'tab3', child: Text('Notifications')),
                ],
              ),
              PPTabPanels(
                children: [
                  PPTabPanel(
                    value: 'tab1',
                    child: const Text('Make changes to your account here. Click save when you\'re done.'),
                  ),
                  PPTabPanel(
                    value: 'tab2',
                    child: const Text('Change your password here. After saving, you\'ll be logged out.'),
                  ),
                  PPTabPanel(
                    value: 'tab3',
                    child: const Text('Manage your notifications here.'),
                  ),
                ],
              ),
            ],
          ),
        ),

        const Divider(height: 48),

        const Text('Pills Tabs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        PPTabs(
          value: _activeTab2,
          onChanged: (val) => setState(() => _activeTab2 = val),
          variant: PPTabsVariant.pills,
          child: Column(
            children: [
              PPTabList(
                children: const [
                  PPTab(value: 'tab1', child: Text('Account')),
                  PPTab(value: 'tab2', child: Text('Password')),
                  PPTab(value: 'tab3', child: Text('Notifications')),
                ],
              ),
              PPTabPanels(
                children: [
                  PPTabPanel(
                    value: 'tab1',
                    child: const Text('Make changes to your account here. Click save when you\'re done.'),
                  ),
                  PPTabPanel(
                    value: 'tab2',
                    child: const Text('Change your password here. After saving, you\'ll be logged out.'),
                  ),
                  PPTabPanel(
                    value: 'tab3',
                    child: const Text('Manage your notifications here.'),
                  ),
                ],
              ),
            ],
          ),
        ),

        const Divider(height: 48),

        const Text('Segmented Tabs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        PPTabs(
          value: _activeTab3,
          onChanged: (val) => setState(() => _activeTab3 = val),
          variant: PPTabsVariant.segmented,
          child: Column(
            children: [
              PPTabList(
                children: const [
                  PPTab(value: 'tab1', child: Text('Account')),
                  PPTab(value: 'tab2', child: Text('Password')),
                  PPTab(value: 'tab3', child: Text('Notifications')),
                ],
              ),
              PPTabPanels(
                children: [
                  PPTabPanel(
                    value: 'tab1',
                    child: const Text('Make changes to your account here. Click save when you\'re done.'),
                  ),
                  PPTabPanel(
                    value: 'tab2',
                    child: const Text('Change your password here. After saving, you\'ll be logged out.'),
                  ),
                  PPTabPanel(
                    value: 'tab3',
                    child: const Text('Manage your notifications here.'),
                  ),
                ],
              ),
            ],
          ),
        ),

        const Divider(height: 48),

        const Text('Outlined Tabs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        PPTabs(
          value: _activeTab4,
          onChanged: (val) => setState(() => _activeTab4 = val),
          variant: PPTabsVariant.outlined,
          child: Column(
            children: [
              PPTabList(
                children: const [
                  PPTab(value: 'tab1', child: Text('Account')),
                  PPTab(value: 'tab2', child: Text('Password')),
                  PPTab(value: 'tab3', child: Text('Notifications')),
                ],
              ),
              PPTabPanels(
                children: [
                  PPTabPanel(
                    value: 'tab1',
                    child: const Text('Make changes to your account here. Click save when you\'re done.'),
                  ),
                  PPTabPanel(
                    value: 'tab2',
                    child: const Text('Change your password here. After saving, you\'ll be logged out.'),
                  ),
                  PPTabPanel(
                    value: 'tab3',
                    child: const Text('Manage your notifications here.'),
                  ),
                ],
              ),
            ],
          ),
        ),

        const Divider(height: 48),

        const Text('Minimal Tabs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        PPTabs(
          value: _activeTab5,
          onChanged: (val) => setState(() => _activeTab5 = val),
          variant: PPTabsVariant.minimal,
          child: Column(
            children: [
              PPTabList(
                children: const [
                  PPTab(value: 'tab1', child: Text('Account')),
                  PPTab(value: 'tab2', child: Text('Password')),
                  PPTab(value: 'tab3', child: Text('Notifications')),
                ],
              ),
              PPTabPanels(
                children: [
                  PPTabPanel(
                    value: 'tab1',
                    child: const Text('Make changes to your account here. Click save when you\'re done.'),
                  ),
                  PPTabPanel(
                    value: 'tab2',
                    child: const Text('Change your password here. After saving, you\'ll be logged out.'),
                  ),
                  PPTabPanel(
                    value: 'tab3',
                    child: const Text('Manage your notifications here.'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final ComponentItem pp_tabsData = ComponentItem(
  name: 'PPTabs',
  description: 'A complete tabs system with multiple variants (standard, pills, segmented, outlined, minimal).',
  demoCode: '''PPTabs(
  value: _activeTab,
  onChanged: (val) => setState(() => _activeTab = val),
  variant: PPTabsVariant.segmented,
  child: Column(
    children: [
      PPTabList(
        children: const [
          PPTab(value: 'tab1', child: Text('Account')),
          PPTab(value: 'tab2', child: Text('Password')),
        ],
      ),
      PPTabPanels(
        children: [
          PPTabPanel(
            value: 'tab1',
            child: const Text('Make changes to your account here.'),
          ),
          PPTabPanel(
            value: 'tab2',
            child: const Text('Change your password here.'),
          ),
        ],
      ),
    ],
  ),
);''',
  demoBuilder: (context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: _PPTabsDemo(),
    );
  },
);
