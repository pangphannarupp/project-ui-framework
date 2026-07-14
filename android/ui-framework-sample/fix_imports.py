import os

base = '/Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/ui-framework/src/main/java/kh/mcnc/lib/components/'

def file_replace(filename, replacements):
    path = os.path.join(base, filename)
    if not os.path.exists(path):
        return
    with open(path, 'r') as f:
        content = f.read()
    
    for o, n in replacements:
        content = content.replace(o, n)
            
    with open(path, 'w') as f:
        f.write(content)

# Add import androidx.compose.material.ripple.rememberRipple
for f in ['BizKeypad.kt', 'BizSecureKeypad.kt']:
    file_replace(f, [
        ('import androidx.compose.runtime.Composable', 'import androidx.compose.runtime.Composable\nimport androidx.compose.material.ripple.rememberRipple')
    ])

# Add import kh.mcnc.lib.utils.CalendarConfig
for f in ['BizMonthPickerAlert.kt', 'BizMonthPickerSheet.kt']:
    file_replace(f, [
        ('import androidx.compose.runtime.Composable', 'import androidx.compose.runtime.Composable\nimport kh.mcnc.lib.utils.CalendarConfig')
    ])

print("Done")
