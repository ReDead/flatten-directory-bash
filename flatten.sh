#!/bin/bash

# Check if the directory is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Get the absolute path of the directory
TARGET_DIR=$(realpath "$1")

# Function to flatten the directory
flatten_directory() {
  local DIR="$1"

  # Find all subdirectories
  find "$DIR" -maxdepth 1 -type d | while read SUBDIR; do
    # Skip the parent directory itself
    if [ "$SUBDIR" != "$DIR" ]; then
      flatten_directory "$SUBDIR"
      # Move all files from the subdirectory to the parent directory
      find "$SUBDIR" -maxdepth 1 -type f -exec mv -t "$DIR" {} +
      rmdir "$SUBDIR"
    fi
  done
}

# Flatten the directory
flatten_directory "$TARGET_DIR"

echo "Directory flattened successfully."
