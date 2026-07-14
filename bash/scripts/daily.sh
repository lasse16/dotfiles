#! /usr/bin/env bash

# Look for commits since yesterday, or since last friday in case of monday, made by the current git author.

print_usage ()
{
    cat <<EOF
Usage: $(basename "$0") [DATE]

Search all git repositories found under the current directory (recursively)
for commits made by the current git author since a given date.

Arguments:
  DATE          Optional. Any date/time expression accepted by
                'git my-commits-since' (e.g. "2024-01-01", "2 days ago").
                If omitted, defaults to "yesterday", or to
                "last.friday.midnight" if today is Monday.

Options:
  -h, --help    Show this help message and exit.

Examples:
  $(basename "$0")                # use the default relevant date
  $(basename "$0") 2024-01-01      # look for commits since 2024-01-01
  $(basename "$0") "3 days ago"    # look for commits since 3 days ago
EOF
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    print_usage
    exit 0
fi

get-commits-by-me-since-relevant-date ()
{
    local relevant_date="yesterday"

    if [[ $(date +%A) == "Monday" ]]; then
        relevant_date="last.friday.midnight"
    fi

    # allow overriding the computed date via the script's first argument
    if [[ -n "$1" ]]; then
        relevant_date="$1"
    fi

    git  my-commits-since "$relevant_date"
}

curr_dir=$(pwd)

# find all subdirectories that are also git repositories 
git_repos=$(find . -type d -name ".git" -exec dirname {} \; 2>/dev/null)

for repo in $git_repos
do
    cd "$repo" || exit
    echo "REPO: $repo"
    get-commits-by-me-since-relevant-date "$1"
    cd $curr_dir || exit
done

