return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	build = ":MasonUpdate",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"gopls",
			},
			automatic_installation = true,
		})

		-- Install formatters and linters
		local ensure_installed = {
			"prettier",
			"stylua",
			"isort",
			"black",
			"pylint",
			"eslint_d",
		}

		local mr = require("mason-registry")
		mr.refresh(function()
			for _, tool in ipairs(ensure_installed) do
				local ok, p = pcall(mr.get_package, tool)
				if ok and not p:is_installed() then
					p:install()
				end
			end
		end)
	end,
}
