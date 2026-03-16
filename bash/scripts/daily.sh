#! /usr/bin/env bash

# Look for commits since yesterday, or since last friday in case of monday, made by the current git author.

get-commits-by-me-since-relevant-date ()
{
    local relevant_date="yesterday"

    if [[ $(date +%A) == "Monday" ]]; then
        relevant_date="last.friday.midnight"
    fi

    git  my-commits-since $relevant_date
}

curr_dir=$(pwd)

# find all subdirectories that are also git repositories 
git_repos=$(find . -type d -name ".git" -exec dirname {} \; 2>/dev/null)

for repo in $git_repos
do
    cd "$repo" || exit
    echo "REPO: $repo"
    get-commits-by-me-since-relevant-date
    cd $curr_dir || exit
done

