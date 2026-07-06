-- neo-tree.nvim - persistent sidebar file tree, runs alongside oil.nvim
-- (트리 = 구조 파악/탐색, oil = 빠른 파일 조작. 역할 분담)
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>et", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree (neo-tree)" },
		{ "<leader>er", "<cmd>Neotree reveal<CR>", desc = "Reveal current file in tree" },
	},
	opts = {
		close_if_last_window = true,
		window = {
			position = "left",
			width = 35,
		},
		filesystem = {
			-- oil 이 디렉토리/netrw 를 담당하므로 neo-tree 는 하이재킹하지 않는다
			hijack_netrw_behavior = "disabled",
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = { ".DS_Store" },
			},
		},
	},
}
