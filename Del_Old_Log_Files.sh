#!/bin/bash

#find whether the directory is present using IF cond
#search for the files with .log ext for more than 14 days using FINd cmd
#use while loop to see each file of a file using 'IFR' and READ cmds

#variable for Source directory
SOURCE_DIR="/tmp/shellscripts-logs"

R="\e[31m"  # Red color code
G="\e[32m"  #Green color ccode
Y="\e[33m" # Yellow color code
N="\e[0m" # Normal code

# Check if directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "$R Source directory: $SOURCE_DIR not present $N"
    exit 1
fi

# Find `.log` files older than 14 days
FILES_TO_DEL=$(find "$SOURCE_DIR" -type f -mtime +14 -name "*.log")

# Check if any files were found
if [ -z "$FILES_TO_DEL" ]; then #-z checks if the string inside $FILES_TO_DEL is empty.
    echo -e "$Y No log files older than 14 days found $N"
    exit 0
fi

# Use while loop to process files
echo -e "$Y Deleting files... $N"
while IFS= read -r line; do
    echo "Deleting file: $line"
    rm -rf "$line"
done <<< "$FILES_TO_DEL"

echo -e "$G Cleanup complete! $N"
