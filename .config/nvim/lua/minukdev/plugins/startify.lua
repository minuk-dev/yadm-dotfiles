return {
	"mhinz/vim-startify",
	lazy = false,
	init = function()
		vim.g.startify_session_dir = vim.fn.stdpath("data") .. "/sessions"
		vim.g.startify_change_to_vcs_root = 1
		vim.g.startify_fortune_type = "text"
		vim.g.startify_lists = {
			{ type = "sessions", header = { "   Sessions" } },
			{ type = "files", header = { "   MRU" } },
			{ type = "bookmarks", header = { "   Bookmarks" } },
			{ type = "commands", header = { "   Commands" } },
		}
	end,
}
