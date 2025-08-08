-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_prettier_needs_config = false

-- Enhanced file change detection
vim.opt.autoread = true
vim.opt.updatetime = 250

-- Clipboard configuration
vim.opt.clipboard = "unnamedplus"

vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Folding configuration using Treesitter
vim.opt.foldenable = true -- Enable folding
vim.opt.foldlevel = 99 -- Start with all folds open
vim.opt.smoothscroll = true
vim.opt.foldexpr = "v:lua.require'lazyvim.util'.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
-- Optional: Set fold column to show fold indicators
vim.opt.foldcolumn = "1"

vim.opt.scrolloff = 10
