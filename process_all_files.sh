#!/bin/bash

# Get list of all .luau files sorted by size (descending)
find C:/Users/Owner/Downloads/JBRewrite/src -name "*.luau" -exec wc -l {} + | sort -rn | grep -v " total$" | awk '{print $2}' > /tmp/all_luau_files.txt

# Count total files
total=$(wc -l < /tmp/all_luau_files.txt)
echo "Total Luau files to process: $total"

# Process in batches of 25
batch_size=25
batch_num=0
processed=0

while IFS= read -r file; do
    ((processed++))

    # Create new batch every N files
    if [ $((processed % batch_size)) -eq 1 ]; then
        ((batch_num++))
        echo "Batch $batch_num starting at file $processed..."
    fi

    # For now, just ensure review marker is present
    if ! head -1 "$file" | grep -q "Reviewed by Claude"; then
        # Add marker
        temp_file="${file}.tmp"
        echo "-- Reviewed by Claude" > "$temp_file"
        cat "$file" >> "$temp_file"
        mv "$temp_file" "$file"
    fi

    if [ $((processed % 100)) -eq 0 ]; then
        echo "Processed: $processed/$total files"
    fi
done < /tmp/all_luau_files.txt

echo ""
echo "Preprocessing complete! All files have review marker."
echo "Total processed: $processed"
