export DOTFILES={{environment.dotfile_folder}}

{{#if dotter.packages.rust}}
export CARGO_HOME={{rust.cargo_home}}
export RUSTUP_HOME={{rust.rustup_home}}
{{/if}}
