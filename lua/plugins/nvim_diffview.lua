return {
	"sindrets/diffview.nvim",
	opts = {
		enhanced_diff_hl = true,
		view = {
			default = {
				layout = "diff2_horizontal",
			},
		},
		file_panel = {
			listing_style = "tree",
		},
		hooks = {
			diff_buf_read = function()
				vim.opt_local.bufhidden = "wipe"
			end,
		},
	},
}
