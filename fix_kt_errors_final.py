import os
import re

base = '/Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/ui-framework/src/main/java/kh/mcnc/lib/components/'

def file_replace(filename, replacements):
    path = os.path.join(base, filename)
    if not os.path.exists(path):
        return
    with open(path, 'r') as f:
        content = f.read()
    
    for o, n in replacements:
        if callable(o):
            content = o(content)
        else:
            content = content.replace(o, n)
            
    with open(path, 'w') as f:
        f.write(content)

# BizKeypad and BizSecureKeypad
for f in ['BizKeypad.kt', 'BizSecureKeypad.kt']:
    file_replace(f, [
        ('androidx.compose.material.ripple.androidx.compose.material.ripple', 'androidx.compose.material.ripple'),
        ('androidx.compose.material.ripple.rememberRipple', 'rememberRipple')
    ])

# BizMonthPickerAlert and Sheet
for f in ['BizMonthPickerAlert.kt', 'BizMonthPickerSheet.kt']:
    file_replace(f, [
        (lambda c: c if 'import kh.mcnc.lib.utils.CalendarConfig' in c else c.replace('import kh.mcnc.lib.components.BizMonthPicker', 'import kh.mcnc.lib.components.BizMonthPicker\nimport kh.mcnc.lib.utils.CalendarConfig'), '')
    ])

# BizOtpInput (fillMaxSize)
file_replace('BizOtpInput.kt', [
    (lambda c: c if 'import androidx.compose.foundation.layout.fillMaxSize' in c else c.replace('import androidx.compose.foundation.layout.widthIn', 'import androidx.compose.foundation.layout.widthIn\nimport androidx.compose.foundation.layout.fillMaxSize'), '')
])

# BizTimePickerAlert
file_replace('BizTimePickerAlert.kt', [
    ('/* time = internalTime ?: "" */', 'value = internalTime ?: "",'),
    ('/* onTimeSelected = {', 'onValueChange = {')
])

# BizTimePickerSheet
file_replace('BizTimePickerSheet.kt', [
    ('/* time = internalTime ?: "" */', 'value = internalTime ?: "",'),
    ('/* onTimeSelected = {', 'onValueChange = {')
])

# Fix for BizTimePickerSheet.kt:34:44 No value passed for parameter 'p1'.
# BizTimePickerSheet line 34 is probably: onConfirm = { onConfirm?.invoke() }
# The error says "No value passed for parameter 'p1'", which means onConfirm signature in BizTimePickerSheet requires a parameter, maybe (String) -> Unit.
# Let's check BizTimePickerSheet.kt
file_replace('BizTimePickerSheet.kt', [
    ('onConfirm = { onConfirm?.invoke() }', 'onConfirm = { onConfirm?.invoke(internalTime) }'),
    ('onConfirm = onConfirm,', 'onConfirm = { onConfirm?.invoke(internalTime) },')
])

print("Done")
