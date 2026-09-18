-- nvim-lint 오버라이드
return {
  {
    "mfussenegger/nvim-lint",
    opts = function()
      local lint = require("lint")
      local golangcilint = require("lint.linters.golangcilint")
      -- 멀티 모듈 repo(예: opentelemetry-collector-contrib)에서 nvim cwd의 go.mod와
      -- 버퍼가 속한 go.mod가 다르면 golangci-lint가 typecheck 에러(exit 7)로 실패한다.
      -- 매 lint마다 버퍼에서 가장 가까운 go.mod 디렉터리를 cwd로 사용한다.
      lint.linters.golangcilint = function()
        local gomod = vim.fs.find("go.mod", { upward = true, path = vim.fn.expand("%:p:h") })[1]
        golangcilint.cwd = gomod and vim.fs.dirname(gomod) or nil
        return golangcilint
      end
    end,
  },
}
