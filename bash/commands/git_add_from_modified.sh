# [Requirement] fzf 
# [Requirement] [Custom] git root 
# [Alias] git ls-files -> git ls

# Add git files from the list of modified files by git ls-files 

git ls --modified `git root` | fzf | xargs git add
