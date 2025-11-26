#!/bin/bash

# Script to package the HTML file with environment variables for deployment
# Usage: ./package.sh [output-file]
# Default output: kid-dash-packaged.html

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/.env"
INPUT_FILE="${SCRIPT_DIR}/kid-dash.html"
OUTPUT_FILE="${1:-${SCRIPT_DIR}/kid-dash-packaged.html}"

# Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found at $ENV_FILE"
    echo "Please create a .env file with the required variables."
    exit 1
fi

# Check if input HTML file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file not found at $INPUT_FILE"
    exit 1
fi

# Read .env file and export variables
# This handles comments and empty lines
while IFS= read -r line || [ -n "$line" ]; do
    # Skip empty lines and comments
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
    
    # Export variable (handles KEY=VALUE format)
    if [[ "$line" =~ ^[[:space:]]*([^=]+)=(.*)$ ]]; then
        export "${BASH_REMATCH[1]}"="${BASH_REMATCH[2]}"
    fi
done < "$ENV_FILE"

# Copy input file to output
cp "$INPUT_FILE" "$OUTPUT_FILE"

# Generate lowercase version of KID1_NAME if not provided
if [ -z "$KID1_NAME_LOWER" ]; then
    KID1_NAME_LOWER=$(echo "$KID1_NAME" | tr '[:upper:]' '[:lower:]')
fi

# Replace placeholders with actual values
sed -i.bak "s|{{CALENDAR_ID}}|${CALENDAR_ID}|g" "$OUTPUT_FILE"
sed -i.bak "s|{{API_KEY}}|${API_KEY}|g" "$OUTPUT_FILE"
sed -i.bak "s|{{SHEET_CSV_URL_ORIGINAL}}|${SHEET_CSV_URL_ORIGINAL}|g" "$OUTPUT_FILE"
sed -i.bak "s|{{LATITUDE}}|${LATITUDE}|g" "$OUTPUT_FILE"
sed -i.bak "s|{{LONGITUDE}}|${LONGITUDE}|g" "$OUTPUT_FILE"
sed -i.bak "s|{{KID1_NAME}}|${KID1_NAME}|g" "$OUTPUT_FILE"
sed -i.bak "s|{{KIDS_NAMES}}|${KIDS_NAMES}|g" "$OUTPUT_FILE"
sed -i.bak "s|{{KID1_NAME_LOWER}}|${KID1_NAME_LOWER}|g" "$OUTPUT_FILE"

# Remove backup file created by sed
rm -f "${OUTPUT_FILE}.bak"

echo "✓ Packaged HTML file created: $OUTPUT_FILE"
echo "  This file contains all environment variables and is ready for deployment."

