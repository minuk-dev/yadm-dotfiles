-- vim.g.mapleader = " "
local keymap = vim.keymap

-- window navigation (without <C-w> prefix)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- window resize
keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- tab
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to prev tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- buffer
keymap.set("n", "\\n", "<cmd>bn<CR>", { desc = "move next buffer" })
keymap.set("n", "\\x", "<cmd>bn<CR>", { desc = "move next buffer" })
keymap.set("n", "\\p", "<cmd>bp<CR>", { desc = "move prev buffer" })
keymap.set("n", "\\z", "<cmd>bp<CR>", { desc = "move prev buffer" })

-- window zoom toggle
local zoom_state = {
	is_zoomed = false,
	saved_layout = nil,
}
keymap.set("n", "<C-z>", function()
	if zoom_state.is_zoomed then
		-- restore layout
		if zoom_state.saved_layout then
			vim.cmd(zoom_state.saved_layout)
		end
		zoom_state.is_zoomed = false
		zoom_state.saved_layout = nil
	else
		-- save current layout and maximize
		zoom_state.saved_layout = vim.fn.winrestcmd()
		zoom_state.is_zoomed = true
		vim.cmd("wincmd _")
		vim.cmd("wincmd |")
	end
end, { desc = "Toggle window zoom" })
