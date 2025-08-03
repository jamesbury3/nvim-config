return {
	"kevinhwang91/nvim-hlslens",
	event = "BufRead", -- Load when reading a buffer
	config = function()
		-- Setup hlslens with virtual text configuration
		require("hlslens").setup({
			-- Show match count for all matches, not just nearest
			calm_down = true,
			nearest_only = false, -- Show info for all matches
			nearest_float_when = "never", -- Don't use floating windows
			
			-- Configure virtual text to show match counts next to search results
			override_lens = function(render, posList, nearest, idx, relIdx)
				local sfw = vim.v.searchforward == 1
				local indicator, text, chunks
				local absRelIdx = math.abs(relIdx)
				
				if absRelIdx > 1 then
					indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
				elseif absRelIdx == 1 then
					indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
				else
					indicator = ''
				end
				
				local lnum, col = unpack(posList[idx])
				if nearest then
					local cnt = #posList
					if indicator ~= '' then
						text = ('[%s %d/%d]'):format(indicator, idx, cnt)
					else
						text = ('[%d/%d]'):format(idx, cnt)
					end
					chunks = {{' '}, {text, 'HlSearchLensNear'}}
				else
					local cnt = #posList
					if indicator ~= '' then
						text = ('[%s %d/%d]'):format(indicator, idx, cnt)
					else
						text = ('[%d/%d]'):format(idx, cnt)
					end
					chunks = {{' '}, {text, 'HlSearchLens'}}
				end
				render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
			end
		})

		-- Define highlight groups for better visibility
		vim.cmd([[
			hi default HlSearchLens guifg=#ff9e64 guibg=NONE gui=italic
			hi default HlSearchLensNear guifg=#7aa2f7 guibg=NONE gui=bold,italic
		]])

		-- Keymaps for enhanced search navigation
		local kopts = { noremap = true, silent = true }

		-- Enhanced n/N navigation with hlslens
		vim.api.nvim_set_keymap(
			"n",
			"n",
			[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
			kopts
		)
		vim.api.nvim_set_keymap(
			"n",
			"N",
			[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
			kopts
		)

		-- Enhanced * and # navigation with hlslens
		vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
		vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
		vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
		vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

		-- Clear search highlighting
		vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", kopts)
	end,
}
