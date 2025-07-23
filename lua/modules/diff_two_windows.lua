local M = {}

-- Opens a vertical split with two new empty buffers in diff mode, with optional filetype
function M.OpenDiffSplit(filetype)
	filetype = filetype or ""
	-- Close NvimTree to prevent it from interfering with the diff view
	vim.cmd.NvimTreeClose()
	-- Create two new empty buffers
	local buf1 = vim.api.nvim_create_buf(true, false)
	local buf2 = vim.api.nvim_create_buf(true, false)
	-- Set buffer names for clarity
	vim.api.nvim_buf_set_name(buf1, "a" .. (filetype ~= "" and "." .. filetype or ""))
	vim.api.nvim_buf_set_name(buf2, "b" .. (filetype ~= "" and "." .. filetype or ""))
	-- Set filetype if provided
	if filetype ~= "" then
		vim.api.nvim_buf_set_option(buf1, "filetype", filetype)
		vim.api.nvim_buf_set_option(buf2, "filetype", filetype)
	end
	-- Set the first buffer in the current window
	vim.api.nvim_win_set_buf(0, buf1)
	-- Open a vertical split and set the second buffer
	vim.cmd("vsplit")
	vim.api.nvim_win_set_buf(0, buf2)
	-- Enable diff mode in both windows
	vim.cmd("windo diffthis")
end

-- Register :OpenDiffSplit command in Neovim, with optional filetype argument
vim.api.nvim_create_user_command("OpenDiffSplit", function(opts)
	require("modules.diff_two_windows").OpenDiffSplit(opts.args)
end, { nargs = "?" })

return M
