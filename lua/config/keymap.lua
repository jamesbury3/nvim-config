local formatter = require("modules.formatter")

-- Open explorer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree" })
vim.keymap.set("n", "<leader>E", ":NvimTreeFindFile<CR>", { desc = "Find File in Nvim Tree" })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Telescope keymaps" })

-- Tab and buffer management
vim.keymap.set("n", "L", vim.cmd.BufferLineCycleNext, { desc = "Switch to next buffer" })
vim.keymap.set("n", "H", vim.cmd.BufferLineCyclePrev, { desc = "Switch to previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd!<CR>", { desc = "Delete current buffer" })
vim.keymap.set("n", "<leader>bn", ":enew<CR>", { desc = "Create new buffer" })

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "UndoTree" })

-- LazyGit
vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit, { desc = "LazyGit" })

-- Gitsigns
local gs = package.loaded.gitsigns
vim.keymap.set("n", "<leader>glp", gs.preview_hunk_inline, { desc = "Preview Changes" })
vim.keymap.set("n", "<leader>glb", gs.blame_line, { desc = "Git blame line" })
vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "Git reset hunk" })
vim.keymap.set("n", "<leader>gb", gs.blame, { desc = "Git blame" })

-- Move highlighted line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy to clipboard" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste and keep register" })

-- General
vim.keymap.set("n", "<leader>qq", ":qa<CR>", { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set("n", "<leader>r", "``", { desc = "Return to previous location" })
vim.keymap.set("n", "<leader>w", function()
	vim.cmd("w")
	vim.cmd("NvimTreeRefresh")
	formatter.format_file()
end, { desc = "Save, refresh tree, format file" })
vim.keymap.set("x", "<", "<gv", { desc = "Unindent" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent" })
vim.keymap.set("n", "<leader>ctc", function()
	if vim.b.completion == nil then
		vim.b.completion = false
	else
		vim.b.completion = not vim.b.completion
	end
end, { desc = "Toggle Autocompletion" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Format file
vim.keymap.set("n", "<leader>cf", function()
	formatter.format_file()
end, { desc = "format file with custom formatter", noremap = true, silent = true })

-- Debugging
vim.keymap.set("n", "<leader>db", vim.cmd.DapToggleBreakpoint, { desc = "DAP Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", vim.cmd.DapClearBreakpoints, { desc = "DAP Clear Breakpoint" })
vim.keymap.set("n", "<leader>dd", vim.cmd.DapDisconnect, { desc = "DAP Disconnect" })
vim.keymap.set("n", "<leader>ds", vim.cmd.DapContinue, { desc = "DAP Continue" })
vim.keymap.set("n", "<F1>", vim.cmd.DapStepOver, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F2>", vim.cmd.DapStepInto, { desc = "DAP Step Into" })
vim.keymap.set("n", "<F3>", vim.cmd.DapContinue, { desc = "DAP Continue" })

-- Specific Language Commands
vim.keymap.set("n", "<leader>sgt", function()
	local abs_path = vim.api.nvim_buf_get_name(0)
	local rel_path = vim.fn.fnamemodify(abs_path, ":.") -- path relative to CWD
	local rel_dir = string.match(rel_path, "^(.*)/")
	vim.cmd("split")
	vim.cmd("terminal go test -v ./" .. rel_dir .. "/.")
	vim.cmd("startinsert")
end, { desc = "Go Test Current Buffer" })

-- Lsp
local function organizeImports()
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }

	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
	for _, res in pairs(result or {}) do
		for _, action in pairs(res.result or {}) do
			if action.edit then
				vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
			else
				vim.lsp.buf.execute_command(action.command)
			end
		end
	end
end

vim.keymap.set("n", "<leader>lo", organizeImports, { desc = "LSP organize imports" })
vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "LSP rename" })
vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "LSP implementation" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "LSP references" })
