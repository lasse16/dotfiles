-- Start scolling before the cursor reaches top or bottom line
vim.opt.scrolloff = 5

-- Always show the gutter
vim.wo.signcolumn = "yes"

-- Provide an extra window for completion in command mode
vim.opt.wildmenu = true

-- Disable the default Vim startup message.
vim.opt.shortmess:append({ I = true })

-- Show line numbers.
vim.opt.number = true
vim.opt.numberwidth = 4

-- Disable line wrapping
vim.opt.wrap = false

-- Disable the .viminfo file, it would normally store the commands and buffers
-- used in vim
vim.opt.viminfo = ""

-- This enables relative line numbering mode. With both number and
-- relativenumber enabled, the current line shows the true line number, while
-- all other lines (above and below) are numbered relative to the current line.
-- This is useful because you can tell, at a glance, what count is needed to
-- jump up or down to a particular line, by {count}k to go up or {count}j to go
-- down.
vim.opt.relativenumber = true

-- Always show the status line at the bottom, even if you only have one window open.
vim.opt.laststatus = 2

-- The backspace key has slightly unintuitive behavior by default. For example,
-- by default, you can't backspace before the insertion point set with 'i'.
-- This configuration makes backspace behave more reasonably, in that you can
-- backspace over anything.
vim.opt.backspace = "indent,eol,start"

-- This setting makes search case-insensitive when all characters in the string
-- being searched are lowercase. However, the search becomes case-sensitive if
-- it contains any capital letters. This makes searching more convenient.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable searching as you type, rather than waiting till you press enter.
vim.opt.incsearch = true

-- Enable mouse support. You should avoid relying on this too much, but it can
-- sometimes be convenient.
vim.opt.mouse = "a"

vim.opt.background = "dark"

vim.opt.encoding = "utf-8"

-- Open new windows to the right or below the current window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Enable 24-bit/true-color support
vim.opt.termguicolors = true

-- Set the characters representing whitespace
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', eol = '⏎' }

vim.filetype.add({
	extension = {
		['http'] = 'http',
	},
})
