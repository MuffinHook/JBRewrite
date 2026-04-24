#!/usr/bin/env python3
import os
import re

def get_inferred_name(assignment):
    """Try to infer a good variable name from its assignment"""
    if 'Instance.new' in assignment:
        match = re.search(r'Instance\.new\("([^"]+)"\)', assignment)
        if match:
            return match.group(1)
    if 'game:GetService' in assignment:
        match = re.search(r'game:GetService\("([^"]+)"\)', assignment)
        if match:
            return match.group(1)
    if '.LocalPlayer' in assignment:
        return 'localPlayer'
    if 'CFrame' in assignment:
        return 'cframe'
    if 'Vector3' in assignment:
        return 'vector'
    if 'Color3' in assignment:
        return 'color'
    if 'UDim2' in assignment:
        return 'udim'
    if re.match(r'^\{', assignment):
        return 'configTable'
    if 'true' in assignment or 'false' in assignment:
        return 'isEnabled'
    return None

def process_file(filepath):
    """Process a single Luau file"""
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            lines = f.readlines()
    except Exception as e:
        return 0, str(e)
    
    if not lines:
        return 0, None
    
    has_review = lines[0].strip() == "-- Reviewed by Claude"
    
    # Build rename map
    renames = {}
    for line in lines:
        match = re.search(r'local\s+(v\d+|p\d+|t\d*|f\d+)\s*=\s*(.+?)(?:--.*)?$', line)
        if match:
            var_name = match.group(1)
            assignment = match.group(2).strip()
            inferred = get_inferred_name(assignment)
            if inferred and var_name not in renames:
                renames[var_name] = inferred
    
    if not renames:
        return 0, None
    
    # Apply renames and remove artifacts
    new_lines = []
    for line in lines:
        # Skip artifact comments
        if re.search(r'--\[\[.*?(?:Line:\s*\d+|Upvalues:)', line):
            continue
        
        # Apply renames
        for old_var, new_var in renames.items():
            line = re.sub(r'\b' + re.escape(old_var) + r'\b', new_var, line)
        
        new_lines.append(line)
    
    # Add markers
    if not has_review:
        new_lines.insert(0, "-- Reviewed by Claude\n")
        new_lines.insert(1, "-- variables reassigned\n")
    else:
        if len(new_lines) > 1 and "variables reassigned" not in new_lines[1]:
            new_lines.insert(1, "-- variables reassigned\n")
    
    # Write back
    try:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
        return len(renames), None
    except Exception as e:
        return 0, str(e)

# Find and process files
files = []
for root, dirs, filenames in os.walk('src'):
    for fname in filenames:
        if fname.endswith('.luau'):
            path = os.path.join(root, fname)
            if 'ReplicatedFirst' in path or 'StarterPlayer' in path:
                files.append(path)

files.sort()

results = []
for filepath in files:
    count, error = process_file(filepath)
    if count and count > 0:
        results.append((filepath, count))

for filepath, count in results:
    print(f"{filepath}: {count}")

total = sum(r[1] for r in results)
print(f"\nFiles changed: {len(results)}/{len(files)}")
print(f"Variables renamed: {total}")
