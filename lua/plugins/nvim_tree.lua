return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)

			vim.keymap.del("n", "L", { buffer = bufnr })

			vim.keymap.set("n", "<CR>", function()
				local node = api.tree.get_node_under_cursor()
				if node and not node.nodes then -- if it's not a directory
					api.node.open.edit()
					api.tree.close()
				else
					api.node.open.edit() -- just expand/collapse directory
				end
			end, opts("Open and maybe Close Tree"))
		end

		require("nvim-tree").setup({
			on_attach = my_on_attach,
			git = {
				enable = true,
				ignore = false,
			},
			filters = {
				custom = {},
				git_ignored = false,
			},
		})
	end,
}
