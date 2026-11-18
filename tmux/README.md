# tmux & tmuxp

## tmux

[tmux](https://tmux.app/) is a terminal multiplexer.
It lets you run multiple terminal sessions, windows and panes inside a single terminal, and detach/reattach to them so your work survives closed terminals or dropped SSH connections.

### Features

- Sessions, windows (tabs) and panes (splits)
- Detach and reattach to running sessions
- Scriptable, with fully customisable key bindings and status bar
- Copy mode with vi keys and mouse support

## tmuxp

[tmuxp](https://github.com/tmux-python/tmuxp) is a session manager for tmux built on libtmux.
Sessions are described declaratively in YAML or JSON files (windows, panes, start directories, commands), so a whole workspace can be recreated with one command.

### Features

- Define workspaces in YAML/JSON
- Load with `tmuxp load <name>`
- Freeze a running session into a config with `tmuxp freeze`

## My configuration

The config is in [`.tmux.conf`](.tmux.conf).

- **Prefix:** `Ctrl-w` instead of `Ctrl-b`, to match vim window commands
- **Vim integration:** `v`, `s`, `o`, `h/j/k/l` are forwarded to vim as `Ctrl-w` commands if the pane runs vim, otherwise they split/navigate tmux panes
- **Windows:** `b` new window in the current path, `c` closes the pane, `r` renames the window; windows auto-rename and renumber
- **Resize:** `H/J/K/L` resize the pane by 5 cells
- **Copy mode:** vi keys; `v` select, `Ctrl-v` rectangle, `y` copy
- **Help:** `?` opens an fzf popup listing all key bindings
- **Reload:** `Ctrl-r` reloads the config
- **Misc:** mouse on, `escape-time` 10ms (neovim advice), `tmux-256color` with TrueColor for alacritty, activity/bell notifications disabled
- **Look:** cyan/black theme, date and time in the status bar, 24h clock
