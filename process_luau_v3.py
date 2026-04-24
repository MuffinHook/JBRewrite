#!/usr/bin/env python3
import os
import re

def get_inferred_name(assignment):
    """Infer a good variable name from its assignment"""
    # Strip leading/trailing whitespace
    assignment = assignment.strip()
    
    # Instance creation
    if 'Instance.new' in assignment:
        match = re.search(r'Instance\.new\("([^"]+)"\)', assignment)
        if match:
            class_name = match.group(1)
            # Simplify some common names
            if class_name == 'RemoteEvent':
                return 'remoteEvent'
            if class_name == 'RemoteFunction':
                return 'remoteFunction'
            # Camel case conversion
            return class_name[0].lower() + class_name[1:]
    
    # Service retrieval
    if 'game:GetService' in assignment:
        match = re.search(r'game:GetService\("([^"]+)"\)', assignment)
        if match:
            service = match.group(1)
            return service[0].lower() + service[1:] if len(service) > 0 else 'service'
    
    # Specific assignments
    if '.LocalPlayer' in assignment:
        return 'localPlayer'
    if 'CFrame' in assignment and 'new' in assignment:
        return 'cframe'
    if 'Vector3' in assignment and 'new' in assignment:
        return 'vector3'
    if 'Color3' in assignment:
        return 'color3'
    if 'UDim2' in assignment:
        return 'udim2'
    if re.match(r'^\{', assignment):
        return 'configTable'
    if assignment in ['true', 'false']:
        return 'isEnabled'
    if 'math.' in assignment:
        return 'mathFunc'
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
    
    # Build rename map by analyzing all variable assignments
    renames = {}
    assigned_vars = {}  # Track what each var was assigned to
    
    for line in lines:
        # Match: local varname = something
        match = re.search(r'local\s+(v\d+|p\d+|t\d*|f\d+)\s*=\s*(.+?)(?:--.*)?$', line)
        if match:
            var_name = match.group(1)
            assignment = match.group(2).strip()
            
            # Only rename if we haven't seen it before (avoid duplicates)
            if var_name not in renames:
                inferred = get_inferred_name(assignment)
                if inferred:
                    renames[var_name] = inferred
                    assigned_vars[var_name] = assignment
    
    if not renames:
        return 0, None
    
    # Apply renames and remove artifacts
    new_lines = []
    for line in lines:
        # Skip artifact comment lines
        if re.search(r'--\[\[.*?(?:Line:\s*\d+|Upvalues:)', line):
            continue
        
        # Apply renames (case-sensitive word boundaries)
        for old_var, new_var in renames.items():
            line = re.sub(r'\b' + re.escape(old_var) + r'\b', new_var, line)
        
        new_lines.append(line)
    
    # Add review and reassignment markers
    if not has_review:
        new_lines.insert(0, "-- Reviewed by Claude\n")
        new_lines.insert(1, "-- variables reassigned\n")
    else:
        # Already has review, add reassignment marker if needed
        if len(new_lines) > 1 and "variables reassigned" not in new_lines[1]:
            new_lines.insert(1, "-- variables reassigned\n")
    
    # Write back
    try:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
        return len(renames), None
    except:
        return 0, None

# Find all Luau files in target directories
files = []
for root, dirs, filenames in os.walk('src'):
    for fname in filenames:
        if fname.endswith('.luau'):
            path = os.path.join(root, fname)
            if 'ReplicatedFirst' in path or 'StarterPlayer' in path:
                files.append(path)

files.sort()

# Process files
results = []
for filepath in files:
    count, error = process_file(filepath)
    if count and count > 0:
        results.append((filepath, count))

# Print results
for filepath, count in results:
    print(f"{filepath}: {count}")

total = sum(r[1] for r in results)
print(f"\nFiles with changes: {len(results)}/{len(files)}")
print(f"Total variables renamed: {total}")
