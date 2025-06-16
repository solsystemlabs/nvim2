-- actions-preview.lua
-- LSP code actions with preview functionality using Snacks backend
-- https://github.com/aznhe21/actions-preview.nvim

return {
  "aznhe21/actions-preview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim", -- Ensure Snacks is loaded first
  },
  event = "LspAttach",   -- Load when LSP attaches to a buffer
  opts = {
    -- Priority list of preferred backend - Snacks first
    backend = { "snacks", "telescope", "nui" },

    -- Options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
    diff = {
      ctxlen = 3,
      algorithm = "patience",
      ignore_whitespace = true,
    },

    -- Options for snacks picker
    ---@type snacks.picker.Config
    snacks = {
      layout = {
        preset = "default",
        -- You can customize the layout here if needed
        -- backdrop = { bg = "none" },
      },
      -- Customize the preview window if needed
      preview = {
        -- border = "rounded",
      },
    },

    -- Disabled by default, but you can enable external diff highlighting
    -- highlight_command = {
    --   require("actions-preview.highlight").delta(),
    --   require("actions-preview.highlight").diff_so_fancy(),
    --   require("actions-preview.highlight").diff_highlight(),
    -- },
  },
  config = function(_, opts)
    require("actions-preview").setup(opts)
  end,
}
