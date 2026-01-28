vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}")

-- bootstrap lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("settings")
require("lazy").setup({
    -- leave nil when passing the spec as the first argument to setup()
    spec = {
        {
            import = "plugins",
        },
    },
    lockfile = vim.fs.joinpath(vim.fn.expand("$DOTFILES"), "nvim/lazy-lock.json"),
    rocks = {
        enabled = false,
    },
    ui = {
        size = { width = 0.8, height = 0.8 },
        wrap = true,
        border = "rounded",
        title = "Lazy",
    },
})

require("clipboard")
require("utils")
require("mappings")
require("lsp")
require("treesitter")
require("nvim-dap")
require("commands")
require("diagnostics")

vim.cmd("colorscheme catppuccin-macchiato")
