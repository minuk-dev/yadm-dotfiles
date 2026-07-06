-- persistence.nvim - per-directory session save/restore (workspace)
-- 자동 저장(종료 시), 복원은 원할 때만 → startify 시작화면과 충돌하지 않음
return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	keys = {
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Restore session (current dir)",
		},
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore last session",
		},
		{
			"<leader>qd",
			function()
				require("persistence").stop()
			end,
			desc = "Stop saving current session",
		},
	},
}
