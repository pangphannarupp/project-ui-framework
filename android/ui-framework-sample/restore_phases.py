import subprocess
import re

file_path = '/Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt'

# 1. Get original MainActivity.kt from git
result = subprocess.run(
    ['git', 'show', 'HEAD:app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt'],
    capture_output=True, text=True, cwd='/Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample'
)
original_content = result.stdout

def extract_view_factory(content, name):
    start_str = f'name = "{name}",'
    if start_str not in content:
        return None
    start_idx = content.find(start_str)
    vf_start = content.find('viewFactory = {', start_idx)
    open_braces = 0
    vf_end = -1
    for i in range(vf_start, len(content)):
        if content[i] == '{': open_braces += 1
        elif content[i] == '}':
            open_braces -= 1
            if open_braces == 0:
                vf_end = i
                break
    return content[vf_start:vf_end+1]

# 2. Extract the three viewFactory blocks
vf_p5s1 = extract_view_factory(original_content, "Phase 5 Sheets (Batch 1)")
vf_p6c1 = extract_view_factory(original_content, "Phase 6 Cards & Lists (Batch 1)")
vf_p6l2 = extract_view_factory(original_content, "Phase 6 Lists & Profiles (Batch 2)")

# 3. Apply fixes to the extracted blocks
if vf_p5s1:
    vf_p5s1 = vf_p5s1.replace('selectedLanguage =', 'selectedLang =')
    vf_p5s1 = vf_p5s1.replace('isVisible =', 'visible =')

if vf_p6c1:
    vf_p6c1 = vf_p6c1.replace('isSelected =', 'selected =')
    vf_p6c1 = vf_p6c1.replace('onClick =', 'onSelect =')
    vf_p6c1 = vf_p6c1.replace('onActionClick =', 'onAction =') # if there's any
    vf_p6c1 = vf_p6c1.replace('isHidden =', 'hidden =') # guessing if BizAccountListCard has this
    vf_p6c1 = vf_p6c1.replace('onUpdateIsHidden =', 'onHiddenChange =')

if vf_p6l2:
    vf_p6l2 = vf_p6l2.replace('modelValue =', 'targetKeys =')
    vf_p6l2 = vf_p6l2.replace('onUpdateModelValue =', 'onTargetKeysChange =')
    vf_p6l2 = vf_p6l2.replace('variant = "outlined"', 'variant = kh.mcnc.lib.components.BizTransferVariant.Outlined')
    vf_p6l2 = vf_p6l2.replace('isActive =', 'active =')
    vf_p6l2 = vf_p6l2.replace('color = "light"', 'color = kh.mcnc.lib.components.BizFabActionColor.Light')
    vf_p6l2 = vf_p6l2.replace('color = "primary"', 'color = kh.mcnc.lib.components.BizFabActionColor.Primary')
    vf_p6l2 = vf_p6l2.replace('color = "danger"', 'color = kh.mcnc.lib.components.BizFabActionColor.Danger')
    # Fix BizFab icon mismatch (requires imageVector directly instead of lambda)
    vf_p6l2 = re.sub(
        r'icon = \{\s*Icon\(\s*imageVector = (if \(isFabActive\) Icons\.Default\.Close else Icons\.Default\.Add),\s*contentDescription = null\s*\)\s*\}',
        r'icon = \1',
        vf_p6l2
    )

# 4. Patch current file
with open(file_path, 'r') as f:
    current_content = f.read()

def patch_block(content, name, new_vf):
    if not new_vf: return content
    start_str = f'name = "{name}",'
    if start_str not in content:
        return content
    start_idx = content.find(start_str)
    vf_start = content.find('viewFactory = {', start_idx)
    open_braces = 0
    vf_end = -1
    for i in range(vf_start, len(content)):
        if content[i] == '{': open_braces += 1
        elif content[i] == '}':
            open_braces -= 1
            if open_braces == 0:
                vf_end = i
                break
    return content[:vf_start] + new_vf + content[vf_end+1:]

current_content = patch_block(current_content, "Phase 5 Sheets (Batch 1)", vf_p5s1)
current_content = patch_block(current_content, "Phase 6 Cards & Lists (Batch 1)", vf_p6c1)
current_content = patch_block(current_content, "Phase 6 Lists & Profiles (Batch 2)", vf_p6l2)

with open(file_path, 'w') as f:
    f.write(current_content)

print("Restored and fixed Phase 5 and Phase 6 batches")
