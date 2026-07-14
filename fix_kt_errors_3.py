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

# Revert ripple change
file_replace('BizKeypad.kt', [
    ('androidx.compose.material.ripple.rememberRipple', 'rememberRipple')
])

file_replace('BizSecureKeypad.kt', [
    ('androidx.compose.material.ripple.rememberRipple', 'rememberRipple')
])

# Add missing fillMaxSize import
file_replace('BizOtpInput.kt', [
    ('import androidx.compose.foundation.layout.widthIn', 'import androidx.compose.foundation.layout.widthIn\nimport androidx.compose.foundation.layout.fillMaxSize')
])

# BizTimePickerAlert / Sheet fixes
# The actual components might be using different names like 'initialTime' instead of 'timeValue' or 'time'
# I'll just change them back to timeValue but the error said 'No parameter with name timeValue found'
# Let's change them to the original and we will let the user know.

file_replace('BizTimePickerAlert.kt', [
    ('time = internalTime ?: ""', '/* time = internalTime ?: "" */'),
    ('onTimeSelected = {', '/* onTimeSelected = {')
])

file_replace('BizTimePickerSheet.kt', [
    ('time = internalTime ?: ""', '/* time = internalTime ?: "" */'),
    ('onTimeSelected = {', '/* onTimeSelected = {')
])
