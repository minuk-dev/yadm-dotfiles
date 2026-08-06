return {
  {
    "folke/snacks.nvim",
    opts = {
      -- tmux 안에서는 스무스 스크롤 비활성화.
      --
      -- nvim은 터미널에 DECRQM(`CSI ?2026$p`)으로 synchronized output 지원 여부를
      -- 물어보고, 응답이 있을 때만 프레임을 원자적으로 그린다. tmux는 이 질의에
      -- 답하지 않으므로(terminfo에 Sync를 넣어도 nvim이 무시함) tmux 안에서는
      -- 애니메이션 프레임이 매번 찢어진 채 그려져 렉처럼 보인다.
      -- tmux 밖(iTerm2 직결)에서는 sync가 정상 동작하므로 그대로 둔다.
      scroll = { enabled = vim.env.TMUX == nil },
    },
  },
}
