{{#if dotter.packages.vim}}
# Open vim, install all plugins, immediately close windows afterwards
vim -c PlugInstall -c qa
{{/if}}

{{#if  dotter.packages.fzf }}
# Source  environment variable for FZF options
. fzf/fzf_setup.sh
{{/if}}
