-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- On ubuntu, this requires a clipboard tool. xclip works, so install with `sudo apt install xclip`
vim.opt.clipboard = "unnamedplus"

vim.g.autoformat = false -- prevents autoformatting when a file is saved
vim.o.tabstop = 4 -- tab looks like 4 spaces
vim.o.expandtab = true -- use spaces instead of tabs
vim.o.softtabstop = 4 -- number of spaces to use instead of tab
vim.o.shiftwidth = 4 -- number of spaces inserted when indenti.o
