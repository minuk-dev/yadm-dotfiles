return {
	"fatih/vim-go",
	ft = "go",
	config = function()
		-- Disable auto formatting since we use gofmt via conform
		vim.g.go_fmt_autosave = 0
		vim.g.go_imports_autosave = 0

		-- Use gofmt
		vim.g.go_fmt_command = "gofmt"

		-- Linter settings
		vim.g.go_lint_on_save = 1
		vim.g.go_linters = { "golangci-lint" }

		-- Enable syntax highlighting
		vim.g.go_highlight_types = 1
		vim.g.go_highlight_fields = 1
		vim.g.go_highlight_functions = 1
		vim.g.go_highlight_function_calls = 1
		vim.g.go_highlight_operators = 1
		vim.g.go_highlight_variable_declarations = 1
		vim.g.go_highlight_variable_assignments = 1

		local keymap = vim.keymap

		-- Go specific keybindings
		keymap.set("n", "<leader>gf", ":GoFmt<CR>", { desc = "Format Go file" })
		keymap.set("n", "<leader>gi", ":GoImports<CR>", { desc = "Run goimports" })
		keymap.set("n", "<leader>gt", ":GoTest<CR>", { desc = "Run Go tests" })
		keymap.set("n", "<leader>gT", ":GoTestFunc<CR>", { desc = "Run current test func" })
		keymap.set("n", "<leader>gc", ":GoCoverageToggle<CR>", { desc = "Toggle coverage" })
		keymap.set("n", "<leader>gr", ":GoReferrers<CR>", { desc = "Show referrers" })
		keymap.set("n", "<leader>gd", ":GoDescribe<CR>", { desc = "Describe symbol" })
		keymap.set("n", "<leader>gn", ":GoRename<CR>", { desc = "Rename symbol" })
	end,
}
