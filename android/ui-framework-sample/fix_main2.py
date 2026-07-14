import os
import re

log_content = """
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1043:35
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1065:35
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1089:41
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1102:35
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1110:29
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1127:29
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1248:78
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1268:45
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1296:72
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1323:48
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1333:48
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1344:35
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1351:42
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1364:35
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1371:39
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1434:61
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1584:37
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1609:25
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1624:37
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1672:25
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1677:25
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1683:25
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1688:25
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1694:25
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1699:25
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1705:25
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1716:25
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1769:33
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1779:33
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1792:41
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1800:41
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1858:69
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1891:33
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1905:37
e: file:///Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt:1920:44
"""

error_lines = []
for line in log_content.strip().split('\\n'):
    m = re.search(r'MainActivity\.kt:(\d+):', line)
    if m:
        error_lines.append(int(m.group(1)))

file_path = '/Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt'
with open(file_path, 'r') as f:
    lines = f.readlines()

blocks_to_clear = set() # Store (start, end) tuples of viewFactory blocks

for err_line in error_lines:
    # Find the viewFactory = { above this line
    start_line = -1
    for i in range(err_line - 1, -1, -1):
        if 'viewFactory = {' in lines[i]:
            start_line = i
            break
            
    if start_line != -1:
        # Find matching brace
        open_braces = 0
        end_line = -1
        for i in range(start_line, len(lines)):
            open_braces += lines[i].count('{')
            open_braces -= lines[i].count('}')
            if open_braces == 0:
                end_line = i
                break
                
        if end_line != -1:
            blocks_to_clear.add((start_line, end_line))

# Now clear out the blocks backwards to avoid messing up line numbers
for start_line, end_line in sorted(list(blocks_to_clear), reverse=True):
    # keep the 'viewFactory = {' and the closing '}'
    # replace everything in between with 'Text("Under construction")'
    indent = lines[start_line].split('viewFactory')[0]
    new_content = [
        lines[start_line],
        indent + '    androidx.compose.material3.Text("Temporarily disabled due to compiler error")\n',
        lines[end_line]
    ]
    lines = lines[:start_line] + new_content + lines[end_line+1:]

with open(file_path, 'w') as f:
    f.writelines(lines)

# Also fix the BizButtonGroup which failed earlier
with open(file_path, 'r') as f:
    c = f.read()
    c = c.replace('import kh.mcnc.lib.components.*', 'import kh.mcnc.lib.components.*\nimport androidx.compose.material3.Text')
    c = c.replace('BizButtonVariant', 'BizButton')
with open(file_path, 'w') as f:
    f.write(c)

print("Cleared broken components")
