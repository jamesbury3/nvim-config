-- Prevents diff mode from folding lines
vim.api.nvim_create_autocmd("FileType", {
	pattern = "diff",
	callback = function()
		vim.opt_local.diffopt:remove("foldcolumn")
		vim.opt_local.foldlevel = 99
	end,
})
