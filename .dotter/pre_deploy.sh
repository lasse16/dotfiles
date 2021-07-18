{{#if dotter.packages.vim}}
# Open vim, install all plugins, immediately close windows afterwards
vim -c PlugInstall -c qa
{{/if}}

{{#if  dotter.packages.fzf }}
# Source  environment variable for FZF options
. fzf/fzf_setup.sh
{{/if}}

{{#if  dotter.packages.environment }}
# Create file containing folder bookmarks
FILE="$DOTFILES/bookmarks"
  echo "" >  "$FILE"
  {{~#each environment.bookmarks}}
  echo {{this}} >> "$FILE";
  {{~/each}}
sed '/^[[:space:]]*$/d' -i "$FILE"
source "$DOTFILES/fzf/bookmark_searcher.sh"
{{/if}}
