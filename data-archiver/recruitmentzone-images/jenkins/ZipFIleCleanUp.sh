#!/bin/bash

# Define the directory
DIRECTORY="/data/backups/archived/"

# Define the threshold date (7 days ago)
THRESHOLD=$(date -d "7 days ago" +%s)

# Find files in the directory older than 7 days and delete them
find "$DIRECTORY" -type f -mtime +7 -exec rm {} \;
