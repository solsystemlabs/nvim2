-- tailwind-tools.lua
return {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "folke/snacks.nvim",     -- optional
    "neovim/nvim-lspconfig", -- optional
  },
  opts = {}                  -- your configuration
}
