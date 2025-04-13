-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("n", "<leader>jq", ":%!jq --indent 4 '.'<CR>", { desc = "format json with jq" })
map('n', '<leader>cf', ':lua Format_file()<CR>', { noremap = true, silent = true })

-- Define the function
function Format_file()
  local filetype = vim.bo.filetype -- Get the current filetype
  if filetype == "yaml" then
    print("formatting yaml...")
    local filepath = vim.api.nvim_buf_get_name(0)
    vim.fn.system('npx prettier --write ' .. filepath)
    vim.cmd("e!")
  elseif filetype == "python" then
    print("formatting python...")
    local filepath = vim.api.nvim_buf_get_name(0)
    vim.fn.system('source ~/.config/nvim/formatters/venv/bin/activate')
    vim.fn.system('black ' .. filepath)
    vim.cmd("silent! !e")
    vim.fn.system("deactivate")
  else
    print("No formatter configured for this filetype: " .. filetype)
  end
end

