-- Start scolling before the cursor reaches top or bottom line
set scrolloff=5

-- Provide an extra window for completion in command mode
set wildmenu

-- Disable the preview window opening at the top of the screen when using the
-- completion
set completeopt-=preview
-
-- Vi-compatibility mode and enables useful Vim functionality. This
-- configuration option turns out not to be necessary for the file named
-- '~/.vimrc', because Vim automatically enters nocompatible mode if that file
-- is present. But we're including it here just in case this config file is
-- loaded some other way (e.g. saved as `foo`, and then Vim started with
-- `vim -u foo`).
set nocompatible

-- Turn on syntax highlighting.
syntax on

-- Disable the default Vim startup message.
set shortmess+=I

-- Show line numbers.
set number
set numberwidth=4

-- Disable line wrapping
set nowrap

-- Disable the .viminfo file, it would normally store the commands and buffers
-- used in vim
set viminfo=""

-- This enables relative line numbering mode. With both number and
-- relativenumber enabled, the current line shows the true line number, while
-- all other lines (above and below) are numbered relative to the current line.
-- This is useful because you can tell, at a glance, what count is needed to
-- jump up or down to a particular line, by {count}k to go up or {count}j to go
-- down.
set relativenumber

-- Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

-- The backspace key has slightly unintuitive behavior by default. For example,
-- by default, you can't backspace before the insertion point set with 'i'.
-- This configuration makes backspace behave more reasonably, in that you can
-- backspace over anything.
set backspace=indent,eol,start

-- This setting makes search case-insensitive when all characters in the string
-- being searched are lowercase. However, the search becomes case-sensitive if
-- it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

-- Enable searching as you type, rather than waiting till you press enter.
set incsearch

-- Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

-- Enable mouse support. You should avoid relying on this too much, but it can
-- sometimes be convenient.
set mouse+=a

set background=dark

set encoding=utf-8
