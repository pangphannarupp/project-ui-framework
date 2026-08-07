import re
import urllib.request

url = "https://raw.githubusercontent.com/flutter/flutter/master/packages/flutter/lib/src/material/icons.dart"
response = urllib.request.urlopen(url)
content = response.read().decode('utf-8')

matches = re.findall(r'static const IconData ([a-zA-Z0-9_]+) =', content)

unique_icons = []
seen = set()
for m in matches:
    if m not in seen:
        seen.add(m)
        unique_icons.append(m)

out = "  final Map<String, IconData> _icons = {\n"
for icon in unique_icons:
    out += f"    '{icon}': Icons.{icon},\n"
out += "  };"

with open('flutter_sample/lib/data/demos/pp_icons_demo.dart', 'r') as f:
    demo_content = f.read()

pattern = re.compile(r'final Map<String, IconData> _icons = \{.*?\};', re.DOTALL)
new_demo_content = pattern.sub(out, demo_content)

with open('flutter_sample/lib/data/demos/pp_icons_demo.dart', 'w') as f:
    f.write(new_demo_content)

print(f"Updated pp_icons_demo.dart with {len(unique_icons)} icons.")
