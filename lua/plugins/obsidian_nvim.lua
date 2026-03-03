if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	return {}
end

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	ft = "markdown",
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false, -- this will be removed in the next major release
		workspaces = {
			{
				name = "james-vault-synced",
				path = "~/obsidian/james-vault-synced",
			},
		},
	},
}
