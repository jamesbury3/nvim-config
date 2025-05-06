local M = {}

local function reload_file()
	vim.cmd("silent! !e")
end

local function format_with_prettier()
	local filepath = vim.api.nvim_buf_get_name(0)
	vim.fn.system("npx prettier --write " .. filepath)
	reload_file()
end

function M.format_file()
	local filetype = vim.bo.filetype

	if filetype == "yaml" then
		print("formatting yaml...")
		format_with_prettier()
	elseif filetype == "json" then
		print("formatting json...")
		format_with_prettier()
	elseif filetype == "java" then
		print("formatting java...")
		format_with_prettier()
	elseif filetype == "python" then
		print("formatting python...")
		local filepath = vim.api.nvim_buf_get_name(0)
		vim.fn.system("source ~/.config/nvim/formatters/python/venv/bin/activate")
		vim.fn.system("black " .. filepath)
		vim.fn.system("deactivate")
		reload_file()
	elseif filetype == "lua" then
		print("formatting lua...")
		local filepath = vim.api.nvim_buf_get_name(0)
		vim.fn.system("stylua " .. filepath)
		reload_file()
	elseif filetype == "go" then
		print("formatting go...")
		local filepath = vim.api.nvim_buf_get_name(0)
		vim.fn.system("gofmt -w " .. filepath)
		reload_file()
	else
		print("No formatter configured for this filetype: " .. filetype)
	end
end

return M
