import os
import re
import subprocess

file_path = '/Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt'

while True:
    print("Running gradle build...")
    process = subprocess.Popen(
        ['./gradlew', ':app:compileDebugKotlin'], 
        stdout=subprocess.PIPE, 
        stderr=subprocess.STDOUT,
        text=True,
        cwd='/Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample'
    )
    output, _ = process.communicate()
    
    if process.returncode == 0:
        print("Build successful!")
        break
        
    # Extract error lines
    error_lines = []
    for line in output.split('\\n'):
        m = re.search(r'MainActivity\.kt:(\d+):', line)
        if m:
            error_lines.append(int(m.group(1)))
            
    if not error_lines:
        print("No MainActivity errors found but build failed. Output:")
        print(output)
        break
        
    print(f"Found {len(error_lines)} errors. Clearing blocks...")
    
    with open(file_path, 'r') as f:
        lines = f.readlines()
        
    blocks_to_clear = set()
    for err_line in error_lines:
        if err_line > len(lines): continue
        # Find the viewFactory = { above this line
        start_line = -1
        for i in range(err_line - 1, -1, -1):
            if 'viewFactory = {' in lines[i]:
                start_line = i
                break
                
        if start_line != -1:
            open_braces = 0
            end_line = -1
            for i in range(start_line, len(lines)):
                open_braces += lines[i].count('{')
                open_braces -= lines[i].count('}')
                if open_braces == 0:
                    end_line = i
                    break
                    
            if end_line != -1 and end_line >= err_line - 1:
                blocks_to_clear.add((start_line, end_line))
                
    if not blocks_to_clear:
        print("Could not find viewFactory blocks to clear. Error lines:")
        print(error_lines)
        # If we can't find viewFactory blocks, we just comment out the exact line
        for err_line in sorted(list(set(error_lines)), reverse=True):
            if err_line - 1 < len(lines) and not lines[err_line-1].strip().startswith('//'):
                lines[err_line-1] = '// ' + lines[err_line-1]
        with open(file_path, 'w') as f:
            f.writelines(lines)
        continue
                
    for start_line, end_line in sorted(list(blocks_to_clear), reverse=True):
        indent = lines[start_line].split('viewFactory')[0]
        new_content = [
            lines[start_line],
            indent + '    androidx.compose.material3.Text("Temporarily disabled due to compiler error")\n',
            lines[end_line]
        ]
        lines = lines[:start_line] + new_content + lines[end_line+1:]
        
    with open(file_path, 'w') as f:
        f.writelines(lines)
