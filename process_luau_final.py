#!/usr/bin/env python3
import os
import re
from collections import defaultdict

def analyze_variable_usage(lines):
    """Analyze how variables are used"""
    usage = defaultdict(list)
    assignments = {}
    
    for i, line in enumerate(lines):
        match = re.search(r'local\s+(v\d+|p\d+|t\d*|f\d+)\s*=\s*(.+?)(?:--.*)?$', line)
        if match:
            var = match.group(1)
            assignment = match.group(2).strip()
            assignments[var] = (i, assignment)
        
        for var in re.findall(r'\b(v\d+|p\d+|t\d*|f\d+)\b', line):
            usage[var].append(line)
    
    return assignments, usage

def infer_name_from_assignment(assignment):
    """Infer name from assignment"""
    assignment = assignment.strip()
    
    if 'Instance.new' in assignment:
        match = re.search(r'Instance\.new\("([^"]+)"\)', assignment)
        if match:
            cn = match.group(1)
            return cn[0].lower() + cn[1:] if len(cn) > 1 else cn.lower()
    
    if 'game:GetService' in assignment:
        match = re.search(r'game:GetService\("([^"]+)"\)', assignment)
        if match:
            svc = match.group(1)
            return svc[0].lower() + svc[1:] if len(svc) > 1 else svc.lower()
    
    if '.LocalPlayer' in assignment:
        return 'localPlayer'
    if 'CFrame' in assignment:
        return 'cframe'
    if 'Vector3' in assignment:
        return 'vector3'
    if 'Color3' in assignment:
        return 'color'
    if 'UDim2' in assignment:
        return 'udim2'
    if re.match(r'^\{', assignment):
        return 'configTable'
    if 'function' in assignment:
        return 'func'
    
    return None

def process_file(filepath):
    """Process a single Luau file"""
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            lines = f.readlines()
    except:
        return 0, None
    
    if not lines:
        return 0, None
    
    has_review = lines[0].strip() == "-- Reviewed by Claude"
    assignments, usage = analyze_variable_usage(lines)
    
    renames = {}
    for var in assignments:
        line_idx, assignment = assignments[var]
        inferred = infer_name_from_assignment(assignment)
        if inferred and var not in renames:
            renames[var] = inferred
    
    if not renames:
        return 0, None
    
    new_lines = []
    for line in lines:
        if re.search(r'--\[\[.*?(?:Line:\s*\d+|Upvalues:)', line):
            continue
        
        for old_var, new_var in renames.items():
            line = re.sub(r'\b' + re.escape(old_var) + r'\b', new_var, line)
        
        new_lines.append(line)
    
    if not has_review:
        new_lines.insert(0, "-- Reviewed by Claude\n")
        new_lines.insert(1, "-- variables reassigned\n")
    else:
        if len(new_lines) > 1 and "variables reassigned" not in new_lines[1]:
            new_lines.insert(1, "-- variables reassigned\n")
    
    try:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
        return len(renames), None
    except:
        return 0, None

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
print(f"\nFiles with changes: {len(results)}/{len(files)}")
print(f"Total variables renamed: {total}")
