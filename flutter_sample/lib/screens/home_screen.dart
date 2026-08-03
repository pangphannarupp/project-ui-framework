import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'component_detail_screen.dart';
import '../data/component_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  void _navigateTo(BuildContext context, String componentName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ComponentDetailScreen(componentName: componentName);
    }));
  }

  Widget _buildComponentList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: componentData.length,
      itemBuilder: (context, index) {
        final item = componentData[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.description),
          onTap: () => _navigateTo(context, item.name),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('UI Components'),
            ),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.list),
                      label: Text('Components'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: _selectedIndex == 0
                      ? _buildComponentList()
                      : const Center(child: Text('Settings Screen Placeholder')),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('UI Components'),
            ),
            body: _selectedIndex == 0
                ? _buildComponentList()
                : const Center(child: Text('Settings Screen Placeholder')),
            bottomNavigationBar: PPBottomNav(
              value: _selectedIndex.toString(),
              onChanged: (String val) {
                setState(() {
                  _selectedIndex = int.parse(val);
                });
              },
              items: const [
                PPBottomNavItem(
                  label: 'Components',
                  value: '0',
                  icon: Icons.list_outlined,
                  activeIcon: Icons.list,
                ),
                PPBottomNavItem(
                  label: 'Settings',
                  value: '1',
                  icon: Icons.settings_outlined,
                  activeIcon: Icons.settings,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
