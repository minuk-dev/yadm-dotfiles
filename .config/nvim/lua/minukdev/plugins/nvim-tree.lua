-- nvim-tree.lua - fast and simple file tree explorer
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- disable netrw
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			hijack_cursor = false,
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			disable_netrw = true,
			hijack_netrw = true,
			view = {
				width = 35,
				side = "left",
			},
			git = {
				enable = true,
				timeout = 500,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},
			renderer = {
				highlight_git = true,
				highlight_diagnostics = true,
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "├",
						bottom = "─",
						none = " ",
					},
				},
				icons = {
					show = {
						git = true,
						diagnostics = true,
					},
				},
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
				custom = { ".DS_Store" },
			},
			filesystem_watchers = {
				enable = true,
			},
		})

		-- set keymaps
		local keymap = vim.keymap
		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set("n", "<F3>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal current file in explorer" })
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeClose<CR>", { desc = "Close file explorer" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}
