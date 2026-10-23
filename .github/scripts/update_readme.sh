#!/bin/bash

# Assign arguments to variables
FREQ_RESULT=$1
GITHUB_USER=$2
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Append the results to README.md
echo -e "\n### Vowel Frequency Analysis" >> README.md
echo "**User:** $GITHUB_USER" >> README.md
echo "**Date:** $TIMESTAMP" >> README.md
echo "**Result:** $FREQ_RESULT" >> README.md
echo "---" >> README.md

# Configure Git (required for GitHub Actions to commit)
git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"
