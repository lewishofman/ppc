#!/bin/bash

echo "Starting the analyzer..."

# Running the python frequency analyser
FREQ_RESULT=$(python3 /app/.github/scripts/frequency.py /app/data.txt)

echo "Analysis complete. Updating README..."

# Run the update_readme.sh
/app/.github/scripts/update_readme.sh "$FREQ_RESULT" "$GITHUB_USER"

echo "Process Completed!"
