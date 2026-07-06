-- blink.cmp - fast (Rust) completion engine, replaces nvim-cmp
return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	-- use a release tag so lazy downloads the prebuilt fuzzy binary (no cargo build)
	version = "1.*",
	dependencies = {
		"rafamadriz/friendly-snippets", -- blink loads these natively, no LuaSnip needed
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "none",
			["<C-k>"] = { "select_prev", "fallback" }, -- previous suggestion
			["<C-j>"] = { "select_next", "fallback" }, -- next suggestion
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" }, -- close completion window
			["<CR>"] = { "accept", "fallback" },
		},
		appearance = {
			-- 'mono' for icon fonts, matches the old lspkind pictograms
			nerd_font_variant = "mono",
		},
		completion = {
			-- do not preselect the first item (old cmp had select = false on <CR>)
			list = { selection = { preselect = false, auto_insert = true } },
			documentation = { auto_show = true, auto_show_delay_ms = 200 },
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		-- prefer the prebuilt Rust matcher; warn (don't error) if unavailable
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
