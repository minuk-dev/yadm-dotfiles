-- oil.nvim - edit your filesystem like a buffer
return {
	"stevearc/oil.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	-- load eagerly so oil can act as the default file explorer for directory args
	lazy = false,
	config = function()
		-- disable netrw
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = false,
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					return name == ".DS_Store"
				end,
			},
			float = {
				padding = 4,
				max_width = 100,
				max_height = 30,
			},
			keymaps = {
				["<C-h>"] = false,
				["q"] = "actions.close",
			},
		})

		-- set keymaps
		local keymap = vim.keymap
		keymap.set("n", "<leader>ee", require("oil").toggle_float, { desc = "Toggle file explorer (oil)" })
		keymap.set("n", "<F3>", require("oil").toggle_float, { desc = "Toggle file explorer (oil)" })
		keymap.set("n", "<leader>ef", "<cmd>Oil<CR>", { desc = "Open parent directory (oil)" })
		keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory (oil)" })
	end,
}
