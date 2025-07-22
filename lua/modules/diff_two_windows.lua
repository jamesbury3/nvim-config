local M = {}

-- Opens a vertical split with two new empty buffers in diff mode
function M.OpenDiffSplit()
	-- Create two new empty buffers
	local buf1 = vim.api.nvim_create_buf(true, false)
	local buf2 = vim.api.nvim_create_buf(true, false)
	-- Set the first buffer in the current window
	vim.api.nvim_win_set_buf(0, buf1)
	-- Open a vertical split and set the second buffer
	vim.cmd("vsplit")
	vim.api.nvim_win_set_buf(0, buf2)
	-- Enable diff mode in both windows
	vim.cmd("windo diffthis")
end

-- Register :OpenDiffSplit command in Neovim
vim.api.nvim_create_user_command("OpenDiffSplit", function()
	require("modules.diff_two_windows").OpenDiffSplit()
end, {})

return M
