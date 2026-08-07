import os
import re

DART_FILE = '/Users/pangphanna/personal/project-ui-framework/flutter_sample/lib/data/component_data.dart'
DEMOS_DIR = '/Users/pangphanna/personal/project-ui-framework/flutter_sample/lib/data/demos'
MODELS_DIR = '/Users/pangphanna/personal/project-ui-framework/flutter_sample/lib/models'

def create_dirs():
    os.makedirs(DEMOS_DIR, exist_ok=True)
    os.makedirs(MODELS_DIR, exist_ok=True)

def camel_to_snake(name):
    name = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', name).lower()

def extract():
    with open(DART_FILE, 'r') as f:
        content = f.read()

    # Get imports
    imports = []
    for line in content.splitlines():
        if line.startswith('import '):
            imports.append(line)
    imports_str = '\n'.join(imports)

    # 1. Extract ComponentItem class
    class_match = re.search(r'class ComponentItem \{.*?\n\}', content, re.DOTALL)
    if class_match:
        component_item_code = class_match.group(0)
        with open(os.path.join(MODELS_DIR, 'component_item.dart'), 'w') as f:
            f.write("import 'package:flutter/material.dart';\n\n" + component_item_code + "\n")
        
        # Remove class from content
        content = content[:class_match.start()] + content[class_match.end():]

    # Find componentData list
    start_idx = content.find('final List<ComponentItem> componentData = [')
    if start_idx == -1:
        print("Could not find componentData list")
        return

    # Parse items by counting brackets
    bracket_count = 0
    in_list = False
    current_item_start = -1
    items = []
    
    i = start_idx + len('final List<ComponentItem> componentData =')
    while i < len(content):
        if content[i] == '[':
            if not in_list:
                in_list = True
                i += 1
                continue
            bracket_count += 1
        elif content[i] == ']':
            if in_list and bracket_count == 0:
                break
            bracket_count -= 1
            
        if in_list and bracket_count == 0:
            if content[i:i+13] == 'ComponentItem':
                current_item_start = i
                # parse ComponentItem(...)
                paren_count = 0
                j = i + 13
                while j < len(content) and content[j] != '(':
                    j += 1
                paren_count = 1
                j += 1
                while j < len(content) and paren_count > 0:
                    if content[j] == '(':
                        paren_count += 1
                    elif content[j] == ')':
                        paren_count -= 1
                    j += 1
                items.append((current_item_start, j, content[current_item_start:j]))
                i = j - 1
        i += 1
        
    print(f"Found {len(items)} items")
    
    # We also need to extract all private classes like _RibbonDemo, _RibbonDemoState, etc.
    # Let's find all class _.*
    private_classes = {} # name -> code
    class_pattern = re.compile(r'class (_[A-Za-z0-9_]+)(?:(?!^class ).)*', re.DOTALL | re.MULTILINE)
    
    # Actually, regex for class is tricky. Let's just find "class _" and parse braces.
    i = 0
    while True:
        idx = content.find('\nclass _', i)
        if idx == -1:
            break
        idx += 1 # move to 'c'
        # find class name
        name_end = content.find(' ', idx + 6)
        name_end2 = content.find('<', idx + 6)
        if name_end2 != -1 and name_end2 < name_end:
            name_end = name_end2
        class_name = content[idx+6:name_end]
        
        # parse braces
        brace_start = content.find('{', idx)
        if brace_start == -1:
            break
        brace_count = 1
        j = brace_start + 1
        while j < len(content) and brace_count > 0:
            if content[j] == '{': brace_count += 1
            elif content[j] == '}': brace_count -= 1
            j += 1
        private_classes[class_name] = content[idx:j]
        i = j

    new_imports = []
    replacement_items = []
    
    for start, end, code in items:
        name_match = re.search(r"name:\s*'([^']+)'", code)
        if not name_match:
            replacement_items.append(code)
            continue
            
        name = name_match.group(1)
        snake_name = camel_to_snake(name)
        
        if 'demoBuilder: null' in code and 'demoCode: null' in code:
            replacement_items.append(code)
            continue
            
        # It's an implemented component!
        file_name = f"{snake_name}_demo.dart"
        var_name = snake_name + 'Data'
        new_imports.append(f"import 'demos/{file_name}';")
        replacement_items.append(var_name)
        
        # Find associated private classes used in this code
        used_classes = []
        for cls_name, cls_code in private_classes.items():
            if cls_name in code or (cls_name.endswith('State') and cls_name[:-5] in code):
                used_classes.append(cls_code)
                
        # Write to file
        with open(os.path.join(DEMOS_DIR, file_name), 'w') as f:
            f.write(imports_str + "\n")
            f.write("import '../../models/component_item.dart';\n\n")
            f.write(f"final ComponentItem {var_name} = {code};\n\n")
            f.write("\n\n".join(used_classes))
            f.write("\n")
            
    # Now construct the new component_data.dart
    new_component_data = imports_str + "\n"
    new_component_data += "import '../models/component_item.dart';\n"
    new_component_data += "\n".join(new_imports) + "\n\n"
    new_component_data += "final List<ComponentItem> componentData = [\n  "
    new_component_data += ",\n  ".join(replacement_items)
    new_component_data += "\n];\n"
    
    with open(DART_FILE, 'w') as f:
        f.write(new_component_data)

    print("Extraction complete.")

if __name__ == '__main__':
    create_dirs()
    extract()
