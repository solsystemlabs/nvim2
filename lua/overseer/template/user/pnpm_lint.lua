return {
  name = "pnpm run lint",
  builder = function()
    return {
      cmd = { "pnpm" },
      args = { "run", "lint" },
      components = { "default" },
    }
  end,
  condition = {
    filetype = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  },
}