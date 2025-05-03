-- Open explorer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree" })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Telescope keymaps" })

vim.keymap.set("n", "L", vim.cmd.BufferLineCycleNext, { desc = "Switch to next buffer" })
vim.keymap.set("n", "H", vim.cmd.BufferLineCyclePrev, { desc = "Switch to previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete current buffer" })


-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "UndoTree" })

-- LazyGit
vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit, { desc = "LazyGit" })

-- Move highlighted line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy to clipboard" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste and keep register" })

-- General
vim.keymap.set("n", "<leader>qq", ":qa<CR>", { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set("n", "<leader>b", "``", { desc = "Return to previous location" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = "format file" })

local formatter = require("modules.formatter")
vim.keymap.set("n", "<leader>cf", function()
	formatter.format_file()
end, { desc = "format file with custom formatter", noremap = true, silent = true })
