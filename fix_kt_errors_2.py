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

# BizCalendarSheet.kt
file_replace('BizCalendarSheet.kt', [
    ('title = title', '')
])

# BizKhmerCalendarSheet.kt
file_replace('BizKhmerCalendarSheet.kt', [
    ('title = title', '')
])

# BizKeypad.kt
file_replace('BizKeypad.kt', [
    ('rememberRipple', 'androidx.compose.material.ripple.rememberRipple')
])

# BizSecureKeypad.kt
file_replace('BizSecureKeypad.kt', [
    ('rememberRipple', 'androidx.compose.material.ripple.rememberRipple')
])

# BizMonthPickerAlert.kt
file_replace('BizMonthPickerAlert.kt', [
    ('import kh.mcnc.lib.components.BizMonthPicker', 'import kh.mcnc.lib.components.BizMonthPicker\nimport kh.mcnc.lib.utils.CalendarConfig')
])

# BizMonthPickerSheet.kt
file_replace('BizMonthPickerSheet.kt', [
    ('import kh.mcnc.lib.components.BizMonthPicker', 'import kh.mcnc.lib.components.BizMonthPicker\nimport kh.mcnc.lib.utils.CalendarConfig')
])

# BizOtpInput.kt
file_replace('BizOtpInput.kt', [
    ('.matchParentSize()', '.fillMaxSize()')
])

# BizTimePickerAlert.kt
file_replace('BizTimePickerAlert.kt', [
    ('timeValue = internalTime', 'time = internalTime ?: ""'),
    ('onTimeUpdate = { \n                                    internalTime = it\n                                }', 'onTimeSelected = { \n                                    internalTime = it\n                                }')
])

# BizTimePickerSheet.kt
file_replace('BizTimePickerSheet.kt', [
    ('timeValue = internalTime', 'time = internalTime ?: ""'),
    ('onTimeSelected = { \n                                internalTime = it\n                            }', 'onTimeSelected = { \n                                internalTime = it\n                            }'),
    ('onTimeUpdate = {', 'onTimeSelected = {')
])
