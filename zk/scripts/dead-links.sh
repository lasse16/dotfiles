#!/usr/bin/env bash

# Find outbound links to notes that don't exist
# Uses zk's notebook.db resolved_links view
# Returns: source_path href

DB="${ZK_NOTEBOOK_DIR:-$PWD}/.zk/notebook.db"

if [ ! -f "$DB" ]; then
  echo "Error: notebook.db not found at $DB" >&2
  exit 1
fi

sqlite3 -- "$DB" -separator ' ' \
  "SELECT source_path, href FROM resolved_links WHERE target_id IS NULL AND external = 0;"
