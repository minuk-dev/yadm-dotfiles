-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
local keymap = vim.keymap

-- buffer
keymap.set("n", "\\n", "<cmd>bn<CR>", { desc = "move next buffer" })
keymap.set("n", "\\x", "<cmd>bn<CR>", { desc = "move next buffer" })
keymap.set("n", "\\p", "<cmd>bp<CR>", { desc = "move prev buffer" })
keymap.set("n", "\\z", "<cmd>bp<CR>", { desc = "move prev buffer" })

-- function keys
-- LazyVim.pick은 현재 설정된 picker(fzf-lua)로 자동 연결된다.
keymap.set("n", "<F2>", function()
  LazyVim.pick("buffers")()
end, { desc = "Buffer search" })

keymap.set("n", "<F3>", function()
  Snacks.explorer({ cwd = LazyVim.root() })
end, { desc = "File explorer (root dir)" })

keymap.set("n", "<F4>", function()
  LazyVim.pick("live_grep")()
end, { desc = "Grep (root dir)" })

keymap.set("n", "<F5>", "<cmd>TagbarToggle<CR>", { desc = "Toggle tagbar" })

-- ESC + j/k 입력 시 Alt+j/k로 잘못 인식되어 줄이 이동하는 현상 방지
keymap.del({ "n", "i", "v" }, "<A-j>")
keymap.del({ "n", "i", "v" }, "<A-k>")

-- git permalink
-- <leader>gY(LazyVim 기본)는 브랜치 URL 복사, <leader>gy는 커밋 해시 고정 permalink 복사
keymap.set({ "n", "x" }, "<leader>gy", function()
  Snacks.gitbrowse({
    what = "permalink",
    notify = false,
    open = function(url)
      vim.fn.setreg("+", url)
      Snacks.notify.info("Copied permalink:\n" .. url)
    end,
  })
end, { desc = "Git Permalink (copy)" })
