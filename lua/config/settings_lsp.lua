vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
		},
	},
})
vim.diagnostic.config({ virtual_text = true })
vim.lsp.enable({ 'pyright', 'lua_ls' })
