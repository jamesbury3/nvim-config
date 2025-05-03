return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "lua", "java", "python", "go", "html", "json", "bash" },
			highlight = { enable = true },
			auto_install = true,
			sync_install = false,
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
