# NVIM Setup

Neovim requires two packages to be setup with Python support and Clipboard integration.

In WSL install win32yank in your path on windows side.
It provides a CLI to your clipboard with `win32yank -o` for outputting your clipboard and `win32yank -i` for copying into your clipboard.

Python is supported if either `g:python3_host_prog` is set or if python3 is found in `$PATH`.
In the used environment, the `pynvim` package must be installed.
