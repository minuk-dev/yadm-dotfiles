-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- depth 3까지는 펼치고, 그보다 깊게 중첩된 fold는 접는다 (LazyVim 기본값: 99)
vim.opt.foldlevel = 3
-- 새 버퍼를 열 때도 동일하게 depth 3부터 접힌 상태로 시작
vim.opt.foldlevelstart = 3
-- 접기 기준 설정 (indent 대신 expr 권장)
vim.opt.foldmethod = "expr"
-- Treesitter 기반으로 접기 구역 계산
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
