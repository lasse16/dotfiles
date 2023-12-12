#!/bin/bash
# [Requirement] fzf

# Add git files from the list of modified files by git ls-files

git_add_from_modified(){
	git ls-files --modified $(git rev-parse --show-toplevel) | fzf --multi | xargs git add
}

export -f git_add_from_modified
