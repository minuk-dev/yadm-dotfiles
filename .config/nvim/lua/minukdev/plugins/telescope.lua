-- fzf-lua - faster and more modern alternative to telescope with better compatibility
return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local fzf = require("fzf-lua")

		fzf.setup({
			winopts = {
				height = 0.85,
				width = 0.80,
				row = 0.35,
				col = 0.50,
				preview = {
					layout = "flex",
					flip_columns = 120,
				},
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
			files = {
				fd_opts = "--color=never --type f --hidden --follow --exclude .git",
			},
			grep = {
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096",
			},
		})

		-- set keymaps
		local keymap = vim.keymap
		keymap.set("n", "<leader>ff", fzf.files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<F2>", fzf.files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Fuzzy find buffers" })
		keymap.set("n", "<F1>", fzf.buffers, { desc = "Fuzzy find buffers" })
		keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", fzf.live_grep, { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", fzf.grep_cword, { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<F4>", fzf.live_grep, { desc = "Find string in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", { desc = "Find todos" })
		keymap.set({ "n", "v" }, "<leader><leader>", fzf.keymaps, { desc = "Find keymaps" })
		keymap.set("n", "gc", fzf.lsp_incoming_calls, { desc = "Go to Callers" })
		keymap.set("n", "gr", fzf.lsp_references, { desc = "Go to Referrers" })
		keymap.set("n", "gi", fzf.lsp_implementations, { desc = "Go to Implements" })
		keymap.set("n", "<leader>D", fzf.diagnostics_document, { desc = "Show buffer diagnostics" })
	end,
}
