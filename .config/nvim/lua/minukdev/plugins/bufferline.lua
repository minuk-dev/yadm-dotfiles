return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			hover = {
				enable = true,
				delay = 200,
				reveal = { "close" },
			},
			diagnostics = "nvim_lsp",
			show_close_icon = false,
		},
	},
}
