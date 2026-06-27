return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		local fzf = require("fzf-lua")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", fzf.lsp_references, opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", function()
					local client = vim.lsp.get_clients({ bufnr = 0 })[1]
					if not client then
						vim.notify("No LSP client attached", vim.log.levels.WARN)
						return
					end
					local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
					vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, config)
						if err or not result or vim.tbl_isempty(result) then
							vim.notify("No definition found", vim.log.levels.INFO)
							return
						end
						-- Normalize to list
						if not vim.islist(result) then
							result = { result }
						end
						-- Deduplicate by uri and line
						local seen = {}
						local unique = {}
						for _, loc in ipairs(result) do
							local uri = loc.uri or loc.targetUri
							local range = loc.range or loc.targetSelectionRange
							local key = uri .. ":" .. range.start.line
							if not seen[key] then
								seen[key] = true
								table.insert(unique, loc)
							end
						end
						-- Jump directly if single result
						if #unique == 1 then
							vim.lsp.util.show_document(unique[1], "utf-8", { focus = true })
						else
							fzf.lsp_definitions({ jump1 = true })
						end
					end)
				end, opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", fzf.lsp_implementations, opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", fzf.lsp_typedefs, opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", fzf.diagnostics_document, opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- Configure LSP servers using vim.lsp.config (Neovim 0.11+)
		local servers = {
			ts_ls = {},
			html = {},
			cssls = {},
			tailwindcss = {},
			svelte = {},
			prismals = {},
			pyright = {},
			graphql = {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			},
			emmet_ls = {
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
			},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
					},
				},
			},
		}

		for server, config in pairs(servers) do
			config.capabilities = capabilities
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end
	end,
}
