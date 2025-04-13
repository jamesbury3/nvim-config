-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map(
  "n",
  "<leader>cf",
  ":lua Format_file()<CR>",
  { desc = "format file with custom formatter", noremap = true, silent = true }
)

local function format_with_prettier()
  print("formatting with prettier...")
  local filepath = vim.api.nvim_buf_get_name(0)
  vim.fn.system("npx prettier --write " .. filepath)
  vim.cmd("silent! !e")
end

-- Define the function
function Format_file()
  local filetype = vim.bo.filetype -- Get the current filetype
  if filetype == "yaml" or filetype == "json" then
    format_with_prettier()
  elseif filetype == "python" then
    print("formatting python...")
    local filepath = vim.api.nvim_buf_get_name(0)
    vim.fn.system("source ~/.config/nvim/formatters/venv/bin/activate")
    vim.fn.system("black " .. filepath)
    vim.cmd("silent! !e")
    vim.fn.system("deactivate")
  elseif filetype == "lua" then
    print("formatting lua...")
    local filepath = vim.api.nvim_buf_get_name(0)
    vim.fn.system("npx stylua " .. filepath)
    vim.cmd("silent! !e")
  elseif filetype == "go" then
    print("formatting go...")
    local filepath = vim.api.nvim_buf_get_name(0)
    vim.fn.system("gofmt -w " .. filepath)
    vim.cmd("silent! !e")
  else
    print("No formatter configured for this filetype: " .. filetype)
  end
end
