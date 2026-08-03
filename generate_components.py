import os
import re

web_components_dir = "/Users/pangphanna/personal/project-ui-framework/web/ui-framework/src/components"
flutter_components_dir = "/Users/pangphanna/personal/project-ui-framework/flutter_ui_framework/lib/src/components"
flutter_export_file = "/Users/pangphanna/personal/project-ui-framework/flutter_ui_framework/lib/flutter_ui_framework.dart"
home_screen_file = "/Users/pangphanna/personal/project-ui-framework/flutter_sample/lib/screens/home_screen.dart"

def camel_to_snake(name):
    name = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', name).lower()

if not os.path.exists(flutter_components_dir):
    os.makedirs(flutter_components_dir)

vue_files = [f for f in os.listdir(web_components_dir) if f.endswith('.vue')]
components = [f[:-4] for f in vue_files]
components.sort()

exports = ["library flutter_ui_framework;\n\n"]
list_tiles = []

for comp in components:
    snake_name = camel_to_snake(comp)
    dart_file = os.path.join(flutter_components_dir, f"{snake_name}.dart")
    
    # Create boilerplate dart file
    if not os.path.exists(dart_file):
        with open(dart_file, 'w') as f:
            f.write(f"import 'package:flutter/material.dart';\n\n")
            f.write(f"class {comp} extends StatelessWidget {{\n")
            f.write(f"  const {comp}({{super.key}});\n\n")
            f.write(f"  @override\n")
            f.write(f"  Widget build(BuildContext context) {{\n")
            f.write(f"    return const Placeholder(fallbackHeight: 50, fallbackWidth: 100);\n")
            f.write(f"  }}\n")
            f.write(f"}}\n")
            
    exports.append(f"export 'src/components/{snake_name}.dart';\n")
    
    list_tiles.append(f"""          ListTile(
            title: const Text('{comp}'),
            subtitle: const Text('Boilerplate component'),
            trailing: const {comp}(),
            onTap: () {{}},
          ),""")

# Write exports
with open(flutter_export_file, 'w') as f:
    f.writelines(exports)

# Update home screen
home_screen_content = f"""import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';

class HomeScreen extends StatelessWidget {{
  const HomeScreen({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Components'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
{chr(10).join(list_tiles)}
        ],
      ),
    );
  }}
}}
"""

with open(home_screen_file, 'w') as f:
    f.write(home_screen_content)

print(f"Generated {len(components)} components.")
