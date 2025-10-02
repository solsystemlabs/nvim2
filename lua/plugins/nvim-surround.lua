return {
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        keymaps = {
          -- Use 's' in visual mode like classic vim-surround
          visual = "s",
          visual_line = "S",
        },
      })
    end,
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          keys = { "f", "F", "t", "T", ";", "," },
        },
      },
    },
    keys = {
      -- Remove the 's' visual mode mapping from flash
      { "s", mode = { "n", "x", "o" }, false },
    },
  },
}
