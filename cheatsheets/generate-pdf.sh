#!/usr/bin/env bash
set -euo pipefail

INPUT="cheatsheets/git-cheatsheet.md"
OUTPUT="cheatsheets/git-cheatsheet.pdf"

# If pandoc is not available, install it and rerun:
# pandoc "$INPUT" -o "$OUTPUT"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "pandoc is not installed. Install pandoc, then rerun this script."
  exit 1
fi

pandoc "$INPUT" -o "$OUTPUT"
echo "Created $OUTPUT"
