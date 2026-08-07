import os
import re

demo_dir = "lib/data/demos"
files = sorted([f for f in os.listdir(demo_dir) if f.endswith('.dart')])
imports = []
items = []

for f in files:
    content = open(os.path.join(demo_dir, f)).read()
    match = re.search(r'final\s+ComponentItem\s+(\w+)\s*=', content)
    if match:
        var_name = match.group(1)
        imports.append(f"import 'demos/{f}';")
        items.append(var_name)

new_content = f"""import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../models/component_item.dart';
export '../models/component_item.dart';

{chr(10).join(imports)}

final List<ComponentItem> componentData = [
  {','.join(chr(10) + '  ' + item for item in items)}
];
"""

with open("lib/data/component_data.dart", "w") as f:
    f.write(new_content)

print("Generated clean component_data.dart")
