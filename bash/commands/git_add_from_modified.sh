# [Requirement] fzf
# [Requirement] [Custom] git root

# Add git files from the list of modified files by git ls-files

git ls -files --modified `git root` | fzf | xargs git add
