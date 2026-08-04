#!/usr/bin/env bash
# md-preview: render a Markdown file to HTML the way GitHub would, and open it
# in $BROWSER. Uses the GitHub API's /markdown endpoint (via `gh api`) for the
# GFM -> HTML conversion, plus the github-markdown-css stylesheet for layout.
#
# Usage: ./md-preview.sh [-t|--theme THEME] <file.md>  (flag can be anywhere)
#
# THEME selects one of the themes from the github-markdown-css project
# (https://github.com/sindresorhus/github-markdown-css):
#   auto (default), light, dark, dark-dimmed, dark-high-contrast,
#   dark-colorblind, light-colorblind

set -euo pipefail

theme="auto"

usage() {
    echo "Usage: $(basename "$0") [-t|--theme THEME] <file.md>" >&2
    echo "Themes: auto, light, dark, dark-dimmed, dark-high-contrast, dark-colorblind, light-colorblind" >&2
}

parsed=$(getopt -o t:h -l theme:,help -n "$(basename "$0")" -- "$@") || { usage; exit 1; }
eval set -- "$parsed"

while true; do
    case "$1" in
        -t|--theme) theme="$2"; shift 2 ;;
        -h|--help) usage; exit 0 ;;
        --) shift; break ;;
    esac
done

if [[ $# -ne 1 ]]; then
    usage
    exit 1
fi

file="$1"

if [[ ! -f "$file" ]]; then
    echo "File not found: $file" >&2
    exit 1
fi

case "$theme" in
    auto) css_name="github-markdown.css" ;;
    light|dark|dark-dimmed|dark-high-contrast|dark-colorblind|light-colorblind)
        css_name="github-markdown-${theme}.css" ;;
    *)
        echo "Unknown theme: $theme" >&2
        usage
        exit 1
        ;;
esac

for cmd in gh jq; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Required command '$cmd' not found in PATH." >&2
        exit 1
    fi
done

body_html=$(jq -Rs '{text: ., mode: "gfm"}' < "$file" | gh api /markdown --input -)

tmp_html=$(mktemp --suffix=.html)

cat > "$tmp_html" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$(basename "$file")</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/github-markdown-css@5/${css_name}">
<style>
  .markdown-body {
    box-sizing: border-box;
    min-width: 12.5rem;
    max-width: 60rem;
    margin: 0 auto;
    padding: clamp(1rem, 4vw, 3rem);
  }

  body {
    background-color: var(--bgColor-default);
  }
</style>
</head>
<body class="markdown-body">
$body_html
</body>
</html>
EOF

echo "Rendered to $tmp_html"

opener="${BROWSER:-xdg-open}"
"$opener" "$tmp_html" >/dev/null 2>&1 &
disown
