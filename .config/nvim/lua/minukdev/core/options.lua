vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
-- opt.statuscolumn = "%s %l %r"
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "white" })

opt.relativenumber = false
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard

-- slip windows
opt.splitright = true
opt.splitbelow = true

-- undo
opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("config") .. "/.undo/"
