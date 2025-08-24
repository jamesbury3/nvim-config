local M = {}

local function reload_file()
	vim.cmd("silent! !e")
end

local function format_with_prettier()
	local filepath = vim.api.nvim_buf_get_name(0)
	vim.fn.system("prettier --write " .. filepath)
	reload_file()
end

function M.format_file()
	local enabled_filetypes = { "go", "lua", "json", "java", "python", "yaml", "rb", "ruby", "eruby", "typescript" }
	local filetype = vim.bo.filetype
	local current_filetype_enabled = false
	local filepath = vim.api.nvim_buf_get_name(0)

	for _, v in ipairs(enabled_filetypes) do
		if v == filetype then
			current_filetype_enabled = true
		end
	end

	if not current_filetype_enabled then
		return
	end

	print("formatting " .. filetype)

	-- Format with deno if in a deno project
	local cwd = vim.fn.getcwd()
	local config_file = cwd .. "/deno.json"
	if vim.fn.filereadable(config_file) == 1 then
		vim.fn.system("deno fmt " .. filepath)
		reload_file()
		return
	end

	if filetype == "yaml" then
		format_with_prettier()
	elseif filetype == "json" then
		format_with_prettier()
	elseif filetype == "java" then
		format_with_prettier()
	elseif filetype == "javascript" then
		format_with_prettier()
	elseif filetype == "typescript" then
		format_with_prettier()
	elseif filetype == "python" then
		vim.fn.system([[
            source ~/.config/nvim/formatters/python/venv/bin/activate &&
            black ]] .. filepath .. [[ &&
            deactivate
        ]])
		reload_file()
	elseif filetype == "lua" then
		vim.fn.system("stylua " .. filepath)
		reload_file()
	elseif filetype == "go" then
		vim.fn.system("gofmt -w " .. filepath)
		reload_file()
	elseif filetype == "ruby" then
		print("formatting ruby file")
		vim.fn.system("rubocop -x " .. vim.fn.shellescape(filepath))
		reload_file()
	elseif filetype == "eruby" then
		print("formatting erb file")
		vim.fn.system("erb-format " .. vim.fn.shellescape(filepath) .. " --write")
		reload_file()
	end
end

return M
