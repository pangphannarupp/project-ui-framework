import re

file_path = 'lib/screens/home_screen.dart'

with open(file_path, 'r') as f:
    content = f.read()

# Add _navigateTo and _buildDemoComponent methods to _HomeScreenState
methods_to_add = """
  void _navigateTo(BuildContext context, String componentName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(title: Text(componentName)),
        body: Center(child: _buildDemoComponent(componentName)),
      );
    }));
  }

  Widget _buildDemoComponent(String name) {
    switch (name) {
      case 'PPBottomNav':
        return PPBottomNav(
          value: '0',
          onChanged: (_) {},
          items: const [
            PPBottomNavItem(label: 'Home', value: '0', icon: Icons.home),
            PPBottomNavItem(label: 'Settings', value: '1', icon: Icons.settings),
          ],
        );
      case 'PPButton':
        return PPButton(text: 'Click Me', onPressed: () {});
      default:
        return const Placeholder(fallbackHeight: 50, fallbackWidth: 100);
    }
  }

  Widget _buildComponentList() {"""

content = content.replace("  Widget _buildComponentList() {", methods_to_add)

# Replace onTap in ListTiles
def repl(match):
    title = match.group(1)
    return f"title: const Text('{title}'),\n            subtitle: const Text('Boilerplate component'),\n            onTap: () => _navigateTo(context, '{title}'),"

content = re.sub(r"title: const Text\('([^']+)'\),\n\s*subtitle: const Text\('Boilerplate component'\),\n\s*onTap: \(\) \{\},", repl, content)

with open(file_path, 'w') as f:
    f.write(content)
print("Patched home_screen.dart")
