import os
import glob
import re

def rename_files(src_dir):
    # Find all files starting with Biz
    files = glob.glob(os.path.join(src_dir, '**/Biz*'), recursive=True)
    renamed = []
    for file_path in files:
        dir_name = os.path.dirname(file_path)
        base_name = os.path.basename(file_path)
        
        if base_name.startswith('Biz'):
            new_base_name = 'PP' + base_name[3:]
            new_file_path = os.path.join(dir_name, new_base_name)
            os.rename(file_path, new_file_path)
            renamed.append((file_path, new_file_path))
            print(f"Renamed: {base_name} -> {new_base_name}")
            
    return renamed

def replace_content(target_dirs):
    # Find all relevant files (.vue, .ts, .json)
    extensions = ['*.vue', '*.ts', '*.json']
    files = []
    for directory in target_dirs:
        for ext in extensions:
            files.extend(glob.glob(os.path.join(directory, '**', ext), recursive=True))
            
    # Include package.json specifically
    pkg_json = '/Users/pangphanna/personal/project-ui-framework/web/ui-framework/package.json'
    if pkg_json not in files and os.path.exists(pkg_json):
        files.append(pkg_json)
        
    for file_path in files:
        # Avoid binary files or node_modules
        if 'node_modules' in file_path or 'dist' in file_path:
            continue
            
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
        except:
            continue
            
        new_content = content
        
        # Replace 'Biz' with 'PP' when followed by uppercase letter (components)
        new_content = re.sub(r'Biz([A-Z])', r'PP\1', new_content)
        
        # Replace 'biz-' with 'pp-'
        new_content = new_content.replace('biz-', 'pp-')
        
        if new_content != content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Updated content in: {os.path.basename(file_path)}")

if __name__ == "__main__":
    src_dir = '/Users/pangphanna/personal/project-ui-framework/web/ui-framework/src'
    tests_dir = '/Users/pangphanna/personal/project-ui-framework/web/ui-framework/tests'
    web_src_dir = '/Users/pangphanna/personal/project-ui-framework/web/src'
    
    print("Starting refactor...")
    rename_files(src_dir)
    replace_content([src_dir, tests_dir, web_src_dir])
    print("Refactor complete!")
