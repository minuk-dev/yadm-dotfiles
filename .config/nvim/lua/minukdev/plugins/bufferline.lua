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
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "left",
				},
			},
			diagnostics = "nvim_lsp",
			show_close_icon = false,
		},
	},
}
