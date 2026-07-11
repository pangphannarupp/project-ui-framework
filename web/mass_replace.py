import os
import glob

replacements = {
    '#003399': 'var(--biz-primary, #003399)',
    '#1a2a5e': 'var(--biz-primary-variant, #1a2a5e)',
    '#3880ff': 'var(--biz-primary-light, #3880ff)',
    '#f4f6fa': 'var(--biz-background, #f4f6fa)'
}

dirs = [
    'ui-framework/src/components/**/*.vue',
    'src/views/**/*.vue',
    'src/components/**/*.vue'
]

files = []
for d in dirs:
    files.extend(glob.glob(d, recursive=True))

for file in files:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    new_content = content
    for old, new in replacements.items():
        new_content = new_content.replace(old, new)
    
    if new_content != content:
        with open(file, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f'Updated {file}')
print('Done!')
