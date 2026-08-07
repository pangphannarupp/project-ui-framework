import os
import re

demo_dir = "lib/data/demos"
files = [f for f in os.listdir(demo_dir) if f.endswith('.dart')]
imports = []
items = []

for f in files:
    content = open(os.path.join(demo_dir, f)).read()
    match = re.search(r'final\s+ComponentItem\s+(\w+)\s*=', content)
    if match:
        var_name = match.group(1)
        imports.append(f"import 'demos/{f}';")
        items.append(var_name)
    else:
        print(f"Could not find ComponentItem in {f}")

# Read original file
with open("lib/data/component_data.dart", "r") as f:
    orig = f.read()

# We need to insert imports after the existing imports
# Look for the last import
lines = orig.split('\n')
last_import_idx = 0
for i, line in enumerate(lines):
    if line.startswith('import ') or line.startswith('export '):
        last_import_idx = i

new_lines = lines[:last_import_idx+1] + imports + lines[last_import_idx+1:]

# Now replace the componentData array. 
# We'll just replace the entire array with our items + whatever was there, 
# or just reconstruct it. Actually, better to just put our items at the top of the array.
new_content = '\n'.join(new_lines)
array_start = new_content.find('final List<ComponentItem> componentData = [')
if array_start != -1:
    insert_pos = new_content.find('[', array_start) + 1
    items_str = '\n  ' + ',\n  '.join(items) + ','
    new_content = new_content[:insert_pos] + items_str + new_content[insert_pos:]

with open("lib/data/component_data.dart", "w") as f:
    f.write(new_content)

print("Regenerated component_data.dart")
