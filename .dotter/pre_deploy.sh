export DOTFILES={{environment.dotfile_folder}}

{{#if dotter.packages.rust}}
export CARGO_HOME={{rust.cargo_home}}
export RUSTUP_HOME={{rust.rustup_home}}
{{/if}}

cat > "{{environment.dotfile_folder}}/folder_shortcuts" <<End-of-message
{{~#each environment.folder_shortcuts}}
{{this}}
{{~/each}}
End-of-message
