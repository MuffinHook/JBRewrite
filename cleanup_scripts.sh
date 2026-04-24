#!/bin/bash

# Comprehensive Luau script cleanup script
# Processes all .luau files and cleans them up

SCRIPT_DIR="C:/Users/Owner/Downloads/JBRewrite/src"
PROCESSED=0
CLEANED=0

# Function to clean a single file
clean_file() {
    local file="$1"
    local backup="${file}.bak"
    local content

    # Read file content
    content=$(cat "$file")

    # Track if changes were made
    local original_content="$content"

    # Remove decompiler comments (--[[ Line: N ]] and --[[ Name: ... | Line: N | Upvalues: ... ]])
    content=$(echo "$content" | sed 's/--\[\[.*Line:.*\]\]//g')

    # Remove trailing whitespace
    content=$(echo "$content" | sed 's/[[:space:]]*$//')

    # Remove multiple blank lines (replace 3+ with 2)
    content=$(echo "$content" | cat -s)

    # Ensure "-- Reviewed by Claude" is on line 1 if not present
    if ! head -1 "$file" | grep -q "Reviewed by Claude"; then
        content="-- Reviewed by Claude
$content"
        ((CLEANED++))
    fi

    # Write back to file if changed
    if [ "$content" != "$original_content" ]; then
        echo "$content" > "$file"
        ((CLEANED++))
    fi

    ((PROCESSED++))
}

# Process all .luau files
echo "Starting cleanup of all Luau scripts in $SCRIPT_DIR..."
echo ""

find "$SCRIPT_DIR" -name "*.luau" -type f | while read file; do
    clean_file "$file"
    if [ $((PROCESSED % 100)) -eq 0 ]; then
        echo "Processed: $PROCESSED files, Cleaned: $CLEANED files"
    fi
done

echo ""
echo "Cleanup complete!"
echo "Total processed: $PROCESSED"
echo "Total cleaned: $CLEANED"
