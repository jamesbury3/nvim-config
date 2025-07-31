-- check_my_dependencies.lua
-- Function to check required external dependencies for Neovim config

local M = {}

local categorized_dependencies = {
	debugger = {
		{ name = "go dlv", cmd = "dlv" },
	},
	formatter = {
		{ name = "black (venv)", custom = true },
		{ name = "prettier", cmd = "prettier" },
		{ name = "prettier-plugin-java", cmd = "prettier-plugin-java" },
		{ name = "stylua", cmd = "stylua" },
		{ name = "rubocop", cmd = "rubocop" },
		{ name = "erb-format", cmd = "erb-format" },
	},
	language = {
		{ name = "go", cmd = "go" },
	},
	lsp = {
		{ name = "gopls", cmd = "gopls" },
		{ name = "jsonls", cmd = "vscode-json-language-server" },
		{ name = "pyright", cmd = "pyright" },
		{ name = "yamlls", cmd = "yaml-language-server" },
		{ name = "ruby-lsp", cmd = "ruby-lsp" },
	},
	utility = {
		{ name = "fzf", cmd = "fzf" },
		{ name = "lazygit", cmd = "lazygit" },
		{ name = "ripgrep", cmd = "rg" },
		{ name = "npm", cmd = "npm" },
		{ name = "pip", cmd = "pip" },
		{ name = "yarn", cmd = "yarn" },
	},
}

-- Checks if a command exists in PATH
local function is_installed(cmd)
	return vim.fn.executable(cmd) == 1
end

-- Checks if black is installed in the python venv
local function is_black_installed()
	local venv_path = vim.fn.expand("~/.config/nvim/formatters/python/venv/bin/black")
	return vim.fn.filereadable(venv_path) == 1
end

local function is_pip_installed()
	return vim.fn.executable("pip") == 1 or vim.fn.executable("pip3") == 1
end

function M.CheckMyDependencies()
	local results = {}
	local categories = {}
	for category, _ in pairs(categorized_dependencies) do
		table.insert(categories, category)
	end
	table.sort(categories)
	for _, category in ipairs(categories) do
		local deps = categorized_dependencies[category]
		table.insert(results, string.format("%s:", category:sub(1, 1):upper() .. category:sub(2)))
		for _, dep in ipairs(deps) do
			local status
			if dep.custom and dep.name == "black (venv)" then
				status = is_black_installed() and "✔️" or "❌"
			elseif dep.name == "pip" then
				status = is_pip_installed() and "✔️" or "❌"
			else
				status = is_installed(dep.cmd) and "✔️" or "❌"
			end
			table.insert(results, string.format("  %s: %s", dep.name, status))
		end
		table.insert(results, "")
	end
	vim.notify(table.concat(results, "\n"), vim.log.levels.INFO, { title = "Dependency Check" })
end

-- Register :CheckMyDependencies command in Neovim
vim.api.nvim_create_user_command("CheckMyDependencies", function()
	require("modules.check_my_dependencies").CheckMyDependencies()
end, {})

return M
