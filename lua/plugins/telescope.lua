return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		opts = {
			defaults = {
				file_ignore_patterns = {
					"^.git/",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		},
	},
}
