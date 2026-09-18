return {
  -- <F5> 태그바. Universal Ctags(/opt/homebrew/bin/ctags)를 사용한다.
  {
    "preservim/tagbar",
    cmd = { "TagbarToggle", "TagbarOpen", "TagbarClose" },
    init = function()
      vim.g.tagbar_ctags_bin = vim.fn.exepath("ctags")
      vim.g.tagbar_position = "right"
      vim.g.tagbar_width = 40
      vim.g.tagbar_autofocus = 1
    end,
  },

  -- <F3> 파일 탐색기. snacks.explorer는 opts에 명시해야 활성화된다.
  {
    "folke/snacks.nvim",
    opts = { explorer = {} },
  },
}
