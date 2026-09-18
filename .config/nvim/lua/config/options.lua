-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- picker를 telescope로 고정. LazyVim은 picker를 하나만 등록하므로
-- lazyvim.json의 editor.fzf extra는 제거해 두었다.
vim.g.lazyvim_picker = "telescope"

-- mise는 `mise activate zsh`로만 PATH를 주입하기 때문에, 그 훅을 거치지 않고 뜬
-- nvim(GUI 실행, launchd가 띄운 tmux 등)에서는 go/gopls가 툴체인을 못 찾는다.
-- shims를 PATH 뒤에 붙여 두면 activate된 셸에서는 실제 install 경로가 우선하고,
-- 아닐 때만 shims가 fallback으로 동작한다.
do
  local extra = {
    vim.env.HOME .. "/.local/share/mise/shims",
    vim.env.HOME .. "/go/bin", -- `go install`로 받은 도구들 (GOPATH/bin)
  }
  local path = vim.env.PATH or ""
  for _, dir in ipairs(extra) do
    if vim.uv.fs_stat(dir) and not (":" .. path .. ":"):find(":" .. dir .. ":", 1, true) then
      path = path .. ":" .. dir
    end
  end
  vim.env.PATH = path
end

-- fold를 기본적으로 끈다. foldmethod/foldexpr은 그대로 두기 때문에 fold 구역 자체는
-- 계산되어 있고, 필요할 때 `zi`로 켜면 바로 접을 수 있다.
vim.opt.foldenable = false
-- foldenable을 다시 켰을 때도 접힌 채로 시작하지 않도록 전부 펼친 상태로 둔다
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
-- 접기 기준 설정 (indent 대신 expr 권장)
vim.opt.foldmethod = "expr"
-- Treesitter 기반으로 접기 구역 계산
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
