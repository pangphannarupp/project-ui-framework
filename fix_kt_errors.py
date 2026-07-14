import os
import re

base_dir = '/Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/ui-framework/src/main/java/kh/mcnc/lib/components'

def replace_in_file(filename, replacements):
    filepath = os.path.join(base_dir, filename)
    if not os.path.exists(filepath):
        return
    with open(filepath, 'r') as f:
        content = f.read()
    
    new_content = content
    for old, new in replacements:
        if callable(old):
            new_content = old(new_content)
        else:
            new_content = new_content.replace(old, new)
            
    if new_content != content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        print(f"Updated {filename}")

replace_in_file('BizAccountListCard.kt', [
    ('Alignment.Baseline', 'Alignment.Bottom')
])

replace_in_file('BizBottomSheet.kt', [
    ('header()', 'this@Column.header()'),
    ('content()', 'this@Column.content()'),
    ('footer()', 'this@Column.footer()')
])

# BizCalendarAlert.kt
replace_in_file('BizCalendarAlert.kt', [
    ('config = config,', 'config = config ?: CalendarConfig(),'),
    ('initialDate = initialDate,', 'initialDate = initialDate ?: Date(),')
])

# BizKhmerCalendarAlert.kt
replace_in_file('BizKhmerCalendarAlert.kt', [
    ('config = config,', 'config = config ?: CalendarConfig(),'),
    ('initialDate = initialDate,', 'initialDate = initialDate ?: Date(),'),
    ('onDateSelected = onDateSelected,', 'onDateSelected = { d, kd, s -> onDateSelected?.invoke(d) },'),
    ('onRangeSelected = onRangeSelected,', 'onRangeSelected = { d1, kd1, s1, d2, kd2, s2 -> onRangeSelected?.invoke(d1, d2) },')
])

# BizCalendarSheet.kt
replace_in_file('BizCalendarSheet.kt', [
    ('BizBottomSheet(\n        visible = visible,', 'BizBottomSheet(\n        isVisible = visible,'),
    ('BizBottomSheet(\n        visible = visible,\n        onDismissRequest = onDismissRequest,\n        title = title\n    )', 'BizBottomSheet(\n        isVisible = visible,\n        onDismissRequest = onDismissRequest\n    )'),
    ('config = config,', 'config = config ?: CalendarConfig(),'),
    ('initialDate = initialDate,', 'initialDate = initialDate ?: Date(),')
])

# BizKhmerCalendarSheet.kt
replace_in_file('BizKhmerCalendarSheet.kt', [
    ('BizBottomSheet(\n        visible = visible,', 'BizBottomSheet(\n        isVisible = visible,'),
    ('BizBottomSheet(\n        visible = visible,\n        onDismissRequest = onDismissRequest,\n        title = title\n    )', 'BizBottomSheet(\n        isVisible = visible,\n        onDismissRequest = onDismissRequest\n    )'),
    ('config = config,', 'config = config ?: CalendarConfig(),'),
    ('initialDate = initialDate,', 'initialDate = initialDate ?: Date(),'),
    ('onDateSelected = onDateSelected,', 'onDateSelected = { d, kd, s -> onDateSelected?.invoke(d) },'),
    ('onRangeSelected = onRangeSelected,', 'onRangeSelected = { d1, kd1, s1, d2, kd2, s2 -> onRangeSelected?.invoke(d1, d2) },')
])

# BizMonthPickerAlert.kt
replace_in_file('BizMonthPickerAlert.kt', [
    ('config = config,', 'config = config as? CalendarConfig ?: CalendarConfig(),'),
    ('initialDate = initialDate,', 'initialDate = initialDate ?: Date(),')
])

# BizMonthPickerSheet.kt
replace_in_file('BizMonthPickerSheet.kt', [
    ('BizBottomSheet(\n        visible = visible,\n        onDismissRequest = onDismissRequest,\n        title = title\n    )', 'BizBottomSheet(\n        isVisible = visible,\n        onDismissRequest = onDismissRequest\n    )'),
    ('config = config,', 'config = config as? CalendarConfig ?: CalendarConfig(),'),
    ('initialDate = initialDate,', 'initialDate = initialDate ?: Date(),')
])

# BizNotificationItem.kt
# (Wait, already fixed crossAxisAlignment via find/sed)

# BizOtpInput.kt
# 'matchParentSize' missing. In Box, Modifier.matchParentSize() is available inside BoxScope.
replace_in_file('BizOtpInput.kt', [
    ('Modifier.matchParentSize()', 'Modifier.fillMaxSize()')
])

# BizTimePickerAlert.kt
replace_in_file('BizTimePickerAlert.kt', [
    ('timeValue = timeValue,', 'time = timeValue ?: "",'),
    ('min = min,', ''),
    ('max = max,', ''),
    ('minuteValues = minuteValues,', ''),
    ('hourCycle = hourCycle,', ''),
    ('onTimeUpdate = onTimeUpdate', 'onTimeSelected = onTimeUpdate ?: {}')
])
# Need to check TimePicker signature if this fails.

# BizTimePickerSheet.kt
replace_in_file('BizTimePickerSheet.kt', [
    ('BizBottomSheet(\n        visible = visible,\n        onDismissRequest = onDismissRequest,\n        title = title\n    )', 'BizBottomSheet(\n        isVisible = visible,\n        onDismissRequest = onDismissRequest\n    )'),
    ('timeValue = timeValue,', 'time = timeValue ?: "",'),
    ('min = min,', ''),
    ('max = max,', ''),
    ('minuteValues = minuteValues,', ''),
    ('hourCycle = hourCycle,', ''),
    ('onTimeUpdate = onTimeUpdate,', 'onTimeSelected = onTimeUpdate ?: {},'),
    ('onChange = onChange,', ''),
    ('onConfirm = onConfirm,', 'onConfirm = { onConfirm?.invoke() },'),
])

print("Done")
