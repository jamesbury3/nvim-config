return {
	"github/copilot.vim",
	cmd = "Copilot",
	config = function()
		vim.g.copilot_no_tab_map = true
		vim.keymap.set(
			"i",
			"<C-j>",
			'copilot#Accept("")',
			{ expr = true, replace_keycodes = false, desc = "Accept copilot suggestion" }
		)
		vim.keymap.set(
			"i",
			"<C-l>",
			"copilot#AcceptWord()",
			{ expr = true, replace_keycodes = false, desc = "Accept next word" }
		)
		vim.keymap.set(
			"i",
			"<C-;>",
			"copilot#Next()",
			{ expr = true, replace_keycodes = false, desc = "Next suggestion" }
		)
		vim.keymap.set(
			"i",
			"<C-,>",
			"copilot#Previous()",
			{ expr = true, replace_keycodes = false, desc = "Previous suggestion" }
		)
		vim.keymap.set(
			"i",
			"<C-i>",
			"copilot#Dismiss()",
			{ expr = true, replace_keycodes = false, desc = "Dismiss suggestion" }
		)
	end,
}
