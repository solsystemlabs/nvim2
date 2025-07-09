return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- Disable all TypeScript LSP servers since we're using typescript-tools
      vtsls = {
        enabled = false,
      },
      ts_ls = {
        enabled = false,
      },
      tsserver = {
        enabled = false,
      },
    },
  },
}