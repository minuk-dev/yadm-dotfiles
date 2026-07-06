return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		require("mini.completion").setup({})
		require("mini.keymap").setup({})
		require("mini.move").setup({})
		require("mini.sessions").setup({})
		require("mini.pairs").setup({})
	end,
}
