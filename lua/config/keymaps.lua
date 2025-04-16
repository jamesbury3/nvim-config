-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local formatter = require("plugins.custom.formatter")

local map = LazyVim.safe_keymap_set

map("n", "<leader>cf", function()
  formatter.format_file()
end, { desc = "format file with custom formatter", noremap = true, silent = true })
