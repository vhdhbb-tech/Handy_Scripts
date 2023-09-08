#!/bin/bash

# Directory to search for files
search_directory="/path/to/directory"

# Log file to store results
log_file="/path/to/directory/large_files.log"

# Iterate over files in the directory
for file in "$search_directory"/*; do
    if [ -f "$file" ]; then
        size=$(stat -c %s "$file")   # Get file size in bytes
        size_in_gb=$((size / 1024 / 1024 / 1024))   # Convert size to GB

        if [ "$size_in_gb" -gt 1 ]; then
            echo "File: $file, Size: $size_in_gb GB" >> "$log_file"
        fi
    fi
done

echo "Large files have been logged to $log_file"
