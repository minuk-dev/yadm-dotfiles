-- LazyVim의 LSP 기본 opts 오버라이드
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- inlay hint(가상 타입/파라미터 힌트)를 기본으로 끈다.
      -- 필요할 때 `<leader>uh`로 버퍼 단위 토글 가능.
      inlay_hints = { enabled = false },
      -- LSP가 제공하는 fold도 함께 꺼서 foldenable=false와 의도를 맞춘다.
      folds = { enabled = false },
    },
  },
}
