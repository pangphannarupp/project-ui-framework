import os
import re

file_path = '/Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt'

with open(file_path, 'r') as f:
    content = f.read()

# Add missing standard imports
imports_to_add = [
    "import kh.mcnc.lib.components.*",
    "import kh.mcnc.lib.utils.*",
    "import androidx.compose.foundation.border"
]
for imp in imports_to_add:
    if imp not in content:
        content = content.replace('import androidx.compose.ui.unit.dp', f'import androidx.compose.ui.unit.dp\n{imp}')

# Fix Icons
icon_fixes = {
    'SwapHoriz': 'Icons.Filled.SwapHoriz',
    'Edit': 'Icons.Filled.Edit',
    'Folder': 'Icons.Filled.Folder',
    'Delete': 'Icons.Filled.Delete',
    'Close': 'Icons.Filled.Close',
    'Add': 'Icons.Filled.Add'
}
for k, v in icon_fixes.items():
    content = re.sub(r'\b' + k + r'\b', v, content)

# BizMonthPicker sheet
content = content.replace('show =', 'visible =')

# Fix progress -> value in BizProgressGauge
content = content.replace('progress =', 'value =')
content = content.replace('title =', '/*title =*/')

# Fix BizRating onRatingChanged -> onRatingChange
content = content.replace('onRatingChanged =', 'onRatingChange =')

with open(file_path, 'w') as f:
    f.write(content)

print("MainActivity fixes applied.")
