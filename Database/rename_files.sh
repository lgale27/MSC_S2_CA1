#!/bin/bash

# Get the directory where the script is located
parent_directory=$(dirname "$(realpath "$0")")

# Function to rename files in a folder with a sequential numbering
rename_files() {
    local folder="$1"
    local counter=1
    
    # Change directory to the specified folder
    cd "$folder" || exit
    
    # Initialize a counter
    counter=1
    
    # Iterate over each file in the folder
    for file in *; do
        # Check if the item is a file
        if [ -f "$file" ]; then
            # Get the file extension
            extension="${file##*.}"
            
            # Pad the counter with leading zeros
            padded_counter=$(printf "%03d" $counter)
            
            # Construct the new filename with the sequence
            new_filename="${padded_counter}.${extension}"
            
            # Rename the file
            mv "$file" "$new_filename"
            
            # Increment the counter
            ((counter++))
        fi
    done
}

# Iterate over each subfolder in the parent directory
for subfolder in "$parent_directory"/*/; do
    if [ -d "$subfolder" ]; then
        # Rename files in the subfolder
        rename_files "$subfolder"
    fi
done
