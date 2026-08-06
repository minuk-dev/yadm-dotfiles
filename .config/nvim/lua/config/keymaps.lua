-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
local keymap = vim.keymap

-- buffer
keymap.set("n", "\\n", "<cmd>bn<CR>", { desc = "move next buffer" })
keymap.set("n", "\\x", "<cmd>bn<CR>", { desc = "move next buffer" })
keymap.set("n", "\\p", "<cmd>bp<CR>", { desc = "move prev buffer" })
keymap.set("n", "\\z", "<cmd>bp<CR>", { desc = "move prev buffer" })

-- ESC + j/k 입력 시 Alt+j/k로 잘못 인식되어 줄이 이동하는 현상 방지
keymap.del({ "n", "i", "v" }, "<A-j>")
keymap.del({ "n", "i", "v" }, "<A-k>")
