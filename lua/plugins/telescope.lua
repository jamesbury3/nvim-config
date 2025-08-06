return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		opts = {
			defaults = {
				file_ignore_patterns = {
					"^.git/",
				},
				path_display = function(opts, path)
					local Path = require("plenary.path")
					local tail = Path:new(path):make_relative(vim.loop.cwd())
					local max_len = 45 -- adjust to how much space you want
					if #tail > max_len then
						return "…" .. tail:sub(-max_len + 1)
					else
						return tail
					end
				end,
				fname_width = 60, -- Ensure filenames are visible even for long paths
			},
			pickers = {
				find_files = {
					hidden = true,
					no_ignore = true,
					-- Custom mapping to close nvim-tree after opening a file from Telescope
					attach_mappings = function(prompt_bufnr, map)
						local actions = require("telescope.actions")
						local nvimtree = require("nvim-tree.api")
						-- This function opens the selected file, then closes nvim-tree (if open) after a short delay
						local function open_and_close_tree()
							-- Open the selected file (default Telescope behavior)
							actions.select_default(prompt_bufnr)
							-- Use vim.schedule to close nvim-tree after the file is opened.
							-- Without this, nvim-tree does not close the first time a file is selected using Telescope.
							vim.schedule(function()
								if nvimtree.tree.is_visible() then
									nvimtree.tree.close()
								end
							end)
						end
						-- Map <CR> (Enter) in both insert and normal mode to our custom function
						map({ "i", "n" }, "<CR>", open_and_close_tree)
						return true
					end,
				},
			},
		},
	},
}
