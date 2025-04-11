#!/bin/bash

# Set source directory and destination directory
SOURCE_DIR="/home/fotakis/myScratch/projects/Natalie/TCGA_PRAD/data/counts_all_pats"
DEST_DIR="/home/fotakis/myScratch/projects/Natalie/TCGA_PRAD/data/total"


# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Iterate over all directories in the source directory
for folder in "$SOURCE_DIR"/*/; do
    # Check if the directory contains any .tsv files and process them
    for tsv_file in "$folder"/*.tsv; do
        if [ -f "$tsv_file" ]; then
            # Create a temporary file to store modified content
            tmp_file=$(mktemp)

            # Use sed to delete lines 1, 3, 4, 5, and 6
            # '1d' deletes line 1, '3,6d' deletes lines 3 through 6 (after adjusting for earlier deletion)
            sed '1d;3,6d' "$tsv_file" > "$tmp_file"

            # Copy the modified file to the destination
            dest_file="$DEST_DIR/$(basename "$tsv_file")"
            echo "Copying modified $tsv_file to $dest_file"
            mv "$tmp_file" "$dest_file"
        fi
    done
done

echo "All .tsv files have been processed and copied to $DEST_DIR."